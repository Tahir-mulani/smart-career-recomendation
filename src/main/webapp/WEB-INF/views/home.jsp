<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Career Recommendation - Find Your Perfect Career Path</title>
<link rel="stylesheet" href="/resources/css/style.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
	--border: #e2e8f0;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

/* Updated Body Background to Dark Theme */
body {
	background-color: var(--bg-dark-blue);
	color: var(--text-light);
	line-height: 1.6;
	overflow-x: hidden;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

/* Header */
header {
	background: rgba(10, 20, 31, 0.95);
	backdrop-filter: blur(10px);
	padding: 12px 0; /* Reduced padding for slimmer navbar */
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
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
	font-size: 1.6rem; /* Slightly reduced font size */
	font-weight: 700;
	color: var(--primary-cyan);
}

.logo span {
	color: var(--text-light);
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
	transition: 0.3s;
}

nav a:hover {
	color: var(--primary-cyan);
}

/* Hero Section */
.hero {
	background: var(--bg-gradient);
	color: var(--text-light);
	padding: 100px 20px;
	text-align: center;
	min-height: 80vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.hero h1 {
	font-size: clamp(2.5rem, 5vw, 4rem);
	font-weight: 700;
	margin-bottom: 20px;
	animation: fadeInUp 1s ease;
}

.hero p {
	font-size: 1.1rem;
	color: rgba(255, 255, 255, 0.8);
	margin-bottom: 40px;
	max-width: 700px;
	animation: fadeInUp 1s ease 0.2s backwards;
}

.hero-buttons {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	justify-content: center;
	animation: fadeInUp 1s ease 0.4s backwards;
}

.btn {
	padding: 14px 35px;
	font-size: 1.05rem;
	font-weight: 600;
	border-radius: 30px;
	text-decoration: none;
	transition: 0.3s;
	display: inline-block;
	border: 2px solid var(--primary-cyan);
	color: var(--primary-cyan);
	background: transparent;
}

.btn:hover {
	background: var(--primary-cyan);
	color: #000;
	transform: translateY(-3px);
	box-shadow: 0 10px 25px rgba(34, 211, 238, 0.2);
}

.btn-primary {
	background: var(--primary-cyan);
	color: #000;
	border: none;
}

.btn-primary:hover {
	background: var(--text-light);
	color: var(--bg-dark-blue);
	box-shadow: 0 10px 25px rgba(255, 255, 255, 0.2);
}

/* --- Features Section (Why Choose Us) --- */
.features {
	padding: 100px 20px;
	background: var(--bg-dark-blue);
}

.features h2 {
	text-align: center;
	font-size: 2.5rem;
	color: var(--primary-cyan);
	margin-bottom: 60px;
}

.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	max-width: 1200px;
	margin: 0 auto;
}

.feature-card {
	background: rgba(255, 255, 255, 0.03);
	padding: 40px;
	border-radius: 16px;
	text-align: center;
	transition: transform 0.3s, box-shadow 0.3s, border-color 0.3s;
	border: 1px solid rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(10px);
}

.feature-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 35px rgba(34, 211, 238, 0.1);
	border-color: var(--primary-cyan);
}

.feature-icon {
	font-size: 2.5rem;
	margin: 0 auto 25px;
	background: rgba(34, 211, 238, 0.1);
	width: 80px;
	height: 80px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 50%;
	border: 1px solid rgba(34, 211, 238, 0.3);
	box-shadow: 0 0 20px rgba(34, 211, 238, 0.1);
}

.feature-card h3 {
	color: var(--text-light);
	margin-bottom: 15px;
	font-size: 1.4rem;
	font-weight: 600;
}

.feature-card p {
	color: var(--text-muted);
	line-height: 1.6;
	font-size: 0.95rem;
}

/* How It Works Section */
.how-it-works {
	padding: 100px 20px;
	background: var(--bg-gradient);
}

.how-it-works h2 {
	text-align: center;
	font-size: 2.5rem;
	color: var(--text-light);
	margin-bottom: 60px;
}

.steps {
	display: flex;
	justify-content: center;
	gap: 40px;
	flex-wrap: wrap;
	max-width: 1200px;
	margin: 0 auto;
}

.step {
	flex: 1;
	min-width: 220px;
	text-align: center;
	background: rgba(255, 255, 255, 0.03);
	padding: 40px 20px;
	border-radius: 16px;
	border: 1px solid rgba(255, 255, 255, 0.1);
	transition: 0.3s;
}

.step:hover {
	transform: translateY(-10px);
	border-color: var(--primary-cyan);
	box-shadow: 0 15px 35px rgba(34, 211, 238, 0.1);
}

.step-number {
	width: 65px;
	height: 65px;
	background: transparent;
	border: 2px solid var(--primary-cyan);
	color: var(--primary-cyan);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	font-weight: bold;
	margin: 0 auto 20px;
	box-shadow: 0 0 15px rgba(34, 211, 238, 0.2);
}

.step h3 {
	color: var(--text-light);
	margin-bottom: 15px;
	font-size: 1.2rem;
	font-weight: 500;
}

.step p {
	color: var(--text-muted);
	line-height: 1.6;
	font-size: 0.9rem;
}

/* CTA Section */
.cta-section {
	padding: 100px 20px;
	background: var(--bg-dark-blue);
	text-align: center;
	border-top: 1px solid rgba(255, 255, 255, 0.05);
}

.cta-section h2 {
	font-size: 2.5rem;
	color: var(--text-light);
	margin-bottom: 20px;
}

.cta-section p {
	font-size: 1.1rem;
	margin-bottom: 40px;
	color: var(--text-muted);
	max-width: 700px;
	margin-left: auto;
	margin-right: auto;
}

/* Footer */
footer {
	background: rgba(10, 20, 31, 0.95);
	color: var(--text-muted);
	text-align: center;
	padding: 30px 20px;
	border-top: 1px solid rgba(255, 255, 255, 0.05);
	font-size: 0.9rem;
}

@keyframes fadeInUp {
	from { opacity: 0; transform: translateY(30px); }
	to { opacity: 1; transform: translateY(0); }
}

@media ( max-width : 768px) {
	.header-content { flex-direction: column; gap: 15px; }
	.hero h1 { font-size: 2.2rem; }
	.hero p { font-size: 1rem; }
	.hero-buttons { flex-direction: column; align-items: center; width: 100%; }
	.hero-buttons .btn { width: 100%; max-width: 300px; text-align: center; }
	.features-grid { grid-template-columns: 1fr; }
	.steps { flex-direction: column; }
}
</style>
</head>
<body>
	<header>
		<div class="container header-content">
			<div class="logo">
				Smart<span>Career</span>
			</div>
			<nav>
				<ul>
					<li><a href="/login">User Login</a></li>
					<li><a href="/register">Register</a></li>
					<li><a href="/admin/login">Admin Login</a></li>
				</ul>
			</nav>
		</div>
	</header>

	<section class="hero">
		<h1>Discover Your Perfect Career Path</h1>
		<p>Take our smart assessments and get personalized career
			recommendations based on your skills, interests, and potential.</p>
		<div class="hero-buttons">
			<a href="/register" class="btn btn-primary">Get Started</a>  
		</div>
	</section>

	<section class="features">
		<div class="container">
			<h2>Why Choose Smart Career?</h2>
			<div class="features-grid">
				<div class="feature-card">
					<div class="feature-icon">🎯</div>
					<h3>Personalized Recommendations</h3>
					<p>Our AI-powered system analyzes your skills and interests to
						suggest the most suitable career paths for you.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon">📊</div>
					<h3>Skill Assessments</h3>
					<p>Take comprehensive assessments in various domains to
						evaluate your strengths and identify areas for improvement.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon">🚀</div>
					<h3>Career Growth</h3>
					<p>Get actionable insights and recommendations to help you grow
						in your chosen career path.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon">🔒</div>
					<h3>Secure & Private</h3>
					<p>Your data is secure with us. We prioritize your privacy and
						ensure your information is protected.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon">📱</div>
					<h3>Easy to Use</h3>
					<p>Simple and intuitive interface designed for everyone. No
						technical expertise required.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon">💡</div>
					<h3>Expert Insights</h3>
					<p>Access career insights and industry trends curated by career
						experts and professionals.</p>
				</div>
			</div>
		</div>
	</section>

	<section class="how-it-works">
		<div class="container">
			<h2>How It Works</h2>
			<div class="steps">
				<div class="step">
					<div class="step-number">1</div>
					<h3>Create Account</h3>
					<p>Sign up for free and create your profile with your skills
						and interests.</p>
				</div>
				<div class="step">
					<div class="step-number">2</div>
					<h3>Take Assessments</h3>
					<p>Complete skill-based assessments to evaluate your strengths
						and knowledge.</p>
				</div>
				<div class="step">
					<div class="step-number">3</div>
					<h3>Get Recommendations</h3>
					<p>Receive personalized career recommendations based on your
						assessment results.</p>
				</div>
				<div class="step">
					<div class="step-number">4</div>
					<h3>Grow Your Career</h3>
					<p>Use the insights to plan your career development and achieve
						your goals.</p>
				</div>
			</div>
		</div>
	</section>

	<section class="cta-section">
		<div class="container">
			<h2>Ready to Find Your Dream Career?</h2>
			<p>Join thousands of users who have discovered their ideal career
				path with Smart Career.</p>
			<!-- Adjusted the inline styles here to match the cyan theme -->
			<a href="/register" class="btn"
				style="background: var(--primary-cyan); color: #000; padding: 15px 40px; font-size: 18px; border: none; font-weight: 600;">Start
				Your Journey</a>
		</div>
	</section>

	<footer>
		<div class="container">
			<p>&copy; 2026 Smart Career Recommendation System. All rights
				reserved.</p>
		</div>
	</footer>
</body>
</html>