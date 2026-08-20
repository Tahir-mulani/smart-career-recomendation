<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.techhub.entity.Skill"%>
<%@ page import="com.techhub.entity.Interest"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Interactive Smart Career Onboarding Wizard - SmartCareer</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<style>
:root {
	--bg-dark-blue: #0a141f;
	--card-bg: #121f2d;
	--primary-cyan: #22d3ee;
	--primary-hover: #06b6d4;
	--text-main: #f8fafc;
	--text-muted: #94a3b8;
	--border: rgba(255, 255, 255, 0.08);
}

body {
	font-family: 'Inter', sans-serif;
	background-color: var(--bg-dark-blue);
	color: var(--text-main);
	margin: 0;
	padding: 0;
	min-height: 100vh;
}

header {
	background: rgba(18, 31, 45, 0.8);
	backdrop-filter: blur(10px);
	border-bottom: 1px solid var(--border);
	padding: 18px 0;
	position: sticky;
	top: 0;
	z-index: 100;
}

.header-content {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 1.5rem;
	font-weight: 800;
	color: #fff;
	text-decoration: none;
}

.logo span {
	color: var(--primary-cyan);
}

.container-main {
	max-width: 1100px;
	margin: 40px auto;
	padding: 0 20px;
}

.onboarding-card {
	background: var(--card-bg);
	border-radius: 20px;
	border: 1px solid var(--border);
	padding: 40px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.onboarding-header {
	margin-bottom: 30px;
}

.onboarding-header h1 {
	font-size: 1.8rem;
	font-weight: 800;
	margin: 0 0 10px 0;
	display: flex;
	align-items: center;
	gap: 12px;
}

.onboarding-header h1 i {
	color: var(--primary-cyan);
}

.onboarding-header p {
	color: var(--text-muted);
	font-size: 0.95rem;
	margin: 0;
}

.badge-info {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: rgba(34, 211, 238, 0.1);
	color: var(--primary-cyan);
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
	margin-top: 15px;
}

.section-title {
	font-size: 1.1rem;
	font-weight: 700;
	margin: 25px 0 12px 0;
	display: flex;
	align-items: center;
	gap: 10px;
	color: #fff;
}

.section-title i {
	color: var(--primary-cyan);
}

.skills-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 14px;
	margin-bottom: 25px;
}

.skill-checkbox-card {
	background: rgba(255, 255, 255, 0.03);
	border: 1px solid var(--border);
	border-radius: 12px;
	padding: 14px 18px;
	display: flex;
	align-items: center;
	gap: 12px;
	cursor: pointer;
	transition: all 0.2s ease;
	user-select: none;
}

.skill-checkbox-card:hover {
	border-color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.04);
}

.skill-checkbox-card.selected {
	border-color: var(--primary-cyan);
	background: rgba(34, 211, 238, 0.12);
}

.skill-checkbox-card.disabled {
	opacity: 0.4;
	cursor: not-allowed;
	pointer-events: none;
}

.skill-checkbox-card input[type="checkbox"],
.skill-checkbox-card input[type="radio"] {
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
		<!-- Guided Journey Progress Tracker -->
		<div style="background: rgba(34, 211, 238, 0.06); border: 1px solid var(--primary-cyan); border-radius: 16px; padding: 18px 24px; margin-bottom: 25px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 15px;">
			<div style="display: flex; align-items: center; gap: 12px;">
				<div style="width: 38px; height: 38px; border-radius: 50%; background: rgba(34, 211, 238, 0.15); color: var(--primary-cyan); display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1rem;">1</div>
				<div>
					<div style="font-weight: 700; font-size: 0.95rem; color: #fff;">Step 1 of 3: Profile Setup & Onboarding</div>
					<div style="font-size: 0.8rem; color: #94a3b8;">Set your target goal & select known skills or discovery test mode</div>
				</div>
			</div>
			<div style="display: flex; align-items: center; gap: 10px;">
				<span style="background: rgba(34, 211, 238, 0.2); color: var(--primary-cyan); font-size: 0.75rem; font-weight: 800; padding: 6px 14px; border-radius: 20px; text-transform: uppercase;">
					<i class="fas fa-spinner fa-spin"></i> In Progress
				</span>
			</div>
		</div>

		<div class="onboarding-card">
			<div class="onboarding-header">
				<h1><i class="fas fa-magic"></i> Interactive Smart Onboarding Wizard</h1>
				<p>Tell us about your background and career goal, or let our Discovery Assessment uncover your strengths.</p>
				<div class="badge-info">
					<i class="fas fa-shield-alt"></i> Multi-Domain Dynamic Career Guidance Engine
				</div>
			</div>

			<!-- 3-STEP SMART CAREER ONBOARDING WIZARD -->
			<div class="wizard-container" style="margin-bottom: 35px;">
				<!-- STEP 1: Select Educational Background & Target Goal -->
				<div class="section-title" style="margin-top: 10px;">
					<i class="fas fa-graduation-cap"></i>
					<span>Step 1: Select Your Background & Target Goal</span>
				</div>
				<div class="skills-grid" style="grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); margin-bottom: 25px;">
					<label class="skill-checkbox-card selected" id="bg-card-it">
						<input type="radio" name="backgroundGoal" value="IT_CORE" checked onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-laptop-code" style="color: #38bdf8; margin-right: 6px;"></i> IT / Tech Student</div>
							<div style="font-size: 0.78rem; color: #94a3b8; margin-top: 4px;">Target Software, Cloud, DevOps & AI Roles</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="bg-card-biz">
						<input type="radio" name="backgroundGoal" value="NON_IT_BIZ" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-chart-line" style="color: #34d399; margin-right: 6px;"></i> Business & Finance</div>
							<div style="font-size: 0.78rem; color: #94a3b8; margin-top: 4px;">Target Business Analytics, Finance & Strategy</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="bg-card-design">
						<input type="radio" name="backgroundGoal" value="NON_IT_DESIGN" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-palette" style="color: #f472b6; margin-right: 6px;"></i> Creative Arts & Design</div>
							<div style="font-size: 0.78rem; color: #94a3b8; margin-top: 4px;">Target UI/UX, Graphic Design & Digital Media</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="bg-card-bridge">
						<input type="radio" name="backgroundGoal" value="NON_IT_TO_IT" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-exchange-alt" style="color: #fbbf24; margin-right: 6px;"></i> Non-IT to IT Bridge</div>
							<div style="font-size: 0.78rem; color: #94a3b8; margin-top: 4px;">Transition from Non-IT into Tech (QA, UI/UX, BA)</div>
						</div>
					</label>
				</div>

				<!-- STEP 2: Choose Self-Awareness Path (4 EXPLICIT OPTIONS) -->
				<div class="section-title">
					<i class="fas fa-compass"></i>
					<span>Step 2: What do you currently know about yourself?</span>
				</div>
				<div class="skills-grid" style="grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); margin-bottom: 25px;">
					<label class="skill-checkbox-card selected" id="path-card-both">
						<input type="radio" name="knowledgeState" value="DIRECT_BOTH" checked onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-check-circle" style="color: #34d399; margin-right: 6px;"></i> Skills & Interests</div>
							<div style="font-size: 0.78rem; color: #cbd5e1; margin-top: 4px;">"I know both my skills & interests"</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="path-card-interests">
						<input type="radio" name="knowledgeState" value="INTERESTS_ONLY" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-heart" style="color: #f472b6; margin-right: 6px;"></i> Interests, NOT Skills</div>
							<div style="font-size: 0.78rem; color: #cbd5e1; margin-top: 4px;">"Select interests & test for skills"</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="path-card-skills">
						<input type="radio" name="knowledgeState" value="SKILLS_ONLY" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-star" style="color: #fbbf24; margin-right: 6px;"></i> Skills, NOT Interests</div>
							<div style="font-size: 0.78rem; color: #cbd5e1; margin-top: 4px;">"Select skills & test for interests"</div>
						</div>
					</label>
					<label class="skill-checkbox-card" id="path-card-unknown">
						<input type="radio" name="knowledgeState" value="UNKNOWN_ALL" onchange="handleWizardChange()">
						<div>
							<div class="skill-name" style="color: #fff; font-weight: 700;"><i class="fas fa-magic" style="color: #a855f7; margin-right: 6px;"></i> Don't Know Either</div>
							<div style="font-size: 0.78rem; color: #cbd5e1; margin-top: 4px;">"Launch Full Discovery Test"</div>
						</div>
					</label>
				</div>
			</div>

			<!-- STEP 3 VIEW A: Discovery Assessment Container -->
			<div id="discoveryContainer" style="display: none; background: rgba(34, 211, 238, 0.08); border: 1px solid var(--primary-cyan); border-radius: 16px; padding: 30px; text-align: center; margin-bottom: 30px;">
				<div style="width: 60px; height: 60px; border-radius: 50%; background: rgba(34, 211, 238, 0.15); display: flex; align-items: center; justify-content: center; margin: 0 auto 15px auto;">
					<i class="fas fa-magic" style="font-size: 1.8rem; color: var(--primary-cyan);"></i>
				</div>
				<h3 style="color: #fff; margin-bottom: 8px; font-weight: 700;">Career Discovery & Strengths Identification Test</h3>
				<p style="font-size: 0.9rem; color: #cbd5e1; max-width: 600px; margin: 0 auto 20px auto; line-height: 1.6;">
					Taking our 15-minute Discovery Assessment will automatically analyze your natural aptitude, problem-solving style, and work preferences to recommend your best matching career paths!
				</p>
				<a href="/assessment/start" class="btn-submit" style="display: inline-flex; width: auto; padding: 14px 30px; font-size: 1rem; text-decoration: none;">
					<i class="fas fa-play-circle"></i> Launch Discovery Assessment Test Now
				</a>
			</div>

			<!-- STEP 3 VIEW B: Form Container for Checkboxes -->
			<div id="formCheckboxesContainer">
				<form action="/api/onboarding" method="post" id="onboardingForm">
					<!-- Section 1: Primary Core Skills -->
					<div id="skillsSectionContainer">
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
					</div>

					<!-- Section 3: Domain Interests -->
					<div id="interestsSectionContainer">
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
					</div>

					<button type="submit" class="btn-submit">
						<span>Save Profile & Continue</span>
						<i class="fas fa-arrow-right"></i>
					</button>
				</form>
			</div>
		</div>
	</div>

	<script>
		const MAX_PRIMARY = 5;

		function handleWizardChange() {
			const knowledge = document.querySelector('input[name="knowledgeState"]:checked').value;
			const skillsSection = document.getElementById('skillsSectionContainer');
			const interestsSection = document.getElementById('interestsSectionContainer');
			const discoveryContainer = document.getElementById('discoveryContainer');
			const formContainer = document.getElementById('formCheckboxesContainer');

			// Highlight selected radio cards
			document.querySelectorAll('input[name="backgroundGoal"]').forEach(radio => {
				const card = radio.closest('.skill-checkbox-card');
				if (radio.checked) card.classList.add('selected');
				else card.classList.remove('selected');
			});

			document.querySelectorAll('input[name="knowledgeState"]').forEach(radio => {
				const card = radio.closest('.skill-checkbox-card');
				if (radio.checked) card.classList.add('selected');
				else card.classList.remove('selected');
			});

			// Granular 4-Option Dynamic Visibility Toggling
			if (knowledge === 'DIRECT_BOTH') {
				formContainer.style.display = 'block';
				skillsSection.style.display = 'block';
				interestsSection.style.display = 'block';
				discoveryContainer.style.display = 'none';
			} else if (knowledge === 'INTERESTS_ONLY') {
				formContainer.style.display = 'block';
				skillsSection.style.display = 'none';
				interestsSection.style.display = 'block';
				discoveryContainer.style.display = 'block';
			} else if (knowledge === 'SKILLS_ONLY') {
				formContainer.style.display = 'block';
				skillsSection.style.display = 'block';
				interestsSection.style.display = 'none';
				discoveryContainer.style.display = 'block';
			} else { // UNKNOWN_ALL
				formContainer.style.display = 'none';
				discoveryContainer.style.display = 'block';
			}
		}

		function handlePrimaryChange(checkbox, skillId) {
			const checkedPrimary = document.querySelectorAll('input[name="primarySkills"]:checked');
			const secCard = document.getElementById('secondary-card-' + skillId);
			const secCheck = document.getElementById('sec-check-' + skillId);
			const primCard = document.getElementById('primary-card-' + skillId);

			if (checkbox.checked) {
				primCard.classList.add('selected');
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

			document.getElementById('primaryCounter').innerText = checkedPrimary.length + ' / ' + MAX_PRIMARY + ' Selected';

			if (checkedPrimary.length >= MAX_PRIMARY) {
				document.querySelectorAll('input[name="primarySkills"]:not(:checked)').forEach(cb => {
					cb.disabled = true;
					cb.closest('.skill-checkbox-card').classList.add('disabled');
				});
			} else {
				document.querySelectorAll('input[name="primarySkills"]').forEach(cb => {
					cb.disabled = false;
					cb.closest('.skill-checkbox-card').classList.remove('disabled');
				});
			}
		}

		document.addEventListener('DOMContentLoaded', () => {
			handleWizardChange();
		});
	</script>
</body>
</html>
