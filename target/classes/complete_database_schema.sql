-- Complete Database Schema for Career Recommendation System
-- This file contains all tables for the normalized database structure
-- Date: 2024

-- Drop existing tables if they exist (for fresh installation)
DROP TABLE IF EXISTS assessment_category_scores;
DROP TABLE IF EXISTS instance_questions;
DROP TABLE IF EXISTS assessment_instances;
DROP TABLE IF EXISTS user_interests;
DROP TABLE IF EXISTS user_skills;
DROP TABLE IF EXISTS career_interests;
DROP TABLE IF EXISTS career_skills;
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS assessment_submissions;
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS recommendations;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS careers;
DROP TABLE IF EXISTS users;

-- ============================================
-- MASTER TABLES
-- ============================================

-- Users table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) DEFAULT 'USER',
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email),
    INDEX idx_role (role)
);

-- Skills master table
CREATE TABLE skills (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    category VARCHAR(50),
    is_popular BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_category (category),
    INDEX idx_popular (is_popular)
);

-- Interests master table
CREATE TABLE interests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    category VARCHAR(50),
    is_popular BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_category (category),
    INDEX idx_popular (is_popular)
);

-- ============================================
-- CAREER TABLES
-- ============================================

-- Careers table
CREATE TABLE careers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    career_name VARCHAR(200) NOT NULL,
    description TEXT,
    qualification VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_career_name (career_name)
);

-- Career-Skills junction table (Many-to-Many)
CREATE TABLE career_skills (
    career_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    proficiency_level VARCHAR(20) DEFAULT 'INTERMEDIATE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (career_id, skill_id),
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    INDEX idx_career_id (career_id),
    INDEX idx_skill_id (skill_id)
);

-- Career-Interests junction table (Many-to-Many)
CREATE TABLE career_interests (
    career_id BIGINT NOT NULL,
    interest_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (career_id, interest_id),
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
    FOREIGN KEY (interest_id) REFERENCES interests(id) ON DELETE CASCADE,
    INDEX idx_career_id (career_id),
    INDEX idx_interest_id (interest_id)
);

-- ============================================
-- USER PROFILE TABLES
-- ============================================

-- User-Skills junction table (Many-to-Many)
CREATE TABLE user_skills (
    user_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    proficiency_level VARCHAR(20) DEFAULT 'BEGINNER',
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_skill_id (skill_id)
);

-- User-Interests junction table (Many-to-Many)
CREATE TABLE user_interests (
    user_id BIGINT NOT NULL,
    interest_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, interest_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (interest_id) REFERENCES interests(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_interest_id (interest_id)
);

-- ============================================
-- ASSESSMENT TABLES
-- ============================================

-- Assessments table (templates)
CREATE TABLE assessments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(200) NOT NULL,
    description TEXT,
    duration INT NOT NULL,
    total_marks INT NOT NULL,
    passing_marks INT DEFAULT 0,
    assessment_type VARCHAR(50) DEFAULT 'TECHNICAL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_test_name (test_name),
    INDEX idx_assessment_type (assessment_type)
);

-- Questions table
CREATE TABLE questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer VARCHAR(1) NOT NULL,
    difficulty_level VARCHAR(20) DEFAULT 'MEDIUM',
    question_category VARCHAR(50) DEFAULT 'TECHNICAL',
    skill_id BIGINT,
    assessment_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE SET NULL,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE,
    INDEX idx_skill_id (skill_id),
    INDEX idx_assessment_id (assessment_id),
    INDEX idx_question_category (question_category),
    INDEX idx_difficulty_level (difficulty_level)
);

-- Assessment Instances (dynamic test sessions)
CREATE TABLE assessment_instances (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    assessment_template_id BIGINT,
    instance_type VARCHAR(50) DEFAULT 'ONBOARDING',
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    time_limit_minutes INT,
    status VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_template_id) REFERENCES assessments(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_instance_type (instance_type),
    INDEX idx_status (status)
);

-- Instance Questions (questions in each test session)
CREATE TABLE instance_questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    instance_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    question_order INT NOT NULL,
    question_category VARCHAR(50),
    user_answer VARCHAR(1),
    is_correct BOOLEAN,
    time_taken_seconds INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instance_id) REFERENCES assessment_instances(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    INDEX idx_instance_id (instance_id),
    INDEX idx_question_id (question_id),
    INDEX idx_question_category (question_category)
);

-- Assessment Category Scores (for common assessment breakdown)
CREATE TABLE assessment_category_scores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    instance_id BIGINT NOT NULL,
    category VARCHAR(50) NOT NULL,
    score INT DEFAULT 0,
    total_questions INT DEFAULT 0,
    percentage DECIMAL(5,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instance_id) REFERENCES assessment_instances(id) ON DELETE CASCADE,
    INDEX idx_instance_id (instance_id),
    INDEX idx_category (category)
);

-- Results table (legacy - kept for compatibility, can be deprecated)
CREATE TABLE results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    assessment_id BIGINT NOT NULL,
    instance_id BIGINT,
    score INT DEFAULT 0,
    percentage DECIMAL(5,2) DEFAULT 0.00,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE,
    FOREIGN KEY (instance_id) REFERENCES assessment_instances(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_assessment_id (assessment_id),
    INDEX idx_instance_id (instance_id)
);

-- Assessment Submissions (legacy - kept for compatibility)
CREATE TABLE assessment_submissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    assessment_id BIGINT NOT NULL,
    instance_id BIGINT,
    answers TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE,
    FOREIGN KEY (instance_id) REFERENCES assessment_instances(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_assessment_id (assessment_id)
);

-- ============================================
-- RECOMMENDATION TABLES
-- ============================================

-- Recommendations table
CREATE TABLE recommendations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    career_id BIGINT NOT NULL,
    match_score DECIMAL(5,2) DEFAULT 0.00,
    skill_match_score DECIMAL(5,2) DEFAULT 0.00,
    interest_match_score DECIMAL(5,2) DEFAULT 0.00,
    assessment_score DECIMAL(5,2) DEFAULT 0.00,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_career_id (career_id),
    INDEX idx_match_score (match_score)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert default admin user
INSERT INTO users (name, email, password, role, phone_number) VALUES
('Admin', 'admin@smartcareer.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'ADMIN', '9876543210');

-- Insert sample skills
INSERT INTO skills (name, description, category, is_popular) VALUES
('Java', 'Java programming language', 'Programming', TRUE),
('Python', 'Python programming language', 'Programming', TRUE),
('JavaScript', 'JavaScript for web development', 'Programming', TRUE),
('SQL', 'Structured Query Language for databases', 'Database', TRUE),
('HTML', 'HTML for web structure', 'Web Development', TRUE),
('CSS', 'CSS for web styling', 'Web Development', TRUE),
('React', 'React JavaScript library', 'Web Development', TRUE),
('Spring Boot', 'Spring Boot framework', 'Backend', TRUE),
('Data Analysis', 'Data analysis and visualization', 'Data Science', TRUE),
('Machine Learning', 'Machine learning algorithms', 'Data Science', FALSE),
('DevOps', 'DevOps practices and tools', 'DevOps', FALSE),
('Git', 'Version control with Git', 'Tools', TRUE),
('Docker', 'Containerization with Docker', 'DevOps', FALSE),
('AWS', 'Amazon Web Services', 'Cloud', FALSE),
('Node.js', 'Node.js runtime', 'Backend', FALSE);

-- Insert sample interests
INSERT INTO interests (name, description, category, is_popular) VALUES
('Software Development', 'Building software applications', 'Technology', TRUE),
('Data Science', 'Working with data and analytics', 'Technology', TRUE),
('Web Development', 'Creating websites and web apps', 'Technology', TRUE),
('Mobile Development', 'Building mobile applications', 'Technology', FALSE),
('Cloud Computing', 'Working with cloud platforms', 'Technology', FALSE),
('Artificial Intelligence', 'AI and machine learning', 'Technology', FALSE),
('Cybersecurity', 'Security and protection', 'Technology', FALSE),
('Database Management', 'Managing databases', 'Technology', FALSE),
('Project Management', 'Managing projects and teams', 'Management', FALSE),
('UI/UX Design', 'User interface and experience design', 'Design', FALSE);

-- Insert sample careers
INSERT INTO careers (career_name, description, qualification) VALUES
('Software Developer', 'Design and develop software applications', 'Bachelor in Computer Science'),
('Data Analyst', 'Analyze data to provide insights', 'Bachelor in Statistics/Computer Science'),
('Web Developer', 'Create and maintain websites', 'Bachelor in Computer Science'),
('DevOps Engineer', 'Bridge development and operations', 'Bachelor in Computer Science/IT'),
('Machine Learning Engineer', 'Build ML models and systems', 'Master in Computer Science/Data Science'),
('Cloud Architect', 'Design cloud infrastructure', 'Bachelor/Master in Computer Science'),
('Database Administrator', 'Manage and optimize databases', 'Bachelor in Computer Science'),
('Full Stack Developer', 'Develop both frontend and backend', 'Bachelor in Computer Science');

-- Link careers with skills
INSERT INTO career_skills (career_id, skill_id, proficiency_level) VALUES
-- Software Developer
(1, 1, 'ADVANCED'), (1, 2, 'INTERMEDIATE'), (1, 3, 'ADVANCED'), (1, 11, 'INTERMEDIATE'),
-- Data Analyst
(2, 2, 'ADVANCED'), (2, 4, 'ADVANCED'), (2, 9, 'ADVANCED'),
-- Web Developer
(3, 3, 'ADVANCED'), (3, 5, 'ADVANCED'), (3, 6, 'ADVANCED'), (3, 7, 'INTERMEDIATE'),
-- DevOps Engineer
(4, 1, 'INTERMEDIATE'), (4, 11, 'ADVANCED'), (4, 12, 'INTERMEDIATE'), (4, 13, 'INTERMEDIATE'),
-- Machine Learning Engineer
(5, 2, 'ADVANCED'), (5, 10, 'ADVANCED'), (5, 9, 'ADVANCED'),
-- Cloud Architect
(6, 13, 'ADVANCED'), (6, 14, 'ADVANCED'), (6, 1, 'INTERMEDIATE'),
-- Database Administrator
(7, 4, 'ADVANCED'), (7, 2, 'INTERMEDIATE'),
-- Full Stack Developer
(8, 1, 'ADVANCED'), (8, 3, 'ADVANCED'), (8, 5, 'ADVANCED'), (8, 6, 'ADVANCED'), (8, 8, 'INTERMEDIATE');

-- Link careers with interests
INSERT INTO career_interests (career_id, interest_id) VALUES
-- Software Developer
(1, 1), (1, 3),
-- Data Analyst
(2, 2),
-- Web Developer
(3, 3),
-- DevOps Engineer
(4, 5),
-- Machine Learning Engineer
(5, 6),
-- Cloud Architect
(6, 5),
-- Database Administrator
(7, 8),
-- Full Stack Developer
(8, 1), (8, 3);

-- Insert sample assessment template
INSERT INTO assessments (test_name, description, duration, total_marks, assessment_type) VALUES
('Java Programming Assessment', 'Test your Java programming skills', 30, 100, 'TECHNICAL'),
('Python Programming Assessment', 'Test your Python programming skills', 30, 100, 'TECHNICAL'),
('Web Development Assessment', 'Test your web development skills', 45, 100, 'TECHNICAL'),
('Common Aptitude Assessment', 'General aptitude and reasoning test', 30, 100, 'COMMON');

-- Insert sample questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, question_category, skill_id, assessment_id) VALUES
-- Java questions
('What is the correct way to declare a main method in Java?', 'public static void main(String[] args)', 'public void main(String[] args)', 'static void main(String[] args)', 'public static main(String[] args)', 'A', 'EASY', 'TECHNICAL', 1, 1),
('Which keyword is used to create a class in Java?', 'class', 'Class', 'CLASS', 'className', 'A', 'EASY', 'TECHNICAL', 1, 1),
('What is the parent class of all classes in Java?', 'Object', 'Class', 'Main', 'Java', 'A', 'MEDIUM', 'TECHNICAL', 1, 1),
-- Python questions
('What is the correct file extension for Python files?', '.python', '.py', '.pt', '.pyt', 'B', 'EASY', 'TECHNICAL', 2, 2),
('Which function is used to output text in Python?', 'echo()', 'print()', 'console.log()', 'System.out.println()', 'B', 'EASY', 'TECHNICAL', 2, 2),
-- Web Development questions
('What does HTML stand for?', 'Hyper Text Markup Language', 'High Text Markup Language', 'Hyperlinks and Text Markup Language', 'Home Tool Markup Language', 'A', 'EASY', 'TECHNICAL', 3, 3),
('Which CSS property is used to change the background color?', 'bgcolor', 'background-color', 'color', 'background', 'B', 'EASY', 'TECHNICAL', 3, 3),
-- Common Aptitude questions
('If A = 1, B = 2, what is the value of A + B?', '3', '12', 'AB', '2', 'A', 'EASY', 'APTITUDE', NULL, 4),
('Which number comes next: 2, 4, 6, 8, ?', '10', '12', '9', '11', 'A', 'EASY', 'APTITUDE', NULL, 4),
('What is 15% of 200?', '25', '30', '35', '40', 'B', 'EASY', 'APTITUDE', NULL, 4);

-- ============================================
-- END OF SCHEMA
-- ============================================
