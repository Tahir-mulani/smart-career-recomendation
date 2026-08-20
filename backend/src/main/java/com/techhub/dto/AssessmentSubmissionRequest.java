package com.techhub.dto;

import java.time.LocalDateTime;
import java.util.Map;

public class AssessmentSubmissionRequest {
    private Long userId;
    private Long testId;
    private Map<Long, String> answers;
    private LocalDateTime startTime;

    public AssessmentSubmissionRequest() {
    }

    public AssessmentSubmissionRequest(Long userId, Long testId, Map<Long, String> answers, LocalDateTime startTime) {
        this.userId = userId;
        this.testId = testId;
        this.answers = answers;
        this.startTime = startTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getTestId() {
        return testId;
    }

    public void setTestId(Long testId) {
        this.testId = testId;
    }

    public Map<Long, String> getAnswers() {
        return answers;
    }

    public void setAnswers(Map<Long, String> answers) {
        this.answers = answers;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }
}
