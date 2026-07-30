package com.techhub.controller;


import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.techhub.dto.LoginRequest;
import com.techhub.dto.UserRegistrationRequest;
import com.techhub.entity.RoleChecker;
import com.techhub.entity.User;
import com.techhub.service.UserService;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;
    private final RoleChecker roleChecker;

    public UserController(UserService userService, RoleChecker roleChecker) {
        this.userService = userService;
        this.roleChecker = roleChecker;
    }

    @PostMapping("/register")
    public ResponseEntity<User> register(@Valid @RequestBody UserRegistrationRequest request) {
        User user = userService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(user);
    }

    @PostMapping("/login")
    public ResponseEntity<User> login(@Valid @RequestBody LoginRequest request) {
        User user = userService.login(request);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/admin/login")
    public ResponseEntity<User> adminLogin(@Valid @RequestBody LoginRequest request) {
        User user = userService.adminLogin(request);
        return ResponseEntity.ok(user);
    }

    @PutMapping("/{id}/profile")
    public ResponseEntity<User> updateProfile(@PathVariable Long id,
                                              @RequestParam(required = false) String name,
                                              @RequestParam(required = false) String phoneNumber,
                                              @RequestParam(required = false) String skills,
                                              @RequestParam(required = false) String interests) {
        User user = userService.updateProfile(id, name, phoneNumber, skills, interests);
        return ResponseEntity.ok(user);
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getById(@PathVariable Long id) {
        User user = userService.findById(id);
        return ResponseEntity.ok(user);
    }

    @GetMapping
    public ResponseEntity<List<User>> getAll() {
        List<User> users = userService.findAll();
        return ResponseEntity.ok(users);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id, @RequestParam Long adminUserId) {
        roleChecker.requireAdminRole(adminUserId);
        userService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout() {
        return ResponseEntity.ok("Logged out successfully");
    }
}
