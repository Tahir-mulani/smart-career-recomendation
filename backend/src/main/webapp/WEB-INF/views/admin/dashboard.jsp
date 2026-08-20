<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Smart Career Recommendation</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

/* Independently Scrollable Main Content Area */
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
	gap: 20px;
}

.admin-header-left h1 {
	font-size: 22px;
	font-weight: 600;
	color: var(--text);
	margin: 0;
}

.admin-menu-toggle {
	background: none;
	border: none;
	font-size: 20px;
	color: var(--text-muted);
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
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background: var(--primary-cyan);
	color: #000;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 600;
	font-size: 18px;
}

.admin-user-name {
	font-weight: 600;
	font-size: 14px;
	color: var(--text);
}

.admin-user-role {
	font-size: 12px;
	color: var(--text-muted);
}

.admin-logout-btn {
	color: var(--danger);
	text-decoration: none;
	font-weight: 500;
	font-size: 14px;
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

.admin-content {
	padding: 35px;
	flex: 1;
}

/* Stats Cards Grid */
.admin-stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 25px;
	margin-bottom: 35px;
}

.admin-stat-card {
	background: var(--white);
	padding: 25px;
	border-radius: 16px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .03);
	border: 1px solid var(--border);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	display: flex;
	align-items: center;
	gap: 20px;
}

.admin-stat-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
}

.admin-stat-card-icon {
	width: 60px;
	height: 60px;
	border-radius: 14px;
	background: rgba(34, 211, 238, 0.12);
	color: var(--primary-hover);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 26px;
}

.admin-stat-card-info h3 {
	font-size: 28px;
	font-weight: 700;
	margin: 0 0 4px 0;
	color: var(--text);
}

.admin-stat-card-info p {
	margin: 0;
	color: var(--text-muted);
	font-size: 14px;
	font-weight: 500;
}

/* Quick Access Cards */
.section-title {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 20px;
	color: var(--text);
	display: flex;
	align-items: center;
	gap: 10px;
}

.quick-actions-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
	margin-bottom: 35px;
}

.quick-action-card {
	background: var(--white);
	padding: 22px;
	border-radius: 14px;
	border: 1px solid var(--border);
	text-decoration: none;
	color: var(--text);
	transition: all 0.3s ease;
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.quick-action-card:hover {
	border-color: var(--primary-cyan);
	transform: translateY(-3px);
	box-shadow: 0 8px 20px rgba(34, 211, 238, 0.15);
}

.quick-action-icon {
	width: 45px;
	height: 45px;
	border-radius: 10px;
	background: var(--bg);
	color: var(--primary-hover);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
}

.quick-action-title {
	font-weight: 600;
	font-size: 16px;
}

.quick-action-desc {
	font-size: 13px;
	color: var(--text-muted);
	margin: 0;
}

/* Data Tables */
.admin-card {
	background: var(--white);
	border-radius: 16px;
	border: 1px solid var(--border);
	box-shadow: 0 5px 20px rgba(0, 0, 0, .03);
	margin-bottom: 35px;
	overflow: hidden;
}

.admin-card-header {
	padding: 20px 25px;
	border-bottom: 1px solid var(--border);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.admin-card-header h3 {
	margin: 0;
	font-size: 16px;
	font-weight: 600;
	color: var(--text);
}

.admin-table-container {
	overflow-x: auto;
}

.admin-table {
	width: 100%;
	border-collapse: collapse;
}

.admin-table th, .admin-table td {
	padding: 15px 25px;
	text-align: left;
	border-bottom: 1px solid var(--border);
}

.admin-table th {
	background: var(--bg);
	color: var(--text-muted);
	font-weight: 600;
	font-size: 12px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.admin-table td {
	font-size: 14px;
}

.admin-badge {
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 500;
	display: inline-block;
}

.admin-badge-primary {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-hover);
}
</style>
</head>
<body class="admin-body">
	<div class="dashboard-layout">
		<!-- Fixed Sidebar -->
		<aside class="admin-sidebar" id="sidebar">
			<div class="admin-sidebar-header">
				<h2>Smart<span>Career</span></h2>
				<p style="color: var(--admin-gold); font-weight: 700; font-size: 11px; margin-top: 5px; margin-bottom: 0; letter-spacing: 1px; text-transform: uppercase;">
					<i class="fas fa-shield-alt"></i> Executive Control Center
				</p>
			</div>
			<nav class="admin-sidebar-nav">
				<ul>
					<li><a href="/admin/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
					<li><a href="/admin/users"><i class="fas fa-users"></i> Users</a></li>
					<li><a href="/admin/assessments"><i class="fas fa-file-alt"></i> Assessments</a></li>
					<li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
					<li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
					<li><a href="/admin/recommendations"><i class="fas fa-lightbulb"></i> Recommendations</a></li>
					<li><a href="/admin/analytics"><i class="fas fa-chart-line"></i> Analytics</a></li>
					<li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
				</ul>
			</nav>
			<div class="admin-sidebar-footer">
				<p style="margin: 0;">&copy; 2026 Smart Career System</p>
			</div>
		</aside>

		<!-- Main Content Area -->
		<main class="admin-main">
			<header class="admin-header">
				<div class="admin-header-left">
					<button class="admin-menu-toggle" onclick="toggleSidebar()">
						<i class="fas fa-bars"></i>
					</button>
					<h1>Admin Overview Dashboard</h1>
				</div>
				<div class="admin-header-right">
					<%
					User admin = (User) request.getAttribute("admin");
					String adminName = (admin != null && admin.getName() != null) ? admin.getName() : "Administrator";
					char avatarInitial = adminName.length() > 0 ? adminName.charAt(0) : 'A';
					%>
					<div class="admin-user-info">
						<div class="admin-user-avatar"><%= avatarInitial %></div>
						<div>
							<div class="admin-user-name"><%= adminName %></div>
							<div class="admin-user-role">System Administrator</div>
						</div>
					</div>
					<a href="/admin/logout" class="admin-logout-btn">
						<i class="fas fa-sign-out-alt"></i> Logout
					</a>
				</div>
			</header>

			<!-- Scrollable Content -->
			<div class="admin-content">
				<%
				List<User> users = (List<User>) request.getAttribute("users");
				List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments");
				List<Question> questions = (List<Question>) request.getAttribute("questions");
				List<Career> careers = (List<Career>) request.getAttribute("careers");
				
				int totalUsers = (users != null) ? users.size() : 0;
				int totalAssessments = (assessments != null) ? assessments.size() : 0;
				int totalQuestions = (questions != null) ? questions.size() : 0;
				int totalCareers = (careers != null) ? careers.size() : 0;
				%>

				<!-- Stat Cards -->
				<div class="admin-stats-grid">
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-users"></i>
						</div>
						<div class="admin-stat-card-info">
							<h3><%= totalUsers %></h3>
							<p>Registered Students</p>
						</div>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-clipboard-list"></i>
						</div>
						<div class="admin-stat-card-info">
							<h3><%= totalAssessments %></h3>
							<p>Active Assessments</p>
						</div>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-question-circle"></i>
						</div>
						<div class="admin-stat-card-info">
							<h3><%= totalQuestions %></h3>
							<p>Question Bank Items</p>
						</div>
					</div>
					<div class="admin-stat-card">
						<div class="admin-stat-card-icon">
							<i class="fas fa-briefcase"></i>
						</div>
						<div class="admin-stat-card-info">
							<h3><%= totalCareers %></h3>
							<p>Career Profiles</p>
						</div>
					</div>
				</div>

				<!-- Quick Access Section -->
				<h2 class="section-title"><i class="fas fa-bolt"></i> Quick Operations</h2>
				<div class="quick-actions-grid">
					<a href="/admin/users" class="quick-action-card">
						<div class="quick-action-icon"><i class="fas fa-user-gear"></i></div>
						<div class="quick-action-title">Manage Students</div>
						<p class="quick-action-desc">View, search, update, or remove student profiles</p>
					</a>
					<a href="/admin/assessments" class="quick-action-card">
						<div class="quick-action-icon"><i class="fas fa-file-signature"></i></div>
						<div class="quick-action-title">Manage Assessments</div>
						<p class="quick-action-desc">Create or configure evaluation test modules</p>
					</a>
					<a href="/admin/questions" class="quick-action-card">
						<div class="quick-action-icon"><i class="fas fa-file-import"></i></div>
						<div class="quick-action-title">Question Bank & CSV</div>
						<p class="quick-action-desc">Add questions manually or bulk upload via CSV</p>
					</a>
					<a href="/admin/careers" class="quick-action-card">
						<div class="quick-action-icon"><i class="fas fa-road"></i></div>
						<div class="quick-action-title">Career Paths</div>
						<p class="quick-action-desc">Define career domains, skill tags, and qualifications</p>
					</a>
					<a href="/admin/analytics" class="quick-action-card">
						<div class="quick-action-icon"><i class="fas fa-chart-line"></i></div>
						<div class="quick-action-title">Analytics & Reports</div>
						<p class="quick-action-desc">View system performance, test metrics, and charts</p>
					</a>
				</div>

				<!-- Recent Registered Users with Pagination -->
				<div class="admin-card">
					<div class="admin-card-header">
						<h3><i class="fas fa-user-clock"></i> Recent Registered Students</h3>
						<a href="/admin/users" style="color: var(--primary-hover); text-decoration: none; font-size: 14px; font-weight: 500;">View All Students &rarr;</a>
					</div>
					<div class="admin-table-container">
						<table class="admin-table" id="recentUsersTable">
							<thead>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>Email</th>
									<th>Phone Number</th>
									<th>Registration Date</th>
									<th>Role</th>
								</tr>
							</thead>
							<tbody>
								<%
								if (users != null && !users.isEmpty()) {
									for (User u : users) {
								%>
								<tr>
									<td>#<%= u.getId() %></td>
									<td><strong><%= u.getName() %></strong></td>
									<td><%= u.getEmail() %></td>
									<td><%= (u.getPhoneNumber() != null) ? u.getPhoneNumber() : "N/A" %></td>
									<td><%= (u.getRegistrationDate() != null) ? u.getRegistrationDate().toString() : "N/A" %></td>
									<td><span class="admin-badge admin-badge-primary"><%= u.getRole() %></span></td>
								</tr>
								<%
									}
								} else {
								%>
								<tr>
									<td colspan="6" style="text-align: center; color: var(--text-muted);">No student records found.</td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</main>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById('sidebar').classList.toggle('collapsed');
		}

		// Reusable Table Pagination Script
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
			initTablePagination('recentUsersTable', 5);
		});
	</script>
</body>
</html>
