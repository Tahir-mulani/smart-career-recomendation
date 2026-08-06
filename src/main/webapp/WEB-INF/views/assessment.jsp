<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smartcareer.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Assessment - Smart Career Recommendation</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
    <header>
        <div class="container header-content">
            <div class="logo">Smart<span>Career</span></div>
            <nav>
                <ul>
                    <li><a href="/dashboard">Dashboard</a></li>
                    <li><a href="/profile">Profile</a></li>
                    <li><a href="/recommendations">Recommendations</a></li>
                    <li><a href="/logout">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="assessment-container">
            <div class="dashboard-header">
                <h2><%= ((Assessment) request.getAttribute("assessment")).getTestName() %></h2>
                <div class="timer">
                    Time: <%= ((Assessment) request.getAttribute("assessment")).getDuration() %> minutes
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="/api/submit-assessment" method="post">
                <input type="hidden" name="assessmentId" value="<%= ((Assessment) request.getAttribute("assessment")).getId() %>">
                <input type="hidden" name="userId" value="<%= ((User) request.getAttribute("user")).getId() %>">

                <% List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
                <% if (questions != null && !questions.isEmpty()) { %>
                    <% int questionNum = 1; %>
                    <% for (Question question : questions) { %>
                        <div class="question-card">
                            <h4>Question <%= questionNum %></h4>
                            <p><%= question.getQuestionText() %></p>
                            
                            <div class="options">
                                <label class="option">
                                    <input type="radio" name="<%= question.getId() %>" value="A" required>
                                    <span><%= question.getOptionA() %></span>
                                </label>
                                <label class="option">
                                    <input type="radio" name="<%= question.getId() %>" value="B">
                                    <span><%= question.getOptionB() %></span>
                                </label>
                                <label class="option">
                                    <input type="radio" name="<%= question.getId() %>" value="C">
                                    <span><%= question.getOptionC() %></span>
                                </label>
                                <label class="option">
                                    <input type="radio" name="<%= question.getId() %>" value="D">
                                    <span><%= question.getOptionD() %></span>
                                </label>
                            </div>
                        </div>
                        <% questionNum++; %>
                    <% } %>
                <% } else { %>
                    <div class="card">
                        <p>No questions available for this assessment.</p>
                    </div>
                <% } %>

                <button type="submit" class="btn">Submit Assessment</button>
                <a href="/dashboard" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2024 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
