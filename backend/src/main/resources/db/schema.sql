-- ====================================================================
-- Production Database Schema (14 Active Tables)
-- Smart Career Recommendation System
-- ====================================================================

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    gender VARCHAR(20) NULL,
    skills TEXT NULL,
    interests TEXT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Careers Table
CREATE TABLE IF NOT EXISTS careers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    career_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    required_skills TEXT NOT NULL,
    qualification VARCHAR(255) NOT NULL
);

-- 3. Static Assessments Metadata Table
CREATE TABLE IF NOT EXISTS assessments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    total_marks INT NOT NULL
);

-- 4. Master Skills Table
CREATE TABLE IF NOT EXISTS skills (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Master Interests Table
CREATE TABLE IF NOT EXISTS interests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    interest_name VARCHAR(100) NOT NULL UNIQUE
);

-- 6. Question Bank Table
CREATE TABLE IF NOT EXISTS questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_answer VARCHAR(1) NOT NULL,
    difficulty_level VARCHAR(50) NOT NULL,
    skill_tag VARCHAR(100) NOT NULL,
    skill_id BIGINT NULL,
    assessment_id BIGINT NULL,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE SET NULL,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE SET NULL
);

-- 7. User Skills Junction Table
CREATE TABLE IF NOT EXISTS user_skills (
    user_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    proficiency_level VARCHAR(50) DEFAULT 'Beginner',
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- 8. User Interests Junction Table
CREATE TABLE IF NOT EXISTS user_interests (
    user_id BIGINT NOT NULL,
    interest_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, interest_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (interest_id) REFERENCES interests(id) ON DELETE CASCADE
);

-- 9. Career Skills Junction Table
CREATE TABLE IF NOT EXISTS career_skills (
    career_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    PRIMARY KEY (career_id, skill_id),
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- 10. Career Interests Junction Table
CREATE TABLE IF NOT EXISTS career_interests (
    career_id BIGINT NOT NULL,
    interest_id BIGINT NOT NULL,
    PRIMARY KEY (career_id, interest_id),
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
    FOREIGN KEY (interest_id) REFERENCES interests(id) ON DELETE CASCADE
);

-- 11. Results Table
CREATE TABLE IF NOT EXISTS results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    assessment_id BIGINT NOT NULL,
    score INT NOT NULL,
    percentage DOUBLE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE
);

-- 12. Recommendations Table
CREATE TABLE IF NOT EXISTS recommendations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    career_id BIGINT NOT NULL,
    match_score DOUBLE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE
);

-- 13. Dynamic Assessment Instances Table
CREATE TABLE IF NOT EXISTS assessment_instances (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    assessment_id BIGINT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    duration_actual INT DEFAULT 0,
    total_questions INT DEFAULT 0,
    score INT DEFAULT 0,
    percentage DOUBLE DEFAULT 0.0,
    status VARCHAR(50) DEFAULT 'GENERATED',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 14. Dynamic Instance Questions Table
CREATE TABLE IF NOT EXISTS instance_questions (
    instance_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    question_order INT NOT NULL,
    user_answer VARCHAR(5) NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    time_taken_seconds INT DEFAULT 0,
    PRIMARY KEY (instance_id, question_id),
    FOREIGN KEY (instance_id) REFERENCES assessment_instances(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);
