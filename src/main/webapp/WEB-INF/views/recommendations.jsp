<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Detailed Career Recommendations - Smart Career System</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

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

/* Base Layout */
.dashboard-layout {
	display: flex;
	flex-direction: row !important;
	flex-wrap: nowrap !important;
	min-height: 100vh;
	width: 100%;
	align-items: stretch;
	overflow-x: hidden;
}

/* Sidebar */
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
	align-items: center;
	justify-content: center;
	font-weight: 700;
	font-size: 1.2rem;
}

.admin-user-details {
	display: flex;
	flex-direction: column;
}

.admin-user-name {
	font-weight: 600;
	color: var(--bg-dark-blue);
	font-size: 0.95rem;
}

.admin-user-role {
	color: var(--text-muted);
	font-size: 0.8rem;
}

.admin-logout-btn {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
	padding: 8px 16px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 500;
	font-size: 0.9rem;
	transition: .3s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.admin-logout-btn:hover {
	background: var(--danger);
	color: var(--white);
}

.admin-content {
	padding: 35px;
	flex: 1;
}

.admin-alert {
	padding: 15px 20px;
	border-radius: 12px;
	margin-bottom: 25px;
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

/* Detailed Report Card Styles */
.report-header-banner {
	background: var(--bg-dark-blue);
	color: var(--white);
	padding: 30px;
	border-radius: 16px;
	margin-bottom: 30px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 20px;
}

.report-header-text h2 {
	margin: 0 0 8px 0;
	font-size: 1.6rem;
	font-weight: 700;
	color: var(--white);
}

.report-header-text p {
	margin: 0;
	color: var(--text-muted);
	font-size: 0.95rem;
}

.career-report-card {
	background: var(--white);
	border-radius: 16px;
	padding: 30px;
	margin-bottom: 25px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.03);
	border: 1px solid var(--border);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.career-report-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 35px rgba(0, 0, 0, 0.06);
}

.card-top-row {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 15px;
	margin-bottom: 15px;
}

.career-title-group h3 {
	margin: 0 0 6px 0;
	font-size: 1.3rem;
	font-weight: 700;
	color: var(--bg-dark-blue);
}

.qualification-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	font-size: 0.85rem;
	color: var(--text-muted);
	font-weight: 500;
}

.match-score-pill {
	padding: 8px 18px;
	border-radius: 25px;
	font-weight: 700;
	font-size: 1rem;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.match-high {
	background: rgba(16, 185, 129, 0.15);
	color: var(--success);
	border: 1px solid rgba(16, 185, 129, 0.3);
}

.match-medium {
	background: rgba(245, 158, 11, 0.15);
	color: var(--warning);
	border: 1px solid rgba(245, 158, 11, 0.3);
}

.match-low {
	background: rgba(239, 68, 68, 0.15);
	color: var(--danger);
	border: 1px solid rgba(239, 68, 68, 0.3);
}

.progress-bar-container {
	height: 10px;
	width: 100%;
	background: #e2e8f0;
	border-radius: 5px;
	overflow: hidden;
	margin: 15px 0 20px 0;
}

.progress-bar-fill {
	height: 100%;
	border-radius: 5px;
	transition: width 0.6s ease;
}

.career-desc {
	font-size: 0.95rem;
	color: #475569;
	line-height: 1.6;
	margin-bottom: 20px;
}

.skills-tags-container {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-bottom: 20px;
}

.skill-tag-badge {
	background: rgba(34, 211, 238, 0.1);
	color: #0284c7;
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
	border: 1px solid rgba(34, 211, 238, 0.3);
}

.analysis-box {
	background: #f8fafc;
	border-radius: 12px;
	padding: 18px 22px;
	border: 1px solid #e2e8f0;
	margin-top: 15px;
}

.analysis-box h4 {
	margin: 0 0 10px 0;
	font-size: 0.95rem;
	color: var(--bg-dark-blue);
	font-weight: 600;
	display: flex;
	align-items: center;
	gap: 8px;
}

.analysis-box p {
	margin: 0;
	font-size: 0.9rem;
	color: var(--text-muted);
	line-height: 1.5;
}

.empty-state {
	text-align: center;
	padding: 60px 20px;
	background: var(--white);
	border-radius: 16px;
	border: 1px solid var(--border);
}

.empty-state i {
	font-size: 3.5rem;
	color: var(--text-muted);
	margin-bottom: 20px;
}

.admin-btn {
	padding: 10px 22px;
	border-radius: 10px;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-size: 0.9rem;
	border: none;
	cursor: pointer;
	transition: all 0.3s ease;
}

.admin-btn-primary {
	background: var(--primary-cyan);
	color: #000;
}

.admin-btn-primary:hover {
	background: var(--primary-hover);
	color: #fff;
}

.admin-btn-secondary {
	background: var(--bg-dark-blue);
	color: var(--white);
}

.admin-btn-secondary:hover {
	background: #1e3a8a;
}
</style>
</head>
<body class="admin-body">
<%
User user = (User) request.getAttribute("user");
List<Recommendation> recommendations = (List<Recommendation>) request.getAttribute("recommendations");
Map<Long, Career> careerMap = (Map<Long, Career>) request.getAttribute("careerMap");
List<Result> userResults = (List<Result>) request.getAttribute("userResults");

double latestTestPercentage = 0.0;
if (userResults != null && !userResults.isEmpty()) {
    latestTestPercentage = userResults.get(userResults.size() - 1).getPercentage();
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
				<li><a href="/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
				<li><a href="/onboarding"><i class="fas fa-layer-group"></i> Skill Onboarding</a></li>
				<li><a href="/assessment/start"><i class="fas fa-file-alt"></i> Dynamic Test</a></li>
				<li><a href="/recommendations" class="active"><i class="fas fa-star"></i> Recommendations</a></li>
				<li><a href="/profile"><i class="fas fa-user-circle"></i> Profile</a></li>
			</ul>
		</nav>
		<div class="admin-sidebar-footer">
			<p>&copy; 2026 Smart Career System</p>
		</div>
	</aside>

	<!-- Main Content -->
	<main class="admin-main">
		<header class="admin-header">
			<div class="admin-header-left">
				<button class="admin-menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
				<h1>Detailed Career Report</h1>
			</div>
			<div class="admin-header-right">
				<div class="admin-user-info">
					<div class="admin-user-avatar"><%=user != null && user.getName() != null ? user.getName().substring(0, 1).toUpperCase() : "U"%></div>
					<div class="admin-user-details">
						<span class="admin-user-name"><%=user != null ? user.getName() : "User"%></span>
						<span class="admin-user-role">Student</span>
					</div>
				</div>
				<a href="/logout" class="admin-logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
			</div>
		</header>

		<div class="admin-content">
			<% if (request.getAttribute("success") != null) { %>
			<div class="admin-alert admin-alert-success"><i class="fas fa-check-circle"></i> <%=request.getAttribute("success")%></div>
			<% } %>
			<% if (request.getAttribute("error") != null) { %>
			<div class="admin-alert admin-alert-error"><i class="fas fa-exclamation-circle"></i> <%=request.getAttribute("error")%></div>
			<% } %>

			<!-- Header Banner -->
			<div class="report-header-banner">
				<div class="report-header-text">
					<h2><i class="fas fa-chart-pie"></i> Your Career Match Report</h2>
					<p>Analyzed based on your onboarded primary/secondary skills and verified assessment score (<%=String.format("%.1f", latestTestPercentage)%>%).</p>
				</div>
				<div>
					<a href="/api/generate-recommendations" class="admin-btn admin-btn-primary">
						<i class="fas fa-sync-alt"></i> Refresh Analysis
					</a>
				</div>
			</div>

			<% if (recommendations != null && !recommendations.isEmpty()) { %>
				<% 
				int rank = 1;
				for (Recommendation rec : recommendations) { 
					if (rank > 3) break; // Display Top 3 Career Recommendations Only
					Career c = careerMap != null ? careerMap.get(rec.getCareerId()) : null;
					if (c == null) continue;
					double score = rec.getMatchScore();
					String matchClass = score >= 80 ? "match-high" : (score >= 50 ? "match-medium" : "match-low");
					String fillStyle = score >= 80 ? "background: linear-gradient(90deg, #10b981, #059669);" : (score >= 50 ? "background: linear-gradient(90deg, #f59e0b, #d97706);" : "background: linear-gradient(90deg, #ef4444, #dc2626);");
				%>
				<div class="career-report-card">
					<div class="card-top-row">
						<div class="career-title-group">
							<div style="display: flex; align-items: center; gap: 10px; margin-bottom: 4px;">
								<span style="background: var(--bg-dark-blue); color: var(--primary-cyan); font-weight: 700; font-size: 0.8rem; padding: 3px 10px; border-radius: 12px;">#<%=rank%> Choice</span>
								<h3 style="margin: 0;"><i class="fas fa-briefcase" style="color: var(--primary-hover);"></i> <%=c.getCareerName()%></h3>
							</div>
							<div class="qualification-badge">
								<i class="fas fa-graduation-cap"></i> Recommended Qualification: <%=c.getQualification()%>
							</div>
						</div>
						<div class="match-score-pill <%=matchClass%>">
							<i class="fas fa-check-circle"></i> <%=String.format("%.1f", score)%>% Match
						</div>
					</div>

					<!-- Visual Progress Bar -->
					<div class="progress-bar-container">
						<div class="progress-bar-fill" style="width: <%=Math.min(100.0, score)%>%; <%=fillStyle%>"></div>
					</div>

					<!-- Role Description -->
					<div class="career-desc">
						<%=c.getDescription()%>
					</div>

					<!-- Required Skills -->
					<div style="font-weight: 600; font-size: 0.9rem; color: var(--bg-dark-blue); margin-bottom: 8px;">
						<i class="fas fa-tools" style="color: var(--primary-cyan);"></i> Required Technical Stack:
					</div>
					<div class="skills-tags-container">
						<% 
						if (c.getRequiredSkills() != null) {
							String[] sArr = c.getRequiredSkills().split(",");
							for (String sk : sArr) {
						%>
							<span class="skill-tag-badge"><%=sk.trim()%></span>
						<% 
							}
						} 
						%>
					</div>

					<!-- Combined Interactive Career Mastery & Skill Remediation Hub -->
					<div style="background: linear-gradient(135deg, #0a141f, #1e293b); border-radius: 16px; padding: 24px; color: #fff; margin-top: 25px; box-shadow: 0 10px 30px rgba(10, 20, 31, 0.2);">
						<!-- Header Row -->
						<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 16px; margin-bottom: 20px; flex-wrap: wrap; gap: 12px;">
							<div style="display: flex; align-items: center; gap: 12px;">
								<div style="width: 42px; height: 42px; border-radius: 12px; background: rgba(34, 211, 238, 0.15); color: var(--primary-cyan); display: flex; align-items: center; justify-content: center; font-size: 1.2rem;">
									<i class="fas fa-rocket"></i>
								</div>
								<div>
									<h4 style="margin: 0; font-size: 1.1rem; color: #fff; font-weight: 700;">Career Mastery Hub & Skill Accelerator</h4>
									<div style="font-size: 0.8rem; color: var(--text-muted); margin-top: 2px;">Role Blueprint: <%=c.getCareerName()%></div>
								</div>
							</div>
							<div style="display: flex; gap: 10px; flex-wrap: wrap;">
								<span style="background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3); padding: 5px 14px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
									<i class="fas fa-chart-line"></i> 🔥 High Demand (28% CAGR)
								</span>
								<span style="background: rgba(34, 211, 238, 0.15); color: var(--primary-cyan); border: 1px solid rgba(34, 211, 238, 0.3); padding: 5px 14px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
									<i class="fas fa-graduation-cap"></i> <%=c.getQualification()%>
								</span>
							</div>
						</div>

						<!-- Dynamic Filter Navigation Tabs (Point 5) -->
						<div style="display: flex; gap: 10px; margin-bottom: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 12px; flex-wrap: wrap;">
							<button class="hub-tab-btn active" onclick="switchHubTab(<%=c.getId()%>, 'matrix')" id="tab-btn-matrix-<%=c.getId()%>">
								<i class="fas fa-chart-bar"></i> Skill Competency Matrix
							</button>
							<button class="hub-tab-btn" onclick="switchHubTab(<%=c.getId()%>, 'modules')" id="tab-btn-modules-<%=c.getId()%>">
								<i class="fas fa-laptop-code"></i> Native Micro-Modules
							</button>
							<button class="hub-tab-btn" onclick="switchHubTab(<%=c.getId()%>, 'project')" id="tab-btn-project-<%=c.getId()%>">
								<i class="fas fa-project-diagram"></i> Hands-On Mini Project
							</button>
						</div>

						<!-- TAB 1: Real Onboarding Skill Competency Matrix -->
						<div id="hub-tab-content-matrix-<%=c.getId()%>" class="hub-tab-content">
							<div style="font-weight: 600; font-size: 0.85rem; color: #94a3b8; margin-bottom: 15px; display: flex; align-items: center; gap: 8px;">
								<i class="fas fa-tasks" style="color: var(--primary-cyan);"></i> Profile Alignment & Onboarding Status:
							</div>
							<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 14px; margin-bottom: 20px;">
								<% 
								List<UserSkill> uSkillsList = (List<UserSkill>) request.getAttribute("userSkills");
								Map<Long, Skill> mSkillMap = (Map<Long, Skill>) request.getAttribute("masterSkillMap");
								Set<String> pNames = new HashSet<>();
								Set<String> sNames = new HashSet<>();
								if (uSkillsList != null && mSkillMap != null) {
									for (UserSkill us : uSkillsList) {
										Skill s = mSkillMap.get(us.getSkillId());
										if (s != null) {
											if (Boolean.TRUE.equals(us.getIsPrimary())) {
												pNames.add(s.getSkillName().toLowerCase().trim());
											} else {
												sNames.add(s.getSkillName().toLowerCase().trim());
											}
										}
									}
								}

								if (c.getRequiredSkills() != null) {
									String[] reqSkills = c.getRequiredSkills().split(",");
									for (int skIdx = 0; skIdx < reqSkills.length; skIdx++) {
										String skName = reqSkills[skIdx].trim();
										String skLower = skName.toLowerCase();
										String statusLabel = "";
										String statusStyle = "";

										if (pNames.contains(skLower)) {
											statusLabel = "🟢 Mastered Core Skill";
											statusStyle = "background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3);";
										} else if (sNames.contains(skLower)) {
											statusLabel = "🟡 Supporting Skill";
											statusStyle = "background: rgba(245, 158, 11, 0.15); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3);";
										} else {
											statusLabel = "🔴 Missing Skill Gap";
											statusStyle = "background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3);";
										}
								%>
								<div style="background: rgba(255,255,255,0.04); padding: 16px; border-radius: 12px; border: 1px solid rgba(255,255,255,0.08); display: flex; flex-direction: column; justify-content: space-between;">
									<div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
										<div>
											<div style="font-weight: 700; font-size: 0.95rem; color: #fff;"><%=skName%></div>
											<div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">Required for <%=c.getCareerName()%></div>
										</div>
									</div>
									<div style="display: flex; align-items: center; justify-content: space-between;">
										<span style="font-size: 0.78rem; font-weight: 700; padding: 4px 12px; border-radius: 20px; <%=statusStyle%>">
											<%=statusLabel%>
										</span>
									</div>
								</div>
								<% 
									}
								} 
								%>
							</div>
						</div>

						<!-- TAB 2: Native In-App Micro-Learning Fast-Track Study Kits -->
						<div id="hub-tab-content-modules-<%=c.getId()%>" class="hub-tab-content" style="display: none;">
							<div style="font-weight: 600; font-size: 0.85rem; color: #94a3b8; margin-bottom: 15px; display: flex; align-items: center; gap: 8px;">
								<i class="fas fa-brain" style="color: var(--primary-cyan);"></i> Fast-Track Interview Study Kits & Core Concepts:
							</div>
							<div style="display: flex; flex-direction: column; gap: 14px; margin-bottom: 20px;">
								<% 
								if (c.getRequiredSkills() != null) {
									String[] reqSkills = c.getRequiredSkills().split(",");
									for (int mIdx = 0; mIdx < reqSkills.length; mIdx++) {
										String skName = reqSkills[mIdx].trim();
								%>
								<details style="background: rgba(255,255,255,0.04); border-radius: 12px; border: 1px solid rgba(255,255,255,0.08); padding: 16px 20px; cursor: pointer;">
									<summary style="font-weight: 700; font-size: 0.95rem; color: var(--primary-cyan); display: flex; align-items: center; justify-content: space-between;">
										<span><i class="fas fa-graduation-cap" style="margin-right: 10px; color: var(--primary-cyan);"></i> <%=skName%> - Fast-Track Study Kit</span>
										<span style="font-size: 0.78rem; background: rgba(34, 211, 238, 0.15); color: var(--primary-cyan); padding: 4px 12px; border-radius: 10px; font-weight: 600;">Expand Study Kit</span>
									</summary>
									<div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid rgba(255,255,255,0.08); color: #cbd5e1; font-size: 0.88rem; line-height: 1.6;">
										<div style="margin-bottom: 12px;">
											<strong style="color: #38bdf8;"><i class="fas fa-lightbulb"></i> Industry Core Role Summary:</strong><br>
											<span><%=skName%> is a primary technology used in industry to engineer reliable, scalable, and high-performance solutions for <strong><%=c.getCareerName()%></strong> roles.</span>
										</div>
										<div style="margin-bottom: 12px; background: rgba(0,0,0,0.3); padding: 12px 16px; border-radius: 8px; border-left: 3px solid var(--primary-cyan);">
											<strong style="color: #fbbf24;"><i class="fas fa-key"></i> Key Interview Questions & Definitions:</strong>
											<ul style="margin: 6px 0 0 18px; padding: 0; color: #94a3b8; font-size: 0.84rem;">
												<li><strong>Q1: What are the core architectural principles of <%=skName%>?</strong><br><em>Focus on modular design, clean separation of concerns, and thread-safety.</em></li>
												<li><strong>Q2: How do you optimize <%=skName%> in production environments?</strong><br><em>Use connection pooling, efficient data structures, and proper memory management.</em></li>
											</ul>
										</div>
										<div>
											<strong style="color: #34d399;"><i class="fas fa-check-circle"></i> Best Practices & Key Pitfalls:</strong>
											<p style="margin: 4px 0 0 0; font-size: 0.84rem; color: #94a3b8;">Always enforce exception handling, write clean unit tests, and maintain modular architecture when building enterprise projects.</p>
										</div>
									</div>
								</details>
								<% 
									}
								} 
								%>
							</div>
						</div>

						<!-- TAB 3: Hands-On Capstone Mini-Project Brief (Point 4) -->
						<div id="hub-tab-content-project-<%=c.getId()%>" class="hub-tab-content" style="display: none;">
							<div style="background: rgba(255,255,255,0.04); border-radius: 14px; border: 1px solid rgba(255,255,255,0.08); padding: 20px; margin-bottom: 20px;">
								<div style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px;">
									<div style="background: rgba(16, 185, 129, 0.2); color: #34d399; padding: 4px 12px; border-radius: 8px; font-weight: 700; font-size: 0.8rem;">
										Portfolio Mini-Project
									</div>
									<h4 style="margin: 0; font-size: 1rem; color: #fff; font-weight: 700;">Build an Enterprise Portal for <%=c.getCareerName()%></h4>
								</div>
								<p style="font-size: 0.88rem; color: #cbd5e1; line-height: 1.6; margin-bottom: 15px;">
									Gain practical hands-on experience by building a production-ready application using <strong><%=c.getRequiredSkills()%></strong>.
								</p>
								<div style="font-weight: 600; font-size: 0.85rem; color: var(--primary-cyan); margin-bottom: 8px;">Key Project Deliverables:</div>
								<ul style="margin: 0 0 15px 20px; padding: 0; color: #94a3b8; font-size: 0.85rem; line-height: 1.8;">
									<li>Implement RESTful API endpoints with JSON request validation.</li>
									<li>Design normalized MySQL database schema with indexed foreign keys.</li>
									<li>Build dynamic UI components connected to backend services.</li>
								</ul>
							</div>
						</div>

						<!-- Bottom Action Bar & Cooldown Guard -->
						<div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; flex-wrap: wrap; gap: 12px;">
							<div style="font-size: 0.82rem; color: #94a3b8; display: flex; align-items: center; gap: 8px;">
								<i class="fas fa-clock" style="color: #fbbf24;"></i>
								<span><strong>24-Hour Assessment Cooldown:</strong> Enforces dedicated study time between test re-takes.</span>
							</div>
							<a href="/assessment/start" class="admin-btn admin-btn-primary" style="padding: 10px 22px; border-radius: 10px; font-weight: 700; text-decoration: none;">
								<i class="fas fa-redo-alt"></i> Re-Take Assessment Test
							</a>
						</div>
					</div>
				</div>
				<% 
					rank++;
				} 
				%>
			<% } else { %>
				<div class="empty-state">
					<i class="fas fa-clipboard-list"></i>
					<h3>No Detailed Recommendations Available Yet</h3>
					<p>Please complete your Skill Onboarding and take your Dynamic Assessment test to generate your personalized career report.</p>
					<div style="margin-top: 25px; display: flex; justify-content: center; gap: 15px;">
						<a href="/onboarding" class="admin-btn admin-btn-primary"><i class="fas fa-layer-group"></i> Start Skill Onboarding</a>
					</div>
				</div>
			<% } %>
		</div>
	</main>
</div>

<script>
	function toggleSidebar() {
		document.getElementById('sidebar').classList.toggle('collapsed');
	}

	function switchHubTab(careerId, tabName) {
		const parent = document.getElementById('tab-btn-' + tabName + '-' + careerId).parentElement.parentElement;
		const contents = parent.getElementsByClassName('hub-tab-content');
		for (let i = 0; i < contents.length; i++) {
			contents[i].style.display = 'none';
		}
		const btns = parent.getElementsByClassName('hub-tab-btn');
		for (let i = 0; i < btns.length; i++) {
			btns[i].classList.remove('active');
		}

		document.getElementById('hub-tab-content-' + tabName + '-' + careerId).style.display = 'block';
		document.getElementById('tab-btn-' + tabName + '-' + careerId).classList.add('active');
	}
</script>
</body>
</html>