package com.techhub.service;

import com.techhub.entity.*;
import com.techhub.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class RecommendationService {

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

            double skillMatchScore = 0.0;
            if (!cSkills.isEmpty()) {
                int primaryMatches = 0;
                int secondaryMatches = 0;
                for (CareerSkill cs : cSkills) {
                    if (primarySkillIds.contains(cs.getSkillId())) {
                        primaryMatches++;
                    } else if (secondarySkillIds.contains(cs.getSkillId())) {
                        secondaryMatches++;
                    }
                }
                double primaryRatio = (double) primaryMatches / cSkills.size();
                double secondaryRatio = (double) secondaryMatches / cSkills.size();
                skillMatchScore = (primaryRatio * 55.0) + (secondaryRatio * 25.0);
            } else {
                skillMatchScore = 30.0; // Baseline fallback
            }

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

            double assessmentBonus = (latestAssessmentPercentage / 100.0) * 10.0;

            double totalMatchScore = Math.min(100.0, skillMatchScore + interestMatchScore + assessmentBonus);

            if (totalMatchScore > 20.0) {
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
