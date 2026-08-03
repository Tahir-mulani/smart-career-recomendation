<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Admin Dashboard</title>
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
                <h1>Reports & Analytics</h1>
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
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +12% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <h3><%= ((List<Result>) request.getAttribute("results")).size() %></h3>
                    <p>Assessments Completed</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +8% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).size() %></h3>
                    <p>Recommendations Generated</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +15% this month</span>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>78%</h3>
                    <p>Average Score</p>
                    <span class="stat-change positive"><i class="fas fa-arrow-up"></i> +5% this month</span>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="admin-charts-section">
                <div class="admin-chart-card">
                    <h3><i class="fas fa-chart-line"></i> User Growth Over Time</h3>
                    <div class="admin-chart-container">
                        <canvas id="userGrowthChart"></canvas>
                    </div>
                </div>
                <div class="admin-chart-card">
                    <h3><i class="fas fa-chart-bar"></i> Assessment Performance by Month</h3>
                    <div class="admin-chart-container">
                        <canvas id="assessmentPerformanceChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="admin-charts-section">
                <div class="admin-chart-card">
                    <h3><i class="fas fa-chart-pie"></i> Popular Career Recommendations</h3>
                    <div class="admin-chart-container">
                        <canvas id="careerRecommendationsChart"></canvas>
                    </div>
                </div>
                <div class="admin-chart-card">
                    <h3><i class="fas fa-chart-area"></i> Monthly Activity</h3>
                    <div class="admin-chart-container">
                        <canvas id="monthlyActivityChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="admin-charts-section">
                <div class="admin-chart-card" style="grid-column: 1 / -1;">
                    <h3><i class="fas fa-chart-bar"></i> User Statistics by Skill Category</h3>
                    <div class="admin-chart-container">
                        <canvas id="skillStatsChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- System Health -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-heartbeat"></i> System Health</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                    <div class="card">
                        <h4>Database Status</h4>
                        <p><span class="admin-badge active">Healthy</span></p>
                        <small>Last backup: 2 hours ago</small>
                    </div>
                    <div class="card">
                        <h4>Server Status</h4>
                        <p><span class="admin-badge active">Running</span></p>
                        <small>Uptime: 99.9%</small>
                    </div>
                    <div class="card">
                        <h4>Active Sessions</h4>
                        <p>24</p>
                        <small>Peak: 45</small>
                    </div>
                    <div class="card">
                        <h4>Memory Usage</h4>
                        <p>2.4 GB / 8 GB</p>
                        <small>30% utilized</small>
                    </div>
                </div>
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
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
                datasets: [{
                    label: 'New Users',
                    data: [12, 19, 25, 32, 45, 52, 68, 85],
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
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

        // Assessment Performance Chart
        const assessmentPerfCtx = document.getElementById('assessmentPerformanceChart').getContext('2d');
        new Chart(assessmentPerfCtx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Completed Assessments',
                    data: [45, 52, 68, 75, 82, 95],
                    backgroundColor: '#667eea'
                }, {
                    label: 'Average Score',
                    data: [72, 75, 78, 80, 82, 85],
                    backgroundColor: '#764ba2'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Career Recommendations Chart
        const careerRecCtx = document.getElementById('careerRecommendationsChart').getContext('2d');
        new Chart(careerRecCtx, {
            type: 'doughnut',
            data: {
                labels: ['Software Developer', 'Data Scientist', 'Product Manager', 'UX Designer', 'DevOps Engineer'],
                datasets: [{
                    data: [35, 25, 20, 12, 8],
                    backgroundColor: ['#667eea', '#764ba2', '#28a745', '#ffc107', '#dc3545']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
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
                    label: 'Logins',
                    data: [120, 150, 180, 210, 245, 280],
                    borderColor: '#28a745',
                    backgroundColor: 'rgba(40, 167, 69, 0.1)',
                    fill: true,
                    tension: 0.4
                }, {
                    label: 'Assessments Taken',
                    data: [45, 52, 68, 75, 82, 95],
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Skill Stats Chart
        const skillStatsCtx = document.getElementById('skillStatsChart').getContext('2d');
        new Chart(skillStatsCtx, {
            type: 'bar',
            data: {
                labels: ['Java', 'Python', 'JavaScript', 'SQL', 'React', 'Node.js', 'AWS', 'DevOps'],
                datasets: [{
                    label: 'Users with Skill',
                    data: [85, 72, 68, 55, 48, 42, 35, 28],
                    backgroundColor: [
                        '#667eea', '#764ba2', '#28a745', '#ffc107', '#dc3545', '#17a2b8', '#fd7e14', '#6c757d'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
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
