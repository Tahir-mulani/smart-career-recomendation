<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - Smart Career Recommendation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style type="text/css">
        /* Executive Admin UI Color Palette (Royal Indigo & Slate Theme) */
        :root {
            --primary-cyan: #818cf8;
            --primary-hover: #6366f1;
            --bg-dark-blue: #0f172a;
            --admin-gold: #fbbf24;
            --bg-gradient: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --bg: #f1f5f9;
            --white: #ffffff;
            --text: #0f172a;
            --text-light: #f8fafc;
            --text-muted: #64748b;
            --border: #cbd5e1;
        }

        body.admin-body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg);
            color: var(--text);
            margin: 0;
            overflow-x: hidden;
        }

        /* Base Layout - FIXED for side-by-side display */
        .dashboard-layout {
            display: flex;
            flex-direction: row !important; 
            flex-wrap: nowrap !important; 
            min-height: 100vh;
            width: 100%;
            align-items: stretch;
            overflow-x: hidden;
        }

        /* Sidebar - FIXED to prevent shrinking */
        .admin-sidebar {
            width: 260px;
            min-width: 260px;
            flex-shrink: 0; 
            background: var(--bg-dark-blue);
            color: var(--text-light);
            box-shadow: 5px 0 20px rgba(0, 0, 0, .05);
            transition: margin-left 0.3s ease;
            display: flex;
            flex-direction: column;
            position: relative;
            z-index: 10;
        }

        .admin-sidebar.collapsed {
            margin-left: -260px;
        }

        .admin-sidebar-header {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .admin-sidebar-header h2 {
            color: var(--white);
            font-size: 26px;
            font-weight: 700;
            margin: 0;
        }

        .admin-sidebar-header h2 span {
            color: var(--primary-cyan);
        }

        .admin-sidebar-nav {
            flex: 1;
        }

        .admin-sidebar-nav ul {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }

        .admin-sidebar-nav ul li {
            margin: 10px 15px;
        }

        .admin-sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--text-muted);
            padding: 14px 18px;
            border-radius: 12px;
            transition: .3s;
            text-decoration: none;
            font-weight: 500;
        }

        .admin-sidebar-nav a:hover, .admin-sidebar-nav a.active {
            background: rgba(34, 211, 238, 0.1);
            color: var(--primary-cyan);
        }

        .admin-sidebar-nav i {
            width: 20px;
            text-align: center;
        }

        .admin-sidebar-footer {
            padding: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 12px;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Main Content Area */
        .admin-main {
            flex: 1;
            flex-grow: 1;
            width: calc(100% - 260px); 
            background: var(--bg);
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        /* Header */
        .admin-header {
            background: var(--white);
            padding: 18px 35px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, .03);
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 5;
        }

        .admin-header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .admin-header h1 {
            color: var(--bg-dark-blue);
            font-weight: 600;
            font-size: 1.5rem;
            margin: 0;
        }

        .admin-menu-toggle {
            background: none;
            border: none;
            font-size: 1.2rem;
            color: var(--text);
            cursor: pointer;
            padding: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .admin-header-right {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .admin-user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .admin-user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary-cyan);
            color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            font-weight: 600;
        }

        .admin-user-name {
            font-weight: 600;
            font-size: 0.9rem;
            line-height: 1.2;
        }

        .admin-user-role {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .admin-logout-btn {
            color: var(--danger);
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .admin-logout-btn:hover {
            color: #b91c1c;
        }

        /* Content Area */
        .admin-content {
            padding: 35px;
            overflow-y: auto;
        }

        /* Stats Grid */
        .admin-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 35px;
        }

        .admin-stat-card {
            background: var(--bg-gradient);
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            color: var(--text-light);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .admin-stat-card-icon {
            font-size: 2rem;
            margin-bottom: 15px;
            opacity: 0.8;
            color: var(--primary-cyan);
        }

        .admin-stat-card h3 {
            font-size: 2.2rem;
            color: var(--white);
            margin: 0 0 5px 0;
            line-height: 1;
        }

        .admin-stat-card p {
            margin: 0;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.7);
            font-weight: 500;
        }

        .admin-stat-card::after {
            content: '';
            position: absolute;
            top: -20px;
            right: -20px;
            width: 100px;
            height: 100px;
            background: rgba(34, 211, 238, 0.05);
            border-radius: 50%;
        }

        /* Charts Section */
        .admin-charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
            gap: 25px;
            margin-bottom: 35px;
        }

        .admin-chart-card {
            background: var(--white);
            border-radius: 18px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .03);
            border: 1px solid var(--border);
        }

        .admin-chart-header {
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 15px;
        }

        .admin-chart-header h3 {
            color: var(--bg-dark-blue);
            margin: 0;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .admin-chart-header h3 i {
            color: var(--primary-cyan);
        }

        .admin-chart-body {
            position: relative;
            height: 300px;
            width: 100%;
        }

        /* Tables */
        .admin-table-container {
            background: var(--white);
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .03);
            border: 1px solid var(--border);
            overflow-x: auto;
            margin-bottom: 30px;
        }

        .admin-table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        .admin-table-header h3 {
            color: var(--bg-dark-blue);
            margin: 0;
            font-size: 1.25rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .admin-table-header h3 i {
            color: var(--primary-cyan);
        }

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        .admin-table th, .admin-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .admin-table th {
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .admin-table td {
            font-size: 0.95rem;
            color: var(--text);
            font-weight: 500;
        }

        /* Badges */
        .admin-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
            text-align: center;
        }

        .admin-badge.active {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        /* Ensure charts layout breaks cleanly on small screens */
        @media (max-width: 1024px) {
            .admin-charts-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="admin-body">
    <div class="dashboard-layout">
        <!-- Sidebar -->
        <aside class="admin-sidebar" id="sidebar">
            <div class="admin-sidebar-header">
                <h2>Smart<span>Career</span></h2>
                <p style="color: var(--admin-gold); font-weight: 700; font-size: 11px; margin-top: 5px; margin-bottom: 0; letter-spacing: 1px; text-transform: uppercase;">
                    <i class="fas fa-shield-alt"></i> Executive Control Center
                </p>
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
                <p style="margin: 0;">&copy; 2026 Smart Career System</p>
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
                        <div class="admin-user-avatar"><%= ((User) request.getAttribute("admin")).getName().charAt(0) %></div>
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
                        <div class="admin-stat-card-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3><%= ((List<User>) request.getAttribute("users")).size() %></h3>
                        <p>Total Users</p>
                    </div>
                    <div class="admin-stat-card">
                        <div class="admin-stat-card-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                        <p>Total Assessments</p>
                    </div>
                    <div class="admin-stat-card">
                        <div class="admin-stat-card-icon">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <h3><%= ((List<Question>) request.getAttribute("questions")).size() %></h3>
                        <p>Total Questions</p>
                    </div>
                    <div class="admin-stat-card">
                        <div class="admin-stat-card-icon">
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

                <%
                List<User> userList = (List<User>) request.getAttribute("users");
                List<Assessment> asmList = (List<Assessment>) request.getAttribute("assessments");
                List<Question> qList = (List<Question>) request.getAttribute("questions");
                List<Career> carList = (List<Career>) request.getAttribute("careers");
                List<com.techhub.entity.Result> resList = (List<com.techhub.entity.Result>) request.getAttribute("results");

                int uCount = userList != null ? userList.size() : 0;
                int aCount = asmList != null ? asmList.size() : 0;
                int qCount = qList != null ? qList.size() : 0;
                int cCount = carList != null ? carList.size() : 0;
                int rCount = resList != null ? resList.size() : 0;
                int totalRecords = uCount + aCount + qCount + cCount;
                %>
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
                                <td><%= totalRecords %></td>
                                <td><span class="admin-badge active">Healthy</span></td>
                            </tr>
                            <tr>
                                <td>Active Sessions</td>
                                <td>1</td>
                                <td><span class="admin-badge active">Active</span></td>
                            </tr>
                            <tr>
                                <td>Registered Users</td>
                                <td><%= uCount %></td>
                                <td><span class="admin-badge active">Growing</span></td>
                            </tr>
                            <tr>
                                <td>Assessments Completed</td>
                                <td><%= rCount %></td>
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
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }

        // Global Chart Defaults for Modern Look
        Chart.defaults.font.family = "'Poppins', sans-serif";
        Chart.defaults.color = '#94a3b8';

        // User Growth Chart
        const userGrowthCtx = document.getElementById('userGrowthChart').getContext('2d');
        new Chart(userGrowthCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'New Users',
                    data: [5, 12, 19, 25, 32, 40],
                    borderColor: '#22d3ee',
                    backgroundColor: 'rgba(34, 211, 238, 0.15)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#22d3ee'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { grid: { color: 'rgba(0,0,0,0.05)' } },
                    x: { grid: { display: false } }
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
                        '#22d3ee', // Cyan
                        '#10b981', // Success Green
                        '#f59e0b', // Warning Orange
                        '#ef4444', // Danger Red
                        '#06b6d4'  // Darker Cyan
                    ],
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { grid: { color: 'rgba(0,0,0,0.05)' } },
                    x: { grid: { display: false } }
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
                        '#22d3ee', 
                        '#10b981', 
                        '#f59e0b', 
                        '#0a141f'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { padding: 20, usePointStyle: true }
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
                    borderColor: '#10b981',
                    backgroundColor: 'rgba(16, 185, 129, 0.15)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#10b981'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { grid: { color: 'rgba(0,0,0,0.05)' } },
                    x: { grid: { display: false } }
                }
            }
        });
    </script>
</body>
</html>