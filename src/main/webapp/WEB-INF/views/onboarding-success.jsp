<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.techhub.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Onboarding Complete - Smart Career</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--text-light: #f8fafc;
	--text-dark: #0f172a;
	--text-muted: #94a3b8;
	--card-bg-light: #ffffff;
	--success: #10b981;
	--border: #e2e8f0;
}

body {
	font-family: 'Poppins', sans-serif;
	background: #f8fafc;
	color: var(--text-dark);
	margin: 0;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

header {
	background: var(--bg-dark-blue);
	padding: 20px 0;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
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
}

.logo span {
	color: var(--text-light);
}

.container-main {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 60px 20px;
}

.success-card {
	background: var(--card-bg-light);
	border-radius: 20px;
	padding: 50px 40px;
	max-width: 650px;
	width: 100%;
	text-align: center;
	box-shadow: 0 10px 35px rgba(0, 0, 0, 0.06);
	border: 1px solid var(--border);
}

.icon-badge {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background: rgba(16, 185, 129, 0.15);
	color: var(--success);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2.5rem;
	margin: 0 auto 25px auto;
}

.success-card h1 {
	font-size: 1.8rem;
	color: var(--bg-dark-blue);
	margin-bottom: 10px;
	font-weight: 700;
}

.success-card p {
	color: var(--text-muted);
	font-size: 0.95rem;
	line-height: 1.6;
	margin-bottom: 35px;
}

.options-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
}

.option-box {
	background: #f8fafc;
	border-radius: 14px;
	padding: 25px;
	border: 2px solid var(--border);
	transition: all 0.3s ease;
	text-decoration: none;
	color: var(--text-dark);
	display: flex;
	flex-direction: column;
	align-items: center;
}

.option-box:hover {
	transform: translateY(-5px);
	border-color: var(--primary-cyan);
	box-shadow: 0 8px 25px rgba(34, 211, 238, 0.15);
}

.option-box i {
	font-size: 2.2rem;
	margin-bottom: 15px;
}

.option-box.primary-option i {
	color: var(--primary-cyan);
}

.option-box.secondary-option i {
	color: #0284c7;
}

.option-box h3 {
	font-size: 1.1rem;
	font-weight: 700;
	margin: 0 0 8px 0;
	color: var(--bg-dark-blue);
}

.option-box p {
	font-size: 0.85rem;
	color: var(--text-muted);
	margin: 0 0 20px 0;
}

.btn-action {
	width: 100%;
	padding: 12px;
	border-radius: 8px;
	font-weight: 700;
	font-size: 0.9rem;
	border: none;
	cursor: pointer;
	text-align: center;
}

.btn-primary-cyan {
	background: var(--primary-cyan);
	color: #000;
}

.btn-secondary-blue {
	background: var(--bg-dark-blue);
	color: #fff;
}
</style>
</head>
<body>
	<header>
		<div class="header-content">
			<a href="/dashboard" class="logo">Smart<span>Career</span></a>
		</div>
	</header>

	<div class="container-main">
		<div class="success-card">
			<div class="icon-badge">
				<i class="fas fa-check-circle"></i>
			</div>
			<h1>Skills & Interests Saved Successfully!</h1>
			<p>Your profile onboarding is complete. How would you like to proceed next?</p>

			<div class="options-grid">
				<!-- Option 1: Take Test Immediately -->
				<a href="/assessment/start" class="option-box primary-option">
					<i class="fas fa-play-circle"></i>
					<h3>Take Dynamic Assessment</h3>
					<p>Start your adaptive test now to verify your skills and calculate your match scores.</p>
					<div class="btn-action btn-primary-cyan">🚀 Start Assessment Now</div>
				</a>

				<!-- Option 2: Go to User Dashboard -->
				<a href="/dashboard" class="option-box secondary-option">
					<i class="fas fa-chart-line"></i>
					<h3>Go to Dashboard</h3>
					<p>Explore your candidate dashboard, career options, and take the assessment later.</p>
					<div class="btn-action btn-secondary-blue">📊 Go to Dashboard</div>
				</a>
			</div>
		</div>
	</div>
</body>
</html>
