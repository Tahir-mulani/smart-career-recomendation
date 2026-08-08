package com.techhub.entity;

public class Interest {

    private Long id;
    private String interestName;

    public Interest() {
    }

    public Interest(Long id, String interestName) {
        this.id = id;
        this.interestName = interestName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getInterestName() {
        return interestName;
    }

    public void setInterestName(String interestName) {
        this.interestName = interestName;
    }
}
