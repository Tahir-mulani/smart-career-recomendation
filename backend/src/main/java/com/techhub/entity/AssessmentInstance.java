package com.techhub.entity;

import java.sql.Timestamp;

public class AssessmentInstance {

    private Long id;
    private Long userId;
    private Long assessmentId;
    private Timestamp generatedAt;
    private Timestamp startedAt;
    private Timestamp completedAt;
    private Integer durationActual;
    private Integer totalQuestions;
    private Integer score;
    private Double percentage;
    private String status; // GENERATED, IN_PROGRESS, COMPLETED, EXPIRED

    public AssessmentInstance() {
        this.status = "GENERATED";
        this.durationActual = 0;
        this.totalQuestions = 0;
        this.score = 0;
        this.percentage = 0.0;
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

    public Timestamp getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(Timestamp generatedAt) {
        this.generatedAt = generatedAt;
    }

    public Timestamp getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(Timestamp startedAt) {
        this.startedAt = startedAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    public Integer getDurationActual() {
        return durationActual;
    }

    public void setDurationActual(Integer durationActual) {
        this.durationActual = durationActual;
    }

    public Integer getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(Integer totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
