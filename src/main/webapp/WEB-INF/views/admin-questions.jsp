<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techhub.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions - Smart Career Recommendation</title>
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
                <h2>Manage Questions</h2>
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
                <h3>Add New Question</h3>
                <form action="/api/admin/create-question" method="post">
                    <div class="form-group">
                        <label for="questionText">Question Text</label>
                        <textarea id="questionText" name="questionText" rows="3" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="optionA">Option A</label>
                        <input type="text" id="optionA" name="optionA" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="optionB">Option B</label>
                        <input type="text" id="optionB" name="optionB" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="optionC">Option C</label>
                        <input type="text" id="optionC" name="optionC" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="optionD">Option D</label>
                        <input type="text" id="optionD" name="optionD" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="correctAnswer">Correct Answer (A, B, C, or D)</label>
                        <input type="text" id="correctAnswer" name="correctAnswer" maxlength="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="difficultyLevel">Difficulty Level</label>
                        <select id="difficultyLevel" name="difficultyLevel" required>
                            <option value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="skillTag">Skill Tag</label>
                        <input type="text" id="skillTag" name="skillTag" placeholder="e.g., Java, Python" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="assessmentId">Assessment</label>
                        <select id="assessmentId" name="assessmentId" required>
                            <% List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments"); %>
                            <% if (assessments != null && !assessments.isEmpty()) { %>
                                <% for (Assessment assessment : assessments) { %>
                                    <option value="<%= assessment.getId() %>"><%= assessment.getTestName() %></option>
                                <% } %>
                            <% } else { %>
                                <option value="">No assessments available</option>
                            <% } %>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn">Add Question</button>
                </form>
            </div>

            <h3 style="margin-top: 30px;">Existing Questions</h3>
            <% List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
            <% if (questions != null && !questions.isEmpty()) { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Skill Tag</th>
                        <th>Difficulty</th>
                        <th>Assessment ID</th>
                    </tr>
                    <% for (Question question : questions) { %>
                        <tr>
                            <td><%= question.getId() %></td>
                            <td><%= question.getQuestionText().substring(0, Math.min(50, question.getQuestionText().length())) %>...</td>
                            <td><%= question.getSkillTag() %></td>
                            <td><%= question.getDifficultyLevel() %></td>
                            <td><%= question.getAssessmentId() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="card">
                    <p>No questions added yet.</p>
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
