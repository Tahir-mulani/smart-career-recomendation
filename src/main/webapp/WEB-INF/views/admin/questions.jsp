<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Question Management - Admin</title>
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
                <li><a href="/admin/questions" class="active"><i class="fas fa-question-circle"></i> Questions</a></li>
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
                <h1>Question Management</h1>
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

            <!-- Create Question Form -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3><i class="fas fa-plus-circle"></i> Add New Question</h3>
                </div>
                <div class="admin-card-body">
                    <form action="/api/admin/create-question" method="post" class="admin-form">
                        <div class="admin-form-group">
                            <label>Question Text</label>
                            <textarea name="questionText" rows="2" required placeholder="Enter the question..."></textarea>
                        </div>
                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label>Option A</label>
                                <input type="text" name="optionA" required placeholder="First option">
                            </div>
                            <div class="admin-form-group">
                                <label>Option B</label>
                                <input type="text" name="optionB" required placeholder="Second option">
                            </div>
                        </div>
                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label>Option C</label>
                                <input type="text" name="optionC" required placeholder="Third option">
                            </div>
                            <div class="admin-form-group">
                                <label>Option D</label>
                                <input type="text" name="optionD" required placeholder="Fourth option">
                            </div>
                        </div>
                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label>Correct Answer</label>
                                <select name="correctAnswer" required>
                                    <option value="">Select correct option</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
                            </div>
                            <div class="admin-form-group">
                                <label>Difficulty Level</label>
                                <select name="difficultyLevel" required>
                                    <option value="">Select difficulty</option>
                                    <option value="Easy">Easy</option>
                                    <option value="Medium">Medium</option>
                                    <option value="Hard">Hard</option>
                                </select>
                            </div>
                        </div>
                        <div class="admin-form-row">
                            <div class="admin-form-group">
                                <label>Skill Tag</label>
                                <input type="text" name="skillTag" required placeholder="e.g., Java, SQL, Python">
                            </div>
                            <div class="admin-form-group">
                                <label>Assessment</label>
                                <select name="assessmentId" required>
                                    <option value="">Select Assessment</option>
                                    <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                                    <% if (assessments != null) { %>
                                        <% for (Assessment assessment : assessments) { %>
                                            <option value="<%= assessment.getId() %>"><%= assessment.getTestName() %></option>
                                        <% } %>
                                    <% } %>
                                </select>
                            </div>
                            <div class="admin-form-group" style="display: flex; align-items: flex-end;">
                                <button type="submit" class="admin-btn admin-btn-primary">
                                    <i class="fas fa-plus"></i> Add Question
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Questions Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-list"></i> All Questions</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search questions...">
                        </div>
                    </div>
                </div>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Question</th>
                            <th>Skill Tag</th>
                            <th>Difficulty</th>
                            <th>Assessment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
                        <% if (questions != null && !questions.isEmpty()) { %>
                            <% for (Question question : questions) { %>
                                <tr>
                                    <td><%= question.getId() %></td>
                                    <td><%= question.getQuestionText().length() > 50 ? question.getQuestionText().substring(0, 50) + "..." : question.getQuestionText() %></td>
                                    <td><span class="admin-badge info"><%= question.getSkillTag() %></span></td>
                                    <td><span class="admin-badge <%= "Easy".equals(question.getDifficultyLevel()) ? "success" : "Medium".equals(question.getDifficultyLevel()) ? "warning" : "danger" %>"><%= question.getDifficultyLevel() %></span></td>
                                    <td>Assessment #<%= question.getAssessmentId() %></td>
                                    <td>
                                        <button class="admin-action-btn view"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="6" style="text-align: center;">No questions found</td>
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
    </script>
</body>
</html>
