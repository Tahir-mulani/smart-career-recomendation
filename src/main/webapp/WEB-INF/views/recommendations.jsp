<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smartcareer.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Recommendations - Smart Career Recommendation</title>
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
                <h2>Your Career Recommendations</h2>
                <div class="user-info">
                    <div class="user-avatar">
                        <%= ((User) request.getAttribute("user")).getName().charAt(0) %>
                    </div>
                    <div>
                        <strong><%= ((User) request.getAttribute("user")).getName() %></strong><br>
                        <small>Based on your assessment results</small>
                    </div>
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <% List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations"); %>
            <% if (recommendations != null && !recommendations.isEmpty()) { %>
                <% for (Recommendation recommendation : recommendations) { %>
                    <div class="recommendation-card">
                        <h3>Career #<%= recommendation.getCareerId() %></h3>
                        <p><strong>Match Score:</strong> <%= String.format("%.2f", recommendation.getMatchScore()) %>%</p>
                        <span class="match-score"><%= String.format("%.2f", recommendation.getMatchScore()) %>% Match</span>
                    </div>
                <% } %>
            <% } else { %>
                <div class="card">
                    <h3>No Recommendations Yet</h3>
                    <p>Complete assessments to get personalized career recommendations based on your skills and performance.</p>
                    <a href="/dashboard" class="btn">Take Assessments</a>
                </div>
            <% } %>

            <div style="margin-top: 30px;">
                <a href="/dashboard" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2024 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
