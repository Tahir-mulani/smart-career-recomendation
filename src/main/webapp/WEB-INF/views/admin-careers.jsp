<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Careers - Smart Career Recommendation</title>
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
                <h2>Manage Careers</h2>
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
                <h3>Add New Career</h3>
                <form action="/api/admin/create-career" method="post">
                    <div class="form-group">
                        <label for="careerName">Career Name</label>
                        <input type="text" id="careerName" name="careerName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="3" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="requiredSkills">Required Skills (comma-separated)</label>
                        <input type="text" id="requiredSkills" name="requiredSkills" placeholder="e.g., Java, Python, SQL" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="qualification">Qualification</label>
                        <input type="text" id="qualification" name="qualification" placeholder="e.g., Bachelor's in Computer Science" required>
                    </div>
                    
                    <button type="submit" class="btn">Add Career</button>
                </form>
            </div>

            <h3 style="margin-top: 30px;">Existing Careers</h3>
            <% List<Career> careers = (List<Career>) request.getAttribute("careers"); %>
            <% if (careers != null && !careers.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Career Name</th>
                        <th>Required Skills</th>
                        <th>Qualification</th>
                    </tr>
                    <% for (Career career : careers) { %>
                        <tr>
                            <td><%= career.getId() %></td>
                            <td><%= career.getCareerName() %></td>
                            <td><%= career.getRequiredSkills() %></td>
                            <td><%= career.getQualification() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No careers added yet.</p>
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
