package com.techhub.entity;

public class CareerSkill {

    private Long careerId;
    private Long skillId;

    public CareerSkill() {
    }

    public CareerSkill(Long careerId, Long skillId) {
        this.careerId = careerId;
        this.skillId = skillId;
    }

    public Long getCareerId() {
        return careerId;
    }

    public void setCareerId(Long careerId) {
        this.careerId = careerId;
    }

    public Long getSkillId() {
        return skillId;
    }

    public void setSkillId(Long skillId) {
        this.skillId = skillId;
    }
}
