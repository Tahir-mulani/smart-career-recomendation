<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Career Recommendation - Find Your Perfect Career Path</title>
    <link rel="stylesheet" href="/resources/css/style.css">
    <style>
        /* Landing Page Specific Styles */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 20px;
            text-align: center;
            min-height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 20px;
            animation: fadeInUp 1s ease;
        }

        .hero p {
            font-size: 20px;
            margin-bottom: 40px;
            max-width: 700px;
            opacity: 0.95;
            animation: fadeInUp 1s ease 0.2s backwards;
        }

        .hero-buttons {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            animation: fadeInUp 1s ease 0.4s backwards;
        }

        .hero-buttons .btn {
            padding: 15px 40px;
            font-size: 18px;
            background: white;
            color: #667eea;
        }

        .hero-buttons .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .hero-buttons .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .features {
            padding: 80px 20px;
            background: white;
        }

        .features h2 {
            text-align: center;
            font-size: 36px;
            color: #333;
            margin-bottom: 50px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: #f8f9fa;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 24px;
        }

        .feature-card p {
            color: #666;
            line-height: 1.6;
        }

        .how-it-works {
            padding: 80px 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .how-it-works h2 {
            text-align: center;
            font-size: 36px;
            color: #333;
            margin-bottom: 50px;
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
            min-width: 250px;
            text-align: center;
        }

        .step-number {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            margin: 0 auto 20px;
        }

        .step h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }

        .step p {
            color: #666;
            line-height: 1.6;
        }

        .cta-section {
            padding: 80px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
        }

        .cta-section h2 {
            font-size: 36px;
            margin-bottom: 20px;
        }

        .cta-section p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.95;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 32px;
            }

            .hero p {
                font-size: 16px;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }

            .hero-buttons .btn {
                width: 100%;
                max-width: 300px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .steps {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container header-content">
            <div class="logo">Smart<span>Career</span></div>
            <nav>
                <ul>
                    <li><a href="/login">Login</a></li>
                    <li><a href="/register">Register</a></li>
                    <li><a href="/admin/login">Admin</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="hero">
        <h1>Discover Your Perfect Career Path</h1>
        <p>Take our smart assessments and get personalized career recommendations based on your skills, interests, and potential.</p>
        <div class="hero-buttons">
            <a href="/register" class="btn btn-primary">Get Started</a>
            <a href="/login" class="btn">Login</a>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <h2>Why Choose Smart Career?</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h3>Personalized Recommendations</h3>
                    <p>Our AI-powered system analyzes your skills and interests to suggest the most suitable career paths for you.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Skill Assessments</h3>
                    <p>Take comprehensive assessments in various domains to evaluate your strengths and identify areas for improvement.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3>Career Growth</h3>
                    <p>Get actionable insights and recommendations to help you grow in your chosen career path.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure & Private</h3>
                    <p>Your data is secure with us. We prioritize your privacy and ensure your information is protected.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Easy to Use</h3>
                    <p>Simple and intuitive interface designed for everyone. No technical expertise required.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💡</div>
                    <h3>Expert Insights</h3>
                    <p>Access career insights and industry trends curated by career experts and professionals.</p>
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
                    <p>Sign up for free and create your profile with your skills and interests.</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Take Assessments</h3>
                    <p>Complete skill-based assessments to evaluate your strengths and knowledge.</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Get Recommendations</h3>
                    <p>Receive personalized career recommendations based on your assessment results.</p>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <h3>Grow Your Career</h3>
                    <p>Use the insights to plan your career development and achieve your goals.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="container">
            <h2>Ready to Find Your Dream Career?</h2>
            <p>Join thousands of users who have discovered their ideal career path with Smart Career.</p>
            <a href="/register" class="btn" style="background: white; color: #667eea; padding: 15px 40px; font-size: 18px;">Start Your Journey</a>
        </div>
    </section>

    <footer>
        <div class="container">
            <p>&copy; 2024 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
