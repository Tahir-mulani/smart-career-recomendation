package com.techhub.controller;

import com.techhub.entity.*;
import com.techhub.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import org.springframework.web.multipart.MultipartFile;
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
    private SkillService skillService;

    @Autowired
    private InterestService interestService;

    @Autowired
    private AssessmentInstanceService assessmentInstanceService;

    @Autowired
    private com.techhub.repository.AssessmentInstanceRepository assessmentInstanceRepository;

    @Autowired
    private com.techhub.repository.UserSkillRepository userSkillRepository;

    @Autowired
    private com.techhub.repository.SkillRepository skillRepository;

    @Autowired
    private com.techhub.util.JwtUtil jwtUtil;

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(WebController.class);

    @GetMapping("/")
    public String homePage() {
        return "home";
    }

    @GetMapping("/home")
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
        return "admin/login";
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
            
            String jwtToken = jwtUtil.generateToken(user.getEmail(), user.getRole());
            session.setAttribute("admin", user);
            session.setAttribute("jwtToken", jwtToken);
            log.info("Admin login successful for email: {}, Issued JWT Token", user.getEmail());
            return "redirect:/admin/dashboard";
        } catch (Exception e) {
            log.warn("Admin login failed for email {}: {}", email, e.getMessage());
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
        List<User> studentUsers = userService.findAll().stream()
                .filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole()))
                .collect(java.util.stream.Collectors.toList());
        List<Question> questions = questionService.findAll();
        
        model.addAttribute("assessments", assessments);
        model.addAttribute("careers", careers);
        model.addAttribute("users", studentUsers);
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
        
        List<User> studentUsers = userService.findAll().stream()
                .filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole()))
                .collect(java.util.stream.Collectors.toList());
        model.addAttribute("users", studentUsers);
        
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

        List<Skill> primarySkills = skillService.getUserPrimarySkills(id);
        List<Skill> allUserSkills = skillService.getUserSkills(id);
        List<Interest> userInterests = interestService.getUserInterests(id);

        List<Skill> secondarySkills = new java.util.ArrayList<>(allUserSkills);
        secondarySkills.removeAll(primarySkills);

        model.addAttribute("primarySkills", primarySkills);
        model.addAttribute("secondarySkills", secondarySkills);
        model.addAttribute("userSkills", allUserSkills);
        model.addAttribute("userInterests", userInterests);
        
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
        
        // Calculate question count for each assessment
        java.util.Map<Long, Integer> questionCounts = new java.util.HashMap<>();
        for (Assessment assessment : assessments) {
            int count = questionService.findByAssessmentId(assessment.getId()).size();
            questionCounts.put(assessment.getId(), count);
        }
        
        model.addAttribute("assessments", assessments);
        model.addAttribute("questionCounts", questionCounts);
        
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
        
        model.addAttribute("careers", careers);
        
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
        List<Skill> skills = skillService.findAll();
        
        model.addAttribute("questions", questions);
        model.addAttribute("assessments", assessments);
        model.addAttribute("skills", skills);
        
        return "admin/questions";
    }

    @GetMapping("/admin/recommendations")
    public String adminRecommendations(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        
        List<Recommendation> allRecs = recommendationService.findAll();
        List<User> users = userService.findAll();
        List<Career> careers = careerService.findAll();

        java.util.Map<Long, User> userMap = new java.util.HashMap<>();
        for (User u : users) {
            userMap.put(u.getId(), u);
        }
        java.util.Map<Long, Career> careerMap = new java.util.HashMap<>();
        for (Career c : careers) {
            careerMap.put(c.getId(), c);
        }

        // Group recommendations by userId
        java.util.Map<Long, List<Recommendation>> userRecsMap = new java.util.HashMap<>();
        for (Recommendation r : allRecs) {
            userRecsMap.computeIfAbsent(r.getUserId(), k -> new java.util.ArrayList<>()).add(r);
        }

        // Sort each user's recommendations descending by match score
        for (List<Recommendation> list : userRecsMap.values()) {
            list.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));
        }

        model.addAttribute("userRecsMap", userRecsMap);
        model.addAttribute("recommendations", allRecs);
        model.addAttribute("userMap", userMap);
        model.addAttribute("careerMap", careerMap);
        
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
        List<Result> results = resultService.findAll();
        List<Assessment> assessments = assessmentService.findAll();
        List<Question> questions = questionService.findAll();
        List<Career> careers = careerService.findAll();
        
        model.addAttribute("users", users);
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

    @PostMapping("/api/admin/assessments/{id}/update")
    public String updateAssessment(@PathVariable Long id,
                                   @RequestParam String testName,
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
            
            assessmentService.update(id, request);
            
            redirectAttributes.addFlashAttribute("success", "Assessment updated successfully!");
            return "redirect:/admin/assessments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/assessments";
        }
    }

    @PostMapping("/api/admin/assessments/{id}/delete")
    public String deleteAssessment(@PathVariable Long id,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            
            assessmentService.deleteById(id);
            
            redirectAttributes.addFlashAttribute("success", "Assessment deleted successfully!");
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
                                 @RequestParam(required = false) Long skillId,
                                 @RequestParam(required = false) Long assessmentId,
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
            request.setSkillId(skillId);
            request.setAssessmentId(assessmentId);
            
            questionService.save(request);
            
            redirectAttributes.addFlashAttribute("success", "Question added to Dynamic Question Bank successfully!");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/questions";
        }
    }

    @PostMapping("/api/admin/upload-questions-csv")
    public String uploadQuestionsCsv(@RequestParam("file") MultipartFile file,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }

            if (file == null || file.isEmpty()) {
                throw new RuntimeException("Please select a valid CSV file to upload.");
            }

            int count = 0;
            try (BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
                String line;
                boolean isHeader = true;
                while ((line = br.readLine()) != null) {
                    line = line.trim();
                    if (line.isEmpty()) continue;

                    if (isHeader && (line.toLowerCase().startsWith("question") || line.toLowerCase().startsWith("questiontext"))) {
                        isHeader = false;
                        continue;
                    }
                    isHeader = false;

                    String[] fields = parseCsvLine(line);
                    if (fields.length < 8) continue;

                    com.techhub.dto.QuestionRequest req = new com.techhub.dto.QuestionRequest();
                    req.setQuestionText(fields[0].trim());
                    req.setOptionA(fields[1].trim());
                    req.setOptionB(fields[2].trim());
                    req.setOptionC(fields[3].trim());
                    req.setOptionD(fields[4].trim());
                    req.setCorrectAnswer(fields[5].trim().toUpperCase());
                    req.setDifficultyLevel(fields[6].trim());
                    req.setSkillTag(fields[7].trim());

                    if (fields.length > 8 && !fields[8].trim().isEmpty() && !"null".equalsIgnoreCase(fields[8].trim())) {
                        try { req.setSkillId(Long.parseLong(fields[8].trim())); } catch (Exception ignored) {}
                    }
                    if (fields.length > 9 && !fields[9].trim().isEmpty() && !"null".equalsIgnoreCase(fields[9].trim())) {
                        try { req.setAssessmentId(Long.parseLong(fields[9].trim())); } catch (Exception ignored) {}
                    }

                    questionService.save(req);
                    count++;
                }
            }

            redirectAttributes.addFlashAttribute("success", "Successfully bulk imported " + count + " questions from CSV file!");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "CSV Upload failed: " + e.getMessage());
            return "redirect:/admin/questions";
        }
    }

    private String[] parseCsvLine(String line) {
        java.util.List<String> result = new java.util.ArrayList<>();
        boolean inQuotes = false;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                result.add(sb.toString());
                sb.setLength(0);
            } else {
                sb.append(c);
            }
        }
        result.add(sb.toString());
        return result.toArray(new String[0]);
    }

    @PostMapping("/api/admin/create-skill")
    public String createSkill(@RequestParam String skillName, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            if (skillService.findByName(skillName).isPresent()) {
                throw new RuntimeException("Skill '" + skillName + "' already exists!");
            }
            skillService.save(new Skill(skillName));
            redirectAttributes.addFlashAttribute("success", "Master Skill '" + skillName + "' added successfully!");
            return "redirect:/admin/careers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/careers";
        }
    }

    @PostMapping("/api/admin/create-interest")
    public String createInterest(@RequestParam String interestName, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User admin = (User) session.getAttribute("admin");
            if (admin == null || !"ADMIN".equals(admin.getRole())) {
                throw new RuntimeException("Access denied");
            }
            if (interestService.findByName(interestName).isPresent()) {
                throw new RuntimeException("Interest '" + interestName + "' already exists!");
            }
            interestService.save(new Interest(interestName));
            redirectAttributes.addFlashAttribute("success", "Domain Interest '" + interestName + "' added successfully!");
            return "redirect:/admin/careers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/careers";
        }
    }

    @PostMapping("/api/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String phoneNumber,
                           @RequestParam(required = false) String gender,
                           RedirectAttributes redirectAttributes) {
        try {
            com.techhub.dto.UserRegistrationRequest request = new com.techhub.dto.UserRegistrationRequest();
            request.setName(name);
            request.setEmail(email);
            request.setPassword(password);
            request.setPhoneNumber(phoneNumber);
            request.setGender(gender);
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
            String jwtToken = jwtUtil.generateToken(user.getEmail(), user.getRole());
            session.setAttribute("user", user);
            session.setAttribute("jwtToken", jwtToken);
            log.info("User login successful for email: {}, Issued JWT Token", user.getEmail());
            return "redirect:/dashboard";
        } catch (Exception e) {
            log.warn("User login failed for email {}: {}", email, e.getMessage());
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
        
        List<Career> careers = careerService.findAll();
        model.addAttribute("careers", careers);

        java.util.Map<Long, Career> careerMap = new java.util.HashMap<>();
        for (Career c : careers) {
            careerMap.put(c.getId(), c);
        }
        model.addAttribute("careerMap", careerMap);

        List<Recommendation> recommendations = recommendationService.findByUserId(user.getId());
        recommendations.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));
        if (recommendations.size() > 3) {
            recommendations = recommendations.subList(0, 3);
        }
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
        
        List<Career> careers = careerService.findAll();
        model.addAttribute("careers", careers);

        java.util.Map<Long, Career> careerMap = new java.util.HashMap<>();
        for (Career c : careers) {
            careerMap.put(c.getId(), c);
        }
        model.addAttribute("careerMap", careerMap);

        List<Recommendation> recommendations = recommendationService.findByUserId(user.getId());
        recommendations.sort((r1, r2) -> Double.compare(r2.getMatchScore(), r1.getMatchScore()));
        if (recommendations.size() > 3) {
            recommendations = recommendations.subList(0, 3);
        }
        model.addAttribute("recommendations", recommendations);

        List<Result> userResults = resultService.findByUserId(user.getId());
        model.addAttribute("userResults", userResults);

        List<UserSkill> userSkills = userSkillRepository.findByUserId(user.getId());
        model.addAttribute("userSkills", userSkills);

        List<Skill> masterSkills = skillRepository.findAll();
        java.util.Map<Long, Skill> masterSkillMap = new java.util.HashMap<>();
        for (Skill s : masterSkills) {
            masterSkillMap.put(s.getId(), s);
        }
        model.addAttribute("masterSkillMap", masterSkillMap);

        List<Assessment> assessments = assessmentService.findAll();
        model.addAttribute("assessments", assessments);
        
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
            
//            assessmentSubmissionService.save(request);
            
            // Generate recommendations after assessment
            try {
                //recommendationService.generateForUser(userId);
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
            
            List<Recommendation> generated = recommendationService.generateForUser(user.getId());
            if (generated.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "You have not completed any skill assessment test yet. Please complete your Skill Onboarding & Assessment first!");
                return "redirect:/dashboard";
            }
            redirectAttributes.addFlashAttribute("success", "Recommendations generated successfully based on your assessment!");
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

    @GetMapping("/onboarding")
    public String onboardingPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("skills", skillService.findAll());
        model.addAttribute("interests", interestService.findAll());
        return "onboarding";
    }

    @PostMapping("/api/onboarding")
    public String handleOnboarding(@RequestParam(required = false) List<Long> primarySkills,
                                   @RequestParam(required = false) List<Long> secondarySkills,
                                   @RequestParam(required = false) List<Long> interests,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        skillService.saveUserSkills(user.getId(), primarySkills, secondarySkills);
        interestService.saveUserInterests(user.getId(), interests);

        redirectAttributes.addFlashAttribute("success", "Skills and interests saved successfully!");
        return "redirect:/onboarding-success";
    }

    @GetMapping("/onboarding-success")
    public String onboardingSuccess(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "onboarding-success";
    }

    @GetMapping("/assessment/start")
    public String startAssessment(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // 24-Hour Assessment Cooldown Check
        java.util.Optional<AssessmentInstance> latestCompleted = assessmentInstanceRepository.findLatestCompletedInstance(user.getId());
        if (latestCompleted.isPresent()) {
            java.sql.Timestamp completedAt = latestCompleted.get().getCompletedAt();
            if (completedAt != null) {
                long now = System.currentTimeMillis();
                long diffMs = now - completedAt.getTime();
                long cooldownMs = 24 * 60 * 60 * 1000L; // 24 Hours
                if (diffMs < cooldownMs) {
                    long remainingMs = cooldownMs - diffMs;
                    long remainingHours = remainingMs / (1000 * 60 * 60);
                    long remainingMinutes = (remainingMs % (1000 * 60 * 60)) / (1000 * 60);

                    redirectAttributes.addFlashAttribute("error", 
                        "⏳ Assessment Re-take Cooldown Active! You completed an assessment recently. " +
                        "Please review your Skill Remediation Blueprint. Next assessment re-take unlocks in " +
                        remainingHours + "h " + remainingMinutes + "m.");
                    return "redirect:/recommendations";
                }
            }
        }

        AssessmentInstance instance = assessmentInstanceService.generateDynamicAssessment(user.getId());
        List<InstanceQuestion> instanceQuestions = assessmentInstanceService.getInstanceQuestions(instance.getId());

        List<Question> questions = new java.util.ArrayList<>();
        for (InstanceQuestion iq : instanceQuestions) {
            try {
                Question q = questionService.findById(iq.getQuestionId());
                if (q != null) {
                    questions.add(q);
                }
            } catch (Exception ignored) {}
        }

        model.addAttribute("instance", instance);
        model.addAttribute("questions", questions);
        return "take-assessment";
    }

    @PostMapping("/api/assessment/submit")
    public String submitAssessment(@RequestParam Long instanceId,
                                   @RequestParam(required = false, defaultValue = "0") Integer timeTaken,
                                   @RequestParam Map<String, String> allParams,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Map<Long, String> answers = new java.util.HashMap<>();
        for (Map.Entry<String, String> entry : allParams.entrySet()) {
            if (entry.getKey().startsWith("answers[")) {
                String qIdStr = entry.getKey().substring("answers[".length(), entry.getKey().length() - 1);
                try {
                    Long qId = Long.parseLong(qIdStr);
                    answers.put(qId, entry.getValue());
                } catch (Exception ignored) {}
            }
        }

        AssessmentInstance completed = assessmentInstanceService.submitAssessment(instanceId, answers, timeTaken);
        
        try {
            recommendationService.generateForUser(user.getId());
        } catch (Exception ignored) {}

        redirectAttributes.addFlashAttribute("success", "Assessment completed! Score: " + completed.getScore() + "/" + completed.getTotalQuestions() + " (" + String.format("%.1f", completed.getPercentage()) + "%)");
        return "redirect:/dashboard";
    }
}
