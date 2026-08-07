<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Recommendations - Smart Career Recommendation</title>
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
                <li><a href="/profile"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="/recommendations" class="active"><i class="fas fa-star"></i> Recommendations</a></li>
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
                <h1>Career Recommendations</h1>
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

            <!-- Info Banner Card -->
            <div class="admin-card">
                <div class="admin-card-body">
                    <div class="admin-info-section">
                        <i class="fas fa-star" style="color: #f59e0b; font-size: 28px;"></i>
                        <div>
                            <h4 style="font-size: 18px;">Recommended Career Paths for You</h4>
                            <p style="color: #6b7280; font-size: 14px; margin-top: 4px;">Below are the top career recommendations based on your skills (<strong><%= (user != null && user.getSkills() != null) ? user.getSkills() : "None listed" %></strong>), assessment performance, and interests.</p>
                        </div>
                    </div>
                </div>
            </div>

            <% List<Career> careers = (List<Career>) request.getAttribute("careers"); %>
            <% if (careers != null && !careers.isEmpty()) { %>
                <div class="admin-charts-grid" style="grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));">
                    <% for (Career career : careers) { %>
                        <div class="admin-card" style="border-top: 4px solid #3b82f6;">
                            <div class="admin-card-header">
                                <h3><i class="fas fa-briefcase" style="color: #3b82f6;"></i> <%= career.getCareerName() %></h3>
                                <span class="admin-badge success"><i class="fas fa-check"></i> High Match</span>
                            </div>
                            <div class="admin-card-body">
                                <p style="color: #4b5563; font-size: 14px; margin-bottom: 15px;"><%= career.getDescription() != null ? career.getDescription() : "Explore potential opportunities and growth in this career domain." %></p>
                                
                                <div style="margin-bottom: 12px;">
                                    <strong style="font-size: 13px; color: #374151;"><i class="fas fa-tools" style="color: #f59e0b; margin-right: 6px;"></i> Required Skills:</strong>
                                    <p style="font-size: 13px; color: #6b7280; margin-top: 2px;"><%= career.getRequiredSkills() %></p>
                                </div>
                                
                                <div style="margin-bottom: 20px;">
                                    <strong style="font-size: 13px; color: #374151;"><i class="fas fa-graduation-cap" style="color: #10b981; margin-right: 6px;"></i> Qualification:</strong>
                                    <p style="font-size: 13px; color: #6b7280; margin-top: 2px;"><%= career.getQualification() %></p>
                                </div>
                                
                                <a href="/dashboard" class="admin-btn admin-btn-primary" style="width: 100%; justify-content: center;">
                                    <i class="fas fa-clipboard-check"></i> Take Relevant Assessment
                                </a>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="admin-card">
                    <div class="admin-card-body" style="text-align: center; padding: 40px;">
                        <i class="fas fa-folder-open" style="font-size: 48px; color: #9ca3af; margin-bottom: 15px;"></i>
                        <h3 style="color: #1e3a8a; margin-bottom: 10px;">No Career Recommendations Available</h3>
                        <p style="color: #6b7280; max-width: 500px; margin: 0 auto 20px;">Complete skill assessments or update your profile skills to get tailored career path recommendations.</p>
                        <div style="display: flex; justify-content: center; gap: 15px;">
                            <a href="/profile" class="admin-btn admin-btn-primary">
                                <i class="fas fa-user-edit"></i> Update Profile Skills
                            </a>
                            <a href="/dashboard" class="admin-btn admin-btn-success">
                                <i class="fas fa-play"></i> Take Assessments
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </main>

    <script>
        function toggleSidebar() {
            document.querySelector('.admin-sidebar').classList.toggle('open');
        }
    </script>
</body>
</html>
