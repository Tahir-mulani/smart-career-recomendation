<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.techhub.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Details - Admin Panel</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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

.dashboard-layout {
	display: flex;
	flex-direction: row !important;
	flex-wrap: nowrap !important;
	min-height: 100vh;
	width: 100%;
	align-items: stretch;
	overflow-x: hidden;
}

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

.admin-sidebar-nav ul li a {
	display: flex;
	align-items: center;
	padding: 12px 15px;
	color: var(--text-muted);
	text-decoration: none;
	border-radius: 8px;
	font-weight: 500;
	transition: all 0.3s ease;
}

.admin-sidebar-nav ul li a i {
	margin-right: 12px;
	font-size: 18px;
	width: 20px;
	text-align: center;
}

.admin-sidebar-nav ul li.active a, .admin-sidebar-nav ul li a:hover {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-cyan);
}

.admin-main-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	min-width: 0;
	background: var(--bg);
}

.admin-header {
	background: var(--white);
	padding: 20px 40px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid var(--border);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
}

.admin-header-title {
	display: flex;
	align-items: center;
	gap: 15px;
}

.toggle-btn {
	background: none;
	border: none;
	font-size: 20px;
	color: var(--text-muted);
	cursor: pointer;
}

.admin-header-title h1 {
	font-size: 22px;
	font-weight: 600;
	margin: 0;
}

.admin-user-profile {
	display: flex;
	align-items: center;
	gap: 20px;
}

.admin-user-info {
	display: flex;
	align-items: center;
	gap: 12px;
}

.admin-avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background: var(--bg-dark-blue);
	color: var(--primary-cyan);
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 600;
}

.admin-user-name {
	font-weight: 600;
	font-size: 14px;
}

.admin-user-role {
	font-size: 12px;
	color: var(--text-muted);
}

.admin-logout-btn {
	color: var(--danger);
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 8px;
}

.admin-content {
	padding: 40px;
	flex: 1;
}

.admin-alert {
	padding: 15px 20px;
	border-radius: 8px;
	margin-bottom: 30px;
	display: flex;
	align-items: center;
	gap: 12px;
	font-weight: 500;
}

.admin-alert-success {
	background: rgba(16, 185, 129, 0.1);
	color: var(--success);
	border: 1px solid rgba(16, 185, 129, 0.2);
}

.admin-alert-error {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
	border: 1px solid rgba(239, 68, 68, 0.2);
}

.user-detail-card {
	background: var(--white);
	border-radius: 16px;
	padding: 40px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
	border: 1px solid var(--border);
	max-width: 800px;
	margin: 0 auto;
}

.user-detail-card h3 {
	font-size: 20px;
	font-weight: 600;
	margin-top: 0;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 2px solid var(--bg);
	display: flex;
	align-items: center;
	gap: 10px;
	color: var(--bg-dark-blue);
}

.user-detail-card h3 i {
	color: var(--primary-cyan);
}

.detail-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 25px;
}

.detail-item {
	background: #f8fafc;
	padding: 18px 22px;
	border-radius: 12px;
	border: 1px solid var(--border);
}

.detail-item-full {
	grid-column: span 2;
}

.detail-label {
	font-size: 13px;
	color: var(--text-muted);
	font-weight: 500;
	margin-bottom: 6px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.detail-label i {
	color: var(--primary-hover);
	font-size: 14px;
}

.detail-value {
	font-size: 16px;
	font-weight: 600;
	color: var(--text);
	word-break: break-word;
}

.admin-badge {
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	display: inline-block;
}

.admin-badge.admin-role {
	background: rgba(34, 211, 238, 0.15);
	color: #0284c7;
}

.admin-badge.user-role {
	background: rgba(16, 185, 129, 0.15);
	color: var(--success);
}

.admin-form-actions {
	display: flex;
	gap: 15px;
	margin-top: 30px;
	padding-top: 20px;
	border-top: 1px solid var(--border);
}

.admin-btn {
	padding: 12px 24px;
	border-radius: 8px;
	font-weight: 500;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-size: 14px;
	border: none;
	cursor: pointer;
	transition: all 0.3s ease;
}

.admin-btn-primary {
	background: var(--bg-dark-blue);
	color: var(--white);
}

.admin-btn-primary:hover {
	background: #1e3a8a;
}

.admin-btn-secondary {
	background: #e2e8f0;
	color: var(--text);
}

.admin-btn-secondary:hover {
	background: #cbd5e1;
}

.admin-btn-danger {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
	border: 1px solid rgba(239, 68, 68, 0.3);
}

.admin-btn-danger:hover {
	background: var(--danger);
	color: var(--white);
}
</style>
</head>
<body class="admin-body">
<%
User admin = (User) session.getAttribute("admin");
User userObj = (User) request.getAttribute("user");
if (admin == null) {
    response.sendRedirect("/admin/login");
    return;
}
%>
<div class="dashboard-layout">
	<!-- Sidebar -->
	<aside class="admin-sidebar" id="sidebar">
		<div class="admin-sidebar-header">
			<h2>Smart<span>Career</span></h2>
		</div>
		<nav class="admin-sidebar-nav">
			<ul>
				<li><a href="/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
				<li class="active"><a href="/admin/users"><i class="fas fa-users"></i> Users</a></li>
				<li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
				<li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
				<li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
				<li><a href="/admin/recommendations"><i class="fas fa-star"></i> Recommendations</a></li>
				<li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
				<li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
			</ul>
		</nav>
	</aside>

	<!-- Main Content -->
	<main class="admin-main-content">
		<header class="admin-header">
			<div class="admin-header-title">
				<button class="toggle-btn" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
				<h1>User Details</h1>
			</div>
			<div class="admin-user-profile">
				<div class="admin-user-info">
					<div class="admin-avatar"><%=admin.getName() != null ? admin.getName().substring(0, 1).toUpperCase() : "A"%></div>
					<div>
						<div class="admin-user-name"><%=admin.getName()%></div>
						<div class="admin-user-role">System Admin</div>
					</div>
				</div>
				<a href="/api/admin/logout" class="admin-logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
			</div>
		</header>

		<div class="admin-content">
			<% if (request.getAttribute("success") != null) { %>
			<div class="admin-alert admin-alert-success"><i class="fas fa-check-circle"></i> <%=request.getAttribute("success")%></div>
			<% } %>
			<% if (request.getAttribute("error") != null) { %>
			<div class="admin-alert admin-alert-error"><i class="fas fa-exclamation-circle"></i> <%=request.getAttribute("error")%></div>
			<% } %>

			<% if (userObj != null) { %>
			<div class="user-detail-card">
				<h3><i class="fas fa-id-card"></i> User Profile Details</h3>

				<div class="detail-grid">
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-hashtag"></i> User ID</div>
						<div class="detail-value">#<%=userObj.getId()%></div>
					</div>
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-shield-alt"></i> User Role</div>
						<div class="detail-value">
							<span class="admin-badge <%="ADMIN".equals(userObj.getRole()) ? "admin-role" : "user-role"%>">
								<%=userObj.getRole()%>
							</span>
						</div>
					</div>
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-user"></i> Full Name</div>
						<div class="detail-value"><%=userObj.getName() != null ? userObj.getName() : "N/A"%></div>
					</div>
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-envelope"></i> Email Address</div>
						<div class="detail-value"><%=userObj.getEmail() != null ? userObj.getEmail() : "N/A"%></div>
					</div>
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-phone"></i> Phone Number</div>
						<div class="detail-value"><%=userObj.getPhoneNumber() != null ? userObj.getPhoneNumber() : "Not provided"%></div>
					</div>
					<div class="detail-item">
						<div class="detail-label"><i class="fas fa-calendar-alt"></i> Registration Date</div>
						<div class="detail-value"><%=userObj.getRegistrationDate() != null ? userObj.getRegistrationDate().toString() : "N/A"%></div>
					</div>
					<div class="detail-item detail-item-full">
						<div class="detail-label"><i class="fas fa-tools"></i> Primary & Secondary Skills</div>
						<div class="detail-value"><%=userObj.getSkills() != null && !userObj.getSkills().isEmpty() ? userObj.getSkills() : "No skills onboarded yet"%></div>
					</div>
					<div class="detail-item detail-item-full">
						<div class="detail-label"><i class="fas fa-heart"></i> Domain Interests</div>
						<div class="detail-value"><%=userObj.getInterests() != null && !userObj.getInterests().isEmpty() ? userObj.getInterests() : "No interests selected yet"%></div>
					</div>
				</div>

				<div class="admin-form-actions">
					<a href="/admin/users" class="admin-btn admin-btn-secondary"><i class="fas fa-arrow-left"></i> Back to Users List</a>
					<form action="/api/admin/users/<%=userObj.getId()%>/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');" style="margin: 0;">
						<button type="submit" class="admin-btn admin-btn-danger"><i class="fas fa-trash"></i> Delete User</button>
					</form>
				</div>
			</div>
			<% } else { %>
			<div class="user-detail-card" style="text-align: center; padding: 60px;">
				<i class="fas fa-user-slash" style="font-size: 3rem; color: var(--text-muted); margin-bottom: 16px;"></i>
				<p style="color: var(--text-muted); font-size: 16px;">User not found or deleted.</p>
				<a href="/admin/users" class="admin-btn admin-btn-primary" style="margin-top: 20px;"><i class="fas fa-arrow-left"></i> Back to Users List</a>
			</div>
			<% } %>
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
