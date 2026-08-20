<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Question Bank - Smart Career Recommendation</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style type="text/css">
/* Executive Admin UI Color Palette */
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--admin-gold: #fbbf24;
	--bg-gradient: linear-gradient(135deg, #0f1c29 0%, #1a364b 50%, #1e455c 100%);
	--success: #10b981;
	--danger: #ef4444;
	--warning: #f59e0b;
	--bg: #f8fafc;
	--white: #ffffff;
	--text: #0f172a;
	--text-light: #f8fafc;
	--text-muted: #94a3b8;
	--border: #e2e8f0;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

body.admin-body {
	font-family: 'Poppins', sans-serif;
	background: var(--bg);
	color: var(--text);
}

/* Base Layout */
.dashboard-layout {
	display: flex;
	flex-direction: row !important;
	flex-wrap: nowrap !important;
	height: 100vh;
	width: 100vw;
	overflow: hidden;
}

/* Fixed Sidebar */
.admin-sidebar {
	width: 260px;
	min-width: 260px;
	height: 100vh;
	flex-shrink: 0;
	background: var(--bg-dark-blue);
	color: var(--text-light);
	box-shadow: 5px 0 20px rgba(0, 0, 0, .05);
	transition: margin-left 0.3s ease;
	display: flex;
	flex-direction: column;
	position: relative;
	z-index: 10;
	overflow-y: auto;
}

.admin-sidebar.collapsed {
	margin-left: -260px;
}

.admin-sidebar-header {
	padding: 30px 20px;
	text-align: center;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.admin-sidebar-header h2 {
	color: var(--white);
	font-size: 26px;
	font-weight: 700;
	margin: 0;
}

.admin-sidebar-header h2 span {
	color: var(--primary-cyan);
}

.admin-sidebar-nav {
	flex: 1;
}

.admin-sidebar-nav ul {
	list-style: none;
	padding: 0;
	margin: 20px 0;
}

.admin-sidebar-nav ul li {
	margin: 10px 15px;
}

.admin-sidebar-nav a {
	display: flex;
	align-items: center;
	gap: 12px;
	color: var(--text-muted);
	padding: 14px 18px;
	border-radius: 12px;
	transition: .3s;
	text-decoration: none;
	font-weight: 500;
}

.admin-sidebar-nav a:hover, .admin-sidebar-nav a.active {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-cyan);
}

.admin-sidebar-nav i {
	width: 20px;
	text-align: center;
}

.admin-sidebar-footer {
	padding: 20px;
	text-align: center;
	color: var(--text-muted);
	font-size: 12px;
	border-top: 1px solid rgba(255, 255, 255, 0.05);
}

/* Main Content Area */
.admin-main {
	flex: 1;
	flex-grow: 1;
	height: 100vh;
	overflow-y: auto;
	background: var(--bg);
	display: flex;
	flex-direction: column;
	min-width: 0;
}

/* Header */
.admin-header {
	background: var(--white);
	padding: 18px 35px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .03);
	border-bottom: 1px solid var(--border);
	display: flex;
	justify-content: space-between;
	align-items: center;
	position: sticky;
	top: 0;
	z-index: 5;
}

.admin-header-left {
	display: flex;
	align-items: center;
	gap: 15px;
}

.admin-header h1 {
	color: var(--bg-dark-blue);
	font-weight: 600;
	font-size: 1.5rem;
	margin: 0;
}

.admin-menu-toggle {
	background: none;
	border: none;
	font-size: 1.2rem;
	color: var(--text);
	cursor: pointer;
	padding: 5px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.admin-header-right {
	display: flex;
	align-items: center;
	gap: 25px;
}

.admin-user-info {
	display: flex;
	align-items: center;
	gap: 12px;
}

.admin-user-avatar {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background: var(--primary-cyan);
	color: #000;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
	font-weight: 600;
}

.admin-user-name {
	font-weight: 600;
	font-size: 0.9rem;
	line-height: 1.2;
}

.admin-user-role {
	font-size: 0.8rem;
	color: var(--text-muted);
}

.admin-logout-btn {
	color: var(--danger);
	text-decoration: none;
	font-weight: 500;
	transition: 0.3s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.admin-logout-btn:hover {
	color: #b91c1c;
}

/* Content Area */
.admin-content {
	padding: 35px;
	overflow-y: auto;
}

/* Alerts */
.admin-alert {
	padding: 15px 20px;
	border-radius: 10px;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	gap: 10px;
	font-weight: 500;
}

.admin-alert-success {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
	border-left: 5px solid var(--success);
}

.admin-alert-error {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
	border-left: 5px solid var(--danger);
}

/* Forms Container */
.forms-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
	margin-bottom: 35px;
}

@media (max-width: 992px) {
	.forms-grid {
		grid-template-columns: 1fr;
	}
}

.admin-form {
	background: var(--bg-gradient);
	color: var(--white);
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.admin-form h3 {
	color: var(--primary-cyan);
	margin-top: 0;
	margin-bottom: 25px;
	font-size: 1.3rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

.admin-form-group {
	display: flex;
	flex-direction: column;
	margin-bottom: 20px;
}

.admin-form label {
	color: var(--text-muted);
	margin-bottom: 8px;
	font-size: 0.9rem;
	font-weight: 500;
}

.admin-form input, .admin-form textarea, .admin-form select {
	background: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.2) !important;
	color: var(--white) !important;
	padding: 12px 15px;
	border-radius: 8px;
	outline: none;
	font-size: 0.95rem;
	width: 100%;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
	transition: border-color 0.3s, box-shadow 0.3s;
}

.admin-form select option {
	background: var(--bg-dark-blue);
	color: var(--white);
}

.admin-form input:focus, .admin-form textarea:focus, .admin-form select:focus {
	border-color: var(--primary-cyan) !important;
	box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
}

.admin-form input::placeholder, .admin-form textarea::placeholder {
	color: rgba(255, 255, 255, 0.4);
}

.admin-form-actions {
	margin-top: 25px;
}

/* Buttons */
.admin-btn {
	border: none;
	border-radius: 30px;
	padding: 10px 24px;
	font-weight: 600;
	transition: .3s;
	text-decoration: none;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	cursor: pointer;
	font-size: 0.9rem;
}

.admin-btn-primary {
	background: var(--primary-cyan);
	color: #000;
	box-shadow: 0 4px 15px rgba(34, 211, 238, 0.2);
}

.admin-btn-primary:hover {
	background: var(--white);
	transform: translateY(-2px);
}

.admin-btn-secondary {
	background: transparent;
	color: var(--primary-cyan);
	border: 2px solid var(--primary-cyan);
}

.admin-btn-secondary:hover {
	background: var(--primary-cyan);
	color: #000;
}

/* Table Container */
.admin-table-container {
	background: var(--white);
	border-radius: 18px;
	padding: 30px;
	margin-bottom: 30px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .03);
	border: 1px solid var(--border);
	overflow-x: auto;
}

.admin-table-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 15px;
	margin-bottom: 25px;
}

.admin-table-header h3 {
	color: var(--bg-dark-blue);
	margin: 0;
	font-size: 1.25rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

.admin-table-header h3 i {
	color: var(--primary-cyan);
}

.admin-table {
	width: 100%;
	border-collapse: collapse;
	min-width: 800px;
}

.admin-table th, .admin-table td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid var(--border);
	vertical-align: top;
}

.admin-table th {
	color: var(--text-muted);
	font-weight: 600;
	font-size: 0.85rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.admin-table td {
	font-size: 0.95rem;
	color: var(--text);
}

/* Badges */
.admin-badge {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 600;
	display: inline-block;
}

.admin-badge.easy {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
}

.admin-badge.medium {
	background: rgba(245, 158, 11, 0.1);
	color: var(--warning);
}

.admin-badge.hard {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
}
</style>
</head>
<body class="admin-body">
	<div class="dashboard-layout">
		<!-- Sidebar -->
		<aside class="admin-sidebar" id="sidebar">
			<div class="admin-sidebar-header">
				<a href="/admin/dashboard" style="text-decoration: none;">
					<h2>Smart<span>Career</span></h2>
				</a>
			</div>
			<nav class="admin-sidebar-nav">
				<ul>
					<li><a href="/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
					<li><a href="/admin/users"><i class="fas fa-users"></i> Users</a></li>
					<li><a href="/admin/assessments"><i class="fas fa-file-alt"></i> Assessments</a></li>
					<li><a href="/admin/questions" class="active"><i class="fas fa-question-circle"></i> Questions</a></li>
					<li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
					<li><a href="/admin/recommendations"><i class="fas fa-lightbulb"></i> Recommendations</a></li>
					<li><a href="/admin/analytics"><i class="fas fa-chart-line"></i> Analytics</a></li>
					<li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
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
					<h1>Dynamic Question Bank</h1>
				</div>
				<div class="admin-header-right">
					<%
					User admin = (User) request.getAttribute("admin");
					String adminName = (admin != null && admin.getName() != null) ? admin.getName() : "Admin";
					char avatarInitial = adminName.length() > 0 ? adminName.charAt(0) : 'A';
					%>
					<div class="admin-user-info">
						<div class="admin-user-avatar"><%= avatarInitial %></div>
						<div>
							<div class="admin-user-name"><%= adminName %></div>
							<div class="admin-user-role">Administrator</div>
						</div>
					</div>
					<a href="/admin/logout" class="admin-logout-btn">
						<i class="fas fa-sign-out-alt"></i> Logout
					</a>
				</div>
			</header>

			<!-- Content Area -->
			<div class="admin-content">
				<%
				if (request.getAttribute("success") != null) {
				%>
				<div class="admin-alert admin-alert-success">
					<i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
				</div>
				<%
				}
				%>

				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="admin-alert admin-alert-error">
					<i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
				</div>
				<%
				}
				%>

				<div class="forms-grid">
					<!-- Bulk CSV Upload -->
					<div class="admin-form">
						<h3><i class="fas fa-file-csv"></i> Bulk CSV Import</h3>
						<form action="/api/admin/upload-questions-csv" method="post" enctype="multipart/form-data">
							<div class="admin-form-group">
								<label for="csvFile"><i class="fas fa-upload"></i> Select CSV File</label>
								<input type="file" id="csvFile" name="file" accept=".csv" required style="padding: 10px;">
							</div>
							<p style="font-size: 0.8rem; color: var(--text-muted); margin-bottom: 20px;">
								CSV headers: <code>questionText, optionA, optionB, optionC, optionD, correctAnswer, difficultyLevel, skillTag</code>
							</p>
							<div class="admin-form-actions">
								<button type="submit" class="admin-btn admin-btn-secondary">
									<i class="fas fa-cloud-upload-alt"></i> Upload CSV File
								</button>
							</div>
						</form>
					</div>

					<!-- Single Question Creation -->
					<div class="admin-form">
						<h3><i class="fas fa-plus-circle"></i> Add Single Question</h3>
						<form action="/api/admin/create-question" method="post">
							<div class="admin-form-group">
								<label for="questionText"><i class="fas fa-question"></i> Question Text</label>
								<textarea id="questionText" name="questionText" rows="2" placeholder="Type question..." required></textarea>
							</div>
							<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
								<div class="admin-form-group">
									<label for="optionA">Option A</label>
									<input type="text" id="optionA" name="optionA" required>
								</div>
								<div class="admin-form-group">
									<label for="optionB">Option B</label>
									<input type="text" id="optionB" name="optionB" required>
								</div>
								<div class="admin-form-group">
									<label for="optionC">Option C</label>
									<input type="text" id="optionC" name="optionC" required>
								</div>
								<div class="admin-form-group">
									<label for="optionD">Option D</label>
									<input type="text" id="optionD" name="optionD" required>
								</div>
							</div>
							<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
								<div class="admin-form-group">
									<label for="correctAnswer">Correct Key</label>
									<select id="correctAnswer" name="correctAnswer" required>
										<option value="A">A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
									</select>
								</div>
								<div class="admin-form-group">
									<label for="difficultyLevel">Difficulty</label>
									<select id="difficultyLevel" name="difficultyLevel" required>
										<option value="EASY">EASY</option>
										<option value="MEDIUM" selected>MEDIUM</option>
										<option value="HARD">HARD</option>
									</select>
								</div>
							</div>
							<div class="admin-form-group">
								<label for="skillTag">Skill Tag</label>
								<input type="text" id="skillTag" name="skillTag" placeholder="e.g. Java, Python" required>
							</div>
							<div class="admin-form-actions">
								<button type="submit" class="admin-btn admin-btn-primary">
									<i class="fas fa-save"></i> Add Question
								</button>
							</div>
						</form>
					</div>
				</div>

				<!-- Table of Question Bank Items -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3><i class="fas fa-database"></i> Question Bank Items</h3>
					</div>
					<table class="admin-table" id="questionsTable">
						<thead>
							<tr>
								<th>ID</th>
								<th>Question</th>
								<th>Options</th>
								<th>Correct</th>
								<th>Difficulty</th>
								<th>Skill Tag</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Question> questions = (List<Question>) request.getAttribute("questions");
							if (questions != null && !questions.isEmpty()) {
								for (Question q : questions) {
									String diffClass = "medium";
									if ("EASY".equalsIgnoreCase(q.getDifficultyLevel())) diffClass = "easy";
									else if ("HARD".equalsIgnoreCase(q.getDifficultyLevel())) diffClass = "hard";
							%>
							<tr>
								<td>#<%= q.getId() %></td>
								<td style="max-width: 280px; font-weight: 500;"><%= q.getQuestionText() %></td>
								<td style="font-size: 0.85rem; color: var(--text-muted);">
									A: <%= q.getOptionA() %><br>
									B: <%= q.getOptionB() %><br>
									C: <%= q.getOptionC() %><br>
									D: <%= q.getOptionD() %>
								</td>
								<td><span style="color: var(--success); font-weight: 700;">Option <%= q.getCorrectAnswer() %></span></td>
								<td><span class="admin-badge <%= diffClass %>"><%= q.getDifficultyLevel() %></span></td>
								<td><span style="color: var(--primary-cyan); font-weight: 500;"><%= q.getSkillTag() != null ? q.getSkillTag() : "General" %></span></td>
							</tr>
							<%
								}
							} else {
							%>
							<tr>
								<td colspan="6" style="text-align: center; color: var(--text-muted); padding: 25px;">No questions found in the bank. Use the forms above to add questions.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</main>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById('sidebar').classList.toggle('collapsed');
		}

		function initTablePagination(tableId, rowsPerPage = 8) {
			const table = document.getElementById(tableId);
			if (!table) return;
			const tbody = table.querySelector('tbody');
			if (!tbody) return;
			const rows = Array.from(tbody.querySelectorAll('tr'));
			if (rows.length <= rowsPerPage) return;

			let currentPage = 1;
			const totalPages = Math.ceil(rows.length / rowsPerPage);

			const nav = document.createElement('div');
			nav.style.cssText = 'display: flex; justify-content: space-between; align-items: center; padding: 15px 25px; border-top: 1px solid var(--border); font-size: 0.9rem;';

			const info = document.createElement('div');
			info.style.color = 'var(--text-muted)';

			const btnContainer = document.createElement('div');
			btnContainer.style.cssText = 'display: flex; gap: 6px; align-items: center;';

			nav.appendChild(info);
			nav.appendChild(btnContainer);
			table.parentElement.appendChild(nav);

			function render() {
				const start = (currentPage - 1) * rowsPerPage;
				const end = start + rowsPerPage;

				rows.forEach((row, index) => {
					row.style.display = (index >= start && index < end) ? '' : 'none';
				});

				info.textContent = 'Showing ' + Math.min(start + 1, rows.length) + ' to ' + Math.min(end, rows.length) + ' of ' + rows.length + ' entries';

				btnContainer.innerHTML = '';
				
				const prevBtn = document.createElement('button');
				prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i> Prev';
				prevBtn.disabled = currentPage === 1;
				prevBtn.style.cssText = 'padding: 6px 12px; border: 1px solid var(--border); background: var(--white); border-radius: 6px; cursor: pointer; font-size: 0.85rem; transition: 0.2s;';
				if (currentPage === 1) prevBtn.style.opacity = '0.5';
				prevBtn.onclick = () => { if (currentPage > 1) { currentPage--; render(); } };
				btnContainer.appendChild(prevBtn);

				for (let i = 1; i <= totalPages; i++) {
					const pageBtn = document.createElement('button');
					pageBtn.textContent = i;
					pageBtn.style.cssText = 'padding: 6px 12px; border: 1px solid var(--border); border-radius: 6px; cursor: pointer; font-size: 0.85rem; font-weight: 500; transition: 0.2s; ' + (i === currentPage ? 'background: var(--primary-cyan); color: #000; font-weight: 700; border-color: var(--primary-cyan);' : 'background: var(--white);');
					pageBtn.onclick = () => { currentPage = i; render(); };
					btnContainer.appendChild(pageBtn);
				}

				const nextBtn = document.createElement('button');
				nextBtn.innerHTML = 'Next <i class="fas fa-chevron-right"></i>';
				nextBtn.disabled = currentPage === totalPages;
				nextBtn.style.cssText = 'padding: 6px 12px; border: 1px solid var(--border); background: var(--white); border-radius: 6px; cursor: pointer; font-size: 0.85rem; transition: 0.2s;';
				if (currentPage === totalPages) nextBtn.style.opacity = '0.5';
				nextBtn.onclick = () => { if (currentPage < totalPages) { currentPage++; render(); } };
				btnContainer.appendChild(nextBtn);
			}

			render();
		}

		document.addEventListener('DOMContentLoaded', function() {
			initTablePagination('questionsTable', 8);
		});
	</script>
</body>
</html>
