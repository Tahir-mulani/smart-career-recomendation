package com.techhub.util;

import org.springframework.stereotype.Component;

import com.techhub.exception.BusinessValidationException;
import com.techhub.service.UserService;
@Component
public class RoleChecker {

    private final UserService userService;

    public RoleChecker(UserService userService) {
        this.userService = userService;
    }

    public void requireAdminRole(Long userId) {
        com.techhub.entity.User user = userService.findById(userId);
        if (!"ADMIN".equals(user.getRole())) {
            throw new BusinessValidationException("role", "Access denied. Admin access only.");
        }
    }

    public void requireAnyRole(Long userId, String... allowedRoles) {
        com.techhub.entity.User user = userService.findById(userId);
        for (String role : allowedRoles) {
            if (role.equals(user.getRole())) {
                return;
            }
        }
        throw new BusinessValidationException("role", "Access denied. Required roles: " + String.join(", ", allowedRoles));
    }

    public boolean isAdmin(Long userId) {
        com.techhub.entity.User user = userService.findById(userId);
        return "ADMIN".equals(user.getRole());
    }
}
