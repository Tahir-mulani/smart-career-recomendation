package com.techhub.service;

import com.techhub.entity.*;
import com.techhub.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.*;

@Service
public class AssessmentInstanceService {

    private final AssessmentInstanceRepository instanceRepository;
    private final InstanceQuestionRepository instanceQuestionRepository;
    private final QuestionRepository questionRepository;
    private final UserSkillRepository userSkillRepository;
    private final SkillRepository skillRepository;
    private final ResultRepository resultRepository;

    public AssessmentInstanceService(AssessmentInstanceRepository instanceRepository,
                                     InstanceQuestionRepository instanceQuestionRepository,
                                     QuestionRepository questionRepository,
                                     UserSkillRepository userSkillRepository,
                                     SkillRepository skillRepository,
                                     ResultRepository resultRepository) {
        this.instanceRepository = instanceRepository;
        this.instanceQuestionRepository = instanceQuestionRepository;
        this.questionRepository = questionRepository;
        this.userSkillRepository = userSkillRepository;
        this.skillRepository = skillRepository;
        this.resultRepository = resultRepository;
    }

    @Transactional
    public AssessmentInstance generateDynamicAssessment(Long userId) {
        // 1. Create AssessmentInstance record
        AssessmentInstance instance = new AssessmentInstance();
        instance.setUserId(userId);
        instance.setGeneratedAt(new Timestamp(System.currentTimeMillis()));
        instance.setStartedAt(new Timestamp(System.currentTimeMillis()));
        instance.setStatus("IN_PROGRESS");

        instance = instanceRepository.save(instance);

        List<Question> selectedQuestions = new ArrayList<>();
        Set<Long> addedQuestionIds = new HashSet<>();

        // 2. Fetch Common Section Questions (15 Max)
        List<Question> commonQs = questionRepository.findRandomCommonQuestions(15);
        for (Question q : commonQs) {
            if (addedQuestionIds.add(q.getId())) {
                selectedQuestions.add(q);
            }
        }

        // 3. Fetch Technical Section Questions matching User's Primary Skills
        List<UserSkill> primarySkills = userSkillRepository.findPrimarySkillsByUserId(userId);
        if (primarySkills.isEmpty()) {
            // Fallback: if no primary skills flagged, take all user skills
            primarySkills = userSkillRepository.findByUserId(userId);
        }

        int maxTechQuestionsTotal = 15;
        int numSkills = Math.max(1, primarySkills.size());
        int qsPerSkill = Math.max(2, Math.min(5, maxTechQuestionsTotal / numSkills));

        for (UserSkill us : primarySkills) {
            List<Question> techQs = questionRepository.findRandomBySkillId(us.getSkillId(), qsPerSkill);
            if (techQs.isEmpty()) {
                // Try finding by skill name tag
                Optional<Skill> skillOpt = skillRepository.findById(us.getSkillId());
                if (skillOpt.isPresent()) {
                    techQs = questionRepository.findRandomBySkillTag(skillOpt.get().getSkillName(), qsPerSkill);
                }
            }

            for (Question q : techQs) {
                if (selectedQuestions.size() >= 30) break; // Hard cap of 30 Qs max
                if (addedQuestionIds.add(q.getId())) {
                    selectedQuestions.add(q);
                }
            }
        }

        // If total questions still under 15, fill with general question bank items
        if (selectedQuestions.size() < 15) {
            List<Question> allQs = questionRepository.findAll();
            Collections.shuffle(allQs);
            for (Question q : allQs) {
                if (selectedQuestions.size() >= 15) break;
                if (addedQuestionIds.add(q.getId())) {
                    selectedQuestions.add(q);
                }
            }
        }

        // 4. Save InstanceQuestions
        int order = 1;
        for (Question q : selectedQuestions) {
            InstanceQuestion iq = new InstanceQuestion(instance.getId(), q.getId(), order++);
            instanceQuestionRepository.save(iq);
        }

        instance.setTotalQuestions(selectedQuestions.size());
        return instanceRepository.save(instance);
    }

    public Optional<AssessmentInstance> findById(Long id) {
        return instanceRepository.findById(id);
    }

    public Optional<AssessmentInstance> findLatestActiveInstance(Long userId) {
        return instanceRepository.findLatestActiveInstance(userId);
    }

    public List<InstanceQuestion> getInstanceQuestions(Long instanceId) {
        return instanceQuestionRepository.findByInstanceId(instanceId);
    }

    @Transactional
    public AssessmentInstance submitAssessment(Long instanceId, Map<Long, String> answers, int timeTakenSeconds) {
        AssessmentInstance instance = instanceRepository.findById(instanceId)
                .orElseThrow(() -> new RuntimeException("Assessment instance not found"));

        List<InstanceQuestion> instanceQuestions = instanceQuestionRepository.findByInstanceId(instanceId);
        int correctCount = 0;

        for (InstanceQuestion iq : instanceQuestions) {
            String selected = answers.get(iq.getQuestionId());
            iq.setUserAnswer(selected);

            Optional<Question> qOpt = questionRepository.findById(iq.getQuestionId());
            if (qOpt.isPresent()) {
                boolean correct = selected != null && selected.equalsIgnoreCase(qOpt.get().getCorrectAnswer());
                iq.setIsCorrect(correct);
                if (correct) correctCount++;
            }

            instanceQuestionRepository.save(iq);
        }

        double percentage = instanceQuestions.isEmpty() ? 0.0 : ((double) correctCount / instanceQuestions.size()) * 100.0;

        instance.setCompletedAt(new Timestamp(System.currentTimeMillis()));
        instance.setDurationActual(timeTakenSeconds);
        instance.setScore(correctCount);
        instance.setPercentage(percentage);
        instance.setStatus("COMPLETED");

        instanceRepository.save(instance);

        // Also update legacy Result table for dashboard compatibility (if assessment ID exists)
        try {
            Result result = new Result();
            result.setUserId(instance.getUserId());
            result.setAssessmentId(instance.getAssessmentId() != null ? instance.getAssessmentId() : 1L);
            result.setScore(correctCount);
            result.setPercentage(percentage);
            resultRepository.save(result);
        } catch (Exception ignored) {}

        // Update user primary skill proficiency based on score
        String proficiency = percentage >= 80 ? "Advanced" : (percentage >= 50 ? "Intermediate" : "Beginner");
        List<UserSkill> primarySkills = userSkillRepository.findPrimarySkillsByUserId(instance.getUserId());
        for (UserSkill us : primarySkills) {
            us.setProficiencyLevel(proficiency);
            userSkillRepository.save(us);
        }

        return instance;
    }
}
