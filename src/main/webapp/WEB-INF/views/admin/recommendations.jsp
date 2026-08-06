<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recommendation Management - Smart Career Recommendation</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style type="text/css">
/* Modern UI Color Palette */
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
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

body.admin-body {
	font-family: 'Poppins', sans-serif;
	background: var(--bg);
	color: var(--text);
	margin: 0;
	overflow-x: hidden;
}

/* Base Layout - FIXED for side-by-side display */
.dashboard-layout {
	display: flex;
	flex-direction: row !important;
	flex-wrap: nowrap !important;
	min-height: 100vh;
	width: 100%;
	align-items: stretch;
	overflow-x: hidden;
}

/* Sidebar - FIXED to prevent shrinking */
.admin-sidebar {
	width: 260px;
	min-width: 260px;
	flex-shrink: 0;
	background: var(--bg-dark-blue);
	color: var(--text-light);
	box-shadow: 5px 0 20px rgba(0, 0, 0, .05);
	transition: margin-left 0.3s ease;
	display: flex;
	flex-direction: column;
	position: relative;
	z-index: 10;
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
	width: calc(100% - 260px);
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

/* Stats Grid */
.admin-stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 25px;
	margin-bottom: 35px;
}

.admin-stat-card {
	background: var(--bg-gradient);
	padding: 25px;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	color: var(--text-light);
	position: relative;
	overflow: hidden;
	display: flex;
	flex-direction: column;
}

.admin-stat-card-icon {
	font-size: 2rem;
	margin-bottom: 15px;
	opacity: 0.8;
	color: var(--primary-cyan);
}

.admin-stat-card h3 {
	font-size: 2.2rem;
	color: var(--white);
	margin: 0 0 5px 0;
	line-height: 1;
}

.admin-stat-card p {
	margin: 0;
	font-size: 0.95rem;
	color: rgba(255, 255, 255, 0.7);
	font-weight: 500;
}

.admin-stat-card::after {
	content: '';
	position: absolute;
	top: -20px;
	right: -20px;
	width: 100px;
	height: 100px;
	background: rgba(34, 211, 238, 0.05);
	border-radius: 50%;
}

/* Tables */
.admin-table-container {
	background: var(--white);
	border-radius: 18px;
	padding: 30px;
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

.admin-table-actions {
	display: flex;
	gap: 15px;
	align-items: center;
}

.admin-search-box {
	position: relative;
}

.admin-search-box i {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--text-muted);
}

.admin-search-box input {
	padding: 10px 15px 10px 35px;
	border: 1px solid var(--border);
	border-radius: 8px;
	outline: none;
	transition: 0.3s;
	font-family: 'Poppins', sans-serif;
	width: 220px;
}

.admin-search-box input:focus {
	border-color: var(--primary-cyan);
	box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
}

.admin-filter-select {
	padding: 10px 15px;
	border: 1px solid var(--border);
	border-radius: 8px;
	outline: none;
	background: var(--white);
	cursor: pointer;
	font-family: 'Poppins', sans-serif;
	color: var(--text-dark);
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

/* Badges */
.admin-badge {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 600;
	display: inline-block;
	text-align: center;
}

.admin-badge.active {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
}

/* Action Buttons */
.admin-action-btn {
	background: none;
	border: none;
	cursor: pointer;
	padding: 8px;
	border-radius: 6px;
	transition: 0.3s;
	color: var(--text-muted);
	font-size: 1rem;
	margin-right: 5px;
}

.admin-action-btn.view:hover {
	color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.1);
}

.admin-action-btn.delete:hover {
	color: var(--danger);
	background: rgba(239, 68, 68, 0.1);
}
</style>
</head>
<body class="admin-body">
	<div class="dashboard-layout">
		<!-- Sidebar -->
		<aside class="admin-sidebar" id="sidebar">
			<div class="admin-sidebar-header">
				<h2>
					Smart<span>Career</span>
				</h2>
				<p
					style="color: var(--text-muted); font-size: 12px; margin-top: 5px; margin-bottom: 0;">Admin
					Panel</p>
			</div>
			<nav class="admin-sidebar-nav">
				<ul>
					<li><a href="/admin/dashboard"><i class="fas fa-home"></i>
							Dashboard</a></li>
					<li><a href="/admin/users"><i class="fas fa-users"></i>
							User Management</a></li>
					<li><a href="/admin/assessments"><i
							class="fas fa-clipboard-list"></i> Assessments</a></li>
					<li><a href="/admin/questions"><i
							class="fas fa-question-circle"></i> Questions</a></li>
					<li><a href="/admin/careers"><i class="fas fa-briefcase"></i>
							Careers</a></li>
					<li><a href="/admin/recommendations" class="active"><i
							class="fas fa-star"></i> Recommendations</a></li>
					<li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i>
							Analytics</a></li>
					<li><a href="/admin/profile"><i class="fas fa-user-cog"></i>
							Profile</a></li>
				</ul>
			</nav>
			<div class="admin-sidebar-footer">
				<p style="margin: 0;">&copy; 2026 Smart Career System</p>
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
					<h1>Recommendation Management</h1>
				</div>
				<div class="admin-header-right">
					<div class="admin-user-info">
						<div class="admin-user-avatar"><%=((User) request.getAttribute("admin")).getName().charAt(0)%></div>
						<div>
							<div class="admin-user-name"><%=((User) request.getAttribute("admin")).getName()%></div>
							<div class="admin-user-role">Administrator</div>
						</div>
					</div>
					<a href="/admin/logout" class="admin-logout-btn"> <i
						class="fas fa-sign-out-alt"></i> Logout
					</a>
				</div>
			</header>

			<!-- Content -->
			<div class="admin-content">
				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="admin-alert admin-alert-error">
					<i class="fas fa-exclamation-circle"></i>
					<%=request.getAttribute("error")%>
				</div>
				<%
				}
				%>
				<%
				if (request.getAttribute("success") != null) {
				%>
				<div class="admin-alert admin-alert-success">
					<i class="fas fa-check-circle"></i>
					<%=request.getAttribute("success")%>
				</div>
				<%
				}
				%>

				<!-- Stats Cards -->
				<div class="admin-stats-grid">
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-star"></i>
						</div>
						<h3><%=((List<Recommendation>) request.getAttribute("recommendations")).size()%></h3>
						<p>Total Recommendations</p>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-check-circle"></i>
						</div>
						<h3><%=((List<Recommendation>) request.getAttribute("recommendations")).stream().filter(r -> r.getMatchScore() >= 80)
		.count()%></h3>
						<p>High Matches</p>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-users"></i>
						</div>
						<h3><%=((List<Recommendation>) request.getAttribute("recommendations")).stream().map(r -> r.getUserId()).distinct()
		.count()%></h3>
						<p>Users with Recommendations</p>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-briefcase"></i>
						</div>
						<h3><%=((List<Recommendation>) request.getAttribute("recommendations")).stream().map(r -> r.getCareerId()).distinct()
		.count()%></h3>
						<p>Careers Recommended</p>
					</div>
				</div>

				<!-- Recommendations Table -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3>
							<i class="fas fa-star"></i> All Recommendations
						</h3>
						<div class="admin-table-actions">
							<div class="admin-search-box">
								<i class="fas fa-search"></i> <input type="text"
									placeholder="Search recommendations...">
							</div>
							<select class="admin-filter-select">
								<option value="">All Match Levels</option>
								<option value="high">High Match (80%+)</option>
								<option value="medium">Medium Match (60-79%)</option>
								<option value="low">Low Match (<60%)</option>
							</select>
						</div>
					</div>
					<table class="admin-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>User ID</th>
								<th>Career ID</th>
								<th>Match Score</th>
								<th>Match Level</th>
								<th>Status</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations");
							%>
							<%
							if (recommendations != null && !recommendations.isEmpty()) {
							%>
							<%
							for (Recommendation recommendation : recommendations) {
							%>
							<tr>
								<td>#<%=recommendation.getId()%></td>
								<td><%=recommendation.getUserId()%></td>
								<td><%=recommendation.getCareerId()%></td>
								<td><%=String.format("%.2f", recommendation.getMatchScore())%>%</td>
								<td>
									<%
									if (recommendation.getMatchScore() >= 80) {
									%> <span
									class="admin-badge active">High Match</span> <%
 } else if (recommendation.getMatchScore() >= 60) {
 %>
									<span class="admin-badge"
									style="background: rgba(245, 158, 11, 0.1); color: var(--warning);">Medium
										Match</span> <%
 } else {
 %> <span class="admin-badge"
									style="background: rgba(239, 68, 68, 0.1); color: var(--danger);">Low
										Match</span> <%
 }
 %>
								</td>
								<td><span class="admin-badge active">Active</span></td>
								<td>
									<button class="admin-action-btn view" title="View Details">
										<i class="fas fa-eye"></i>
									</button>
									<button class="admin-action-btn delete" title="Delete">
										<i class="fas fa-trash"></i>
									</button>
								</td>
							</tr>
							<%
							}
							%>
							<%
							} else {
							%>
							<tr>
								<td colspan="7"
									style="text-align: center; padding: 40px; color: var(--text-muted);">No
									recommendations found.</td>
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
	</script>
</body>
</html>