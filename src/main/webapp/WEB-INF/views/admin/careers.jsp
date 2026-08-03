<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Management - Admin Dashboard</title>
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
                <li><a href="/admin/users"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
                <li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
                <li><a href="/admin/careers" class="active"><i class="fas fa-briefcase"></i> Careers</a></li>
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
                <h1>Career Management</h1>
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

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3><%= ((List<Career>) request.getAttribute("careers")).size() %></h3>
                    <p>Total Careers</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3><%= ((List<Recommendation>) request.getAttribute("recommendations")).size() %></h3>
                    <p>Total Recommendations</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-layer-group"></i>
                    </div>
                    <h3><%= ((List<Career>) request.getAttribute("careers")).stream().mapToInt(c -> c.getRequiredSkills() != null ? c.getRequiredSkills().split(",").length : 0).sum() %></h3>
                    <p>Total Skills</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <h3><%= ((List<Career>) request.getAttribute("careers")).stream().map(c -> c.getQualification()).distinct().count() %></h3>
                    <p>Qualifications</p>
                </div>
            </div>

            <!-- Create Career Form -->
            <div class="admin-form">
                <h3><i class="fas fa-plus-circle"></i> Create New Career</h3>
                <form action="/api/admin/create-career" method="post">
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="careerName">Career Name</label>
                            <input type="text" id="careerName" name="careerName" required placeholder="Enter career name">
                        </div>
                        <div class="admin-form-group">
                            <label for="qualification">Qualification</label>
                            <input type="text" id="qualification" name="qualification" required placeholder="e.g., Bachelor's in Computer Science">
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="requiredSkills">Required Skills</label>
                            <input type="text" id="requiredSkills" name="requiredSkills" required placeholder="e.g., Java, Python, SQL (comma-separated)">
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" required placeholder="Enter career description"></textarea>
                        </div>
                    </div>
                    <div class="admin-form-actions">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-plus"></i> Create Career
                        </button>
                        <button type="reset" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </form>
            </div>

            <!-- Careers Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-briefcase"></i> All Careers</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Search careers..." onkeyup="searchCareers()">
                        </div>
                    </div>
                </div>
                <table class="admin-table" id="careersTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Career Name</th>
                            <th>Required Skills</th>
                            <th>Qualification</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Career> careers = (List<Career>) request.getAttribute("careers"); %>
                        <% if (careers != null && !careers.isEmpty()) { %>
                            <% for (Career career : careers) { %>
                                <tr>
                                    <td><%= career.getId() %></td>
                                    <td><%= career.getCareerName() %></td>
                                    <td><%= career.getRequiredSkills() %></td>
                                    <td><%= career.getQualification() %></td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view" onclick="viewCareer(<%= career.getId() %>)"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit" onclick="editCareer(<%= career.getId() %>)"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete" onclick="deleteCareer(<%= career.getId() %>)"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="6" style="text-align: center;">No careers found</td>
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

        function searchCareers() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('careersTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                const td = tr[i].getElementsByTagName('td');
                let found = false;
                for (let j = 0; j < td.length; j++) {
                    if (td[j]) {
                        const txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                tr[i].style.display = found ? '' : 'none';
            }
        }

        function viewCareer(id) {
            window.location.href = '/admin/careers/' + id;
        }

        function editCareer(id) {
            window.location.href = '/admin/careers/' + id + '/edit';
        }

        function deleteCareer(id) {
            if (confirm('Are you sure you want to delete this career?')) {
                window.location.href = '/admin/careers/' + id + '/delete';
            }
        }
    </script>
</body>
</html>
