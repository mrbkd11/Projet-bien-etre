package com.example.demo.entity;

public class QueryInput {
    private String question;
    private String context;

    // Default constructor
    public QueryInput() {
    }

    // Getters and Setters
    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }
}