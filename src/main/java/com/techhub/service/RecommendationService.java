package com.techhub.service;

import com.techhub.entity.*;
import com.techhub.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class RecommendationService {

    private static final Logger log = LoggerFactory.getLogger(RecommendationService.class);

    private final RecommendationRepository recommendationRepository;
    private final CareerRepository careerRepository;
    private final CareerSkillRepository careerSkillRepository;
    private final CareerInterestRepository careerInterestRepository;
    private final UserSkillRepository userSkillRepository;
    private final UserInterestRepository userInterestRepository;
    private final ResultRepository resultRepository;

    public RecommendationService(RecommendationRepository recommendationRepository,
                                 CareerRepository careerRepository,
                                 CareerSkillRepository careerSkillRepository,
                                 CareerInterestRepository careerInterestRepository,
                                 UserSkillRepository userSkillRepository,
                                 UserInterestRepository userInterestRepository,
                                 ResultRepository resultRepository) {
        this.recommendationRepository = recommendationRepository;
        this.careerRepository = careerRepository;
        this.careerSkillRepository = careerSkillRepository;
        this.careerInterestRepository = careerInterestRepository;
        this.userSkillRepository = userSkillRepository;
        this.userInterestRepository = userInterestRepository;
        this.resultRepository = resultRepository;
    }

    public Recommendation save(Recommendation recommendation) {
        return recommendationRepository.save(recommendation);
    }

    public Optional<Recommendation> findById(Long id) {
        return recommendationRepository.findById(id);
    }

    public List<Recommendation> findByUserId(Long userId) {
        return recommendationRepository.findByUserId(userId);
    }

    public List<Recommendation> findAll() {
        return recommendationRepository.findAll();
    }

    public void deleteByUserId(Long userId) {
        recommendationRepository.deleteByUserId(userId);
    }

    public void deleteById(Long id) {
        recommendationRepository.deleteById(id);
    }

    @Transactional
    public List<Recommendation> generateForUser(Long userId) {
        recommendationRepository.deleteByUserId(userId);

        List<Career> allCareers = careerRepository.findAll();
        List<UserSkill> userSkills = userSkillRepository.findByUserId(userId);
        List<UserInterest> userInterests = userInterestRepository.findByUserId(userId);
        List<Result> userResults = resultRepository.findByUserId(userId);

        // If user has not completed any test AND has no skills, do NOT generate recommendations
        if (userResults.isEmpty() && userSkills.isEmpty()) {
            return Collections.emptyList();
        }

        Set<Long> primarySkillIds = new HashSet<>();
        Set<Long> secondarySkillIds = new HashSet<>();
        for (UserSkill us : userSkills) {
            if (Boolean.TRUE.equals(us.getIsPrimary())) {
                primarySkillIds.add(us.getSkillId());
            } else {
                secondarySkillIds.add(us.getSkillId());
            }
        }

        Set<Long> interestIds = new HashSet<>();
        for (UserInterest ui : userInterests) {
            interestIds.add(ui.getInterestId());
        }

        double latestAssessmentPercentage = 0.0;
        if (!userResults.isEmpty()) {
            latestAssessmentPercentage = userResults.get(userResults.size() - 1).getPercentage();
        }

        List<Recommendation> generated = new ArrayList<>();

        for (Career career : allCareers) {
            List<CareerSkill> cSkills = careerSkillRepository.findByCareerId(career.getId());
            List<CareerInterest> cInterests = careerInterestRepository.findByCareerId(career.getId());

            // 1. Skill Score Component (50% Max Weight) - Primary = 1.0, Secondary = 0.6
            double skillScore = 0.0;
            if (!cSkills.isEmpty()) {
                double totalMatchedWeight = 0.0;
                for (CareerSkill cs : cSkills) {
                    if (primarySkillIds.contains(cs.getSkillId())) {
                        totalMatchedWeight += 1.0; // Full Primary Skill Mastery
                    } else if (secondarySkillIds.contains(cs.getSkillId())) {
                        totalMatchedWeight += 0.6; // Secondary Skill Base
                    }
                }
                double skillRatio = totalMatchedWeight / cSkills.size();
                skillScore = Math.min(50.0, skillRatio * 50.0);
            } else {
                skillScore = 30.0; // Default fallback if no skills defined for role
            }

            // 2. Domain Interest Component (15% Max Weight)
            double interestMatchScore = 0.0;
            if (!cInterests.isEmpty()) {
                int interestMatches = 0;
                for (CareerInterest ci : cInterests) {
                    if (interestIds.contains(ci.getInterestId())) {
                        interestMatches++;
                    }
                }
                interestMatchScore = ((double) interestMatches / cInterests.size()) * 15.0;
            } else {
                interestMatchScore = 10.0;
            }

            // 3. Assessment Test Score Component (35% Max Weight)
            double actualTestScoreComponent = (latestAssessmentPercentage / 100.0) * 35.0;

            // Total 100% Match Score
            double totalMatchScore = Math.min(100.0, skillScore + interestMatchScore + actualTestScoreComponent);

            log.info("Career Recommendation Generated: User={}, Role={}, MatchScore={}% (Skill={}, Interest={}, Test={})",
                    userId, career.getCareerName(), String.format("%.1f", totalMatchScore),
                    String.format("%.1f", skillScore), String.format("%.1f", interestMatchScore), String.format("%.1f", actualTestScoreComponent));

            if (totalMatchScore > 15.0) {
                Recommendation rec = new Recommendation();
                rec.setUserId(userId);
                rec.setCareerId(career.getId());
                rec.setMatchScore(totalMatchScore);
                generated.add(recommendationRepository.save(rec));
            }
        }

        generated.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));
        return generated;
    }
}
