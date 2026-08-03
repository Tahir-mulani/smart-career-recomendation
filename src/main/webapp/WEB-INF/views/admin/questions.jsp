<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Question Management - Admin Dashboard</title>
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

            <!-- Stats Cards -->
            <div class="admin-stats-grid">
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon blue">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h3><%= ((List<Question>) request.getAttribute("questions")).size() %></h3>
                    <p>Total Questions</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon green">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3><%= ((List<Assessment>) request.getAttribute("assessments")).size() %></h3>
                    <p>Assessments</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon orange">
                        <i class="fas fa-layer-group"></i>
                    </div>
                    <h3><%= ((List<Question>) request.getAttribute("questions")).stream().map(q -> q.getSkillTag()).distinct().count() %></h3>
                    <p>Skill Categories</p>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-card-icon red">
                        <i class="fas fa-signal"></i>
                    </div>
                    <h3><%= ((List<Question>) request.getAttribute("questions")).stream().filter(q -> "Hard".equals(q.getDifficultyLevel())).count() %></h3>
                    <p>Hard Questions</p>
                </div>
            </div>

            <!-- Create Question Form -->
            <div class="admin-form">
                <h3><i class="fas fa-plus-circle"></i> Create New Question</h3>
                <form action="/api/admin/create-question" method="post">
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="questionText">Question Text</label>
                            <textarea id="questionText" name="questionText" required placeholder="Enter question text"></textarea>
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="optionA">Option A</label>
                            <input type="text" id="optionA" name="optionA" required placeholder="Enter option A">
                        </div>
                        <div class="admin-form-group">
                            <label for="optionB">Option B</label>
                            <input type="text" id="optionB" name="optionB" required placeholder="Enter option B">
                        </div>
                    </div>
                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label for="optionC">Option C</label>
                            <input type="text" id="optionC" name="optionC" required placeholder="Enter option C">
                        </div>
                        <div class="admin-form-group">
                            <label for="optionD">Option D</label>
                            <input type="text" id="optionD" name="optionD" required placeholder="Enter option D">
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
                            <input type="text" id="skillTag" name="skillTag" required placeholder="e.g., Java, Python, SQL">
                        </div>
                        <div class="admin-form-group">
                            <label for="assessmentId">Assessment</label>
                            <select id="assessmentId" name="assessmentId" required>
                                <option value="">Select assessment</option>
                                <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                                <% if (assessments != null) { %>
                                    <% for (Assessment assessment : assessments) { %>
                                        <option value="<%= assessment.getId() %>"><%= assessment.getTestName() %></option>
                                    <% } %>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="admin-form-actions">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-plus"></i> Create Question
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
                    <h3><i class="fas fa-question-circle"></i> All Questions</h3>
                    <div class="admin-table-actions">
                        <div class="admin-search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Search questions..." onkeyup="searchQuestions()">
                        </div>
                        <select class="admin-form-group" style="width: auto; padding: 10px; border: 2px solid #e8e8e8; border-radius: 8px;" onchange="filterByDifficulty(this.value)">
                            <option value="all">All Difficulties</option>
                            <option value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                        </select>
                    </div>
                </div>
                <table class="admin-table" id="questionsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Question</th>
                            <th>Correct Answer</th>
                            <th>Difficulty</th>
                            <th>Skill Tag</th>
                            <th>Assessment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
                        <% if (questions != null && !questions.isEmpty()) { %>
                            <% for (Question question : questions) { %>
                                <tr data-difficulty="<%= question.getDifficultyLevel() %>">
                                    <td><%= question.getId() %></td>
                                    <td><%= question.getQuestionText().length() > 50 ? question.getQuestionText().substring(0, 50) + "..." : question.getQuestionText() %></td>
                                    <td><span class="admin-badge admin-badge-success"><%= question.getCorrectAnswer() %></span></td>
                                    <td><span class="admin-badge <%= "Hard".equals(question.getDifficultyLevel()) ? "admin-badge-danger" : "Easy".equals(question.getDifficultyLevel()) ? "admin-badge-success" : "admin-badge-warning" %>"><%= question.getDifficultyLevel() %></span></td>
                                    <td><%= question.getSkillTag() %></td>
                                    <td><%= question.getAssessmentId() %></td>
                                    <td>
                                        <button class="admin-action-btn view" onclick="viewQuestion(<%= question.getId() %>)"><i class="fas fa-eye"></i></button>
                                        <button class="admin-action-btn edit" onclick="editQuestion(<%= question.getId() %>)"><i class="fas fa-edit"></i></button>
                                        <button class="admin-action-btn delete" onclick="deleteQuestion(<%= question.getId() %>)"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No questions found</td>
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

        function searchQuestions() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('questionsTable');
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

        function filterByDifficulty(difficulty) {
            const table = document.getElementById('questionsTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                const rowDifficulty = tr[i].getAttribute('data-difficulty');
                if (difficulty === 'all' || rowDifficulty === difficulty) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }

        function viewQuestion(id) {
            window.location.href = '/admin/questions/' + id;
        }

        function editQuestion(id) {
            window.location.href = '/admin/questions/' + id + '/edit';
        }

        function deleteQuestion(id) {
            if (confirm('Are you sure you want to delete this question?')) {
                window.location.href = '/admin/questions/' + id + '/delete';
            }
        }
    </script>
</body>
</html>
