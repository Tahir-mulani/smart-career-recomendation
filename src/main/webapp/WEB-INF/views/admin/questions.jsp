<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions - Smart Career Recommendation</title>
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

            <!-- Add Question Form -->
            <div class="admin-form">
                <h3><i class="fas fa-plus-circle"></i> Add New Question</h3>
                <form action="/api/admin/create-question" method="post">
                    <div class="admin-form-group">
                        <label for="questionText">Question Text</label>
                        <textarea id="questionText" name="questionText" rows="3" placeholder="Enter the question text" required></textarea>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="optionA">Option A</label>
                            <input type="text" id="optionA" name="optionA" placeholder="First option" required>
                        </div>
                        <div class="admin-form-group">
                            <label for="optionB">Option B</label>
                            <input type="text" id="optionB" name="optionB" placeholder="Second option" required>
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="optionC">Option C</label>
                            <input type="text" id="optionC" name="optionC" placeholder="Third option" required>
                        </div>
                        <div class="admin-form-group">
                            <label for="optionD">Option D</label>
                            <input type="text" id="optionD" name="optionD" placeholder="Fourth option" required>
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="correctAnswer">Correct Answer</label>
                            <select id="correctAnswer" name="correctAnswer" required>
                                <option value="">Select correct answer</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                            </select>
                        </div>
                        <div class="admin-form-group">
                            <label for="difficultyLevel">Difficulty Level</label>
                            <select id="difficultyLevel" name="difficultyLevel" required>
                                <option value="">Select difficulty</option>
                                <option value="Easy">Easy</option>
                                <option value="Medium">Medium</option>
                                <option value="Hard">Hard</option>
                            </select>
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="skillTag">Skill Tag</label>
                            <input type="text" id="skillTag" name="skillTag" placeholder="e.g., Java, Python" required>
                        </div>
                        <div class="admin-form-group">
                            <label for="assessmentId">Assessment</label>
                            <select id="assessmentId" name="assessmentId" required>
                                <option value="">Select assessment</option>
                                <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                                <% if (assessments != null && !assessments.isEmpty()) { %>
                                    <% for (Assessment assessment : assessments) { %>
                                        <option value="<%= assessment.getId() %>"><%= assessment.getTestName() %></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="admin-form-actions">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-plus"></i> Add Question
                        </button>
                        <button type="reset" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </form>
            </div>

            <!-- Questions Table -->
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h3><i class="fas fa-question-circle"></i> Existing Questions</h3>
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
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
                        <% if (questions != null && !questions.isEmpty()) { %>
                            <% for (Question question : questions) { %>
                                <tr>
                                    <td><%= question.getId() %></td>
                                    <td><%= question.getQuestionText().substring(0, Math.min(50, question.getQuestionText().length())) %>...</td>
                                    <td><%= question.getSkillTag() %></td>
                                    <td>
                                        <% if ("Easy".equals(question.getDifficultyLevel())) { %>
                                            <span class="admin-badge" style="background: #28a745;">Easy</span>
                                        <% } else if ("Medium".equals(question.getDifficultyLevel())) { %>
                                            <span class="admin-badge" style="background: #ffc107; color: #000;">Medium</span>
                                        <% } else { %>
                                            <span class="admin-badge" style="background: #dc3545;">Hard</span>
                                        <% } %>
                                    </td>
                                    <td><%= question.getAssessmentId() %></td>
                                    <td><span class="admin-badge active">Active</span></td>
                                    <td>
                                        <button class="admin-action-btn view" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit" title="Edit"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete" title="Delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No questions added yet.</td>
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
