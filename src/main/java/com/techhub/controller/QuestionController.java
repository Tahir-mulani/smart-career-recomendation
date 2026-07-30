package com.techhub.controller;


import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.techhub.dto.QuestionRequest;
import com.techhub.entity.Question;
import com.techhub.service.QuestionService;

import java.util.List;

@RestController
@RequestMapping("/api/questions")
public class QuestionController {

    private final QuestionService questionService;

    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @PostMapping
    public ResponseEntity<Question> save(@Valid @RequestBody QuestionRequest request) {
        Question question = questionService.save(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(question);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Question> getById(@PathVariable Long id) {
        Question question = questionService.findById(id);
        return ResponseEntity.ok(question);
    }

    @GetMapping("/assessment/{assessmentId}")
    public ResponseEntity<List<Question>> getByAssessmentId(@PathVariable Long assessmentId) {
        List<Question> questions = questionService.findByAssessmentId(assessmentId);
        return ResponseEntity.ok(questions);
    }

    @GetMapping
    public ResponseEntity<List<Question>> getAll() {
        List<Question> questions = questionService.findAll();
        return ResponseEntity.ok(questions);
    }

    @PutMapping("/{id}")
//    public ResponseEntity<Question> update(@PathVariable Long id, @Valid @RequestBody QuestionRequest request) {
//        Question question = questionService.findById(id);
//        question.setQuestionText(request.getQuestionText());
//        question.setOptionA(request.getOptionA());
//        question.setOptionB(request.getOptionB());
//        question.setOptionC(request.getOptionC());
//        question.setOptionD(request.getOptionD());
//        question.setCorrectAnswer(request.getCorrectAnswer().toUpperCase());
//        question.setDifficultyLevel(request.getDifficultyLevel());
//        question.setSkillTag(request.getSkillTag());
//        //Question updated = questionService.save(question);
//       // return ResponseEntity.ok(updated);
//    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        questionService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
