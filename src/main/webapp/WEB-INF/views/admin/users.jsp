<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar-header">
            <h2>Smart<span>Career</span></h2>
            <p style="color: #666; font-size: 12px; margin-top: 5px;">Admin Panel</p>
        </div>
        <nav class="admin-sidebar-nav">
            <ul>
                <li><a href="/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="/admin/users" class="active"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
                <li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
                <li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
                <li><a href="/admin/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
                <li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
                <li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
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
                <h1>User Management</h1>
            </div>
            <div class="admin-header-right">
                <div class="admin-user-info">
                    <div class="admin-user-avatar">A</div>
                    <div>
                        <div class="admin-user-name"><%= ((User) request.getAttribute("admin")).getName() %></div>
                        <div class="admin-user-role">Administrator</div>
                    </div>
                </div>
                <a href="/admin/logout" class="admin-logout-btn">
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

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).size() %></h3>
                    <p>Total Users</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).stream().filter(u -> "USER".equals(u.getRole())).count() %></h3>
                    <p>Regular Users</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).stream().filter(u -> "ADMIN".equals(u.getRole())).count() %></h3>
                    <p>Admin Users</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-user-clock"></i>
                    </div>
                    <h3><%= ((List<User>) request.getAttribute("users")).stream().filter(u -> u.getRegistrationDate() != null && u.getRegistrationDate().toString().startsWith("2024")).count() %></h3>
                    <p>New This Year</p>
                </div>
            </div>

            <!-- Users Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-users"></i> All Users</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search users...">
                        </div>
                        <select class="admin-filter-select">
                            <option value="">All Roles</option>
                            <option value="USER">Users</option>
                            <option value="ADMIN">Admins</option>
                        </select>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Registration Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<User> users = (List<User>) request.getAttribute("users"); %>
                        <% if (users != null && !users.isEmpty()) { %>
                            <% for (User user : users) { %>
                                <tr>
                                    <td><%= user.getId() %></td>
                                    <td><%= user.getName() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "N/A" %></td>
                                    <td>
                                        <span class="admin-badge <%= "ADMIN".equals(user.getRole()) ? "admin" : "user" %>">
                                            <%= user.getRole() %>
                                        </span>
                                    </td>
                                    <td><%= user.getRegistrationDate() != null ? user.getRegistrationDate().toString() : "N/A" %></td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view" title="View" onclick="viewUser(<%= user.getId() %>)"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit" title="Edit"><i class="fas fa-edit"></i></button>
                                        <% if (!"ADMIN".equals(user.getRole())) { %>
                                            <button class="admin-action-btn delete" title="Delete" onclick="deleteUser(<%= user.getId() %>)"><i class="fas fa-trash"></i></button>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="8" style="text-align: center;">No users found.</td>
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

        function viewUser(userId) {
            window.location.href = '/admin/users/' + userId;
        }

        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/api/admin/users/' + userId + '/delete';
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
