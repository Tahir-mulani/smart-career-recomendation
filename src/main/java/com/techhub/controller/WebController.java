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
        return "home";
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
        List<Question> questions = questionService.findAll();
        
        model.addAttribute("assessments", assessments);
        model.addAttribute("careers", careers);
        model.addAttribute("users", users);
        model.addAttribute("questions", questions);
        
        return "admin/dashboard";
    }

    @GetMapping("/admin/users")
    public String adminUsers(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
        
        return "admin/users";
    }

    @GetMapping("/admin/users/{id}")
    public String adminViewUser(@PathVariable Long id, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        User user = userService.findById(id);
        model.addAttribute("user", user);
        
        return "admin/user-view";
    }

    @PostMapping("/api/admin/users/{id}/delete")
    public String adminDeleteUser(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            
            userService.deleteById(id);
            
            redirectAttributes.addFlashAttribute("success", "User deleted successfully!");
            return "redirect:/admin/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/users";
        }
    }

    @PostMapping("/api/admin/update-profile")
    public String adminUpdateProfile(@RequestParam Long userId,
                                     @RequestParam String name,
                                     @RequestParam String phoneNumber,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !admin.getId().equals(userId)) {
                throw new RuntimeException("Unauthorized access");
            }
            
            User updated = userService.updateProfile(userId, name, phoneNumber, null, null);
            session.setAttribute("admin", updated);
            
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
            return "redirect:/admin/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/profile";
        }
    }

    @PostMapping("/api/admin/change-password")
    public String adminChangePassword(@RequestParam String currentPassword,
                                       @RequestParam String newPassword,
                                       @RequestParam String confirmPassword,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null) {
                throw new RuntimeException("Unauthorized access");
            }
            
            if (!newPassword.equals(confirmPassword)) {
                throw new RuntimeException("New passwords do not match");
            }
            
            if (!currentPassword.equals(admin.getPassword())) {
                throw new RuntimeException("Current password is incorrect");
            }
            
            admin.setPassword(newPassword);
            userService.updateProfile(admin.getId(), admin.getName(), admin.getPhoneNumber(), admin.getSkills(), admin.getInterests());
            session.setAttribute("admin", admin);
            
            redirectAttributes.addFlashAttribute("success", "Password changed successfully!");
            return "redirect:/admin/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/profile";
        }
    }

    @GetMapping("/admin/assessments")
    public String adminAssessments(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Assessment> assessments = assessmentService.findAll();
        List<Question> questions = questionService.findAll();
        
        model.addAttribute("assessments", assessments);
        model.addAttribute("questions", questions);
        
        return "admin/assessments";
    }

    @GetMapping("/admin/careers")
    public String adminCareers(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Career> careers = careerService.findAll();
        List<Recommendation> recommendations = recommendationService.findAll();
        
        model.addAttribute("careers", careers);
        model.addAttribute("recommendations", recommendations);
        
        return "admin/careers";
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
        
        return "admin/questions";
    }

    @GetMapping("/admin/recommendations")
    public String adminRecommendations(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Recommendation> recommendations = recommendationService.findAll();
        model.addAttribute("recommendations", recommendations);
        
        return "admin/recommendations";
    }

    @GetMapping("/admin/analytics")
    public String adminAnalytics(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<User> users = userService.findAll();
        List<Recommendation> recommendations = recommendationService.findAll();
        List<Result> results = resultService.findAll();
        List<Assessment> assessments = assessmentService.findAll();
        List<Question> questions = questionService.findAll();
        List<Career> careers = careerService.findAll();
        
        model.addAttribute("users", users);
        model.addAttribute("recommendations", recommendations);
        model.addAttribute("results", results);
        model.addAttribute("assessments", assessments);
        model.addAttribute("questions", questions);
        model.addAttribute("careers", careers);
        
        return "admin/analytics";
    }

    @GetMapping("/admin/profile")
    public String adminProfile(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        return "admin/profile";
    }

    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    @PostMapping("/api/admin/create-assessment")
    public String createAssessment(@RequestParam String testName,
                                   @RequestParam Integer duration,
                                   @RequestParam Integer totalMarks,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            
            com.techhub.dto.AssessmentRequest request = new com.techhub.dto.AssessmentRequest();
            request.setTestName(testName);
            request.setDuration(duration);
            request.setTotalMarks(totalMarks);
            
            assessmentService.save(request);
            
            redirectAttributes.addFlashAttribute("success", "Assessment created successfully!");
            return "redirect:/admin/assessments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/assessments";
        }
    }

    @PostMapping("/api/admin/create-career")
    public String createCareer(@RequestParam String careerName,
                               @RequestParam String description,
                               @RequestParam String requiredSkills,
                               @RequestParam String qualification,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            
            com.techhub.dto.CareerRequest request = new com.techhub.dto.CareerRequest();
            request.setCareerName(careerName);
            request.setDescription(description);
            request.setRequiredSkills(requiredSkills);
            request.setQualification(qualification);
            
            careerService.save(request);
            
            redirectAttributes.addFlashAttribute("success", "Career created successfully!");
            return "redirect:/admin/careers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/careers";
        }
    }

    @PostMapping("/api/admin/create-question")
    public String createQuestion(@RequestParam String questionText,
                                 @RequestParam String optionA,
                                 @RequestParam String optionB,
                                 @RequestParam String optionC,
                                 @RequestParam String optionD,
                                 @RequestParam String correctAnswer,
                                 @RequestParam String difficultyLevel,
                                 @RequestParam String skillTag,
                                 @RequestParam Long assessmentId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            
            com.techhub.dto.QuestionRequest request = new com.techhub.dto.QuestionRequest();
            request.setQuestionText(questionText);
            request.setOptionA(optionA);
            request.setOptionB(optionB);
            request.setOptionC(optionC);
            request.setOptionD(optionD);
            request.setCorrectAnswer(correctAnswer);
            request.setDifficultyLevel(difficultyLevel);
            request.setSkillTag(skillTag);
            request.setAssessmentId(assessmentId);
            
            questionService.save(request);
            
            redirectAttributes.addFlashAttribute("success", "Question created successfully!");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/questions";
        }
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
