<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techhub.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <% User admin = (User) request.getAttribute("admin"); %>
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Smart<span>Career</span></h2>
            <p style="color: #666; font-size: 12px; margin-top: 5px;">Admin Panel</p>
        </div>
        <nav class="admin-sidebar-nav">
            <ul>
                <li><a href="/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/admin/users"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
                <li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
                <li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
                <li><a href="/admin/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
                <li><a href="/admin/profile" class="active"><i class="fas fa-user-cog"></i> Profile</a></li>
            </ul>
        </nav>
        <div class="admin-sidebar-footer">
            <p>&copy; 2026 Smart Career System</p>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Header -->
        <header class="admin-header">
            <div class="admin-header-left">
                <button class="admin-menu-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Admin Profile Settings</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar">
                        <%= (admin != null && admin.getName() != null && !admin.getName().isEmpty()) ? Character.toUpperCase(admin.getName().charAt(0)) : 'A' %>
                    </div>
                    <div>
                        <div class="admin-user-name"><%= (admin != null && admin.getName() != null) ? admin.getName() : "Admin" %></div>
                        <div class="admin-user-role">Administrator</div>
                    </div>
                </div>
                <a href="/admin/logout" class="admin-logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </header>

        <!-- Content -->
        <div class="admin-content">
            <% if (request.getAttribute("success") != null) { %>
                <div class="admin-alert admin-alert-success">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="admin-alert admin-alert-error">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Admin Profile Overview Card -->
            <div class="admin-card">
                <div class="admin-card-body">
                    <div class="admin-profile-info">
                        <div class="admin-profile-avatar-large" style="background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 100%);">
                            <%= (admin != null && admin.getName() != null && !admin.getName().isEmpty()) ? Character.toUpperCase(admin.getName().charAt(0)) : 'A' %>
                        </div>
                        <div class="admin-profile-details">
                            <h4><%= (admin != null && admin.getName() != null) ? admin.getName() : "Administrator" %></h4>
                            <p class="admin-profile-email"><i class="fas fa-envelope" style="margin-right: 5px;"></i> <%= (admin != null && admin.getEmail() != null) ? admin.getEmail() : "" %></p>
                            <span class="admin-badge admin"><i class="fas fa-user-shield"></i> System Administrator</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="admin-charts-grid">
                <!-- Update Account Details -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h3><i class="fas fa-user-edit"></i> Profile Details</h3>
                    </div>
                    <div class="admin-card-body">
                        <form action="/api/admin/update-profile" method="post" class="admin-form">
                            <input type="hidden" name="userId" value="<%= (admin != null) ? admin.getId() : "" %>">
                            
                            <div class="admin-form-group">
                                <label for="name"><i class="fas fa-user" style="color: #3b82f6; margin-right: 5px;"></i> Full Name</label>
                                <input type="text" id="name" name="name" value="<%= (admin != null && admin.getName() != null) ? admin.getName() : "" %>" required>
                            </div>
                            
                            <div class="admin-form-group">
                                <label for="email"><i class="fas fa-envelope" style="color: #3b82f6; margin-right: 5px;"></i> Email Address (Read-Only)</label>
                                <input type="email" id="email" value="<%= (admin != null && admin.getEmail() != null) ? admin.getEmail() : "" %>" readonly style="background: #f3f4f6; cursor: not-allowed;">
                            </div>

                            <div class="admin-form-group">
                                <label for="phoneNumber"><i class="fas fa-phone" style="color: #3b82f6; margin-right: 5px;"></i> Phone Number</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= (admin != null && admin.getPhoneNumber() != null) ? admin.getPhoneNumber() : "" %>" placeholder="Enter phone number">
                            </div>

                            <button type="submit" class="admin-btn admin-btn-primary" style="margin-top: 10px;">
                                <i class="fas fa-save"></i> Save Profile Updates
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Change Password Form -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h3><i class="fas fa-key"></i> Security Settings</h3>
                    </div>
                    <div class="admin-card-body">
                        <form action="/api/admin/change-password" method="post" class="admin-form">
                            <div class="admin-form-group">
                                <label for="currentPassword"><i class="fas fa-lock" style="color: #f59e0b; margin-right: 5px;"></i> Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" required placeholder="Enter current password">
                            </div>
                            
                            <div class="admin-form-group">
                                <label for="newPassword"><i class="fas fa-lock" style="color: #10b981; margin-right: 5px;"></i> New Password</label>
                                <input type="password" id="newPassword" name="newPassword" required placeholder="Enter new password">
                            </div>

                            <div class="admin-form-group">
                                <label for="confirmPassword"><i class="fas fa-check-double" style="color: #10b981; margin-right: 5px;"></i> Confirm New Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm new password">
                            </div>

                            <button type="submit" class="admin-btn admin-btn-warning" style="margin-top: 10px;">
                                <i class="fas fa-shield-alt"></i> Change Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        function toggleSidebar() {
            document.querySelector('.admin-sidebar').classList.toggle('open');
        }
    </script>
</body>
</html>
