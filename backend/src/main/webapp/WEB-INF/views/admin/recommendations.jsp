<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.techhub.entity.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recommendation Management - Smart Career Admin</title>
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

.dashboard-layout {
	display: flex;
	flex-direction: row !important;
	min-height: 100vh;
	width: 100%;
}

.admin-sidebar {
	width: 260px;
	min-width: 260px;
	background: var(--bg-dark-blue);
	color: #fff;
	display: flex;
	flex-direction: column;
	transition: margin-left 0.3s ease;
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
	color: #fff;
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
	text-decoration: none;
	font-weight: 500;
	transition: .3s;
}

.admin-sidebar-nav a:hover, .admin-sidebar-nav a.active {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-cyan);
}

.admin-main {
	flex: 1;
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
	align-items: center;
	justify-content: center;
	font-weight: 700;
}

.admin-logout-btn {
	background: rgba(239, 68, 68, 0.1);
	color: var(--danger);
	padding: 8px 16px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 500;
	font-size: 0.9rem;
}

.admin-content {
	padding: 35px;
	flex: 1;
}

.admin-stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.admin-stat-card {
	background: var(--white);
	padding: 22px;
	border-radius: 14px;
	border: 1px solid var(--border);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
}

.admin-stat-card h3 {
	font-size: 1.8rem;
	margin: 0 0 5px 0;
	color: var(--bg-dark-blue);
}

.admin-stat-card p {
	margin: 0;
	color: var(--text-muted);
	font-size: 0.85rem;
}

/* Student Group Card Styles */
.student-group-card {
	background: var(--white);
	border-radius: 16px;
	padding: 28px;
	margin-bottom: 25px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.03);
	border: 1px solid var(--border);
}

.student-card-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding-bottom: 20px;
	margin-bottom: 20px;
	border-bottom: 2px solid #f1f5f9;
}

.student-info-meta {
	display: flex;
	align-items: center;
	gap: 15px;
}

.student-avatar-lg {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: var(--bg-dark-blue);
	color: var(--primary-cyan);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.3rem;
	font-weight: 700;
}

.student-name-title h3 {
	margin: 0 0 4px 0;
	font-size: 1.2rem;
	font-weight: 700;
	color: var(--bg-dark-blue);
}

.student-email-tag {
	font-size: 0.85rem;
	color: var(--text-muted);
	display: flex;
	align-items: center;
	gap: 6px;
}

.top-careers-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 18px;
}

.career-choice-box {
	background: #f8fafc;
	border-radius: 12px;
	padding: 18px;
	border: 1px solid var(--border);
	position: relative;
}

.choice-rank-badge {
	position: absolute;
	top: 14px;
	right: 14px;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 0.75rem;
	font-weight: 700;
}

.rank-1 { background: rgba(34, 211, 238, 0.15); color: #0284c7; }
.rank-2 { background: rgba(16, 185, 129, 0.15); color: #059669; }
.rank-3 { background: rgba(245, 158, 11, 0.15); color: #d97706; }

.career-choice-title {
	font-size: 1rem;
	font-weight: 700;
	color: var(--bg-dark-blue);
	margin-bottom: 8px;
	padding-right: 70px;
}

.match-score-text {
	font-size: 0.9rem;
	font-weight: 600;
	margin-bottom: 8px;
}

.score-high { color: var(--success); }
.score-medium { color: var(--warning); }
.score-low { color: var(--danger); }

.bar-bg {
	height: 8px;
	width: 100%;
	background: #e2e8f0;
	border-radius: 4px;
	overflow: hidden;
}

.bar-fill {
	height: 100%;
	border-radius: 4px;
}

.search-header-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	gap: 15px;
}

.admin-search-box {
	display: flex;
	align-items: center;
	background: var(--white);
	padding: 10px 18px;
	border-radius: 12px;
	border: 1px solid var(--border);
	width: 320px;
}

.admin-search-box input {
	border: none;
	outline: none;
	margin-left: 10px;
	width: 100%;
	font-family: inherit;
}
</style>
</head>
<body class="admin-body">
<%
User admin = (User) session.getAttribute("admin");
Map<Long, List<Recommendation>> userRecsMap = (Map<Long, List<Recommendation>>) request.getAttribute("userRecsMap");
Map<Long, User> userMap = (Map<Long, User>) request.getAttribute("userMap");
Map<Long, Career> careerMap = (Map<Long, Career>) request.getAttribute("careerMap");
List<Recommendation> allRecs = (List<Recommendation>) request.getAttribute("recommendations");

int totalCount = allRecs != null ? allRecs.size() : 0;
int studentCount = userRecsMap != null ? userRecsMap.size() : 0;
long highMatchesCount = allRecs != null ? allRecs.stream().filter(r -> r.getMatchScore() != null && r.getMatchScore() >= 80).count() : 0;
%>
<div class="dashboard-layout">
	<!-- Sidebar -->
	<aside class="admin-sidebar" id="sidebar">
		<div class="admin-sidebar-header">
			<h2>Smart<span>Career</span></h2>
			<p style="color: var(--admin-gold); font-weight: 700; font-size: 11px; margin-top: 5px; margin-bottom: 0; letter-spacing: 1px; text-transform: uppercase;">
				<i class="fas fa-shield-alt"></i> Executive Control Center
			</p>
		</div>
		<nav class="admin-sidebar-nav">
			<ul>
				<li><a href="/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
				<li><a href="/admin/users"><i class="fas fa-users"></i> User Management</a></li>
				<li><a href="/admin/assessments"><i class="fas fa-clipboard-list"></i> Assessments</a></li>
				<li><a href="/admin/questions"><i class="fas fa-question-circle"></i> Questions</a></li>
				<li><a href="/admin/careers"><i class="fas fa-briefcase"></i> Careers</a></li>
				<li><a href="/admin/recommendations" class="active"><i class="fas fa-star"></i> Recommendations</a></li>
				<li><a href="/admin/analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
				<li><a href="/admin/profile"><i class="fas fa-user-cog"></i> Profile</a></li>
			</ul>
		</nav>
	</aside>

	<!-- Main Content -->
	<main class="admin-main">
		<header class="admin-header">
			<div class="admin-header-left">
				<button class="admin-menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
				<h1>Recommendation Management</h1>
			</div>
			<div class="admin-user-info">
				<div class="admin-user-avatar"><%=admin != null && admin.getName() != null ? admin.getName().substring(0, 1).toUpperCase() : "A"%></div>
				<div>
					<div style="font-weight: 600; font-size: 14px;"><%=admin != null ? admin.getName() : "Admin"%></div>
					<div style="font-size: 12px; color: var(--text-muted);">Administrator</div>
				</div>
				<a href="/admin/logout" class="admin-logout-btn" style="margin-left: 15px;"><i class="fas fa-sign-out-alt"></i> Logout</a>
			</div>
		</header>

		<div class="admin-content">
			<!-- Stats Cards -->
			<div class="admin-stats-grid">
				<div class="admin-stat-card">
					<h3><%=studentCount%></h3>
					<p>Students Evaluated</p>
				</div>
				<div class="admin-stat-card">
					<h3><%=totalCount%></h3>
					<p>Total Recommendation Matches</p>
				</div>
				<div class="admin-stat-card">
					<h3><%=highMatchesCount%></h3>
					<p>High Score Matches (&ge;80%)</p>
				</div>
			</div>

			<!-- Search Header -->
			<div class="search-header-box">
				<h3 style="margin: 0; color: var(--bg-dark-blue); font-size: 1.2rem;">
					<i class="fas fa-user-graduate" style="color: var(--primary-cyan);"></i> Student Recommendation Summary Cards
				</h3>
				<div class="admin-search-box">
					<i class="fas fa-search" style="color: var(--text-muted);"></i>
					<input type="text" id="recSearchInput" onkeyup="filterRecommendationCards()" placeholder="Search by student name or career...">
				</div>
			</div>

			<!-- Student Cards List -->
			<div id="studentCardsContainer">
				<% if (userRecsMap != null && !userRecsMap.isEmpty()) { 
					for (Map.Entry<Long, List<Recommendation>> entry : userRecsMap.entrySet()) {
						Long uId = entry.getKey();
						List<Recommendation> recList = entry.getValue();
						User student = userMap != null ? userMap.get(uId) : null;
						String studentName = student != null && student.getName() != null ? student.getName() : ("Student #" + uId);
						String studentEmail = student != null && student.getEmail() != null ? student.getEmail() : "N/A";
				%>
				<div class="student-group-card" data-search="<%=studentName.toLowerCase()%> <%=studentEmail.toLowerCase()%>">
					<div class="student-card-header">
						<div class="student-info-meta">
							<div class="student-avatar-lg"><%=studentName.substring(0, 1).toUpperCase()%></div>
							<div class="student-name-title">
								<h3><%=studentName%></h3>
								<div class="student-email-tag"><i class="fas fa-envelope"></i> <%=studentEmail%></div>
							</div>
						</div>
						<div style="background: rgba(16, 185, 129, 0.1); color: var(--success); padding: 6px 16px; border-radius: 20px; font-weight: 600; font-size: 0.85rem;">
							<i class="fas fa-check-circle"></i> Assessment Verified
						</div>
					</div>

					<div style="font-weight: 600; font-size: 0.9rem; color: var(--text-muted); margin-bottom: 12px;">
						<i class="fas fa-star" style="color: #f59e0b;"></i> Top Career Matches for this Student:
					</div>

					<div class="top-careers-grid">
						<% 
						int rank = 1;
						for (Recommendation rec : recList) {
							if (rank > 3) break; // Display top 3 per student
							Career career = careerMap != null ? careerMap.get(rec.getCareerId()) : null;
							String careerName = career != null ? career.getCareerName() : ("Career #" + rec.getCareerId());
							double score = rec.getMatchScore() != null ? rec.getMatchScore() : 0.0;
							String scoreClass = score >= 80 ? "score-high" : (score >= 50 ? "score-medium" : "score-low");
							String bgStyle = score >= 80 ? "background: #10b981;" : (score >= 50 ? "background: #f59e0b;" : "background: #ef4444;");
						%>
						<div class="career-choice-box">
							<span class="choice-rank-badge rank-<%=rank%>">#<%=rank%> Choice</span>
							<div class="career-choice-title"><%=careerName%></div>
							<div class="match-score-text <%=scoreClass%>"><%=String.format("%.1f", score)%>% Match</div>
							<div class="bar-bg">
								<div class="bar-fill" style="width: <%=Math.min(100.0, score)%>%; <%=bgStyle%>"></div>
							</div>
						</div>
						<% 
							rank++;
						} 
						%>
					</div>
				</div>
				<% 
					} 
				} else { 
				%>
				<div class="student-group-card" style="text-align: center; padding: 50px;">
					<i class="fas fa-folder-open" style="font-size: 3rem; color: var(--text-muted); margin-bottom: 15px;"></i>
					<p style="color: var(--text-muted); font-size: 16px;">No student recommendations generated yet.</p>
				</div>
				<% } %>
			</div>
		</div>
	</main>
</div>

<script>
	function toggleSidebar() {
		document.getElementById('sidebar').classList.toggle('collapsed');
	}

	function filterRecommendationCards() {
		const input = document.getElementById('recSearchInput');
		const filter = input.value.toLowerCase();
		const cards = document.getElementsByClassName('student-group-card');
		for (let i = 0; i < cards.length; i++) {
			const card = cards[i];
			const text = card.innerText || card.textContent;
			if (text.toLowerCase().indexOf(filter) > -1) {
				card.style.display = "";
			} else {
				card.style.display = "none";
			}
		}
	}
</script>
</body>
</html>