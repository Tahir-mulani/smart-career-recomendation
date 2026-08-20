<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Dashboard - Smart Career Recommendation</title>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style type="text/css">
/* Modern UI Color Palette */
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--bg-gradient: linear-gradient(135deg, #0f1729 0%, #1a364b 50%, #1e455c 100%);
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
	font-family: 'Plus Jakarta Sans', sans-serif;
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
	font-size: 24px;
	font-weight: 800;
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

/* Scrollable Main Content */
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
	font-weight: 700;
	font-size: 1.4rem;
	margin: 0;
}

.admin-menu-toggle {
	background: none;
	border: none;
	font-size: 1.2rem;
	color: var(--text);
	cursor: pointer;
	padding: 5px;
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
	width: 42px;
	height: 42px;
	border-radius: 50%;
	background: var(--primary-cyan);
	color: #000;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 18px;
	font-weight: 700;
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
	font-size: 0.9rem;
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 8px 16px;
	border-radius: 8px;
	background: rgba(239, 68, 68, 0.1);
	transition: .3s;
}

.admin-logout-btn:hover {
	background: rgba(239, 68, 68, 0.2);
}

/* Content Area */
.admin-content {
	padding: 35px;
	overflow-y: auto;
}

/* Form / Welcome Box */
.admin-form {
	background: var(--bg-gradient);
	color: var(--white);
	border-radius: 18px;
	padding: 35px;
	margin-bottom: 35px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.admin-form h3 {
	color: var(--primary-cyan);
	margin-top: 0;
	margin-bottom: 25px;
	font-size: 1.4rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

.admin-form-row {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 20px;
}

.admin-form-group {
	flex: 1;
	min-width: 250px;
	display: flex;
	flex-direction: column;
}

.admin-form label {
	color: var(--text-muted);
	margin-bottom: 8px;
	font-size: 0.9rem;
	font-weight: 500;
}

.admin-form input {
	background: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.2) !important;
	color: var(--white) !important;
	padding: 12px 15px;
	border-radius: 8px;
	outline: none;
	font-size: 0.95rem;
	width: 100%;
	box-sizing: border-box;
}

.admin-form-actions {
	margin-top: 25px;
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
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

/* Table Containers */
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
	min-width: 700px;
}

.admin-table th, .admin-table td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid var(--border);
	vertical-align: middle;
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

.admin-badge {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 600;
	display: inline-block;
}

.admin-badge.active {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
}
</style>
</head>
<body class="admin-body">
	<div class="dashboard-layout">
		<!-- Fixed Sidebar -->
		<aside class="admin-sidebar" id="sidebar">
			<div class="admin-sidebar-header">
				<a href="/dashboard" style="text-decoration: none;">
					<h2>Smart<span>Career</span></h2>
				</a>
			</div>
			<nav class="admin-sidebar-nav">
				<ul>
					<li><a href="/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
					<li><a href="/onboarding"><i class="fas fa-layer-group"></i> Skill Onboarding</a></li>
					<li><a href="/recommendations"><i class="fas fa-star"></i> Career Matches</a></li>
					<li><a href="/profile"><i class="fas fa-user-circle"></i> Profile</a></li>
				</ul>
			</nav>
			<div class="admin-sidebar-footer">
				<p>&copy; 2026 Smart Career System</p>
			</div>
		</aside>

		<!-- Scrollable Main Content -->
		<main class="admin-main">
			<header class="admin-header">
				<div class="admin-header-left">
					<button class="admin-menu-toggle" onclick="toggleSidebar()">
						<i class="fas fa-bars"></i>
					</button>
					<h1>Student Portal Dashboard</h1>
				</div>
				<div class="admin-header-right">
					<%
					User user = (User) request.getAttribute("user");
					String userName = (user != null && user.getName() != null) ? user.getName() : "Student";
					char avatarInitial = userName.length() > 0 ? userName.charAt(0) : 'S';
					%>
					<div class="admin-user-info">
						<div class="admin-user-avatar"><%= avatarInitial %></div>
						<div>
							<div class="admin-user-name"><%= userName %></div>
							<div class="admin-user-role">Student Account</div>
						</div>
					</div>
					<a href="/login" class="admin-logout-btn">
						<i class="fas fa-sign-out-alt"></i> Logout
					</a>
				</div>
			</header>

			<div class="admin-content">
				<!-- Guided Pathway Card -->
				<div style="background: rgba(34, 211, 238, 0.06); border: 1px solid var(--primary-cyan); border-radius: 18px; padding: 25px; margin-bottom: 30px;">
					<div style="font-weight: 700; font-size: 1.1rem; color: var(--bg-dark-blue); margin-bottom: 6px; display: flex; align-items: center; gap: 10px;">
						<i class="fas fa-route" style="color: var(--primary-hover);"></i> Your 3-Step Career Recommendation Pathway
					</div>
					<p style="font-size: 0.88rem; color: var(--text-muted); margin: 0 0 20px 0;">
						Follow these simple steps to evaluate your technical skills and generate personalized career recommendations:
					</p>

					<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 15px;">
						<a href="/onboarding" style="text-decoration: none;">
							<div style="background: var(--white); border: 1px solid var(--primary-cyan); border-radius: 12px; padding: 16px; transition: 0.3s;">
								<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;">
									<span style="font-size: 0.75rem; font-weight: 800; color: var(--primary-hover); text-transform: uppercase;">Step 1</span>
									<span style="background: rgba(34, 211, 238, 0.15); color: var(--primary-hover); font-size: 0.7rem; padding: 2px 8px; border-radius: 10px; font-weight: 700;">START</span>
								</div>
								<div style="font-weight: 700; font-size: 0.95rem; color: var(--text);"><i class="fas fa-layer-group" style="margin-right: 6px; color: var(--primary-hover);"></i> Skill Onboarding</div>
								<div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 4px;">Set background & select target tech domains</div>
							</div>
						</a>

						<a href="/assessment/start" style="text-decoration: none;">
							<div style="background: var(--white); border: 1px solid var(--border); border-radius: 12px; padding: 16px; transition: 0.3s;">
								<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;">
									<span style="font-size: 0.75rem; font-weight: 800; color: var(--text-muted); text-transform: uppercase;">Step 2</span>
									<span style="background: rgba(0, 0, 0, 0.04); color: var(--text-muted); font-size: 0.7rem; padding: 2px 8px; border-radius: 10px;">TEST</span>
								</div>
								<div style="font-weight: 700; font-size: 0.95rem; color: var(--text);"><i class="fas fa-vial" style="margin-right: 6px; color: var(--primary-hover);"></i> Take Assessment</div>
								<div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 4px;">Complete adaptive domain skill tests</div>
							</div>
						</a>

						<a href="/recommendations" style="text-decoration: none;">
							<div style="background: var(--white); border: 1px solid var(--border); border-radius: 12px; padding: 16px; transition: 0.3s;">
								<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;">
									<span style="font-size: 0.75rem; font-weight: 800; color: var(--text-muted); text-transform: uppercase;">Step 3</span>
									<span style="background: rgba(0, 0, 0, 0.04); color: var(--text-muted); font-size: 0.7rem; padding: 2px 8px; border-radius: 10px;">REPORT</span>
								</div>
								<div style="font-weight: 700; font-size: 0.95rem; color: var(--text);"><i class="fas fa-star" style="margin-right: 6px; color: var(--primary-hover);"></i> View Matches</div>
								<div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 4px;">Explore match %, gap analysis, & roadmaps</div>
							</div>
						</a>
					</div>
				</div>

				<!-- Student Welcome Card -->
				<div class="admin-form">
					<h3><i class="fas fa-user-circle"></i> Welcome, <%= userName %>!</h3>
					<div class="admin-form-row">
						<div class="admin-form-group">
							<label>Email Address</label>
							<input type="text" value="<%= user != null ? user.getEmail() : "" %>" readonly>
						</div>
						<div class="admin-form-group">
							<label>Phone Number</label>
							<input type="text" value="<%= (user != null && user.getPhoneNumber() != null) ? user.getPhoneNumber() : "Not provided" %>" readonly>
						</div>
					</div>
					<div class="admin-form-row">
						<div class="admin-form-group">
							<label>Member Since</label>
							<input type="text" value="<%= (user != null && user.getRegistrationDate() != null) ? user.getRegistrationDate().toString() : "N/A" %>" readonly>
						</div>
						<div class="admin-form-group">
							<label>Account Status</label>
							<input type="text" value="Active Student" readonly>
						</div>
					</div>
					<div class="admin-form-actions">
						<a href="/onboarding" class="admin-btn admin-btn-primary">
							<i class="fas fa-layer-group"></i> Skill Onboarding
						</a>
						<a href="/profile" class="admin-btn admin-btn-secondary">
							<i class="fas fa-user-edit"></i> Edit Profile
						</a>
						<a href="/api/generate-recommendations" class="admin-btn admin-btn-secondary">
							<i class="fas fa-sync"></i> Refresh Matches
						</a>
					</div>
				</div>

				<!-- Assessment Performance Results -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3><i class="fas fa-chart-bar"></i> Test Assessment Results</h3>
					</div>
					<table class="admin-table" id="studentResultsTable">
						<thead>
							<tr>
								<th>Assessment Module</th>
								<th>Score Achieved</th>
								<th>Percentage</th>
								<th>Performance Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Result> results = (List<Result>) request.getAttribute("results");
							if (results != null && !results.isEmpty()) {
								for (Result r : results) {
							%>
							<tr>
								<td>Assessment #<%= r.getAssessmentId() %></td>
								<td><strong><%= r.getScore() %> Marks</strong></td>
								<td><%= r.getPercentage() %>%</td>
								<td>
									<% if (r.getPercentage() >= 70) { %>
										<span class="admin-badge active">Excellent</span>
									<% } else if (r.getPercentage() >= 50) { %>
										<span class="admin-badge" style="background: rgba(245, 158, 11, 0.1); color: var(--warning);">Good</span>
									<% } else { %>
										<span class="admin-badge" style="background: rgba(239, 68, 68, 0.1); color: var(--danger);">Needs Improvement</span>
									<% } %>
								</td>
							</tr>
							<%
								}
							} else {
							%>
							<tr>
								<td colspan="4" style="text-align: center; color: var(--text-muted); padding: 25px;">No test results recorded yet. Take an assessment above to generate your score.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>

				<!-- Top Recommended Career Matches -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3><i class="fas fa-star"></i> Top Career Matches</h3>
						<a href="/recommendations" class="admin-btn admin-btn-secondary">View All Matches &rarr;</a>
					</div>
					<table class="admin-table" id="studentRecsTable">
						<thead>
							<tr>
								<th>Recommended Career Path</th>
								<th>Match Percentage</th>
								<th>Match Level</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations");
							java.util.Map<Long, Career> careerMap = (java.util.Map<Long, Career>) request.getAttribute("careerMap");
							if (recommendations != null && !recommendations.isEmpty()) {
								for (Recommendation rec : recommendations) {
									Career cObj = careerMap != null ? careerMap.get(rec.getCareerId()) : null;
									String name = cObj != null ? cObj.getCareerName() : ("Career Role #" + rec.getCareerId());
							%>
							<tr>
								<td><strong style="color: var(--primary-hover); font-size: 0.95rem;"><%= name %></strong></td>
								<td><strong><%= String.format("%.1f", rec.getMatchScore()) %>%</strong></td>
								<td>
									<% if (rec.getMatchScore() >= 80) { %>
										<span class="admin-badge active">High Match</span>
									<% } else if (rec.getMatchScore() >= 50) { %>
										<span class="admin-badge" style="background: rgba(245, 158, 11, 0.1); color: var(--warning);">Medium Match</span>
									<% } else { %>
										<span class="admin-badge" style="background: rgba(239, 68, 68, 0.1); color: var(--danger);">Low Match</span>
									<% } %>
								</td>
							</tr>
							<%
								}
							} else {
							%>
							<tr>
								<td colspan="3" style="text-align: center; color: var(--text-muted); padding: 25px;">No career matches generated yet. Complete an assessment to see recommendations.</td>
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

		function initTablePagination(tableId, rowsPerPage = 5) {
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
			initTablePagination('studentResultsTable', 5);
			initTablePagination('studentRecsTable', 5);
		});
	</script>
</body>
</html>