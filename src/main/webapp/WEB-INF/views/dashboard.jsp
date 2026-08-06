<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smartcareer.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
    <header>
        <div class="container header-content">
            <div class="logo">Smart<span>Career</span></div>
            <nav>
                <ul>
                    <li><a href="/dashboard">Dashboard</a></li>
                    <li><a href="/profile">Profile</a></li>
                    <li><a href="/recommendations">Recommendations</a></li>
                    <li><a href="/logout">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="dashboard">
            <div class="dashboard-header">
                <h2>Welcome, <%= ((User) request.getAttribute("user")).getName() %>!</h2>
                <div class="user-info">
                    <div class="user-avatar">
                        <%= ((User) request.getAttribute("user")).getName().charAt(0) %>
                    </div>
                    <div>
                        <strong><%= ((User) request.getAttribute("user")).getEmail() %></strong><br>
                        <small><%= ((User) request.getAttribute("user")).getSkills() != null ? ((User) request.getAttribute("user")).getSkills() : "No skills added" %></small>
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

            <h3>Recommended Assessments</h3>
            <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
            <% if (assessments != null && !assessments.isEmpty()) { %>
                <% for (Assessment assessment : assessments) { %>
                    <div class="card">
                        <h3><%= assessment.getTestName() %></h3>
                        <p><strong>Duration:</strong> <%= assessment.getDuration() %> minutes</p>
                        <p><strong>Total Marks:</strong> <%= assessment.getTotalMarks() %></p>
                        <a href="/assessment/<%= assessment.getId() %>" class="btn">Take Assessment</a>
                    </div>
                <% } %>
            <% } else { %>
                <div class="card">
                    <p>No assessments available. Please update your skills in your profile.</p>
                    <a href="/profile" class="btn">Update Profile</a>
                </div>
            <% } %>

            <h3 style="margin-top: 30px;">Your Results</h3>
            <% List<Result> results = (List<Result>) request.getAttribute("results"); %>
            <% if (results != null && !results.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Assessment</th>
                        <th>Score</th>
                        <th>Percentage</th>
                        <th>Date</th>
                    </tr>
                    <% for (Result result : results) { %>
                        <tr>
                            <td>Assessment #<%= result.getAssessmentId() %></td>
                            <td><%= result.getScore() %></td>
                            <td><%= result.getPercentage() %>%</td>
                            <td><%= result.getAttemptDate() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No results yet. Take an assessment to see your results.</p>
                </div>
            <% } %>

            <h3 style="margin-top: 30px;">Career Recommendations</h3>
            <% List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations"); %>
            <% if (recommendations != null && !recommendations.isEmpty()) { %>
                <% for (Recommendation recommendation : recommendations) { %>
                    <div class="card">
                        <h3>Career #<%= recommendation.getCareerId() %></h3>
                        <p><strong>Match Score:</strong> <%= String.format("%.2f", recommendation.getMatchScore()) %>%</p>
                    </div>
                <% } %>
                <a href="/recommendations" class="btn">View All Recommendations</a>
            <% } else { %>
                <div class="card">
                    <p>No recommendations yet. Complete assessments to get career recommendations.</p>
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
