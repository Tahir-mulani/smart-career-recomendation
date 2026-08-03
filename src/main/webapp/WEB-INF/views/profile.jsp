<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techhub.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Smart Career Recommendation</title>
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
                <li><a href="/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/profile" class="active"><i class="fas fa-user"></i> Profile</a></li>
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
                <h1>My Profile</h1>
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

            <!-- Profile Form -->
            <div class="admin-form">
                <h3><i class="fas fa-user-edit"></i> Update Profile</h3>
                <form action="/api/update-profile" method="post">
                    <input type="hidden" name="userId" value="<%= ((User) request.getAttribute("user")).getId() %>">
                    
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="<%= ((User) request.getAttribute("user")).getName() %>" required>
                        </div>
                        <div class="admin-form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%= ((User) request.getAttribute("user")).getEmail() %>" readonly style="background: #f5f5f5;">
                        </div>
                    </div>
                    
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="phoneNumber">Phone Number</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= ((User) request.getAttribute("user")).getPhoneNumber() != null ? ((User) request.getAttribute("user")).getPhoneNumber() : "" %>">
                        </div>
                        <div class="admin-form-group">
                            <label for="role">Role</label>
                            <input type="text" id="role" name="role" value="<%= ((User) request.getAttribute("user")).getRole() %>" readonly style="background: #f5f5f5;">
                        </div>
                    </div>
                    
                    <div class="admin-form-group">
                        <label for="skills">Skills (comma-separated)</label>
                        <input type="text" id="skills" name="skills" value="<%= ((User) request.getAttribute("user")).getSkills() != null ? ((User) request.getAttribute("user")).getSkills() : "" %>" placeholder="e.g., Java, Python, C#">
                        <small style="color: #666;">Enter your skills separated by commas to get personalized assessments</small>
                    </div>
                    
                    <div class="admin-form-group">
                        <label for="interests">Interests (comma-separated)</label>
                        <input type="text" id="interests" name="interests" value="<%= ((User) request.getAttribute("user")).getInterests() != null ? ((User) request.getAttribute("user")).getInterests() : "" %>" placeholder="e.g., AI, Machine Learning, Web Development">
                        <small style="color: #666;">Enter your interests for better career recommendations</small>
                    </div>
                    
                    <div class="admin-form-actions">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                        <a href="/dashboard" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>
                </form>
            </div>

            <!-- Account Information -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-info-circle"></i> Account Information</h3>
                </div>
                <table class="admin-table">
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                    <tr>
                        <td>User ID</td>
                        <td><%= ((User) request.getAttribute("user")).getId() %></td>
                    </tr>
                    <tr>
                        <td>Registration Date</td>
                        <td><%= ((User) request.getAttribute("user")).getRegistrationDate() != null ? ((User) request.getAttribute("user")).getRegistrationDate().toString() : "N/A" %></td>
                    </tr>
                    <tr>
                        <td>Account Status</td>
                        <td><span class="admin-badge active">Active</span></td>
                    </tr>
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
