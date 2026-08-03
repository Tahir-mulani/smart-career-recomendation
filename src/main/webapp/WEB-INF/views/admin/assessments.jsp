<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assessment Management - Admin Dashboard</title>
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
                <li><a href="/admin/assessments" class="active"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
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
                <h1>Assessment Management</h1>
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
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Total Assessments</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Active Assessments</p>
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
                        <i class="fas fa-star"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).stream().mapToInt(Assessment::getTotalMarks).sum() %></h3>
                    <p>Total Marks</p>
                </div>
            </div>

            <!-- Create Assessment Form -->
            <div class="admin-form">
                <h3><i class="fas fa-plus-circle"></i> Create New Assessment</h3>
                <form action="/api/admin/create-assessment" method="post">
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="testName">Test Name</label>
                            <input type="text" id="testName" name="testName" required placeholder="Enter test name">
                        </div>
                        <div class="admin-form-group">
                            <label for="duration">Duration (minutes)</label>
                            <input type="number" id="duration" name="duration" required placeholder="Enter duration" min="1">
                        </div>
                        <div class="admin-form-group">
                            <label for="totalMarks">Total Marks</label>
                            <input type="number" id="totalMarks" name="totalMarks" required placeholder="Enter total marks" min="1">
                        </div>
                    </div>
                    <div class="admin-form-actions">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-plus"></i> Create Assessment
                        </button>
                        <button type="reset" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </form>
            </div>

            <!-- Assessments Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-clipboard-list"></i> All Assessments</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Search assessments..." onkeyup="searchAssessments()">
                        </div>
                    </div>
                </div>
                <table class="admin-table" id="assessmentsTable">
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
                            <% for (Assessment assessment : assessments) { %>
                                <tr>
                                    <td><%= assessment.getId() %></td>
                                    <td><%= assessment.getTestName() %></td>
                                    <td><%= assessment.getDuration() %> min</td>
                                    <td><%= assessment.getTotalMarks() %></td>
                                    <td>0</td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view" onclick="viewAssessment(<%= assessment.getId() %>)"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit" onclick="editAssessment(<%= assessment.getId() %>)"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete" onclick="deleteAssessment(<%= assessment.getId() %>)"><i class="fas fa-trash"></i></button>
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
        function toggleSidebar() {
            document.querySelector('.admin-sidebar').classList.toggle('open');
        }

        function searchAssessments() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('assessmentsTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                const td = tr[i].getElementsByTagName('td');
                let found = false;
                for (let j = 0; j < td.length; j++) {
                    if (td[j]) {
                        const txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                tr[i].style.display = found ? '' : 'none';
            }
        }

        function viewAssessment(id) {
            window.location.href = '/admin/assessments/' + id;
        }

        function editAssessment(id) {
            window.location.href = '/admin/assessments/' + id + '/edit';
        }

        function deleteAssessment(id) {
            if (confirm('Are you sure you want to delete this assessment? All associated questions will also be deleted.')) {
                window.location.href = '/admin/assessments/' + id + '/delete';
            }
        }
    </script>
</body>
</html>
