<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techhub.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <% User user = (User) request.getAttribute("user"); %>
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
            <p>&copy; 2026 Smart Career System</p>
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
                <h1>User Profile</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar">
                        <%= (user != null && user.getName() != null && !user.getName().isEmpty()) ? Character.toUpperCase(user.getName().charAt(0)) : 'U' %>
                    </div>
                    <div>
                        <div class="admin-user-name"><%= (user != null && user.getName() != null) ? user.getName() : "User" %></div>
                        <div class="admin-user-role"><%= (user != null && user.getEmail() != null) ? user.getEmail() : "" %></div>
                    </div>
                </div>
                <a href="/logout" class="admin-logout-btn">
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

            <!-- Profile Summary Header Card -->
            <div class="admin-card">
                <div class="admin-card-body">
                    <div class="admin-profile-info">
                        <div class="admin-profile-avatar-large">
                            <%= (user != null && user.getName() != null && !user.getName().isEmpty()) ? Character.toUpperCase(user.getName().charAt(0)) : 'U' %>
                        </div>
                        <div class="admin-profile-details">
                            <h4><%= (user != null && user.getName() != null) ? user.getName() : "User" %></h4>
                            <p class="admin-profile-email"><i class="fas fa-envelope" style="margin-right: 5px;"></i> <%= (user != null && user.getEmail() != null) ? user.getEmail() : "" %></p>
                            <span class="admin-badge user"><i class="fas fa-user-check"></i> Registered User</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Edit Form -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-user-edit"></i> Edit Profile Information</h3>
                </div>
                <div class="admin-card-body">
                    <form action="/api/update-profile" method="post" class="admin-form">
                        <input type="hidden" name="userId" value="<%= (user != null) ? user.getId() : "" %>">
                        
                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label for="name"><i class="fas fa-user" style="color: #3b82f6; margin-right: 5px;"></i> Full Name</label>
                                <input type="text" id="name" name="name" value="<%= (user != null && user.getName() != null) ? user.getName() : "" %>" required placeholder="Enter full name">
                            </div>
                            
                            <div class="admin-form-group">
                                <label for="email"><i class="fas fa-envelope" style="color: #3b82f6; margin-right: 5px;"></i> Email (Read Only)</label>
                                <input type="email" id="email" name="email" value="<%= (user != null && user.getEmail() != null) ? user.getEmail() : "" %>" readonly style="background: #f3f4f6; cursor: not-allowed;">
                            </div>
                        </div>

                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label for="phoneNumber"><i class="fas fa-phone" style="color: #3b82f6; margin-right: 5px;"></i> Phone Number</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= (user != null && user.getPhoneNumber() != null) ? user.getPhoneNumber() : "" %>" placeholder="Enter phone number">
                            </div>

                            <div class="admin-form-group">
                                <label for="skills"><i class="fas fa-code" style="color: #3b82f6; margin-right: 5px;"></i> Skills (Comma-separated)</label>
                                <input type="text" id="skills" name="skills" value="<%= (user != null && user.getSkills() != null) ? user.getSkills() : "" %>" placeholder="e.g., Java, Python, SQL, React">
                                <p style="font-size: 12px; color: #6b7280; margin-top: 4px;">Enter your technical and soft skills to receive personalized career recommendations.</p>
                            </div>
                        </div>

                        <div class="admin-form-group">
                            <label for="interests"><i class="fas fa-heart" style="color: #3b82f6; margin-right: 5px;"></i> Interests (Comma-separated)</label>
                            <input type="text" id="interests" name="interests" value="<%= (user != null && user.getInterests() != null) ? user.getInterests() : "" %>" placeholder="e.g., AI, Machine Learning, Web Development, Cloud Computing">
                            <p style="font-size: 12px; color: #6b7280; margin-top: 4px;">Specify your domain interests for better assessment suggestions.</p>
                        </div>

                        <div style="display: flex; gap: 15px; margin-top: 25px;">
                            <button type="submit" class="admin-btn admin-btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                            <a href="/dashboard" class="admin-btn admin-btn-danger">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
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
