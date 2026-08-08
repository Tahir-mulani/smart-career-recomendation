<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.Skill"%>
<%@ page import="com.techhub.entity.Interest"%>
<%@ page import="com.techhub.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Skill Onboarding - Smart Career Recommendation</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--bg-dark-blue: #0a141f;
	--card-bg: #ffffff;
	--text-dark: #0f172a;
	--text-muted: #64748b;
	--border-color: #e2e8f0;
	--danger: #ef4444;
	--success: #10b981;
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
	font-size: 1.6rem;
	font-weight: 700;
	color: var(--primary-cyan);
	text-decoration: none;
}

.logo span {
	color: #ffffff;
}

.container-main {
	flex: 1;
	width: min(900px, 90%);
	margin: 40px auto;
}

.onboarding-card {
	background: var(--card-bg);
	border-radius: 20px;
	padding: 40px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
	border: 1px solid var(--border-color);
}

.onboarding-header {
	text-align: center;
	margin-bottom: 35px;
}

.onboarding-header h1 {
	font-size: 1.8rem;
	color: var(--bg-dark-blue);
	margin-bottom: 10px;
}

.onboarding-header p {
	color: var(--text-muted);
	font-size: 0.95rem;
}

.badge-info {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	background: rgba(34, 211, 238, 0.12);
	color: #0284c7;
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
	margin-top: 12px;
}

.section-title {
	font-size: 1.1rem;
	font-weight: 600;
	color: var(--bg-dark-blue);
	margin: 30px 0 15px 0;
	display: flex;
	align-items: center;
	gap: 10px;
}

.section-title i {
	color: var(--primary-cyan);
}

.skills-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 12px;
}

.skill-checkbox-card {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 14px 18px;
	border: 1px solid var(--border-color);
	border-radius: 12px;
	cursor: pointer;
	transition: all 0.2s ease;
	background: #ffffff;
}

.skill-checkbox-card:hover {
	border-color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.04);
}

.skill-checkbox-card.selected {
	border-color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.1);
}

.skill-checkbox-card.disabled {
	opacity: 0.5;
	cursor: not-allowed;
	pointer-events: none;
}

.skill-checkbox-card input[type="checkbox"] {
	width: 18px;
	height: 18px;
	accent-color: #06b6d4;
	cursor: pointer;
}

.skill-name {
	font-size: 0.95rem;
	font-weight: 500;
}

.btn-submit {
	width: 100%;
	padding: 16px;
	border: none;
	border-radius: 12px;
	background: var(--primary-cyan);
	color: #0a141f;
	font-size: 1.05rem;
	font-weight: 700;
	cursor: pointer;
	transition: 0.3s;
	margin-top: 35px;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
}

.btn-submit:hover {
	background: var(--primary-hover);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(34, 211, 238, 0.3);
}

.counter-badge {
	margin-left: auto;
	font-size: 0.8rem;
	font-weight: 600;
	color: var(--text-muted);
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
		<div class="onboarding-card">
			<div class="onboarding-header">
				<h1><i class="fas fa-layer-group"></i> Profile Skill Onboarding</h1>
				<p>Select your skills and domain interests to generate your personalized dynamic career assessment.</p>
				<div class="badge-info">
					<i class="fas fa-shield-alt"></i> Adaptive Grouping (Top 5 Core Skills Tested)
				</div>
			</div>

			<form action="/api/onboarding" method="post" id="onboardingForm">
				<!-- Section 1: Primary Core Skills -->
				<div class="section-title">
					<i class="fas fa-star"></i>
					<span>Top Core Skills (Max 5)</span>
					<span class="counter-badge" id="primaryCounter">0 / 5 Selected</span>
				</div>
				<p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 15px;">
					These top skills will be verified through your dynamic assessment (~3–5 questions each).
				</p>

				<div class="skills-grid">
					<%
					List<Skill> skills = (List<Skill>) request.getAttribute("skills");
					if (skills != null) {
						for (Skill skill : skills) {
					%>
					<label class="skill-checkbox-card" id="primary-card-<%=skill.getId()%>">
						<input type="checkbox" name="primarySkills" value="<%=skill.getId()%>" onchange="handlePrimaryChange(this, <%=skill.getId()%>)">
						<span class="skill-name"><%=skill.getSkillName()%></span>
					</label>
					<%
						}
					}
					%>
				</div>

				<!-- Section 2: Secondary Skills -->
				<div class="section-title">
					<i class="fas fa-plus-circle"></i>
					<span>Secondary / Additional Skills</span>
				</div>
				<p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 15px;">
					Saved to your profile to enhance career matching without lengthening your assessment.
				</p>

				<div class="skills-grid">
					<%
					if (skills != null) {
						for (Skill skill : skills) {
					%>
					<label class="skill-checkbox-card" id="secondary-card-<%=skill.getId()%>">
						<input type="checkbox" name="secondarySkills" value="<%=skill.getId()%>" id="sec-check-<%=skill.getId()%>">
						<span class="skill-name"><%=skill.getSkillName()%></span>
					</label>
					<%
						}
					}
					%>
				</div>

				<!-- Section 3: Interests -->
				<div class="section-title">
					<i class="fas fa-heart"></i>
					<span>Domain Interests</span>
				</div>
				<div class="skills-grid">
					<%
					List<Interest> interests = (List<Interest>) request.getAttribute("interests");
					if (interests != null) {
						for (Interest interest : interests) {
					%>
					<label class="skill-checkbox-card">
						<input type="checkbox" name="interests" value="<%=interest.getId()%>">
						<span class="skill-name"><%=interest.getInterestName()%></span>
					</label>
					<%
						}
					}
					%>
				</div>

				<button type="submit" class="btn-submit">
					<span>Save & Start Dynamic Assessment</span>
					<i class="fas fa-arrow-right"></i>
				</button>
			</form>
		</div>
	</div>

	<script>
		const MAX_PRIMARY = 5;

		function handlePrimaryChange(checkbox, skillId) {
			const checkedPrimary = document.querySelectorAll('input[name="primarySkills"]:checked');
			const secCard = document.getElementById('secondary-card-' + skillId);
			const secCheck = document.getElementById('sec-check-' + skillId);
			const primCard = document.getElementById('primary-card-' + skillId);

			if (checkbox.checked) {
				primCard.classList.add('selected');
				// Automatically uncheck and disable in secondary list
				if (secCheck) {
					secCheck.checked = false;
					secCard.classList.add('disabled');
				}
			} else {
				primCard.classList.remove('selected');
				if (secCard) {
					secCard.classList.remove('disabled');
				}
			}

			// Update counter
			document.getElementById('primaryCounter').innerText = checkedPrimary.length + ' / ' + MAX_PRIMARY + ' Selected';

			// Enforce max 5 primary skills limit
			const allPrimaryChecks = document.querySelectorAll('input[name="primarySkills"]');
			if (checkedPrimary.length >= MAX_PRIMARY) {
				allPrimaryChecks.forEach(cb => {
					if (!cb.checked) {
						cb.disabled = true;
						cb.parentElement.classList.add('disabled');
					}
				});
			} else {
				allPrimaryChecks.forEach(cb => {
					cb.disabled = false;
					cb.parentElement.classList.remove('disabled');
				});
			}
		}
	</script>
</body>
</html>
