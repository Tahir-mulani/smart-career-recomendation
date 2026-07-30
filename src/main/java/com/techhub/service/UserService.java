package com.techhub.service;

import org.springframework.stereotype.Service;

import com.techhub.dto.LoginRequest;
import com.techhub.dto.UserRegistrationRequest;
import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.UserRepository;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User register(UserRegistrationRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BusinessValidationException("email", "Email must be unique");
        }

        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setRole("USER");
        user.setRegistrationDate(java.time.LocalDate.now());

        return userRepository.save(user);
    }

    public User login(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BusinessValidationException("email", "Email does not exist"));

        if (!request.getPassword().equals(user.getPassword())) {
            throw new BusinessValidationException("password", "Invalid login credentials");
        }

        return user;
    }
    
    public User adminLogin(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BusinessValidationException("email", "Email does not exist"));

        if (!"ADMIN".equals(user.getRole())) {
            throw new BusinessValidationException("email", "Access denied. Admin access only.");
        }

        if (!request.getPassword().equals(user.getPassword())) {
            throw new BusinessValidationException("password", "Invalid login credentials");
        }

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
        userRepository.deleteById(id);
    }

    public User updateProfile(Long userId, String name, String phoneNumber, String skills, String interests) {
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
