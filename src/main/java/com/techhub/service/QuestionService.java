package com.techhub.service;


import org.springframework.stereotype.Service;

import com.techhub.dto.QuestionRequest;
import com.techhub.entity.Assessment;
import com.techhub.entity.Question;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.QuestionRepository;

import java.util.List;

@Service
public class QuestionService {

    private final QuestionRepository questionRepository;
    private final AssessmentService assessmentService;

    public QuestionService(QuestionRepository questionRepository, AssessmentService assessmentService) {
        this.questionRepository = questionRepository;
        this.assessmentService = assessmentService;
    }

    public Question save(QuestionRequest request) {
        //Assessment assessment = assessmentService.findById(request.getAssessmentId());
        validateCorrectAnswerMatchesOption(request);

        Question question = new Question();
        question.setQuestionText(request.getQuestionText());
        question.setOptionA(request.getOptionA());
        question.setOptionB(request.getOptionB());
        question.setOptionC(request.getOptionC());
        question.setOptionD(request.getOptionD());
        question.setCorrectAnswer(request.getCorrectAnswer().toUpperCase());
        question.setDifficultyLevel(request.getDifficultyLevel());
        question.setSkillTag(request.getSkillTag());
        question.setSkillId(request.getSkillId());
        question.setAssessmentId(request.getAssessmentId());

        return questionRepository.save(question);
    }

    private void validateCorrectAnswerMatchesOption(QuestionRequest request) {
        String answer = request.getCorrectAnswer().toUpperCase();
        String selectedOption = switch (answer) {
            case "A" -> request.getOptionA();
            case "B" -> request.getOptionB();
            case "C" -> request.getOptionC();
            case "D" -> request.getOptionD();
            default -> null;
        };

        if (selectedOption == null || selectedOption.isBlank()) {
            throw new BusinessValidationException("correctAnswer",
                    "Correct answer must match one of the available options");
        }
    }

    public Question findById(Long id) {
        return questionRepository.findById(id)
                .orElseThrow(() -> new BusinessValidationException("id", "Question does not exist"));
    }

    public List<Question> findByAssessmentId(Long assessmentId) {
        return questionRepository.findByAssessmentId(assessmentId);
    }

    public List<Question> findAll() {
        return questionRepository.findAll();
    }

    public long countByAssessmentId(Long assessmentId) {
        return questionRepository.countByAssessmentId(assessmentId);
    }

    public void deleteById(Long id) {
        questionRepository.deleteById(id);
    }
}
