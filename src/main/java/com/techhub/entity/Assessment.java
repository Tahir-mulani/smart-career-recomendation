package com.techhub.entity;

import java.util.ArrayList;
import java.util.List;

public class Assessment {

    private Long id;
    private String testName;
    private Integer duration;
    private Integer totalMarks;
    private List<Question> questions = new ArrayList<>();

    public Assessment() {
    }

    public Assessment(Long id, String testName, Integer duration, Integer totalMarks) {
        this.id = id;
        this.testName = testName;
        this.duration = duration;
        this.totalMarks = totalMarks;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(Integer totalMarks) {
        this.totalMarks = totalMarks;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }
}
