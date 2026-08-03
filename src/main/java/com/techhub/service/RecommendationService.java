package com.techhub.service;

import com.techhub.dto.RecommendationRequest;
import com.techhub.entity.Career;
import com.techhub.entity.Question;
import com.techhub.entity.Recommendation;
import com.techhub.entity.Result;
import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.RecommendationRepository;
import com.techhub.repository.ResultRepository;
import com.techhub.repository.QuestionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RecommendationService {

    private final RecommendationRepository recommendationRepository;
    private final UserService userService;
    private final CareerService careerService;
    private final ResultRepository resultRepository;
    private final QuestionRepository questionRepository;

    public RecommendationService(RecommendationRepository recommendationRepository,
                                 UserService userService,
                                 CareerService careerService,
                                 ResultRepository resultRepository,
                                 QuestionRepository questionRepository) {
        this.recommendationRepository = recommendationRepository;
        this.userService = userService;
        this.careerService = careerService;
        this.resultRepository = resultRepository;
        this.questionRepository = questionRepository;
    }

    public Recommendation save(RecommendationRequest request) {
        User user = userService.findById(request.getUserId());
        Career career = careerService.findById(request.getCareerId());
        validateUserHasCompletedAssessment(user.getId());

        Recommendation recommendation = new Recommendation();
        recommendation.setUserId(user.getId());
        recommendation.setCareerId(career.getId());
        recommendation.setMatchScore(request.getMatchScore());

        return recommendationRepository.save(recommendation);
    }

    @Transactional
    public List<Recommendation> generateForUser(Long userId) {
        User user = userService.findById(userId);
        List<Result> results = resultRepository.findByUserId(userId);

        if (results.isEmpty()) {
            throw new BusinessValidationException("userId",
                    "User must have completed at least one assessment");
        }

        // Delete existing recommendations for this user
        List<Recommendation> existingRecommendations = recommendationRepository.findByUserId(userId);
        for (Recommendation rec : existingRecommendations) {
            recommendationRepository.deleteById(rec.getId());
        }

        // Calculate skill scores from assessment results
        Map<String, Double> skillScores = calculateSkillScores(results);

        // Generate recommendations based on skill scores and career requirements
        List<Career> allCareers = careerService.findAll();
        List<Recommendation> newRecommendations = new ArrayList<>();

        for (Career career : allCareers) {
            double matchScore = calculateMatchScore(skillScores, career);
            if (matchScore > 0) {
                Recommendation recommendation = new Recommendation();
                recommendation.setUserId(user.getId());
                recommendation.setCareerId(career.getId());
                recommendation.setMatchScore(matchScore);
                newRecommendations.add(recommendationRepository.save(recommendation));
            }
        }

        // Sort by match score descending
        newRecommendations.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));

        return newRecommendations;
    }

    private Map<String, Double> calculateSkillScores(List<Result> results) {
        Map<String, Double> skillScores = new HashMap<>();
        Map<String, Integer> skillQuestionCounts = new HashMap<>();

        for (Result result : results) {
            List<Question> questions = questionRepository.findByAssessmentId(result.getAssessmentId());
            for (Question question : questions) {
                String skillTag = question.getSkillTag();
                if (skillTag != null && !skillTag.trim().isEmpty()) {
                    // Assume each correct answer contributes to skill score
                    // For simplicity, use percentage as contribution
                    double contribution = result.getPercentage() / questions.size();
                    skillScores.merge(skillTag, contribution, Double::sum);
                    skillQuestionCounts.merge(skillTag, 1, Integer::sum);
                }
            }
        }

        // Normalize scores by question count
        for (Map.Entry<String, Double> entry : skillScores.entrySet()) {
            int count = skillQuestionCounts.getOrDefault(entry.getKey(), 1);
            skillScores.put(entry.getKey(), entry.getValue() / count);
        }

        return skillScores;
    }

    private double calculateMatchScore(Map<String, Double> skillScores, Career career) {
        String requiredSkills = career.getRequiredSkills();
        if (requiredSkills == null || requiredSkills.trim().isEmpty()) {
            return 0.0;
        }

        List<String> careerSkills = Arrays.asList(requiredSkills.split(","))
                .stream()
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toList());

        if (careerSkills.isEmpty()) {
            return 0.0;
        }

        double totalScore = 0.0;
        int matchedSkills = 0;

        for (String careerSkill : careerSkills) {
            for (Map.Entry<String, Double> entry : skillScores.entrySet()) {
                String userSkill = entry.getKey();
                if (careerSkill.toLowerCase().contains(userSkill.toLowerCase()) ||
                    userSkill.toLowerCase().contains(careerSkill.toLowerCase())) {
                    totalScore += entry.getValue();
                    matchedSkills++;
                    break;
                }
            }
        }

        // Calculate match score as average of matched skills
        if (matchedSkills > 0) {
            return (totalScore / matchedSkills) * 100;
        }

        return 0.0;
    }

    private void validateUserHasCompletedAssessment(Long userId) {
        if (!resultRepository.existsByUserId(userId)) {
            throw new BusinessValidationException("userId",
                    "User must have completed at least one assessment");
        }
    }

    public Recommendation findById(Long id) {
        return recommendationRepository.findById(id)
                .orElseThrow(() -> new BusinessValidationException("id", "Recommendation does not exist"));
    }

    public List<Recommendation> findByUserId(Long userId) {
        return recommendationRepository.findByUserId(userId);
    }

    public List<Recommendation> findAll() {
        return recommendationRepository.findAll();
    }

    public void deleteById(Long id) {
        recommendationRepository.deleteById(id);
    }
}
