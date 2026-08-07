<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techhub.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - Admin</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Smart<span>Career</span></h2>
            <p style="color: #666; font-size: 12px; margin-top: 5px;">Admin Panel</p>
        </div>
        <nav class="admin-sidebar-nav">
            <ul>
                <li><a href="/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/admin/users" class="active"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
                <li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
                <li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
                <li><a href="/admin/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
                <li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
            </ul>
        </nav>
        <div class="admin-sidebar-footer">
            <p>&copy; 2024 Smart Career System</p>
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
                <h1>User Details</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar">A</div>
                    <div>
                        <div class="admin-user-name"><%= ((User) request.getAttribute("admin")).getName() %></div>
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
            <% User user = (User) request.getAttribute("user"); %>
            
            <!-- Back Button -->
            <a href="/admin/users" class="admin-btn admin-btn-secondary" style="margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>

            <!-- User Profile Card -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-user"></i> User Profile</h3>
                    <div class="admin-card-actions">
                        <span class="admin-badge <%= "ADMIN".equals(user.getRole()) ? "admin" : "user" %>"><%= user.getRole() %></span>
                    </div>
                </div>
                <div class="admin-card-body">
                    <div class="admin-profile-info">
                        <div class="admin-profile-avatar-large">
                            <%= user.getName() != null && !user.getName().isEmpty() ? user.getName().charAt(0) : "U" %>
                        </div>
                        <div class="admin-profile-details">
                            <h4><%= user.getName() %></h4>
                            <p class="admin-profile-email"><%= user.getEmail() %></p>
                            <p style="color: #6b7280; font-size: 14px; margin-top: 4px;">
                                <i class="fas fa-calendar"></i> Member since <%= user.getRegistrationDate() != null ? user.getRegistrationDate().toString() : "N/A" %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Information -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-info-circle"></i> Account Information</h3>
                </div>
                <div class="admin-card-body">
                    <table class="admin-info-table">
                        <tr>
                            <td><strong>User ID:</strong></td>
                            <td><%= user.getId() %></td>
                        </tr>
                        <tr>
                            <td><strong>Name:</strong></td>
                            <td><%= user.getName() %></td>
                        </tr>
                        <tr>
                            <td><strong>Email:</strong></td>
                            <td><%= user.getEmail() %></td>
                        </tr>
                        <tr>
                            <td><strong>Phone:</strong></td>
                            <td><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "Not provided" %></td>
                        </tr>
                        <tr>
                            <td><strong>Role:</strong></td>
                            <td><span class="admin-badge <%= "ADMIN".equals(user.getRole()) ? "admin" : "user" %>"><%= user.getRole() %></span></td>
                        </tr>
                        <tr>
                            <td><strong>Registration Date:</strong></td>
                            <td><%= user.getRegistrationDate() != null ? user.getRegistrationDate().toString() : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><strong>Account Status:</strong></td>
                            <td><span class="admin-badge success">Active</span></td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Skills and Interests -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-star"></i> Skills & Interests</h3>
                </div>
                <div class="admin-card-body">
                    <div style="margin-bottom: 20px;">
                        <h4 style="margin-bottom: 10px; color: #1e3a8a;">Skills</h4>
                        <% if (user.getSkills() != null && !user.getSkills().isEmpty()) { %>
                            <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                                <% for (String skill : user.getSkills().split(",")) { %>
                                    <span class="admin-badge info"><%= skill.trim() %></span>
                                <% } %>
                            </div>
                        <% } else { %>
                            <p style="color: #6b7280;">No skills added</p>
                        <% } %>
                    </div>
                    <div>
                        <h4 style="margin-bottom: 10px; color: #1e3a8a;">Interests</h4>
                        <% if (user.getInterests() != null && !user.getInterests().isEmpty()) { %>
                            <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                                <% for (String interest : user.getInterests().split(",")) { %>
                                    <span class="admin-badge warning"><%= interest.trim() %></span>
                                <% } %>
                            </div>
                        <% } else { %>
                            <p style="color: #6b7280;">No interests added</p>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-cog"></i> Account Actions</h3>
                </div>
                <div class="admin-card-body">
                    <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                        <form action="/api/admin/users/<%= user.getId() %>/delete" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user? This action cannot be undone.');">
                            <button type="submit" class="admin-btn admin-btn-danger">
                                <i class="fas fa-trash"></i> Delete User
                            </button>
                        </form>
                        <a href="/admin/users" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
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
