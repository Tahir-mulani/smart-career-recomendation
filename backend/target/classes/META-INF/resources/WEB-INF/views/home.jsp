<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Career Recommendation - Precision AI Career Analytics</title>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--indigo-accent: #6366f1;
	--purple-accent: #8b5cf6;
	--emerald-accent: #10b981;
	--bg-dark: #070c14;
	--bg-card: rgba(15, 23, 42, 0.7);
	--bg-gradient: radial-gradient(circle at 50% 0%, #1e293b 0%, #0f172a 60%, #070c14 100%);
	--text-light: #f8fafc;
	--text-dark: #0f172a;
	--text-muted: #94a3b8;
	--border-glass: rgba(255, 255, 255, 0.08);
	--border-glow: rgba(34, 211, 238, 0.3);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Plus Jakarta Sans', sans-serif;
}

body {
	background: var(--bg-dark);
	color: var(--text-light);
	line-height: 1.6;
	overflow-x: hidden;
}

.container {
	width: min(1240px, 92%);
	margin: 0 auto;
}

/* --- Header Navbar --- */
header {
	background: rgba(7, 12, 20, 0.85);
	backdrop-filter: blur(16px);
	-webkit-backdrop-filter: blur(16px);
	padding: 16px 0;
	border-bottom: 1px solid var(--border-glass);
	position: sticky;
	top: 0;
	z-index: 100;
}

.header-content {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.7rem;
	font-weight: 800;
	color: var(--primary-cyan);
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 10px;
	letter-spacing: -0.5px;
}

.logo span {
	color: var(--text-light);
}

.logo-badge {
	font-size: 0.7rem;
	background: rgba(34, 211, 238, 0.15);
	color: var(--primary-cyan);
	padding: 3px 8px;
	border-radius: 20px;
	border: 1px solid var(--border-glow);
	font-weight: 600;
}

nav ul {
	list-style: none;
	display: flex;
	gap: 30px;
	align-items: center;
}

nav a {
	color: var(--text-muted);
	text-decoration: none;
	font-weight: 500;
	font-size: 0.95rem;
	transition: all 0.3s ease;
}

nav a:hover {
	color: var(--primary-cyan);
}

.nav-cta-group {
	display: flex;
	gap: 14px;
	align-items: center;
}

.btn-nav {
	padding: 10px 22px;
	border-radius: 30px;
	font-size: 0.9rem;
	font-weight: 600;
	text-decoration: none;
	transition: all 0.3s ease;
}

.btn-nav-outline {
	color: var(--text-light);
	border: 1px solid var(--border-glass);
	background: rgba(255, 255, 255, 0.03);
}

.btn-nav-outline:hover {
	border-color: var(--primary-cyan);
	color: var(--primary-cyan);
}

.btn-nav-cyan {
	background: var(--primary-cyan);
	color: #000;
	box-shadow: 0 4px 20px rgba(34, 211, 238, 0.25);
}

.btn-nav-cyan:hover {
	background: var(--primary-hover);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(34, 211, 238, 0.4);
}

/* --- Hero Section --- */
.hero-section {
	position: relative;
	padding: 110px 0 80px;
	background: var(--bg-gradient);
	overflow: hidden;
}

.hero-glow-1 {
	position: absolute;
	top: -100px;
	left: 50%;
	transform: translateX(-50%);
	width: 600px;
	height: 600px;
	background: radial-gradient(circle, rgba(34, 211, 238, 0.15) 0%, rgba(99, 102, 241, 0.08) 50%, transparent 70%);
	border-radius: 50%;
	pointer-events: none;
}

.hero-grid {
	display: grid;
	grid-template-columns: 1.1fr 0.9fr;
	gap: 50px;
	align-items: center;
}

.hero-badge {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: rgba(34, 211, 238, 0.1);
	border: 1px solid var(--border-glow);
	color: var(--primary-cyan);
	padding: 8px 18px;
	border-radius: 30px;
	font-size: 0.85rem;
	font-weight: 600;
	margin-bottom: 24px;
	box-shadow: 0 0 20px rgba(34, 211, 238, 0.1);
}

.hero-title {
	font-size: clamp(2.8rem, 4.5vw, 4rem);
	font-weight: 800;
	line-height: 1.15;
	letter-spacing: -1.5px;
	margin-bottom: 22px;
}

.gradient-text {
	background: linear-gradient(135deg, #22d3ee 0%, #818cf8 50%, #c084fc 100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.hero-desc {
	font-size: 1.15rem;
	color: var(--text-muted);
	margin-bottom: 38px;
	max-width: 580px;
}

.hero-actions {
	display: flex;
	gap: 18px;
	flex-wrap: wrap;
	margin-bottom: 45px;
}

.btn-hero-primary {
	padding: 16px 36px;
	background: var(--primary-cyan);
	color: #000;
	border-radius: 30px;
	font-weight: 700;
	font-size: 1.05rem;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	box-shadow: 0 10px 30px rgba(34, 211, 238, 0.3);
	transition: all 0.3s ease;
}

.btn-hero-primary:hover {
	background: #fff;
	color: var(--bg-dark);
	transform: translateY(-3px);
	box-shadow: 0 15px 35px rgba(255, 255, 255, 0.3);
}

.btn-hero-secondary {
	padding: 16px 32px;
	background: rgba(255, 255, 255, 0.05);
	color: var(--text-light);
	border: 1px solid var(--border-glass);
	border-radius: 30px;
	font-weight: 600;
	font-size: 1.05rem;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	transition: all 0.3s ease;
}

.btn-hero-secondary:hover {
	border-color: var(--primary-cyan);
	color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.05);
}

/* Stats Counter Row */
.hero-stats-row {
	display: flex;
	gap: 40px;
	border-top: 1px solid var(--border-glass);
	padding-top: 30px;
}

.hero-stat-item h4 {
	font-size: 1.8rem;
	font-weight: 800;
	color: var(--text-light);
	margin-bottom: 2px;
}

.hero-stat-item p {
	font-size: 0.85rem;
	color: var(--text-muted);
}

/* Hero Mockup Card */
.hero-preview-card {
	background: var(--bg-card);
	border: 1px solid var(--border-glass);
	backdrop-filter: blur(20px);
	border-radius: 24px;
	padding: 35px;
	box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
	position: relative;
}

.preview-card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 1px solid var(--border-glass);
}

.preview-card-title {
	display: flex;
	align-items: center;
	gap: 10px;
	font-weight: 700;
	font-size: 1.05rem;
}

.preview-match-badge {
	background: rgba(16, 185, 129, 0.15);
	color: var(--emerald-accent);
	border: 1px solid rgba(16, 185, 129, 0.3);
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 700;
}

.preview-skill-list {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.preview-skill-item label {
	display: flex;
	justify-content: space-between;
	font-size: 0.9rem;
	margin-bottom: 8px;
	font-weight: 600;
}

.preview-bar-track {
	height: 10px;
	background: rgba(255, 255, 255, 0.08);
	border-radius: 20px;
	overflow: hidden;
}

.preview-bar-fill {
	height: 100%;
	border-radius: 20px;
	background: linear-gradient(90deg, #22d3ee, #6366f1);
}

/* --- Features Section --- */
.features-section {
	padding: 100px 0;
	background: var(--bg-dark);
	position: relative;
}

.section-header {
	text-align: center;
	max-width: 650px;
	margin: 0 auto 60px;
}

.section-tag {
	color: var(--primary-cyan);
	font-size: 0.85rem;
	font-weight: 700;
	letter-spacing: 1.5px;
	text-transform: uppercase;
	margin-bottom: 12px;
}

.section-title {
	font-size: 2.4rem;
	font-weight: 800;
	letter-spacing: -0.8px;
	margin-bottom: 16px;
}

.section-desc {
	color: var(--text-muted);
	font-size: 1.05rem;
}

.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
	gap: 30px;
}

.feature-card {
	background: var(--bg-card);
	border: 1px solid var(--border-glass);
	border-radius: 20px;
	padding: 38px 32px;
	transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
	position: relative;
}

.feature-card:hover {
	transform: translateY(-8px);
	border-color: var(--border-glow);
	box-shadow: 0 20px 40px rgba(34, 211, 238, 0.1);
}

.feature-icon-box {
	width: 64px;
	height: 64px;
	border-radius: 16px;
	background: rgba(34, 211, 238, 0.1);
	border: 1px solid var(--border-glow);
	color: var(--primary-cyan);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.6rem;
	margin-bottom: 24px;
}

.feature-card h3 {
	font-size: 1.25rem;
	font-weight: 700;
	margin-bottom: 12px;
	color: var(--text-light);
}

.feature-card p {
	color: var(--text-muted);
	font-size: 0.95rem;
	line-height: 1.65;
}

/* --- How It Works Section --- */
.timeline-section {
	padding: 100px 0;
	background: var(--bg-gradient);
}

.steps-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 25px;
}

.step-card {
	background: var(--bg-card);
	border: 1px solid var(--border-glass);
	border-radius: 20px;
	padding: 35px 25px;
	text-align: center;
	transition: all 0.3s ease;
}

.step-card:hover {
	transform: translateY(-6px);
	border-color: var(--primary-cyan);
}

.step-num-ring {
	width: 58px;
	height: 58px;
	border-radius: 50%;
	border: 2px solid var(--primary-cyan);
	color: var(--primary-cyan);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.3rem;
	font-weight: 800;
	margin: 0 auto 20px;
	box-shadow: 0 0 20px rgba(34, 211, 238, 0.2);
}

.step-card h3 {
	font-size: 1.15rem;
	font-weight: 700;
	margin-bottom: 10px;
}

.step-card p {
	font-size: 0.9rem;
	color: var(--text-muted);
}

/* --- CTA Section --- */
.cta-banner {
	padding: 90px 0;
	background: var(--bg-dark);
}

.cta-box {
	background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
	border: 1px solid var(--border-glow);
	border-radius: 28px;
	padding: 60px 40px;
	text-align: center;
	box-shadow: 0 20px 50px rgba(34, 211, 238, 0.12);
	position: relative;
	overflow: hidden;
}

.cta-box h2 {
	font-size: 2.5rem;
	font-weight: 800;
	margin-bottom: 16px;
	letter-spacing: -1px;
}

.cta-box p {
	color: var(--text-muted);
	font-size: 1.1rem;
	max-width: 600px;
	margin: 0 auto 35px;
}

/* --- Footer --- */
footer {
	background: #04080e;
	border-top: 1px solid var(--border-glass);
	padding: 35px 0;
	text-align: center;
	color: var(--text-muted);
	font-size: 0.9rem;
}

@media (max-width: 992px) {
	.hero-grid { grid-template-columns: 1fr; gap: 40px; text-align: center; }
	.hero-desc { margin: 0 auto 35px; }
	.hero-actions { justify-content: center; }
	.hero-stats-row { justify-content: center; }
}
</style>
</head>
<body>
	<!-- Header Navbar -->
	<header>
		<div class="container header-content">
			<a href="/" class="logo">
				Smart<span>Career</span>
				<span class="logo-badge">AI 2.0</span>
			</a>
			<nav>
				<ul>
					<li><a href="/login">Features</a></li>
					<li><a href="/login">Assessments</a></li>
					<li><a href="/login">Recommendations</a></li>
				</ul>
			</nav>
			<div class="nav-cta-group">
				<a href="/login" class="btn-nav btn-nav-outline">Student Sign In</a>
				<a href="/register" class="btn-nav btn-nav-cyan">Get Started Free</a>
			</div>
		</div>
	</header>

	<!-- Hero Section -->
	<section class="hero-section">
		<div class="hero-glow-1"></div>
		<div class="container hero-grid">
			<div>
				<div class="hero-badge">
					<i class="fas fa-sparkles"></i> Next-Gen Career Analytics Platform
				</div>
				<h1 class="hero-title">
					Discover Your Ideal Career with <span class="gradient-text">Precision Intelligence</span>
				</h1>
				<p class="hero-desc">
					Our AI-driven skill evaluation platform analyzes your technical capabilities, problem-solving speed, and domain interests to build a tailored career roadmap.
				</p>
				<div class="hero-actions">
					<a href="/register" class="btn-hero-primary">
						<i class="fas fa-rocket"></i> Start Free Assessment
					</a>
					<a href="/login" class="btn-hero-secondary">
						<i class="fas fa-play-circle"></i> Student Login
					</a>
				</div>
				<div class="hero-stats-row">
					<div class="hero-stat-item">
						<h4>98.4%</h4>
						<p>Recommendation Accuracy</p>
					</div>
					<div class="hero-stat-item">
						<h4>15,000+</h4>
						<p>Evaluated Students</p>
					</div>
					<div class="hero-stat-item">
						<h4>50+</h4>
						<p>Specialized Skill Modules</p>
					</div>
				</div>
			</div>

			<!-- Live Mockup Card -->
			<div class="hero-preview-card">
				<div class="preview-card-header">
					<div class="preview-card-title">
						<i class="fas fa-brain" style="color: var(--primary-cyan);"></i> Full-Stack Software Engineer
					</div>
					<span class="preview-match-badge"><i class="fas fa-fire"></i> 96% Match</span>
				</div>
				<div class="preview-skill-list">
					<div class="preview-skill-item">
						<label><span>Java Core & Spring Boot</span> <span>94%</span></label>
						<div class="preview-bar-track">
							<div class="preview-bar-fill" style="width: 94%;"></div>
						</div>
					</div>
					<div class="preview-skill-item">
						<label><span>REST APIs & Database Design</span> <span>90%</span></label>
						<div class="preview-bar-track">
							<div class="preview-bar-fill" style="width: 90%;"></div>
						</div>
					</div>
					<div class="preview-skill-item">
						<label><span>Frontend Frameworks</span> <span>88%</span></label>
						<div class="preview-bar-track">
							<div class="preview-bar-fill" style="width: 88%;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Features Grid -->
	<section class="features-section">
		<div class="container">
			<div class="section-header">
				<div class="section-tag">Powerful Capabilities</div>
				<h2 class="section-title">Engineered for Your Success</h2>
				<p class="section-desc">Unlock data-driven career clarity with our suite of assessment tools and real-time guidance engines.</p>
			</div>
			<div class="features-grid">
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-bullseye"></i></div>
					<h3>Personalized AI Matching</h3>
					<p>Intelligent algorithms match your unique skill profile against current industry demand for accurate career direction.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-clipboard-check"></i></div>
					<h3>Domain Skill Assessments</h3>
					<p>Take timed, adaptive tests across Web Development, Data Science, Cloud, and Software Engineering.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-chart-pie"></i></div>
					<h3>Skill Gap Analytics</h3>
					<p>Visualize your strong technical competencies alongside key areas to target for career advancement.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-shield-halved"></i></div>
					<h3>Secure & Verifiable</h3>
					<p>Enterprise-grade encryption keeps your academic performance, assessment credentials, and personal data safe.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-compass"></i></div>
					<h3>Step-by-Step Roadmaps</h3>
					<p>Receive clear action plans recommending specific skills to acquire to land your target job role.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon-box"><i class="fas fa-graduation-cap"></i></div>
					<h3>Executive Progress Tracking</h3>
					<p>Monitor test score trends over time with comprehensive student and administrator dashboard metrics.</p>
				</div>
			</div>
		</div>
	</section>

	<!-- How It Works Section -->
	<section class="timeline-section">
		<div class="container">
			<div class="section-header">
				<div class="section-tag">Four Steps to Clarity</div>
				<h2 class="section-title">How Smart Career Works</h2>
				<p class="section-desc">A frictionless journey from skill evaluation to personalized career path discovery.</p>
			</div>
			<div class="steps-grid">
				<div class="step-card">
					<div class="step-num-ring">1</div>
					<h3>Register Profile</h3>
					<p>Create your student account and indicate your primary tech interests and background.</p>
				</div>
				<div class="step-card">
					<div class="step-num-ring">2</div>
					<h3>Take Assessment</h3>
					<p>Complete timed multiple-choice skill tests tailored to your domain of choice.</p>
				</div>
				<div class="step-card">
					<div class="step-num-ring">3</div>
					<h3>Generate Report</h3>
					<p>Our recommendation engine evaluates your scores and generates your match percentage.</p>
				</div>
				<div class="step-card">
					<div class="step-num-ring">4</div>
					<h3>Achieve Goals</h3>
					<p>Follow your custom roadmap and build skills needed for top industry positions.</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Call To Action -->
	<section class="cta-banner">
		<div class="container">
			<div class="cta-box">
				<h2>Ready to Find Your Ideal Career Path?</h2>
				<p>Join thousands of students who have discovered their optimal tech career direction with Smart Career Analytics.</p>
				<a href="/register" class="btn-hero-primary" style="font-size: 1.1rem; padding: 18px 45px;">
					<i class="fas fa-user-plus"></i> Create Free Account
				</a>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<footer>
		<div class="container">
			<p>&copy; 2026 Smart Career Recommendation System. All rights reserved.</p>
		</div>
	</footer>
</body>
</html>