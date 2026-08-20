package com.techhub.util;

import com.techhub.entity.User;
import com.techhub.exception.BusinessValidationException;
import com.techhub.service.UserService;
import org.springframework.stereotype.Component;

@Component
public class RoleChecker {

    private final UserService userService;

    public RoleChecker(UserService userService) {
        this.userService = userService;
    }

    public void requireAdminRole(Long userId) {
        if (userId == null) {
            throw new BusinessValidationException("adminUserId", "Admin user ID is required");
        }
        User user = userService.findById(userId);
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            throw new BusinessValidationException("adminUserId", "User does not have ADMIN privileges");
        }
    }
}
