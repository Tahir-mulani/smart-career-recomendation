package com.techhub.entity;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

public class AssessmentSubmission {

    private Long id;
    private Long userId;
    private Long assessmentId;
    private Map<Long, String> answers = new HashMap<>();
    private LocalDateTime submittedAt;

    public AssessmentSubmission() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Long assessmentId) {
        this.assessmentId = assessmentId;
    }

    public Map<Long, String> getAnswers() {
        return answers;
    }

    public void setAnswers(Map<Long, String> answers) {
        this.answers = answers;
    }

    public LocalDateTime getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(LocalDateTime submittedAt) {
        this.submittedAt = submittedAt;
    }
}
