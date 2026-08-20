package com.techhub.service;

import com.techhub.dto.LoginRequest;
import com.techhub.dto.UserRegistrationRequest;
import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class UserService {

    private static final Logger log = LoggerFactory.getLogger(UserService.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, EmailService emailService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.emailService = emailService;
    }

    public User register(UserRegistrationRequest request) {
        log.info("Processing user registration for email: {}", request.getEmail());
        if (userRepository.existsByEmail(request.getEmail())) {
            log.warn("Registration failed: Email {} is already registered", request.getEmail());
            throw new BusinessValidationException("email", "Email must be unique");
        }

        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        // BCrypt Password Hashing (Point 1)
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setPhoneNumber(request.getPhoneNumber());
        user.setGender(request.getGender());
        user.setRole("USER");
        user.setRegistrationDate(LocalDate.now());

        User savedUser = userRepository.save(user);
        log.info("User registered successfully with ID: {}", savedUser.getId());

        // Send Welcome Email (Point 5)
        emailService.sendEmail(savedUser.getEmail(), 
                "Welcome to Smart Career Recommendation System!", 
                "Hello " + savedUser.getName() + ",\n\nWelcome to Smart Career Recommendation System! Your account has been registered successfully.\n\nBest regards,\nSmart Career Team");

        return savedUser;
    }

    public User login(LoginRequest request) {
        log.info("Processing login request for email: {}", request.getEmail());
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> {
                    log.warn("Login failed: Email {} not found", request.getEmail());
                    return new BusinessValidationException("email", "Email does not exist");
                });

        // BCrypt Password Verification with legacy fallback (Point 1)
        boolean passwordMatches = passwordEncoder.matches(request.getPassword(), user.getPassword())
                || request.getPassword().equals(user.getPassword());

        if (!passwordMatches) {
            log.warn("Login failed: Invalid password for user email {}", request.getEmail());
            throw new BusinessValidationException("password", "Invalid login credentials");
        }

        log.info("User login successful for email: {}", request.getEmail());
        return user;
    }

    public User adminLogin(LoginRequest request) {
        log.info("Processing admin login request for email: {}", request.getEmail());
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> {
                    log.warn("Admin login failed: Email {} not found", request.getEmail());
                    return new BusinessValidationException("email", "Email does not exist");
                });

        if (!"ADMIN".equals(user.getRole())) {
            log.warn("Admin login failed: User {} does not have ADMIN role", request.getEmail());
            throw new BusinessValidationException("email", "Access denied. Admin access only.");
        }

        boolean passwordMatches = passwordEncoder.matches(request.getPassword(), user.getPassword())
                || request.getPassword().equals(user.getPassword());

        if (!passwordMatches) {
            log.warn("Admin login failed: Invalid password for admin email {}", request.getEmail());
            throw new BusinessValidationException("password", "Invalid login credentials");
        }

        log.info("Admin login successful for email: {}", request.getEmail());
        return user;
    }

    public User findById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new BusinessValidationException("userId", "User does not exist"));
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new BusinessValidationException("email", "Email does not exist"));
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public void deleteById(Long id) {
        log.info("Deleting user with ID: {}", id);
        userRepository.deleteById(id);
    }

    public User updateProfile(Long userId, String name, String phoneNumber, String skills, String interests) {
        log.info("Updating profile for user ID: {}", userId);
        User user = findById(userId);
        if (name != null) {
            user.setName(name);
        }
        if (phoneNumber != null) {
            user.setPhoneNumber(phoneNumber);
        }
        return userRepository.save(user);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }
}
