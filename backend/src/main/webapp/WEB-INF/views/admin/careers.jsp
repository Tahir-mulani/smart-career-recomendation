<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Careers - Smart Career Recommendation</title>
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

/* Add Career Form */
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

/* Updated Form Inputs and Textareas */
.admin-form input, .admin-form textarea {
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

.admin-form textarea {
	resize: vertical;
	min-height: 80px;
}

.admin-form input:focus, .admin-form textarea:focus {
	border-color: var(--primary-cyan) !important;
	box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
}

.admin-form input::placeholder, .admin-form textarea::placeholder {
	color: rgba(255, 255, 255, 0.4);
}

.admin-form-actions {
	margin-top: 30px;
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

.admin-btn-secondary {
	background: transparent;
	color: var(--primary-cyan);
	border: 2px solid var(--primary-cyan);
}

.admin-btn-secondary:hover {
	background: var(--primary-cyan);
	color: #000;
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
	background: var(--white) !important;
	color: var(--text-dark) !important;
}

.admin-search-box input:focus {
	border-color: var(--primary-cyan);
	box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
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

.admin-action-btn.edit:hover {
	color: var(--warning);
	background: rgba(245, 158, 11, 0.1);
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
					<li><a href="/admin/careers" class="active"><i
							class="fas fa-briefcase"></i> Careers</a></li>
					<li><a href="/admin/recommendations"><i
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
					<h1>Career Management</h1>
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

				<!-- Add Career Form -->
				<div class="admin-form">
					<h3>
						<i class="fas fa-plus-circle"></i> Add New Career
					</h3>
					<form action="/api/admin/create-career" method="post">
						<div class="admin-form-row">
							<div class="admin-form-group">
								<label for="careerName">Career Name</label> <input type="text"
									id="careerName" name="careerName"
									placeholder="e.g., Software Developer" required>
							</div>
							<div class="admin-form-group">
								<label for="qualification">Qualification</label> <input
									type="text" id="qualification" name="qualification"
									placeholder="e.g., Bachelor's in Computer Science" required>
							</div>
						</div>
						<div class="admin-form-group">
							<label for="description">Description</label>
							<textarea id="description" name="description" rows="3"
								placeholder="Brief description of the career role" required></textarea>
						</div>
						<div class="admin-form-group">
							<label for="requiredSkills">Required Skills
								(comma-separated)</label> <input type="text" id="requiredSkills"
								name="requiredSkills" placeholder="e.g., Java, Python, SQL"
								required>
						</div>
						<div class="admin-form-actions">
							<button type="submit" class="admin-btn admin-btn-primary">
								<i class="fas fa-plus"></i> Add Career
							</button>
							<button type="reset" class="admin-btn admin-btn-secondary">
								<i class="fas fa-undo"></i> Reset
							</button>
						</div>
					</form>
				</div>

				<!-- Add Master Skill & Domain Interest (Admin Authority) -->
				<div class="admin-form" style="margin-top: 25px;">
					<h3>
						<i class="fas fa-tools"></i> Add Master Skill or Domain Interest (Admin Authority)
					</h3>
					<div class="admin-form-row">
						<form action="/api/admin/create-skill" method="post" style="flex: 1;">
							<div class="admin-form-group">
								<label for="skillName">New Master Skill Name</label>
								<input type="text" id="skillName" name="skillName" placeholder="e.g., Flutter, Rust, Go" required>
							</div>
							<button type="submit" class="admin-btn admin-btn-primary" style="margin-top: 10px;">
								<i class="fas fa-plus"></i> Add Master Skill
							</button>
						</form>
						<form action="/api/admin/create-interest" method="post" style="flex: 1;">
							<div class="admin-form-group">
								<label for="interestName">New Domain Interest Name</label>
								<input type="text" id="interestName" name="interestName" placeholder="e.g., Quantum Computing, Blockchain" required>
							</div>
							<button type="submit" class="admin-btn admin-btn-primary" style="margin-top: 10px;">
								<i class="fas fa-plus"></i> Add Domain Interest
							</button>
						</form>
					</div>
				</div>

				<!-- Careers Table -->
				<div class="admin-table-container">
					<div class="admin-table-header">
						<h3>
							<i class="fas fa-briefcase"></i> Existing Careers
						</h3>
						<div class="admin-table-actions">
							<div class="admin-search-box">
								<i class="fas fa-search"></i> <input type="text" id="careerSearchInput" onkeyup="filterCareersTable()"
									placeholder="Search careers by name or skills...">
							</div>
						</div>
					</div>
					<table class="admin-table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Career Name</th>
								<th>Required Skills</th>
								<th>Qualification</th>
								<th>Status</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Career> careers = (List<Career>) request.getAttribute("careers");
							%>
							<%
							if (careers != null && !careers.isEmpty()) {
							%>
							<%
							for (Career career : careers) {
							%>
							<tr>
								<td>#<%=career.getId()%></td>
								<td><strong><%=career.getCareerName()%></strong></td>
								<td><%=career.getRequiredSkills()%></td>
								<td><%=career.getQualification()%></td>
								<td><span class="admin-badge active">Active</span></td>
								<td>
									<button class="admin-action-btn view" title="View">
										<i class="fas fa-eye"></i>
									</button>
									<button class="admin-action-btn edit" title="Edit">
										<i class="fas fa-edit"></i>
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
								<td colspan="6"
									style="text-align: center; padding: 40px; color: var(--text-muted);">No
									careers added yet.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>

					<!-- Pagination Controls -->
					<div class="pagination-bar" style="display: flex; justify-content: space-between; align-items: center; padding: 18px 20px; background: #fff; border-top: 1px solid var(--border); border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
						<div id="careerPageInfo" style="font-size: 0.85rem; color: var(--text-muted);">Showing 1 to 10 of 0 careers</div>
						<div id="careerPageButtons" style="display: flex; gap: 6px;"></div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script>
		let currentCareerPage = 1;
		const careerPageSize = 10;

		function toggleSidebar() {
			document.getElementById('sidebar').classList.toggle('collapsed');
		}

		function renderCareerPagination() {
			const input = document.getElementById('careerSearchInput');
			const filter = input ? input.value.toLowerCase() : '';
			const table = document.querySelector('.admin-table');
			if (!table) return;
			const tbody = table.querySelector('tbody');
			if (!tbody) return;
			const allRows = Array.from(tbody.getElementsByTagName('tr'));

			const matchingRows = allRows.filter(tr => {
				const text = tr.textContent || tr.innerText;
				return text.toLowerCase().indexOf(filter) > -1;
			});

			const totalItems = matchingRows.length;
			const totalPages = Math.max(1, Math.ceil(totalItems / careerPageSize));
			if (currentCareerPage > totalPages) currentCareerPage = totalPages;

			allRows.forEach(tr => tr.style.display = 'none');

			const startIndex = (currentCareerPage - 1) * careerPageSize;
			const endIndex = Math.min(startIndex + careerPageSize, totalItems);

			for (let i = startIndex; i < endIndex; i++) {
				matchingRows[i].style.display = '';
			}

			const pageInfo = document.getElementById('careerPageInfo');
			if (pageInfo) {
				if (totalItems === 0) {
					pageInfo.innerText = "No matching careers found";
				} else {
					pageInfo.innerText = 'Showing ' + (startIndex + 1) + ' to ' + endIndex + ' of ' + totalItems + ' careers';
				}
			}

			const pageButtons = document.getElementById('careerPageButtons');
			if (!pageButtons) return;
			pageButtons.innerHTML = '';

			const prevBtn = document.createElement('button');
			prevBtn.className = 'admin-btn admin-btn-secondary';
			prevBtn.style.padding = '5px 12px';
			prevBtn.style.fontSize = '0.8rem';
			prevBtn.disabled = currentCareerPage === 1;
			prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i> Prev';
			prevBtn.onclick = () => { if (currentCareerPage > 1) { currentCareerPage--; renderCareerPagination(); } };
			pageButtons.appendChild(prevBtn);

			for (let p = 1; p <= totalPages; p++) {
				const pBtn = document.createElement('button');
				pBtn.className = p === currentCareerPage ? 'admin-btn admin-btn-primary' : 'admin-btn admin-btn-secondary';
				pBtn.style.padding = '5px 12px';
				pBtn.style.fontSize = '0.8rem';
				pBtn.innerText = p;
				pBtn.onclick = () => { currentCareerPage = p; renderCareerPagination(); };
				pageButtons.appendChild(pBtn);
			}

			const nextBtn = document.createElement('button');
			nextBtn.className = 'admin-btn admin-btn-secondary';
			nextBtn.style.padding = '5px 12px';
			nextBtn.style.fontSize = '0.8rem';
			nextBtn.disabled = currentCareerPage === totalPages;
			nextBtn.innerHTML = 'Next <i class="fas fa-chevron-right"></i>';
			nextBtn.onclick = () => { if (currentCareerPage < totalPages) { currentCareerPage++; renderCareerPagination(); } };
			pageButtons.appendChild(nextBtn);
		}

		function filterCareersTable() {
			currentCareerPage = 1;
			renderCareerPagination();
		}

		document.addEventListener('DOMContentLoaded', () => {
			renderCareerPagination();
		});
	</script>
</body>
</html>