<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techhub.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Smart Career Recommendation</title>
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
                <h2>My Profile</h2>
                <div class="user-info">
                    <div class="user-avatar">
                        <%= ((User) request.getAttribute("user")).getName().charAt(0) %>
                    </div>
                    <div>
                        <strong><%= ((User) request.getAttribute("user")).getName() %></strong><br>
                        <small><%= ((User) request.getAttribute("user")).getEmail() %></small>
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
                <form action="/api/update-profile" method="post">
                    <input type="hidden" name="userId" value="<%= ((User) request.getAttribute("user")).getId() %>">
                    
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" value="<%= ((User) request.getAttribute("user")).getName() %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="<%= ((User) request.getAttribute("user")).getEmail() %>" readonly style="background: #f5f5f5;">
                    </div>
                    
                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= ((User) request.getAttribute("user")).getPhoneNumber() %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="skills">Skills (comma-separated)</label>
                        <input type="text" id="skills" name="skills" value="<%= ((User) request.getAttribute("user")).getSkills() != null ? ((User) request.getAttribute("user")).getSkills() : "" %>" placeholder="e.g., Java, Python, C#">
                        <small style="color: #666;">Enter your skills separated by commas to get personalized assessments</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="interests">Interests (comma-separated)</label>
                        <input type="text" id="interests" name="interests" value="<%= ((User) request.getAttribute("user")).getInterests() != null ? ((User) request.getAttribute("user")).getInterests() : "" %>" placeholder="e.g., AI, Machine Learning, Web Development">
                        <small style="color: #666;">Enter your interests for better career recommendations</small>
                    </div>
                    
                    <button type="submit" class="btn">Update Profile</button>
                    <a href="/dashboard" class="btn btn-secondary">Cancel</a>
                </form>
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
