package com.techhub.exception;

import java.util.Map;

public class BusinessValidationException extends RuntimeException {

    private final Map<String, String> errors;

    public BusinessValidationException(String message) {
        super(message);
        this.errors = Map.of("error", message);
    }

    public BusinessValidationException(String field, String message) {
        super(message);
        this.errors = Map.of(field, message);
    }

    public BusinessValidationException(Map<String, String> errors) {
        super("Validation Failed");
        this.errors = errors;
    }

    public Map<String, String> getErrors() {
        return errors;
    }
}
