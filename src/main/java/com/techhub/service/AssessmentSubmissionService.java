package com.techhub.service;

import com.techhub.dto.AssessmentSubmissionRequest;
import com.techhub.entity.Assessment;
import com.techhub.entity.AssessmentSubmission;
import com.techhub.entity.Question;
import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.AssessmentSubmissionRepository;
import com.techhub.repository.QuestionRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AssessmentSubmissionService {

    private final AssessmentSubmissionRepository submissionRepository;
    private final UserService userService;
    private final AssessmentService assessmentService;
    private final QuestionRepository questionRepository;
    private final ResultService resultService;

    public AssessmentSubmissionService(AssessmentSubmissionRepository submissionRepository,
                                       UserService userService,
                                       AssessmentService assessmentService,
                                       QuestionRepository questionRepository,
                                       ResultService resultService) {
        this.submissionRepository = submissionRepository;
        this.userService = userService;
        this.assessmentService = assessmentService;
        this.questionRepository = questionRepository;
        this.resultService = resultService;
    }

    public AssessmentSubmission save(AssessmentSubmissionRequest request) {
        User user = userService.findById(request.getUserId());
        Assessment assessment = assessmentService.findById(request.getTestId());
        validateQuestionsBelongToAssessment(request.getTestId(), request.getAnswers());
        validateTiming(assessment, request.getStartTime());

        AssessmentSubmission submission = new AssessmentSubmission();
        submission.setUserId(user.getId());
        submission.setAssessmentId(assessment.getId());
        submission.setAnswers(new HashMap<>(request.getAnswers()));
        submission.setSubmittedAt(LocalDateTime.now());

        AssessmentSubmission saved = submissionRepository.save(submission);
        resultService.evaluateAndSave(user, assessment, request.getAnswers());
        return saved;
    }

    private void validateTiming(Assessment assessment, LocalDateTime startTime) {
        if (startTime == null) {
            throw new BusinessValidationException("startTime", "Start time is required");
        }

        LocalDateTime now = LocalDateTime.now();
        long durationMinutes = java.time.Duration.between(startTime, now).toMinutes();
        
        if (durationMinutes > assessment.getDuration()) {
            throw new BusinessValidationException("timing",
                    "Assessment time exceeded. Allowed duration: " + assessment.getDuration() + 
                    " minutes, Actual time: " + durationMinutes + " minutes");
        }
    }

    private void validateQuestionsBelongToAssessment(Long assessmentId, Map<Long, String> answers) {
        List<Question> assessmentQuestions = questionRepository.findByAssessmentId(assessmentId);
        Set<Long> validQuestionIds = assessmentQuestions.stream()
                .map(Question::getId)
                .collect(Collectors.toSet());

        for (Long questionId : answers.keySet()) {
            if (!validQuestionIds.contains(questionId)) {
                throw new BusinessValidationException("answers",
                        "Question " + questionId + " does not belong to the selected assessment");
            }
        }
    }

    public AssessmentSubmission findById(Long id) {
        return submissionRepository.findById(id)
                .orElseThrow(() -> new BusinessValidationException("id", "Assessment submission does not exist"));
    }

    public List<AssessmentSubmission> findAll() {
        return submissionRepository.findAll();
    }

    public void deleteById(Long id) {
        submissionRepository.deleteById(id);
    }
}
