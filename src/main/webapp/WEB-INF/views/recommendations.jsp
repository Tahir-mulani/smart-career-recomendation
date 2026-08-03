<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Recommendations - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Smart<span>Career</span></h2>
            <p style="color: #666; font-size: 12px; margin-top: 5px;">User Portal</p>
        </div>
        <nav class="admin-sidebar-nav">
            <ul>
                <li><a href="/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/profile"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="/recommendations" class="active"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
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
                <h1>Career Recommendations</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar"><%= ((User) request.getAttribute("user")).getName().charAt(0) %></div>
                    <div>
                        <div class="admin-user-name"><%= ((User) request.getAttribute("user")).getName() %></div>
                        <div class="admin-user-role">User</div>
                    </div>
                </div>
                <a href="/logout" class="admin-logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </header>

        <!-- Content -->
        <div class="admin-content">
            <% if (request.getAttribute("error") != null) { %>
                <div class="admin-alert admin-alert-error">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="admin-alert admin-alert-success">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <!-- Info Section -->
            <div class="admin-form">
                <h3><i class="fas fa-info-circle"></i> Your Career Recommendations</h3>
                <p style="color: #666; margin-bottom: 20px;">
                    Based on your assessment results, skills, and interests, here are the recommended career paths for you.
                </p>
                <div class="admin-form-actions">
                    <a href="/api/generate-recommendations" class="admin-btn admin-btn-primary">
                        <i class="fas fa-sync"></i> Generate New Recommendations
                    </a>
                    <a href="/dashboard" class="admin-btn admin-btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>

            <!-- Recommendations Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-star"></i> Recommended Careers</h3>
                </div>
                <% List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations"); %>
                <% if (recommendations != null && !recommendations.isEmpty()) { %>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Career ID</th>
                                <th>Match Score</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Recommendation recommendation : recommendations) { %>
                                <tr>
                                    <td>Career #<%= recommendation.getCareerId() %></td>
                                    <td><%= String.format("%.2f", recommendation.getMatchScore()) %>%</td>
                                    <td>
                                        <% if (recommendation.getMatchScore() >= 80) { %>
                                            <span class="admin-badge active">High Match</span>
                                        <% } else if (recommendation.getMatchScore() >= 60) { %>
                                            <span class="admin-badge" style="background: #ffc107; color: #000;">Medium Match</span>
                                        <% } else { %>
                                            <span class="admin-badge" style="background: #dc3545;">Low Match</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="/dashboard" class="admin-btn admin-btn-primary" style="padding: 5px 10px; font-size: 12px;">View Details</a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div style="text-align: center; padding: 40px;">
                        <i class="fas fa-folder-open" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                        <h3 style="color: #666;">No Recommendations Yet</h3>
                        <p style="color: #999;">Complete assessments to get personalized career recommendations based on your skills and performance.</p>
                        <div style="margin-top: 20px;">
                            <a href="/dashboard" class="admin-btn admin-btn-primary">Take Assessments</a>
                            <a href="/api/generate-recommendations" class="admin-btn admin-btn-secondary">Generate Recommendations</a>
                        </div>
                    </div>
                <% } %>
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
