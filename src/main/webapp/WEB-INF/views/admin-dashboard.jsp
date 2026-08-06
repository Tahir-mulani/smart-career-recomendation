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

<style>
/* Modern UI Color Palette */
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--bg-gradient: linear-gradient(135deg, #0f1c29 0%, #1a364b 50%, #1e455c 100%);
	--text-light: #f8fafc;
	--text-dark: #0f172a;
	--text-muted: #94a3b8;
	--card-bg-light: #ffffff;
	--border: #e2e8f0;
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
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* --- Header --- */
header {
	background: var(--bg-dark-blue);
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	padding: 20px 0;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.header-content {
	width: min(1200px, 90%);
	margin: auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.7rem;
	font-weight: 700;
	color: var(--primary-cyan);
	text-decoration: none;
	display: flex;
	align-items: center;
}

.logo span.main-span {
	color: var(--text-light);
}

.logo span.admin-span {
	font-size: 0.85rem;
	color: var(--text-muted);
	margin-left: 8px;
	background: rgba(255, 255, 255, 0.1);
	padding: 2px 8px;
	border-radius: 12px;
	font-weight: 500;
}

nav ul {
	list-style: none;
	display: flex;
	gap: 25px;
}

nav a {
	color: var(--text-light);
	text-decoration: none;
	font-weight: 500;
	font-size: 0.95rem;
	transition: 0.3s;
}

nav a:hover {
	color: var(--primary-cyan);
}

/* --- Dashboard Container --- */
.container {
	width: min(1200px, 90%);
	margin: auto;
	flex: 1;
	padding: 40px 0;
}

.dashboard-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.dashboard-header h2 {
	color: var(--bg-dark-blue);
	font-size: 2rem;
	margin: 0;
}

.user-info {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: var(--primary-cyan);
	color: #000;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 1.2rem;
	font-weight: 700;
}

.user-info small {
	color: var(--text-muted);
	font-weight: 500;
}

/* --- Stats Grid --- */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 25px;
	margin-bottom: 40px;
}

.stat-card {
	background: var(--bg-gradient);
	padding: 30px;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	color: var(--text-light);
	position: relative;
	overflow: hidden;
}

.stat-card h3 {
	font-size: 2.5rem;
	color: var(--primary-cyan);
	margin: 0;
	line-height: 1;
}

.stat-card p {
	margin: 10px 0 0;
	font-size: 1.1rem;
	color: rgba(255, 255, 255, 0.8);
	font-weight: 500;
}

/* --- Admin Nav --- */
.admin-nav {
	display: flex;
	gap: 15px;
	margin-bottom: 30px;
	border-bottom: 2px solid var(--border);
	padding-bottom: 15px;
	flex-wrap: wrap;
}

.admin-nav a {
	text-decoration: none;
	color: var(--text-muted);
	font-weight: 500;
	padding: 8px 16px;
	border-radius: 8px;
	transition: 0.3s;
}

.admin-nav a:hover {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-hover);
}

.admin-nav a.active {
	background: var(--primary-cyan);
	color: #000;
}

/* --- Tables --- */
h3.section-title {
	color: var(--bg-dark-blue);
	margin-bottom: 20px;
	font-size: 1.3rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

h3.section-title i {
	color: var(--primary-cyan);
}

table {
	width: 100%;
	border-collapse: collapse;
	background: var(--card-bg-light);
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

th, td {
	padding: 16px 20px;
	text-align: left;
	border-bottom: 1px solid var(--border);
}

th {
	background: rgba(248, 250, 252, 0.8);
	color: var(--text-muted);
	font-weight: 600;
	text-transform: uppercase;
	font-size: 0.85rem;
	letter-spacing: 0.5px;
}

td {
	color: var(--text-dark);
	font-size: 0.95rem;
	vertical-align: middle;
}

tr:last-child td {
	border-bottom: none;
}

.role-badge {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-hover);
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 0.8rem;
	font-weight: 600;
}

.card {
	background: var(--card-bg-light);
	padding: 30px;
	border-radius: 12px;
	text-align: center;
	color: var(--text-muted);
	border: 1px dashed var(--border);
	margin-bottom: 30px;
}

/* --- Footer --- */
footer {
	background: var(--bg-dark-blue);
	color: var(--text-muted);
	text-align: center;
	padding: 25px 20px;
	font-size: 0.9rem;
	border-top: 1px solid rgba(255, 255, 255, 0.05);
	margin-top: auto;
}
</style>
</head>
<body>
	<header>
		<div class="header-content">
			<div class="logo">
				Smart<span class="main-span">Career</span> <span class="admin-span">Admin</span>
			</div>
			<nav>
				<ul>
					<li><a href="/admin/dashboard">Dashboard</a></li>
					<li><a href="/admin/assessments">Assessments</a></li>
					<li><a href="/admin/careers">Careers</a></li>
					<li><a href="/admin/questions">Questions</a></li>
					<li><a href="/admin/logout">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>

	<div class="container">
		<div class="dashboard">
			<div class="dashboard-header">
				<h2>Admin Dashboard</h2>
				<div class="user-info">
					<div class="user-avatar">
						<%=((User) request.getAttribute("admin")).getName().substring(0, 1).toUpperCase()%>
					</div>
					<div>
						<strong><%=((User) request.getAttribute("admin")).getName()%></strong><br>
						<small>Administrator</small>
					</div>
				</div>
			</div>

			<div class="stats-grid">
				<div class="stat-card">
					<h3><%=((List<Assessment>) request.getAttribute("assessments")).size()%></h3>
					<p>
						<i class="fas fa-clipboard-list" style="margin-right: 5px;"></i>
						Assessments
					</p>
				</div>
				<div class="stat-card">
					<h3><%=((List<Career>) request.getAttribute("careers")).size()%></h3>
					<p>
						<i class="fas fa-briefcase" style="margin-right: 5px;"></i>
						Careers
					</p>
				</div>
				<div class="stat-card">
					<h3><%=((List<User>) request.getAttribute("users")).size()%></h3>
					<p>
						<i class="fas fa-users" style="margin-right: 5px;"></i> Users
					</p>
				</div>
			</div>

			<div class="admin-nav">
				<a href="/admin/assessments" class="active"><i
					class="fas fa-edit"></i> Manage Assessments</a> <a
					href="/admin/careers"><i class="fas fa-briefcase"></i> Manage
					Careers</a> <a href="/admin/questions"><i
					class="fas fa-question-circle"></i> Manage Questions</a>
			</div>

			<h3 class="section-title">
				<i class="fas fa-clipboard-check"></i> Recent Assessments
			</h3>
			<%
			List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments");
			%>
			<%
			if (assessments != null && !assessments.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Duration</th>
					<th>Total Marks</th>
				</tr>
				<%
				for (Assessment assessment : assessments) {
				%>
				<tr>
					<td>#<%=assessment.getId()%></td>
					<td><%=assessment.getTestName()%></td>
					<td><%=assessment.getDuration()%> min</td>
					<td><%=assessment.getTotalMarks()%></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No assessments created yet.</p>
			</div>
			<%
			}
			%>

			<h3 class="section-title" style="margin-top: 40px;">
				<i class="fas fa-briefcase"></i> Recent Careers
			</h3>
			<%
			List<Career> careers = (List<Career>) request.getAttribute("careers");
			%>
			<%
			if (careers != null && !careers.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Career Name</th>
					<th>Required Skills</th>
				</tr>
				<%
				for (Career career : careers) {
				%>
				<tr>
					<td>#<%=career.getId()%></td>
					<td><%=career.getCareerName()%></td>
					<td><%=career.getRequiredSkills()%></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No careers added yet.</p>
			</div>
			<%
			}
			%>

			<h3 class="section-title" style="margin-top: 40px;">
				<i class="fas fa-users"></i> Registered Users
			</h3>
			<%
			List<User> users = (List<User>) request.getAttribute("users");
			%>
			<%
			if (users != null && !users.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Role</th>
				</tr>
				<%
				for (User user : users) {
				%>
				<tr>
					<td>#<%=user.getId()%></td>
					<td><%=user.getName()%></td>
					<td><%=user.getEmail()%></td>
					<td><span class="role-badge"><%=user.getRole()%></span></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No users registered yet.</p>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<footer>
		<div class="container" style="width: 100%; max-width: none;">
			<p>&copy; 2026 Smart Career Recommendation System. All rights
				reserved.</p>
		</div>
	</footer>
</body>
</html><%@ page contentType="text/html;charset=UTF-8" language="java"%>
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

<style>
/* Modern UI Color Palette */
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--bg-gradient: linear-gradient(135deg, #0f1c29 0%, #1a364b 50%, #1e455c 100%);
	--text-light: #f8fafc;
	--text-dark: #0f172a;
	--text-muted: #94a3b8;
	--card-bg-light: #ffffff;
	--border: #e2e8f0;
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
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* --- Header --- */
header {
	background: var(--bg-dark-blue);
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	padding: 20px 0;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.header-content {
	width: min(1200px, 90%);
	margin: auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.7rem;
	font-weight: 700;
	color: var(--primary-cyan);
	text-decoration: none;
	display: flex;
	align-items: center;
}

.logo span.main-span {
	color: var(--text-light);
}

.logo span.admin-span {
	font-size: 0.85rem;
	color: var(--text-muted);
	margin-left: 8px;
	background: rgba(255, 255, 255, 0.1);
	padding: 2px 8px;
	border-radius: 12px;
	font-weight: 500;
}

nav ul {
	list-style: none;
	display: flex;
	gap: 25px;
}

nav a {
	color: var(--text-light);
	text-decoration: none;
	font-weight: 500;
	font-size: 0.95rem;
	transition: 0.3s;
}

nav a:hover {
	color: var(--primary-cyan);
}

/* --- Dashboard Container --- */
.container {
	width: min(1200px, 90%);
	margin: auto;
	flex: 1;
	padding: 40px 0;
}

.dashboard-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.dashboard-header h2 {
	color: var(--bg-dark-blue);
	font-size: 2rem;
	margin: 0;
}

.user-info {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: var(--primary-cyan);
	color: #000;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 1.2rem;
	font-weight: 700;
}

.user-info small {
	color: var(--text-muted);
	font-weight: 500;
}

/* --- Stats Grid --- */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 25px;
	margin-bottom: 40px;
}

.stat-card {
	background: var(--bg-gradient);
	padding: 30px;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	color: var(--text-light);
	position: relative;
	overflow: hidden;
}

.stat-card h3 {
	font-size: 2.5rem;
	color: var(--primary-cyan);
	margin: 0;
	line-height: 1;
}

.stat-card p {
	margin: 10px 0 0;
	font-size: 1.1rem;
	color: rgba(255, 255, 255, 0.8);
	font-weight: 500;
}

/* --- Admin Nav --- */
.admin-nav {
	display: flex;
	gap: 15px;
	margin-bottom: 30px;
	border-bottom: 2px solid var(--border);
	padding-bottom: 15px;
	flex-wrap: wrap;
}

.admin-nav a {
	text-decoration: none;
	color: var(--text-muted);
	font-weight: 500;
	padding: 8px 16px;
	border-radius: 8px;
	transition: 0.3s;
}

.admin-nav a:hover {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-hover);
}

.admin-nav a.active {
	background: var(--primary-cyan);
	color: #000;
}

/* --- Tables --- */
h3.section-title {
	color: var(--bg-dark-blue);
	margin-bottom: 20px;
	font-size: 1.3rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

h3.section-title i {
	color: var(--primary-cyan);
}

table {
	width: 100%;
	border-collapse: collapse;
	background: var(--card-bg-light);
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

th, td {
	padding: 16px 20px;
	text-align: left;
	border-bottom: 1px solid var(--border);
}

th {
	background: rgba(248, 250, 252, 0.8);
	color: var(--text-muted);
	font-weight: 600;
	text-transform: uppercase;
	font-size: 0.85rem;
	letter-spacing: 0.5px;
}

td {
	color: var(--text-dark);
	font-size: 0.95rem;
	vertical-align: middle;
}

tr:last-child td {
	border-bottom: none;
}

.role-badge {
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-hover);
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 0.8rem;
	font-weight: 600;
}

.card {
	background: var(--card-bg-light);
	padding: 30px;
	border-radius: 12px;
	text-align: center;
	color: var(--text-muted);
	border: 1px dashed var(--border);
	margin-bottom: 30px;
}

/* --- Footer --- */
footer {
	background: var(--bg-dark-blue);
	color: var(--text-muted);
	text-align: center;
	padding: 25px 20px;
	font-size: 0.9rem;
	border-top: 1px solid rgba(255, 255, 255, 0.05);
	margin-top: auto;
}
</style>
</head>
<body>
	<header>
		<div class="header-content">
			<div class="logo">
				Smart<span class="main-span">Career</span> <span class="admin-span">Admin</span>
			</div>
			<nav>
				<ul>
					<li><a href="/admin/dashboard">Dashboard</a></li>
					<li><a href="/admin/assessments">Assessments</a></li>
					<li><a href="/admin/careers">Careers</a></li>
					<li><a href="/admin/questions">Questions</a></li>
					<li><a href="/admin/logout">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>

	<div class="container">
		<div class="dashboard">
			<div class="dashboard-header">
				<h2>Admin Dashboard</h2>
				<div class="user-info">
					<div class="user-avatar">
						<%=((User) request.getAttribute("admin")).getName().substring(0, 1).toUpperCase()%>
					</div>
					<div>
						<strong><%=((User) request.getAttribute("admin")).getName()%></strong><br>
						<small>Administrator</small>
					</div>
				</div>
			</div>

			<div class="stats-grid">
				<div class="stat-card">
					<h3><%=((List<Assessment>) request.getAttribute("assessments")).size()%></h3>
					<p>
						<i class="fas fa-clipboard-list" style="margin-right: 5px;"></i>
						Assessments
					</p>
				</div>
				<div class="stat-card">
					<h3><%=((List<Career>) request.getAttribute("careers")).size()%></h3>
					<p>
						<i class="fas fa-briefcase" style="margin-right: 5px;"></i>
						Careers
					</p>
				</div>
				<div class="stat-card">
					<h3><%=((List<User>) request.getAttribute("users")).size()%></h3>
					<p>
						<i class="fas fa-users" style="margin-right: 5px;"></i> Users
					</p>
				</div>
			</div>

			<div class="admin-nav">
				<a href="/admin/assessments" class="active"><i
					class="fas fa-edit"></i> Manage Assessments</a> <a
					href="/admin/careers"><i class="fas fa-briefcase"></i> Manage
					Careers</a> <a href="/admin/questions"><i
					class="fas fa-question-circle"></i> Manage Questions</a>
			</div>

			<h3 class="section-title">
				<i class="fas fa-clipboard-check"></i> Recent Assessments
			</h3>
			<%
			List<Assessment> assessments = (List<Assessment>) request.getAttribute("assessments");
			%>
			<%
			if (assessments != null && !assessments.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Duration</th>
					<th>Total Marks</th>
				</tr>
				<%
				for (Assessment assessment : assessments) {
				%>
				<tr>
					<td>#<%=assessment.getId()%></td>
					<td><%=assessment.getTestName()%></td>
					<td><%=assessment.getDuration()%> min</td>
					<td><%=assessment.getTotalMarks()%></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No assessments created yet.</p>
			</div>
			<%
			}
			%>

			<h3 class="section-title" style="margin-top: 40px;">
				<i class="fas fa-briefcase"></i> Recent Careers
			</h3>
			<%
			List<Career> careers = (List<Career>) request.getAttribute("careers");
			%>
			<%
			if (careers != null && !careers.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Career Name</th>
					<th>Required Skills</th>
				</tr>
				<%
				for (Career career : careers) {
				%>
				<tr>
					<td>#<%=career.getId()%></td>
					<td><%=career.getCareerName()%></td>
					<td><%=career.getRequiredSkills()%></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No careers added yet.</p>
			</div>
			<%
			}
			%>

			<h3 class="section-title" style="margin-top: 40px;">
				<i class="fas fa-users"></i> Registered Users
			</h3>
			<%
			List<User> users = (List<User>) request.getAttribute("users");
			%>
			<%
			if (users != null && !users.isEmpty()) {
			%>
			<table>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Role</th>
				</tr>
				<%
				for (User user : users) {
				%>
				<tr>
					<td>#<%=user.getId()%></td>
					<td><%=user.getName()%></td>
					<td><%=user.getEmail()%></td>
					<td><span class="role-badge"><%=user.getRole()%></span></td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<div class="card">
				<p>No users registered yet.</p>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<footer>
		<div class="container" style="width: 100%; max-width: none;">
			<p>&copy; 2026 Smart Career Recommendation System. All rights
				reserved.</p>
		</div>
	</footer>
</body>
</html>