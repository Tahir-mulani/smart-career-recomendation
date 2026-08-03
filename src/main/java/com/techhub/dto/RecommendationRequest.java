package com.techhub.dto;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

public class RecommendationRequest {

    @NotNull(message = "User ID is required")
    private Long userId;

    @NotNull(message = "Career ID is required")
    private Long careerId;

    @NotNull(message = "Match score is required")
    @DecimalMin(value = "0.0", message = "Match score must be between 0 and 100")
    @DecimalMax(value = "100.0", message = "Match score must be between 0 and 100")
    private Double matchScore;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCareerId() {
        return careerId;
    }

    public void setCareerId(Long careerId) {
        this.careerId = careerId;
    }

    public Double getMatchScore() {
        return matchScore;
    }

    public void setMatchScore(Double matchScore) {
        this.matchScore = matchScore;
    }
}
