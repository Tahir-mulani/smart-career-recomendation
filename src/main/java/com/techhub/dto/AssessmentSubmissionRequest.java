package com.techhub.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.Map;

public class AssessmentSubmissionRequest {

    @NotNull(message = "User ID is required")
    private Long userId;

    @NotNull(message = "Test ID is required")
    private Long testId;

    @NotEmpty(message = "Answers cannot be empty")
    private Map<Long, String> answers;

    @NotNull(message = "Start time is required")
    private LocalDateTime startTime;

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
