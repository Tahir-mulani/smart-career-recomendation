package com.techhub.service;

import com.techhub.dto.ResultRequest;
import com.techhub.entity.Assessment;
import com.techhub.entity.Question;
import com.techhub.entity.Result;
import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.QuestionRepository;
import com.techhub.repository.ResultRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ResultService {

    private final ResultRepository resultRepository;
    private final UserService userService;
    private final AssessmentService assessmentService;
    private final QuestionRepository questionRepository;

    public ResultService(ResultRepository resultRepository,
                         UserService userService,
                         AssessmentService assessmentService,
                         QuestionRepository questionRepository) {
        this.resultRepository = resultRepository;
        this.userService = userService;
        this.assessmentService = assessmentService;
        this.questionRepository = questionRepository;
    }

    public Result save(ResultRequest request) {
        User user = userService.findById(request.getUserId());
        Assessment assessment = assessmentService.findById(request.getAssessmentId());
        validatePercentage(request.getScore(), assessment.getTotalMarks(), request.getPercentage());

        Result result = new Result();
        result.setUserId(user.getId());
        result.setAssessmentId(assessment.getId());
        result.setScore(request.getScore());
        result.setPercentage(request.getPercentage());

        return resultRepository.save(result);
    }

    public Result evaluateAndSave(User user, Assessment assessment, Map<Long, String> answers) {
        List<Question> questions = questionRepository.findByAssessmentId(assessment.getId());
        int score = 0;

        for (Question question : questions) {
            String selected = answers.get(question.getId());
            if (selected != null && selected.equalsIgnoreCase(question.getCorrectAnswer())) {
                score++;
            }
        }

        double percentage = assessment.getTotalMarks() == 0
                ? 0.0
                : (score * 100.0) / assessment.getTotalMarks();

        Result result = new Result();
        result.setUserId(user.getId());
        result.setAssessmentId(assessment.getId());
        result.setScore(score);
        result.setPercentage(percentage);

        return resultRepository.save(result);
    }

    private void validatePercentage(int score, int totalMarks, double percentage) {
        if (totalMarks <= 0) {
            throw new BusinessValidationException("percentage", "Total marks must be greater than 0");
        }

        double expected = (score * 100.0) / totalMarks;
        if (Math.abs(expected - percentage) > 0.01) {
            throw new BusinessValidationException("percentage", "Percentage must be calculated correctly");
        }
    }

    public Result findById(Long id) {
        return resultRepository.findById(id)
                .orElseThrow(() -> new BusinessValidationException("id", "Result does not exist"));
    }

    public List<Result> findByUserId(Long userId) {
        return resultRepository.findByUserId(userId);
    }

    public List<Result> findAll() {
        return resultRepository.findAll();
    }

    public boolean existsByUserId(Long userId) {
        return resultRepository.existsByUserId(userId);
    }

    public void deleteById(Long id) {
        resultRepository.deleteById(id);
    }

    public Map<String, Object> getUserAnalytics(Long userId) {
        List<Result> results = findByUserId(userId);
        
        if (results.isEmpty()) {
            return Map.of(
                "userId", userId,
                "totalAssessments", 0,
                "averagePercentage", 0.0,
                "highestScore", 0,
                "lowestScore", 0,
                "recentResults", List.of()
            );
        }

        double averagePercentage = results.stream()
            .mapToDouble(Result::getPercentage)
            .average()
            .orElse(0.0);
        
        int highestScore = results.stream()
            .mapToInt(Result::getScore)
            .max()
            .orElse(0);
        
        int lowestScore = results.stream()
            .mapToInt(Result::getScore)
            .min()
            .orElse(0);

        return Map.of(
            "userId", userId,
            "totalAssessments", results.size(),
            "averagePercentage", averagePercentage,
            "highestScore", highestScore,
            "lowestScore", lowestScore,
            "recentResults", results
        );
    }

    public Map<String, Object> getSystemAnalytics() {
        List<Result> allResults = findAll();
        
        if (allResults.isEmpty()) {
            return Map.of(
                "totalResults", 0,
                "averagePercentage", 0.0,
                "totalUsers", 0,
                "totalAssessments", 0
            );
        }

        double averagePercentage = allResults.stream()
            .mapToDouble(Result::getPercentage)
            .average()
            .orElse(0.0);
        
        long totalUsers = allResults.stream()
            .map(Result::getUserId)
            .distinct()
            .count();
        
        long totalAssessments = allResults.stream()
            .map(Result::getAssessmentId)
            .distinct()
            .count();

        return Map.of(
            "totalResults", allResults.size(),
            "averagePercentage", averagePercentage,
            "totalUsers", totalUsers,
            "totalAssessments", totalAssessments
        );
    }
}
