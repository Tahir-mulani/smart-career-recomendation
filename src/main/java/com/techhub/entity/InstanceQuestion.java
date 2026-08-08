package com.techhub.entity;

public class InstanceQuestion {

    private Long instanceId;
    private Long questionId;
    private Integer questionOrder;
    private String userAnswer;
    private Boolean isCorrect;
    private Integer timeTakenSeconds;

    public InstanceQuestion() {
        this.isCorrect = false;
        this.timeTakenSeconds = 0;
    }

    public InstanceQuestion(Long instanceId, Long questionId, Integer questionOrder) {
        this.instanceId = instanceId;
        this.questionId = questionId;
        this.questionOrder = questionOrder;
        this.isCorrect = false;
        this.timeTakenSeconds = 0;
    }

    public Long getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(Long instanceId) {
        this.instanceId = instanceId;
    }

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public Integer getQuestionOrder() {
        return questionOrder;
    }

    public void setQuestionOrder(Integer questionOrder) {
        this.questionOrder = questionOrder;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public Boolean getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(Boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Integer getTimeTakenSeconds() {
        return timeTakenSeconds;
    }

    public void setTimeTakenSeconds(Integer timeTakenSeconds) {
        this.timeTakenSeconds = timeTakenSeconds;
    }
}
