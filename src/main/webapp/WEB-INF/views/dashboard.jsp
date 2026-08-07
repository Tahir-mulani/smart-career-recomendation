<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <% User user = (User) request.getAttribute("user"); %>
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Smart<span>Career</span></h2>
            <p style="color: #666; font-size: 12px; margin-top: 5px;">User Portal</p>
        </div>
        <nav class="admin-sidebar-nav">
            <ul>
                <li><a href="/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/profile"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
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
                <h1>User Dashboard</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar">
                        <%= (user != null && user.getName() != null && !user.getName().isEmpty()) ? Character.toUpperCase(user.getName().charAt(0)) : 'U' %>
                    </div>
                    <div>
                        <div class="admin-user-name"><%= (user != null && user.getName() != null) ? user.getName() : "User" %></div>
                        <div class="admin-user-role"><%= (user != null && user.getEmail() != null) ? user.getEmail() : "" %></div>
                    </div>
                </div>
                <a href="/logout" class="admin-logout-btn">
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

            <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
            <% List<Result> results = (List<Result>) request.getAttribute("results"); %>

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <div>
                        <h3><%= assessments != null ? assessments.size() : 0 %></h3>
                        <p>Available Assessments</p>
                    </div>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <h3><%= results != null ? results.size() : 0 %></h3>
                        <p>Tests Completed</p>
                    </div>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-lightbulb"></i>
                    </div>
                    <div>
                        <h3 style="font-size: 18px; word-break: break-word;"><%= (user != null && user.getSkills() != null && !user.getSkills().isEmpty()) ? user.getSkills() : "No Skills Added" %></h3>
                        <p>Your Skills</p>
                    </div>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-star"></i>
                    </div>
                    <div>
                        <h3>Active</h3>
                        <p>Account Status</p>
                    </div>
                </div>
            </div>

            <!-- Recommended Assessments -->
            <div class="admin-table-container" style="margin-bottom: 30px;">
                <div class="admin-table-header">
                    <h3><i class="fas fa-clipboard-list"></i> Recommended Assessments</h3>
                </div>
                <% if (assessments != null && !assessments.isEmpty()) { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Test Name</th>
                                <th>Duration</th>
                                <th>Total Marks</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Assessment assessment : assessments) { %>
                                <tr>
                                    <td><strong><%= assessment.getTestName() %></strong></td>
                                    <td><i class="fas fa-clock" style="color: #6b7280; margin-right: 5px;"></i> <%= assessment.getDuration() %> mins</td>
                                    <td><i class="fas fa-trophy" style="color: #f59e0b; margin-right: 5px;"></i> <%= assessment.getTotalMarks() %></td>
                                    <td><span class="admin-badge active">Available</span></td>
                                    <td>
                                        <a href="/assessment/<%= assessment.getId() %>" class="admin-btn admin-btn-primary">
                                            <i class="fas fa-play"></i> Take Assessment
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div style="padding: 30px; text-align: center; color: #6b7280;">
                        <p style="margin-bottom: 15px; font-size: 15px;">No assessments available. Please update your skills in your profile to receive relevant recommendations.</p>
                        <a href="/profile" class="admin-btn admin-btn-primary">
                            <i class="fas fa-user-edit"></i> Update Profile
                        </a>
                    </div>
                <% } %>
            </div>

            <!-- Test Results -->
            <div class="admin-table-container" style="margin-bottom: 30px;">
                <div class="admin-table-header">
                    <h3><i class="fas fa-chart-bar"></i> Your Assessment Results</h3>
                </div>
                <% if (results != null && !results.isEmpty()) { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Assessment</th>
                                <th>Score</th>
                                <th>Percentage</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Result result : results) { %>
                                <tr>
                                    <td><strong>Assessment #<%= result.getAssessmentId() %></strong></td>
                                    <td><%= result.getScore() %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 10px;">
                                            <div class="admin-progress-bar">
                                                <div class="admin-progress-fill" style="width: <%= Math.min(100, Math.max(0, result.getPercentage())) %>%;"></div>
                                            </div>
                                            <span><%= result.getPercentage() %>%</span>
                                        </div>
                                    </td>
                                    <td><span class="admin-badge success">Completed</span></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div style="padding: 30px; text-align: center; color: #6b7280;">
                        <p style="font-size: 15px;">No results yet. Take an assessment to see your performance here.</p>
                    </div>
                <% } %>
            </div>

            <!-- Career Recommendations -->
            <div class="admin-card">
                <div class="admin-card-header" style="display: flex; justify-content: space-between; align-items: center;">
                    <h3><i class="fas fa-briefcase"></i> Career Recommendations</h3>
                    <a href="/recommendations" class="admin-btn admin-btn-primary" style="padding: 6px 14px; font-size: 13px;">View All</a>
                </div>
                <div class="admin-card-body">
                    <% List<Career> careers = (List<Career>) request.getAttribute("careers"); %>
                    <% if (careers != null && !careers.isEmpty()) { %>
                        <div class="admin-charts-grid" style="grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); margin-bottom: 0;">
                            <% for (int i = 0; i < Math.min(3, careers.size()); i++) { %>
                                <% Career career = careers.get(i); %>
                                <div style="background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 10px; padding: 18px;">
                                    <h4 style="color: #1e3a8a; font-size: 16px; margin-bottom: 8px;"><i class="fas fa-star" style="color: #f59e0b; margin-right: 6px;"></i> <%= career.getCareerName() %></h4>
                                    <p style="color: #6b7280; font-size: 13px; margin-bottom: 10px;"><%= career.getDescription() != null ? career.getDescription() : "Recommended based on your skill set." %></p>
                                    <p style="font-size: 12px; color: #4b5563;"><i class="fas fa-tools" style="color: #3b82f6;"></i> <strong>Skills:</strong> <%= career.getRequiredSkills() %></p>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <p style="color: #6b7280; font-size: 14px;">Complete assessments or update your profile skills to get personalized career recommendations tailored to your profile.</p>
                    <% } %>
                </div>
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
