<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Smart Career Recommendation</title>
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
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Total Assessments</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h3><%= ((List<Question>) request.getAttribute("questions")).size() %></h3>
                    <p>Total Questions</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3><%= ((List<Career>) request.getAttribute("careers")).size() %></h3>
                    <p>Total Careers</p>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="admin-charts-grid">
                <!-- User Growth Chart -->
                <div class="admin-chart-card">
                    <div class="admin-chart-header">
                        <h3><i class="fas fa-chart-line"></i> User Growth</h3>
                    </div>
                    <div class="admin-chart-body">
                        <canvas id="userGrowthChart"></canvas>
                    </div>
                </div>

                <!-- Assessment Performance Chart -->
                <div class="admin-chart-card">
                    <div class="admin-chart-header">
                        <h3><i class="fas fa-chart-bar"></i> Assessment Performance</h3>
                    </div>
                    <div class="admin-chart-body">
                        <canvas id="assessmentPerformanceChart"></canvas>
                    </div>
                </div>

                <!-- Career Recommendations Chart -->
                <div class="admin-chart-card">
                    <div class="admin-chart-header">
                        <h3><i class="fas fa-chart-pie"></i> Popular Career Recommendations</h3>
                    </div>
                    <div class="admin-chart-body">
                        <canvas id="careerRecommendationsChart"></canvas>
                    </div>
                </div>

                <!-- User Activity Chart -->
                <div class="admin-chart-card">
                    <div class="admin-chart-header">
                        <h3><i class="fas fa-chart-area"></i> Monthly Activity</h3>
                    </div>
                    <div class="admin-chart-body">
                        <canvas id="monthlyActivityChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- System Statistics -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-server"></i> System Statistics</h3>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Metric</th>
                            <th>Value</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Total Database Records</td>
                            <td><%= ((List<User>) request.getAttribute("users")).size() + ((List<Assessment>) request.getAttribute("assessments")).size() + ((List<Question>) request.getAttribute("questions")).size() + ((List<Career>) request.getAttribute("careers")).size() %></td>
                            <td><span class="admin-badge active">Healthy</span></td>
                        </tr>
                        <tr>
                            <td>Active Sessions</td>
                            <td>1</td>
                            <td><span class="admin-badge active">Active</span></td>
                        </tr>
                        <tr>
                            <td>Registered Users</td>
                            <td><%= ((List<User>) request.getAttribute("users")).size() %></td>
                            <td><span class="admin-badge active">Growing</span></td>
                        </tr>
                        <tr>
                            <td>Assessments Completed</td>
                            <td><%= ((List<com.techhub.entity.Result>) request.getAttribute("results")).size() %></td>
                            <td><span class="admin-badge active">Tracking</span></td>
                        </tr>
                        <tr>
                            <td>System Health</td>
                            <td>98%</td>
                            <td><span class="admin-badge active">Excellent</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        function toggleSidebar() {
            document.querySelector('.admin-sidebar').classList.toggle('open');
        }

        // User Growth Chart
        const userGrowthCtx = document.getElementById('userGrowthChart').getContext('2d');
        new Chart(userGrowthCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'New Users',
                    data: [5, 12, 19, 25, 32, 40],
                    borderColor: '#3498db',
                    backgroundColor: 'rgba(52, 152, 219, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });

        // Assessment Performance Chart
        const assessmentPerfCtx = document.getElementById('assessmentPerformanceChart').getContext('2d');
        new Chart(assessmentPerfCtx, {
            type: 'bar',
            data: {
                labels: ['Java', 'Python', 'SQL', 'React', 'JavaScript'],
                datasets: [{
                    label: 'Average Score',
                    data: [75, 82, 68, 79, 71],
                    backgroundColor: [
                        '#3498db',
                        '#2ecc71',
                        '#f39c12',
                        '#e74c3c',
                        '#9b59b6'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });

        // Career Recommendations Chart
        const careerRecCtx = document.getElementById('careerRecommendationsChart').getContext('2d');
        new Chart(careerRecCtx, {
            type: 'doughnut',
            data: {
                labels: ['Software Developer', 'Data Analyst', 'Web Developer', 'DevOps Engineer'],
                datasets: [{
                    data: [35, 25, 20, 20],
                    backgroundColor: [
                        '#3498db',
                        '#2ecc71',
                        '#f39c12',
                        '#e74c3c'
                    ]
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

        // Monthly Activity Chart
        const monthlyActivityCtx = document.getElementById('monthlyActivityChart').getContext('2d');
        new Chart(monthlyActivityCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Assessments Taken',
                    data: [15, 28, 35, 42, 55, 68],
                    borderColor: '#2ecc71',
                    backgroundColor: 'rgba(46, 204, 113, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>
</body>
</html>
