package com.techhub.controller;

import com.techhub.entity.*;
import com.techhub.service.*;
import com.techhub.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/v1")
@CrossOrigin(origins = "*", allowCredentials = "false")
public class RestApiController {

    @Autowired
    private UserService userService;

    @Autowired
    private AssessmentService assessmentService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private CareerService careerService;

    @Autowired
    private ResultService resultService;

    @Autowired
    private RecommendationService recommendationService;

    @Autowired
    private SkillService skillService;

    @Autowired
    private InterestService interestService;

    @Autowired
    private UserSkillRepository userSkillRepository;

    @Autowired
    private SkillRepository skillRepository;

    // Get current user session
    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body(Map.of("message", "Not logged in"));
        }
        return ResponseEntity.ok(user);
    }

    // Student Dashboard Data
    @GetMapping("/dashboard/{userId}")
    public ResponseEntity<?> getDashboardData(@PathVariable Long userId) {
        User user = userService.findById(userId);
        if (user == null) {
            return ResponseEntity.status(404).body(Map.of("message", "User not found"));
        }

        List<Assessment> assessments = assessmentService.findAll();
        List<Result> results = resultService.findByUserId(userId);
        List<Career> careers = careerService.findAll();

        List<Recommendation> recommendations = recommendationService.findByUserId(userId);
        if (recommendations != null && !recommendations.isEmpty()) {
            recommendations = new ArrayList<>(recommendations);
            recommendations.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));
            if (recommendations.size() > 3) {
                recommendations = recommendations.subList(0, 3);
            }
        }

        Map<String, Object> data = new HashMap<>();
        data.put("user", user);
        data.put("assessments", assessments);
        data.put("results", results);
        data.put("careers", careers);
        data.put("recommendations", recommendations != null ? recommendations : Collections.emptyList());

        return ResponseEntity.ok(data);
    }

    // Onboarding master data (skills & interests)
    @GetMapping("/onboarding/data")
    public ResponseEntity<?> getOnboardingData() {
        Map<String, Object> data = new HashMap<>();
        data.put("skills", skillService.findAll());
        data.put("interests", interestService.findAll());
        return ResponseEntity.ok(data);
    }

    // Submit Onboarding skills & interests
    @PostMapping("/onboarding/submit")
    public ResponseEntity<?> submitOnboarding(@RequestBody Map<String, Object> body) {
        Long userId = Long.valueOf(body.get("userId").toString());
        List<Integer> pSkills = (List<Integer>) body.get("primarySkills");
        List<Integer> sSkills = (List<Integer>) body.get("secondarySkills");
        List<Integer> interests = (List<Integer>) body.get("interests");

        List<Long> primarySkills = pSkills != null ? pSkills.stream().map(Long::valueOf).toList() : null;
        List<Long> secondarySkills = sSkills != null ? sSkills.stream().map(Long::valueOf).toList() : null;
        List<Long> userInterests = interests != null ? interests.stream().map(Long::valueOf).toList() : null;

        skillService.saveUserSkills(userId, primarySkills, secondarySkills);
        interestService.saveUserInterests(userId, userInterests);

        return ResponseEntity.ok(Map.of("message", "Onboarding completed successfully!"));
    }

    // Get Recommendations Data
    @GetMapping("/recommendations/{userId}")
    public ResponseEntity<?> getRecommendations(@PathVariable Long userId) {
        User user = userService.findById(userId);
        if (user == null) {
            return ResponseEntity.status(404).body(Map.of("message", "User not found"));
        }

        List<Recommendation> recommendations = recommendationService.findByUserId(userId);
        if (recommendations == null || recommendations.isEmpty()) {
            try {
                recommendations = recommendationService.generateForUser(userId);
            } catch (Exception ignored) {}
        }

        List<Career> careers = careerService.findAll();
        List<Result> userResults = resultService.findByUserId(userId);
        List<UserSkill> userSkills = userSkillRepository.findByUserId(userId);
        List<Skill> masterSkills = skillRepository.findAll();

        Map<String, Object> data = new HashMap<>();
        data.put("user", user);
        data.put("recommendations", recommendations != null ? recommendations : Collections.emptyList());
        data.put("careers", careers);
        data.put("userResults", userResults);
        data.put("userSkills", userSkills);
        data.put("masterSkills", masterSkills);

        return ResponseEntity.ok(data);
    }

    // Take Assessment Data
    @GetMapping("/assessment/{id}")
    public ResponseEntity<?> getAssessmentDetails(@PathVariable Long id) {
        Assessment assessment = assessmentService.findById(id);
        List<Question> questions = questionService.findByAssessmentId(id);
        return ResponseEntity.ok(Map.of(
            "assessment", assessment,
            "questions", questions
        ));
    }

    // Submit Assessment
    @PostMapping("/assessment/submit")
    public ResponseEntity<?> submitAssessment(@RequestBody Map<String, Object> body) {
        Long userId = Long.valueOf(body.get("userId").toString());
        Long assessmentId = Long.valueOf(body.get("assessmentId").toString());
        Map<String, Object> rawAnswers = (Map<String, Object>) body.get("answers");

        Map<Long, String> answers = new HashMap<>();
        if (rawAnswers != null) {
            for (Map.Entry<String, Object> entry : rawAnswers.entrySet()) {
                answers.put(Long.valueOf(entry.getKey()), entry.getValue().toString());
            }
        }

        // Generate recommendations
        try {
            recommendationService.generateForUser(userId);
        } catch (Exception ignored) {}

        return ResponseEntity.ok(Map.of("message", "Assessment submitted successfully!"));
    }
}
