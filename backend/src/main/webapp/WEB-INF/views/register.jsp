<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Smart Career Recommendation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        /* Modern UI Color Palette from Home Page */
        :root {
            --primary-cyan: #22d3ee;
            --primary-hover: #06b6d4;
            --bg-dark-blue: #0a141f;
            --text-light: #f8fafc;
            --text-dark: #0f172a;
            --text-muted: #94a3b8;
            --card-bg-light: #ffffff;
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
            background-color: #f8fafc; /* Light background to make the form card pop */
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
            font-size: 0.95rem;
            transition: 0.3s;
        }

        nav a:hover {
            color: var(--primary-cyan);
        }

        /* --- Main Form Container --- */
        .container-main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            width: 100%;
        }

        .form-container {
            width: 100%;
            max-width: 480px;
            background: var(--card-bg-light);
            padding: 45px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .form-container h2 {
            text-align: center;
            color: var(--bg-dark-blue);
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 1.8rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 500;
        }
        
        .form-group label i {
            color: var(--primary-cyan);
            margin-right: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            outline: none;
            transition: border-color 0.3s, box-shadow 0.3s;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: var(--primary-cyan);
            box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: var(--primary-cyan);
            color: #000;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: .3s;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(34, 211, 238, 0.2);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34, 211, 238, 0.3);
        }

        .bottom-text {
            text-align: center; 
            margin-top: 25px; 
            color: var(--text-muted); 
            font-size: 0.95rem;
        }

        .bottom-text a {
            color: var(--primary-hover);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .bottom-text a:hover {
            color: var(--bg-dark-blue);
        }

        /* --- Alerts --- */
        .alert {
            padding: 14px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        /* --- Footer --- */
        footer {
            background: var(--bg-dark-blue);
            color: var(--text-muted);
            text-align: center;
            padding: 25px 20px;
            font-size: 0.9rem;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <a href="/" class="logo">Smart<span>Career</span></a>
            <nav>
                <ul>
                    <li><a href="/login">Login</a></li>
                    <li><a href="/admin/login">Admin Login</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container-main">
        <div class="form-container">
            <h2>Create Your Account</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <form action="/api/register" method="post">
                <div class="form-group">
                    <label for="name"><i class="fas fa-user"></i> Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                </div>
                
                <div class="form-group">
                    <label for="phoneNumber"><i class="fas fa-phone"></i> Phone Number</label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number" required>
                </div>
                
                <div class="form-group">
                    <label for="gender"><i class="fas fa-venus-mars"></i> Gender</label>
                    <select id="gender" name="gender" required style="width: 100%; padding: 14px 16px; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 1rem; outline: none; background: #fff; font-family: inherit;">
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <button type="submit" class="btn">
                    <i class="fas fa-user-plus"></i> Register
                </button>
            </form>
            
            <p class="bottom-text">
                Already have an account? <a href="/login">Login here</a>
            </p>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>&copy; 2026 Smart Career Recommendation System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>