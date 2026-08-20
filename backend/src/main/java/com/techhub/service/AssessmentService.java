package com.techhub.service;


import org.springframework.stereotype.Service;

import com.techhub.dto.AssessmentRequest;
import com.techhub.entity.Assessment;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.AssessmentRepository;
import com.techhub.repository.QuestionRepository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AssessmentService {

    private final AssessmentRepository assessmentRepository;
    private final QuestionRepository questionRepository;

    public AssessmentService(AssessmentRepository assessmentRepository, QuestionRepository questionRepository) {
        this.assessmentRepository = assessmentRepository;
        this.questionRepository = questionRepository;
    }

    public Assessment save(AssessmentRequest request) {
        Assessment assessment = new Assessment();
        assessment.setTestName(request.getTestName());
        assessment.setDuration(request.getDuration());
        assessment.setTotalMarks(request.getTotalMarks());

        return assessmentRepository.save(assessment);
    }

    public Assessment findById(Long assessmentId) {
        return assessmentRepository.findById(assessmentId)
                .orElseThrow(() -> new BusinessValidationException("testId", "Assessment does not exist"));
    }

    public Assessment update(Long id, AssessmentRequest request) {
        Assessment assessment = findById(id);
        assessment.setTestName(request.getTestName());
        assessment.setDuration(request.getDuration());
        assessment.setTotalMarks(request.getTotalMarks());
        return assessmentRepository.save(assessment);
    }

    public List<Assessment> findAll() {
        return assessmentRepository.findAll();
    }

    public List<Assessment> findRecommendedAssessments(String userSkills) {
        if (userSkills == null || userSkills.trim().isEmpty()) {
            return findAll();
        }

        List<String> skillList = Arrays.asList(userSkills.split(","))
                .stream()
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toList());

        if (skillList.isEmpty()) {
            return findAll();
        }

        List<Assessment> allAssessments = findAll();
        List<Assessment> recommendedAssessments = new ArrayList<>();

        for (Assessment assessment : allAssessments) {
            List<com.techhub.entity.Question> questions = questionRepository.findByAssessmentId(assessment.getId());
            for (com.techhub.entity.Question question : questions) {
                String questionSkillTag = question.getSkillTag();
                if (questionSkillTag != null && !questionSkillTag.trim().isEmpty()) {
                    for (String userSkill : skillList) {
                        if (questionSkillTag.toLowerCase().contains(userSkill.toLowerCase()) ||
                            userSkill.toLowerCase().contains(questionSkillTag.toLowerCase())) {
                            if (!recommendedAssessments.contains(assessment)) {
                                recommendedAssessments.add(assessment);
                            }
                            break;
                        }
                    }
                }
            }
        }

        return recommendedAssessments.isEmpty() ? allAssessments : recommendedAssessments;
    }

    public void deleteById(Long id) {
        assessmentRepository.deleteById(id);
    }
}
