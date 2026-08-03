<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Career Recommendation</title>
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
                <li><a href="/admin/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/admin/users"><i class="fas fa-users"></i> User Management</a></li>
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
                <h1>Dashboard Overview</h1>
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

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).size() %></h3>
                    <p>Total Users</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +12% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Total Assessments</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +5% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h3><%= ((List<Question>) request.getAttribute("questions")).size() %></h3>
                    <p>Total Questions</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +8% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3><%= ((List<Career>) request.getAttribute("careers")).size() %></h3>
                    <p>Total Careers</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +3% this month</span>
                </div>
            </div>


            <!-- Recent Activity -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-clock"></i> Recent Users</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search users...">
                        </div>
                        <a href="/admin/users" class="admin-btn admin-btn-primary">View All</a>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Registration Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<User> users = (List<User>) request.getAttribute("users"); %>
                        <% if (users != null && !users.isEmpty()) { %>
                            <% for (int i = 0; i < Math.min(5, users.size()); i++) { %>
                                <% User user = users.get(i); %>
                                <tr>
                                    <td><%= user.getId() %></td>
                                    <td><%= user.getName() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><span class="admin-badge <%= "ADMIN".equals(user.getRole()) ? "admin" : "user" %>"><%= user.getRole() %></span></td>
                                    <td><%= user.getRegistrationDate() != null ? user.getRegistrationDate().toString() : "N/A" %></td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No users found</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Recent Assessments -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-clipboard-list"></i> Recent Assessments</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search assessments...">
                        </div>
                        <a href="/admin/assessments" class="admin-btn admin-btn-primary">View All</a>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Test Name</th>
                            <th>Duration</th>
                            <th>Total Marks</th>
                            <th>Questions</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                        <% if (assessments != null && !assessments.isEmpty()) { %>
                            <% for (int i = 0; i < Math.min(5, assessments.size()); i++) { %>
                                <% Assessment assessment = assessments.get(i); %>
                                <tr>
                                    <td><%= assessment.getId() %></td>
                                    <td><%= assessment.getTestName() %></td>
                                    <td><%= assessment.getDuration() %> min</td>
                                    <td><%= assessment.getTotalMarks() %></td>
                                    <td>0</td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No assessments found</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        // Toggle Sidebar
        function toggleSidebar() {
            document.querySelector('.admin-sidebar').classList.toggle('open');
        }
    </script>
</body>
</html>
