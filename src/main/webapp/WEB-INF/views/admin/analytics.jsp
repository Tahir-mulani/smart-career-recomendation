<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Admin</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <li><a href="/admin/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/admin/analytics" class="active"><i class="fas fa-chart-bar"></i> Analytics</a></li>
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
                <h1>Analytics & Reports</h1>
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
            <!-- Stats Overview -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).size() %></h3>
                    <p>Total Users</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <h3><%= ((List<Result>) request.getAttribute("results")).size() %></h3>
                    <p>Assessments Completed</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3><%= ((List<Result>) request.getAttribute("results")).stream().mapToDouble(r -> r.getPercentage()).average().orElse(0.0) %>%</h3>
                    <p>Average Score</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).stream().filter(u -> u.getRegistrationDate() != null && u.getRegistrationDate().toString().startsWith("2024")).count() %></h3>
                    <p>New Registrations</p>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="admin-charts-grid">
                <div class="admin-chart-card">
                    <div class="admin-card-header">
                        <h3><i class="fas fa-chart-pie"></i> User Distribution</h3>
                    </div>
                    <div class="admin-card-body">
                        <canvas id="userDistributionChart"></canvas>
                    </div>
                </div>
                <div class="admin-chart-card">
                    <div class="admin-card-header">
                        <h3><i class="fas fa-chart-bar"></i> Assessment Performance</h3>
                    </div>
                    <div class="admin-card-body">
                        <canvas id="assessmentPerformanceChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Recent Activity Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-history"></i> Recent Assessment Results</h3>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Assessment ID</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Result> results = (List<Result>) request.getAttribute("results"); %>
                        <% if (results != null && !results.isEmpty()) { %>
                            <% for (int i = 0; i < Math.min(10, results.size()); i++) { %>
                                <% Result result = results.get(i); %>
                                <tr>
                                    <td><%= result.getUserId() %></td>
                                    <td><%= result.getAssessmentId() %></td>
                                    <td><%= result.getScore() %></td>
                                    <td><%= result.getPercentage() %>%</td>
                                    <td><span class="admin-badge <%= result.getPercentage() >= 70 ? "success" : result.getPercentage() >= 50 ? "warning" : "danger" %>"><%= result.getPercentage() >= 70 ? "Excellent" : result.getPercentage() >= 50 ? "Good" : "Needs Improvement" %></span></td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="5" style="text-align: center;">No assessment results found</td>
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

        // User Distribution Chart
        const userCtx = document.getElementById('userDistributionChart').getContext('2d');
        new Chart(userCtx, {
            type: 'doughnut',
            data: {
                labels: ['Regular Users', 'Admin Users'],
                datasets: [{
                    data: [
                        <%= ((List<User>) request.getAttribute("users")).stream().filter(u -> "USER".equals(u.getRole())).count() %>,
                        <%= ((List<User>) request.getAttribute("users")).stream().filter(u -> "ADMIN".equals(u.getRole())).count() %>
                    ],
                    backgroundColor: ['#3b82f6', '#f59e0b'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Assessment Performance Chart
        const perfCtx = document.getElementById('assessmentPerformanceChart').getContext('2d');
        new Chart(perfCtx, {
            type: 'bar',
            data: {
                labels: ['Excellent (90%+)', 'Good (70-89%)', 'Average (50-69%)', 'Below 50%'],
                datasets: [{
                    label: 'Number of Results',
                    data: [
                        <%= ((List<Result>) request.getAttribute("results")).stream().filter(r -> r.getPercentage() >= 90).count() %>,
                        <%= ((List<Result>) request.getAttribute("results")).stream().filter(r -> r.getPercentage() >= 70 && r.getPercentage() < 90).count() %>,
                        <%= ((List<Result>) request.getAttribute("results")).stream().filter(r -> r.getPercentage() >= 50 && r.getPercentage() < 70).count() %>,
                        <%= ((List<Result>) request.getAttribute("results")).stream().filter(r -> r.getPercentage() < 50).count() %>
                    ],
                    backgroundColor: ['#10b981', '#3b82f6', '#f59e0b', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
