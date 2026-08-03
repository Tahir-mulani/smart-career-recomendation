<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Smart Career Recommendation</title>
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
                <li><a href="/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/profile"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
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
                <h1>Dashboard Overview</h1>
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

            <!-- Welcome Section -->
            <div class="admin-form">
                <h3><i class="fas fa-user"></i> Welcome, <%= ((User) request.getAttribute("user")).getName() %>!</h3>
                <div class="admin-form-row">
                    <div class="admin-form-group">
                        <label>Email</label>
                        <input type="text" value="<%= ((User) request.getAttribute("user")).getEmail() %>" readonly style="background: #f5f5f5;">
                    </div>
                    <div class="admin-form-group">
                        <label>Phone Number</label>
                        <input type="text" value="<%= ((User) request.getAttribute("user")).getPhoneNumber() != null ? ((User) request.getAttribute("user")).getPhoneNumber() : "Not provided" %>" readonly style="background: #f5f5f5;">
                    </div>
                </div>
                <div class="admin-form-row">
                    <div class="admin-form-group">
                        <label>Skills</label>
                        <input type="text" value="<%= ((User) request.getAttribute("user")).getSkills() != null ? ((User) request.getAttribute("user")).getSkills() : "No skills added yet" %>" readonly style="background: #f5f5f5;">
                    </div>
                    <div class="admin-form-group">
                        <label>Interests</label>
                        <input type="text" value="<%= ((User) request.getAttribute("user")).getInterests() != null ? ((User) request.getAttribute("user")).getInterests() : "No interests added yet" %>" readonly style="background: #f5f5f5;">
                    </div>
                </div>
                <div class="admin-form-row">
                    <div class="admin-form-group">
                        <label>Member Since</label>
                        <input type="text" value="<%= ((User) request.getAttribute("user")).getRegistrationDate() != null ? ((User) request.getAttribute("user")).getRegistrationDate().toString() : "N/A" %>" readonly style="background: #f5f5f5;">
                    </div>
                    <div class="admin-form-group">
                        <label>Account Status</label>
                        <input type="text" value="Active" readonly style="background: #f5f5f5;">
                    </div>
                </div>
                <div class="admin-form-actions">
                    <a href="/profile" class="admin-btn admin-btn-primary">
                        <i class="fas fa-edit"></i> Update Profile
                    </a>
                    <a href="/api/generate-recommendations" class="admin-btn admin-btn-secondary">
                        <i class="fas fa-star"></i> Get Recommendations
                    </a>
                </div>
            </div>

            <!-- Recommended Assessments -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-clipboard-list"></i> Recommended Assessments</h3>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Test Name</th>
                            <th>Duration</th>
                            <th>Total Marks</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                        <% if (assessments != null && !assessments.isEmpty()) { %>
                            <% for (Assessment assessment : assessments) { %>
                                <tr>
                                    <td><%= assessment.getTestName() %></td>
                                    <td><%= assessment.getDuration() %> min</td>
                                    <td><%= assessment.getTotalMarks() %></td>
                                    <td>
                                        <a href="/assessment/<%= assessment.getId() %>" class="admin-btn admin-btn-primary">Take Assessment</a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="4" style="text-align: center;">No assessments available. Please update your skills in your profile.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Your Results -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-chart-bar"></i> Your Results</h3>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Assessment ID</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Result> results = (List<Result>) request.getAttribute("results"); %>
                        <% if (results != null && !results.isEmpty()) { %>
                            <% for (Result result : results) { %>
                                <tr>
                                    <td>Assessment #<%= result.getAssessmentId() %></td>
                                    <td><%= result.getScore() %></td>
                                    <td><%= result.getPercentage() %>%</td>
                                    <td>
                                        <% if (result.getPercentage() >= 70) { %>
                                            <span class="admin-badge active">Excellent</span>
                                        <% } else if (result.getPercentage() >= 50) { %>
                                            <span class="admin-badge" style="background: #ffc107; color: #000;">Good</span>
                                        <% } else { %>
                                            <span class="admin-badge" style="background: #dc3545;">Needs Improvement</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="4" style="text-align: center;">No results yet. Take an assessment to see your results.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Career Recommendations -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-star"></i> Career Recommendations</h3>
                    <div class="admin-table-actions">
                        <a href="/api/generate-recommendations" class="admin-btn admin-btn-primary">Generate New</a>
                        <a href="/recommendations" class="admin-btn admin-btn-secondary">View All</a>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Career ID</th>
                            <th>Match Score</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations"); %>
                        <% if (recommendations != null && !recommendations.isEmpty()) { %>
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
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="3" style="text-align: center;">No recommendations yet. Complete assessments to get career recommendations.</td>
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

