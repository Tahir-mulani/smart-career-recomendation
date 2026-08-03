<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
    <header>
        <div class="container header-content">
            <div class="logo">Smart<span>Career</span> <span style="font-size: 14px; color: #666;">Admin</span></div>
            <nav>
                <ul>
                    <li><a href="/admin/dashboard">Dashboard</a></li>
                    <li><a href="/admin/assessments">Assessments</a></li>
                    <li><a href="/admin/careers">Careers</a></li>
                    <li><a href="/admin/questions">Questions</a></li>
                    <li><a href="/admin/logout">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="dashboard">
            <div class="dashboard-header">
                <h2>Admin Dashboard</h2>
                <div class="user-info">
                    <div class="user-avatar">
                        A
                    </div>
                    <div>
                        <strong><%= ((User) request.getAttribute("admin")).getName() %></strong><br>
                        <small>Administrator</small>
                    </div>
                </div>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Assessments</p>
                </div>
                <div class="stat-card">
                    <h3><%= ((List<Career>) request.getAttribute("careers")).size() %></h3>
                    <p>Careers</p>
                </div>
                <div class="stat-card">
                    <h3><%= ((List<User>) request.getAttribute("users")).size() %></h3>
                    <p>Users</p>
                </div>
            </div>

            <div class="admin-nav">
                <a href="/admin/assessments" class="active">Manage Assessments</a>
                <a href="/admin/careers">Manage Careers</a>
                <a href="/admin/questions">Manage Questions</a>
            </div>

            <h3>Recent Assessments</h3>
            <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
            <% if (assessments != null && !assessments.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Duration</th>
                        <th>Total Marks</th>
                    </tr>
                    <% for (Assessment assessment : assessments) { %>
                        <tr>
                            <td><%= assessment.getId() %></td>
                            <td><%= assessment.getTestName() %></td>
                            <td><%= assessment.getDuration() %> min</td>
                            <td><%= assessment.getTotalMarks() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No assessments created yet.</p>
                </div>
            <% } %>

            <h3 style="margin-top: 30px;">Recent Careers</h3>
            <% List<Career> careers = (List<Career>) request.getAttribute("careers"); %>
            <% if (careers != null && !careers.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Career Name</th>
                        <th>Required Skills</th>
                    </tr>
                    <% for (Career career : careers) { %>
                        <tr>
                            <td><%= career.getId() %></td>
                            <td><%= career.getCareerName() %></td>
                            <td><%= career.getRequiredSkills() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No careers added yet.</p>
                </div>
            <% } %>

            <h3 style="margin-top: 30px;">Registered Users</h3>
            <% List<User> users = (List<User>) request.getAttribute("users"); %>
            <% if (users != null && !users.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                    </tr>
                    <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getId() %></td>
                            <td><%= user.getName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getRole() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No users registered yet.</p>
                </div>
            <% } %>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2024 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
