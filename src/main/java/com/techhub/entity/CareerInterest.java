package com.techhub.entity;

public class CareerInterest {

    private Long careerId;
    private Long interestId;

    public CareerInterest() {
    }

    public CareerInterest(Long careerId, Long interestId) {
        this.careerId = careerId;
        this.interestId = interestId;
    }

    public Long getCareerId() {
        return careerId;
    }

    public void setCareerId(Long careerId) {
        this.careerId = careerId;
    }

    public Long getInterestId() {
        return interestId;
    }

    public void setInterestId(Long interestId) {
        this.interestId = interestId;
    }
}
