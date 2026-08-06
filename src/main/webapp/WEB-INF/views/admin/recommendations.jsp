<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recommendation Management - Smart Career Recommendation</title>
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
                <li><a href="/admin/users"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
                <li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
                <li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
                <li><a href="/admin/recommendations" class="active"><i class="fas fa-star"></i> Recommendations</a></li>
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
                <h1>Recommendation Management</h1>
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

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).size() %></h3>
                    <p>Total Recommendations</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).stream().filter(r -> r.getMatchScore() >= 80).count() %></h3>
                    <p>High Matches</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).stream().map(r -> r.getUserId()).distinct().count() %></h3>
                    <p>Users with Recommendations</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).stream().map(r -> r.getCareerId()).distinct().count() %></h3>
                    <p>Careers Recommended</p>
                </div>
            </div>

            <!-- Recommendations Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-star"></i> All Recommendations</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search recommendations...">
                        </div>
                        <select class="admin-filter-select">
                            <option value="">All Match Levels</option>
                            <option value="high">High Match (80%+)</option>
                            <option value="medium">Medium Match (60-79%)</option>
                            <option value="low">Low Match (<60%)</option>
                        </select>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Career ID</th>
                            <th>Match Score</th>
                            <th>Match Level</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations"); %>
                        <% if (recommendations != null && !recommendations.isEmpty()) { %>
                            <% for (Recommendation recommendation : recommendations) { %>
                                <tr>
                                    <td><%= recommendation.getId() %></td>
                                    <td><%= recommendation.getUserId() %></td>
                                    <td><%= recommendation.getCareerId() %></td>
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
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view" title="View Details"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn delete" title="Delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No recommendations found.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
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
