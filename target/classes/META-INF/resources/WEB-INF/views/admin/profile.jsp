<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.techhub.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Profile - Smart Career Recommendation</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style type="text/css">
/* Executive Admin UI Color Palette (Royal Indigo & Slate Theme) */
:root {
	--primary-cyan: #818cf8;
	--primary-hover: #6366f1;
	--bg-dark-blue: #0f172a;
	--admin-gold: #fbbf24;
	--bg-gradient: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
	--success: #10b981;
	--danger: #ef4444;
	--warning: #f59e0b;
	--bg: #f1f5f9;
	--white: #ffffff;
	--text: #0f172a;
	--text-light: #f8fafc;
	--text-muted: #64748b;
	--border: #cbd5e1;
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

/* Forms */
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
	margin-bottom: 20px;
}

.admin-form-row .admin-form-group {
	margin-bottom: 0;
}

.admin-form label {
	color: var(--text-muted);
	margin-bottom: 8px;
	font-size: 0.9rem;
	font-weight: 500;
}

/* Updated Form Inputs */
.admin-form input, .admin-form select, .admin-form textarea {
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

.admin-form input:focus, .admin-form select:focus, .admin-form textarea:focus
	{
	border-color: var(--primary-cyan) !important;
	box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
}

.admin-form-actions {
	margin-top: 20px;
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
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

/* Tables */
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
}

.admin-table th, .admin-table td {
	padding: 18px 15px;
	text-align: left;
	border-bottom: 1px solid var(--border);
	vertical-align: middle;
}

.admin-table th {
	color: var(--text-muted);
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	width: 30%;
}

.admin-table td {
	font-size: 0.95rem;
	color: var(--text);
	font-weight: 500;
}

.admin-table tr:last-child th, .admin-table tr:last-child td {
	border-bottom: none;
}

/* Badges */
.admin-badge {
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 600;
	display: inline-block;
	text-align: center;
}

.admin-badge.admin {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
}

.admin-badge.active {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
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
				<p style="color: var(--admin-gold); font-weight: 700; font-size: 11px; margin-top: 5px; margin-bottom: 0; letter-spacing: 1px; text-transform: uppercase;">
					<i class="fas fa-shield-alt"></i> Executive Control Center
				</p>
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
					<li><a href="/admin/recommendations"><i
							class="fas fa-star"></i> Recommendations</a></li>
					<li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i>
							Analytics</a></li>
					<li><a href="/admin/profile" class="active"><i
							class="fas fa-user-cog"></i> Profile</a></li>
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
					<h1>Admin Profile</h1>
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

				<!-- Profile Information -->
				<div class="admin-form">
					<h3>
						<i class="fas fa-user"></i> Profile Information
					</h3>
					<form action="/api/admin/update-profile" method="post">
						<input type="hidden" name="userId"
							value="<%=((User) request.getAttribute("admin")).getId()%>">
						<div class="admin-form-row">
							<div class="admin-form-group">
								<label for="name">Full Name</label> <input type="text" id="name"
									name="name"
									value="<%=((User) request.getAttribute("admin")).getName()%>"
									required>
							</div>
							<div class="admin-form-group">
								<label for="phoneNumber">Phone Number</label> <input type="tel"
									id="phoneNumber" name="phoneNumber"
									value="<%=((User) request.getAttribute("admin")).getPhoneNumber() != null
		? ((User) request.getAttribute("admin")).getPhoneNumber()
		: ""%>">
							</div>
						</div>
						<div class="admin-form-actions">
							<button type="submit" class="admin-btn admin-btn-primary">
								<i class="fas fa-save"></i> Update Profile
							</button>
						</div>
					</form>
				</div>

				<!-- Change Password -->
				<div class="admin-form">
					<h3>
						<i class="fas fa-lock"></i> Change Password
					</h3>
					<form action="/api/admin/change-password" method="post">
						<div class="admin-form-group">
							<label for="currentPassword">Current Password</label> <input
								type="password" id="currentPassword" name="currentPassword"
								placeholder="Enter current password" required>
						</div>
						<div class="admin-form-row">
							<div class="admin-form-group">
								<label for="newPassword">New Password</label> <input
									type="password" id="newPassword" name="newPassword"
									placeholder="Enter new password" required>
							</div>
							<div class="admin-form-group">
								<label for="confirmPassword">Confirm New Password</label> <input
									type="password" id="confirmPassword" name="confirmPassword"
									placeholder="Confirm new password" required>
							</div>
						</div>
						<div class="admin-form-actions">
							<button type="submit" class="admin-btn admin-btn-primary">
								<i class="fas fa-key"></i> Change Password
							</button>
						</div>
					</form>
				</div>

				<!-- Account Information -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3>
							<i class="fas fa-info-circle"></i> Account Information
						</h3>
					</div>
					<table class="admin-table">
						<tbody>
							<tr>
								<th>Email</th>
								<td><%=((User) request.getAttribute("admin")).getEmail()%></td>
							</tr>
							<tr>
								<th>Role</th>
								<td><span class="admin-badge admin">Administrator</span></td>
							</tr>
							<tr>
								<th>Account Status</th>
								<td><span class="admin-badge active">Active</span></td>
							</tr>
							<tr>
								<th>Member Since</th>
								<td><%=((User) request.getAttribute("admin")).getRegistrationDate() != null
		? ((User) request.getAttribute("admin")).getRegistrationDate().toString()
		: "<span style='color: var(--text-muted)'>N/A</span>"%></td>
							</tr>
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