<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Assessments - Smart Career Recommendation</title>
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
                <h2>Manage Assessments</h2>
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

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <div class="form-container" style="margin: 0; max-width: 100%;">
                <h3>Add New Assessment</h3>
                <form action="/api/admin/create-assessment" method="post">
                    <div class="form-group">
                        <label for="testName">Test Name</label>
                        <input type="text" id="testName" name="testName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="duration">Duration (minutes)</label>
                        <input type="number" id="duration" name="duration" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="totalMarks">Total Marks</label>
                        <input type="number" id="totalMarks" name="totalMarks" min="1" required>
                    </div>
                    
                    <button type="submit" class="btn">Add Assessment</button>
                </form>
            </div>

            <h3 style="margin-top: 30px;">Existing Assessments</h3>
            <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
            <% if (assessments != null && !assessments.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Test Name</th>
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
        </div>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2024 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
