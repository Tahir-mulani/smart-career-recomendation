<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.Question"%>
<%@ page import="com.techhub.entity.AssessmentInstance"%>
<%@ page import="com.techhub.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dynamic Assessment - Smart Career Recommendation</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--card-bg: #ffffff;
	--text-dark: #0f172a;
	--text-muted: #64748b;
	--border-color: #e2e8f0;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background-color: #f8fafc;
	color: var(--text-dark);
	min-height: 100vh;
}

.header-bar {
	background: var(--bg-dark-blue);
	color: white;
	padding: 16px 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.header-logo {
	font-size: 1.4rem;
	font-weight: 700;
	color: var(--primary-cyan);
}

.timer-box {
	background: rgba(255,255,255,0.1);
	padding: 8px 18px;
	border-radius: 20px;
	font-weight: 600;
	display: flex;
	align-items: center;
	gap: 8px;
	color: var(--primary-cyan);
}

.test-layout {
	width: min(1200px, 92%);
	margin: 30px auto;
	display: grid;
	grid-template-columns: 1fr 300px;
	gap: 25px;
}

.question-card {
	background: white;
	border-radius: 16px;
	padding: 35px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.04);
	border: 1px solid var(--border-color);
	margin-bottom: 25px;
}

.question-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.question-number {
	font-weight: 700;
	color: var(--primary-hover);
	font-size: 1.1rem;
}

.skill-tag {
	background: rgba(34, 211, 238, 0.12);
	color: #0284c7;
	padding: 4px 12px;
	border-radius: 15px;
	font-size: 0.8rem;
	font-weight: 600;
}

.question-title {
	font-size: 1.15rem;
	font-weight: 600;
	margin-bottom: 25px;
	line-height: 1.5;
}

.options-group {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.option-label {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 16px 20px;
	border: 1.5px solid var(--border-color);
	border-radius: 12px;
	cursor: pointer;
	transition: all 0.2s ease;
}

.option-label:hover {
	border-color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.04);
}

.option-label input[type="radio"] {
	width: 18px;
	height: 18px;
	accent-color: #06b6d4;
}

.sidebar-panel {
	background: white;
	border-radius: 16px;
	padding: 25px;
	height: fit-content;
	box-shadow: 0 4px 20px rgba(0,0,0,0.04);
	border: 1px solid var(--border-color);
}

.sidebar-panel h3 {
	font-size: 1rem;
	font-weight: 600;
	margin-bottom: 18px;
}

.q-grid {
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	gap: 8px;
	margin-bottom: 25px;
}

.q-badge {
	width: 40px;
	height: 40px;
	border-radius: 8px;
	border: 1px solid var(--border-color);
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: 600;
	font-size: 0.9rem;
	background: #f8fafc;
	color: var(--text-dark);
}

.q-badge.answered {
	background: var(--primary-cyan);
	color: #0a141f;
	border-color: var(--primary-cyan);
}

.btn-submit-test {
	width: 100%;
	padding: 14px;
	border: none;
	border-radius: 10px;
	background: var(--bg-dark-blue);
	color: white;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.btn-submit-test:hover {
	background: #1e293b;
}
</style>
</head>
<body>
	<%
	AssessmentInstance instance = (AssessmentInstance) request.getAttribute("instance");
	List<Question> questions = (List<Question>) request.getAttribute("questions");
	%>
	<div class="header-bar">
		<div class="header-logo">Smart<span>Career</span> Assessment Player</div>
		<div class="timer-box">
			<i class="fas fa-clock"></i>
			<span id="timeDisplay">45:00</span>
		</div>
	</div>

	<form action="/api/assessment/submit" method="post" id="testForm">
		<input type="hidden" name="instanceId" value="<%=instance != null ? instance.getId() : ""%>">
		<input type="hidden" name="timeTaken" id="timeTakenInput" value="0">

		<div class="test-layout">
			<div class="questions-container">
				<%
				if (questions != null) {
					for (int i = 0; i < questions.size(); i++) {
						Question q = questions.get(i);
				%>
				<div class="question-card" id="q-card-<%=i+1%>">
					<div class="question-header">
						<span class="question-number">Question <%=i + 1%> of <%=questions.size()%></span>
						<span class="skill-tag"><%=q.getSkillTag() != null ? q.getSkillTag() : "General"%></span>
					</div>
					<div class="question-title"><%=q.getQuestionText()%></div>

					<div class="options-group">
						<label class="option-label">
							<input type="radio" name="answers[<%=q.getId()%>]" value="A" onchange="markAnswered(<%=i+1%>)">
							<span>A. <%=q.getOptionA()%></span>
						</label>
						<label class="option-label">
							<input type="radio" name="answers[<%=q.getId()%>]" value="B" onchange="markAnswered(<%=i+1%>)">
							<span>B. <%=q.getOptionB()%></span>
						</label>
						<label class="option-label">
							<input type="radio" name="answers[<%=q.getId()%>]" value="C" onchange="markAnswered(<%=i+1%>)">
							<span>C. <%=q.getOptionC()%></span>
						</label>
						<label class="option-label">
							<input type="radio" name="answers[<%=q.getId()%>]" value="D" onchange="markAnswered(<%=i+1%>)">
							<span>D. <%=q.getOptionD()%></span>
						</label>
					</div>
				</div>
				<%
					}
				}
				%>
			</div>

			<div class="sidebar-panel">
				<h3>Question Palette</h3>
				<div class="q-grid">
					<%
					if (questions != null) {
						for (int i = 0; i < questions.size(); i++) {
					%>
					<div class="q-badge" id="badge-<%=i+1%>"><%=i + 1%></div>
					<%
						}
					}
					%>
				</div>
				<button type="submit" class="btn-submit-test">
					<i class="fas fa-check-circle"></i> Submit Test
				</button>
			</div>
		</div>
	</form>

	<script>
		let totalSeconds = 45 * 60;
		let elapsedSeconds = 0;

		const timer = setInterval(() => {
			totalSeconds--;
			elapsedSeconds++;

			let minutes = Math.floor(totalSeconds / 60);
			let seconds = totalSeconds % 60;

			document.getElementById('timeDisplay').innerText = 
				(minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;

			document.getElementById('timeTakenInput').value = elapsedSeconds;

			if (totalSeconds <= 0) {
				clearInterval(timer);
				document.getElementById('testForm').submit();
			}
		}, 1000);

		function markAnswered(index) {
			const badge = document.getElementById('badge-' + index);
			if (badge) {
				badge.classList.add('answered');
			}
		}
	</script>
</body>
</html>
