package com.techhub.entity;

public class UserInterest {

    private Long userId;
    private Long interestId;

    public UserInterest() {
    }

    public UserInterest(Long userId, Long interestId) {
        this.userId = userId;
        this.interestId = interestId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getInterestId() {
        return interestId;
    }

    public void setInterestId(Long interestId) {
        this.interestId = interestId;
    }
}
