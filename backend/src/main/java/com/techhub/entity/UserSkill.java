package com.techhub.entity;

public class UserSkill {

    private Long userId;
    private Long skillId;
    private Boolean isPrimary;
    private String proficiencyLevel;

    public UserSkill() {
        this.isPrimary = false;
        this.proficiencyLevel = "Beginner";
    }

    public UserSkill(Long userId, Long skillId, Boolean isPrimary, String proficiencyLevel) {
        this.userId = userId;
        this.skillId = skillId;
        this.isPrimary = isPrimary != null ? isPrimary : false;
        this.proficiencyLevel = proficiencyLevel != null ? proficiencyLevel : "Beginner";
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getSkillId() {
        return skillId;
    }

    public void setSkillId(Long skillId) {
        this.skillId = skillId;
    }

    public Boolean getIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(Boolean isPrimary) {
        this.isPrimary = isPrimary;
    }

    public String getProficiencyLevel() {
        return proficiencyLevel;
    }

    public void setProficiencyLevel(String proficiencyLevel) {
        this.proficiencyLevel = proficiencyLevel;
    }
}
