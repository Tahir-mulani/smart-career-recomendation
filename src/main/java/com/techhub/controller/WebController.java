package com.techhub.controller;

import com.techhub.entity.*;
import com.techhub.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
public class WebController {

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
    private AssessmentSubmissionService assessmentSubmissionService;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @GetMapping("/admin/login")
    public String adminLoginPage() {
        return "admin-login";
    }

    @PostMapping("/api/admin/login")
    public String adminLogin(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            com.techhub.dto.LoginRequest request = new com.techhub.dto.LoginRequest();
            request.setEmail(email);
            request.setPassword(password);
            User user = userService.login(request);
            
            // Check if user is admin
            if (!"ADMIN".equals(user.getRole())) {
                throw new RuntimeException("Access denied. Admin only.");
            }
            
            session.setAttribute("admin", user);
            return "redirect:/admin/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/login";
        }
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Assessment> assessments = assessmentService.findAll();
        List<Career> careers = careerService.findAll();
        List<User> users = userService.findAll();
        
        model.addAttribute("assessments", assessments);
        model.addAttribute("careers", careers);
        model.addAttribute("users", users);
        
        return "admin-dashboard";
    }

    @GetMapping("/admin/assessments")
    public String adminAssessments(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Assessment> assessments = assessmentService.findAll();
        model.addAttribute("assessments", assessments);
        
        return "admin-assessments";
    }

    @GetMapping("/admin/careers")
    public String adminCareers(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Career> careers = careerService.findAll();
        model.addAttribute("careers", careers);
        
        return "admin-careers";
    }

    @GetMapping("/admin/questions")
    public String adminQuestions(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Question> questions = questionService.findAll();
        List<Assessment> assessments = assessmentService.findAll();
        
        model.addAttribute("questions", questions);
        model.addAttribute("assessments", assessments);
        
        return "admin-questions";
    }

    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    @PostMapping("/api/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String phoneNumber,
                           RedirectAttributes redirectAttributes) {
        try {
            com.techhub.dto.UserRegistrationRequest request = new com.techhub.dto.UserRegistrationRequest();
            request.setName(name);
            request.setEmail(email);
            request.setPassword(password);
            request.setPhoneNumber(phoneNumber);
            User user = userService.register(request);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/register";
        }
    }

    @PostMapping("/api/login")
    public String login(@RequestParam String email,
                       @RequestParam String password,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        try {
            com.techhub.dto.LoginRequest request = new com.techhub.dto.LoginRequest();
            request.setEmail(email);
            request.setPassword(password);
            User user = userService.login(request);
            session.setAttribute("user", user);
            return "redirect:/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/dashboard")
    public String userDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        
        List<Assessment> assessments = assessmentService.findAll();
        model.addAttribute("assessments", assessments);
        
        List<Result> results = resultService.findByUserId(user.getId());
        model.addAttribute("results", results);
        
        List<Recommendation> recommendations = recommendationService.findByUserId(user.getId());
        model.addAttribute("recommendations", recommendations);
        
        return "dashboard";
    }

    @GetMapping("/recommendations")
    public String recommendations(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        
        List<Recommendation> recommendations = recommendationService.findByUserId(user.getId());
        model.addAttribute("recommendations", recommendations);
        
        return "recommendations";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/api/update-profile")
    public String updateProfile(@RequestParam Long userId,
                               @RequestParam(required = false) String name,
                               @RequestParam(required = false) String phoneNumber,
                               @RequestParam(required = false) String skills,
                               @RequestParam(required = false) String interests,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getId().equals(userId)) {
                throw new RuntimeException("Unauthorized access");
            }
            
            User updated = userService.updateProfile(userId, name, phoneNumber, skills, interests);
            session.setAttribute("user", updated);
            
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
            return "redirect:/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/profile";
        }
    }

    @GetMapping("/assessment/{id}")
    public String takeAssessment(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        Assessment assessment = assessmentService.findById(id);
        List<Question> questions = questionService.findByAssessmentId(id);
        
        model.addAttribute("user", user);
        model.addAttribute("assessment", assessment);
        model.addAttribute("questions", questions);
        
        return "assessment";
    }

    @PostMapping("/api/submit-assessment")
    public String submitAssessment(@RequestParam Long assessmentId,
                                   @RequestParam Long userId,
                                   @RequestParam Map<Long, String> answers,
                                   @RequestParam(required = false) String startTime,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.getId().equals(userId)) {
                throw new RuntimeException("Unauthorized access");
            }
            
            com.techhub.dto.AssessmentSubmissionRequest request = new com.techhub.dto.AssessmentSubmissionRequest();
            request.setUserId(userId);
            request.setTestId(assessmentId);
            request.setAnswers(answers);
            
            if (startTime != null && !startTime.isEmpty()) {
                request.setStartTime(java.time.LocalDateTime.parse(startTime));
            } else {
                request.setStartTime(java.time.LocalDateTime.now());
            }
            
            assessmentSubmissionService.save(request);
            
            // Generate recommendations after assessment
            try {
                recommendationService.generateForUser(userId);
            } catch (Exception e) {
                // Don't fail if recommendation generation fails
            }
            
            redirectAttributes.addFlashAttribute("success", "Assessment submitted successfully!");
            return "redirect:/dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/dashboard";
        }
    }

    @GetMapping("/api/generate-recommendations")
    public String generateRecommendations(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }
            
            recommendationService.generateForUser(user.getId());
            redirectAttributes.addFlashAttribute("success", "Recommendations generated successfully!");
            return "redirect:/recommendations";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/dashboard";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
