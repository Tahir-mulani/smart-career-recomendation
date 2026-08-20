-- ====================================================================
-- Production Seed Data for Smart Career Recommendation System
-- Includes Users, Master Skills (30), Master Interests (12), Careers (12),
-- Junction Mappings, Assessments, and Full Question Bank.
-- Uses NULL for assessment_id so inserts never fail on Foreign Key constraints.
-- ====================================================================

USE careerrecommendationsystem;

-- 1. Seed Users (Admin & Sample Test Users)
INSERT IGNORE INTO users (id, name, email, password, phone_number, role) VALUES
(1, 'System Admin', 'admin@techhub.com', 'admin123', '9876543210', 'ADMIN'),
(2, 'John Doe', 'john@example.com', 'user123', '9876543211', 'USER'),
(3, 'Jane Smith', 'jane@example.com', 'user123', '9876543212', 'USER');

-- 2. Seed Master Technical & Domain Skills (40 Skills)
INSERT IGNORE INTO skills (id, skill_name) VALUES
(1, 'Java'),
(2, 'Spring Boot'),
(3, 'React'),
(4, 'SQL & MySQL'),
(5, 'Python'),
(6, 'Machine Learning & AI'),
(7, 'AWS & Cloud Infrastructure'),
(8, 'Azure'),
(9, 'Docker & Containers'),
(10, 'Kubernetes'),
(11, 'Figma & UI Design'),
(12, 'Adobe XD'),
(13, 'HTML & CSS'),
(14, 'Network Security & Ethical Hacking'),
(15, 'SIEM Tools'),
(16, 'Jenkins & CI/CD'),
(17, 'Git & Version Control'),
(18, 'Android & Kotlin'),
(19, 'iOS & Swift'),
(20, 'React Native'),
(21, 'Data Structures & Algorithms'),
(22, 'JavaScript'),
(23, 'C++'),
(24, 'Node.js'),
(25, 'Angular'),
(26, 'MongoDB'),
(27, 'PostgreSQL'),
(28, 'Linux System Administration'),
(29, 'TensorFlow & Deep Learning'),
(30, 'PowerBI & Data Visualization'),
(31, 'Business Analysis'),
(32, 'Excel & Data Analytics'),
(33, 'Financial Modeling & Accounting'),
(34, 'Digital Marketing & SEO'),
(35, 'HR Management & Recruitment'),
(36, 'CAD & Mechanical Design'),
(37, 'Agile & Project Management'),
(38, 'Quality Assurance & Testing'),
(39, 'Communication & Negotiation'),
(40, 'Market Research & Strategy');

-- 3. Seed Master Interests (17 Domain Interests)
INSERT IGNORE INTO interests (id, interest_name) VALUES
(1, 'Software Engineering'),
(2, 'Data Science & AI'),
(3, 'Cloud Computing & Infrastructure'),
(4, 'UI/UX Design'),
(5, 'Cybersecurity'),
(6, 'DevOps & Automation'),
(7, 'Mobile App Development'),
(8, 'Web Development'),
(9, 'Database Administration'),
(10, 'QA & Software Testing'),
(11, 'Game Development'),
(12, 'Big Data & Analytics'),
(13, 'Business & Management'),
(14, 'Finance & Accounting'),
(15, 'Digital Marketing & Sales'),
(16, 'Human Resources & Recruitment'),
(17, 'Mechanical & Product Engineering');

-- 4. Seed Core Careers (17 Careers - IT & Non-IT Multi-Domain)
INSERT IGNORE INTO careers (id, career_name, description, required_skills, qualification) VALUES
(1, 'Java Full Stack Developer', 'Develops web applications using Java, Spring Boot, React, and MySQL.', 'Java, Spring Boot, React, MySQL', 'B.Tech Computer Science'),
(2, 'Data Scientist', 'Analyzes complex datasets to extract insights and build predictive machine learning models.', 'Python, Machine Learning, SQL, TensorFlow', 'M.Sc. Data Science / B.Tech CS'),
(3, 'Cloud Engineer', 'Designs and manages cloud infrastructure for scalable applications using AWS, Azure, and Docker.', 'AWS, Azure, Docker, Kubernetes', 'B.Tech Information Technology'),
(4, 'UI/UX Designer', 'Creates user-friendly interfaces and designs seamless user experiences.', 'Figma, Adobe XD, HTML, CSS', 'B.Des Interaction Design / B.Tech'),
(5, 'Cybersecurity Analyst', 'Protects systems and networks from cyber threats, malware, and vulnerabilities.', 'Network Security, Ethical Hacking, SIEM Tools, Python', 'B.Tech Computer Science'),
(6, 'DevOps Engineer', 'Automates software delivery pipelines and manages CI/CD processes.', 'Jenkins, Docker, Kubernetes, Git, Linux', 'B.Tech Software Engineering'),
(7, 'Mobile App Developer', 'Builds and maintains applications for Android and iOS platforms.', 'Java, Kotlin, Swift, React Native', 'B.Tech Computer Engineering'),
(8, 'Backend Engineer', 'Architects high-performance server APIs, database queries, and microservices.', 'Java, Node.js, PostgreSQL, Data Structures', 'B.Tech CS / BCA / MCA'),
(9, 'Frontend Engineer', 'Builds interactive, modern web frontends using JavaScript, React, and Angular.', 'JavaScript, React, Angular, HTML & CSS', 'B.Tech CS / BCA'),
(10, 'AI / Machine Learning Engineer', 'Deploys deep learning models and neural networks to production servers.', 'Python, Machine Learning, TensorFlow, C++', 'M.Tech AI / B.Tech CS'),
(11, 'Database Administrator (DBA)', 'Manages database integrity, performance tuning, clustering, and backup recovery.', 'SQL & MySQL, PostgreSQL, MongoDB, Linux', 'B.Tech / BCA / MCA'),
(12, 'QA Automation Engineer', 'Automates software testing suites to ensure application quality and stability.', 'Java, Python, Selenium, Git', 'B.Tech CS / BCA'),
(13, 'Business Analyst', 'Bridge career for IT/Business transition. Gathers business requirements and maps data workflows.', 'Excel & Data Analytics, Business Analysis, Agile & Project Management, SQL & MySQL', 'B.Tech / B.Com / BBA / MBA'),
(14, 'Financial Analyst', 'Evaluates financial data, forecasts investment trends, and manages corporate budgeting.', 'Excel & Data Analytics, Financial Modeling & Accounting, Market Research & Strategy', 'B.Com / BBA / MBA Finance'),
(15, 'Digital Marketing Specialist', 'Executes online campaigns, SEO optimization, and social media growth strategies.', 'Digital Marketing & SEO, Market Research & Strategy', 'Any Bachelor Degree'),
(16, 'HR Talent Manager', 'Manages talent acquisition, employee relations, and organization development.', 'HR Management & Recruitment, Communication & Negotiation', 'BBA / MBA / Any Graduate'),
(17, 'Mechanical Design Engineer', 'Engineers mechanical components and product designs using CAD tools.', 'CAD & Mechanical Design, Linux System Administration, C++', 'B.Tech Mechanical / Automobile');

-- 5. Seed Career-Skill Junction Entries (career_skills)
INSERT IGNORE INTO career_skills (career_id, skill_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 22),
(2, 5), (2, 6), (2, 4), (2, 29), (2, 30),
(3, 7), (3, 8), (3, 9), (3, 10), (3, 28),
(4, 11), (4, 12), (4, 13),
(5, 14), (5, 15), (5, 5), (5, 28),
(6, 16), (6, 9), (6, 10), (6, 17), (6, 28),
(7, 1), (7, 18), (7, 19), (7, 20),
(8, 1), (8, 24), (8, 27), (8, 21),
(9, 22), (9, 3), (9, 25), (9, 13),
(10, 5), (10, 6), (10, 29), (10, 23),
(11, 4), (11, 27), (11, 26), (11, 28),
(12, 1), (12, 5), (12, 17), (12, 38),
(13, 31), (13, 32), (13, 37), (13, 4),
(14, 32), (14, 33), (14, 40),
(15, 34), (15, 40), (15, 39),
(16, 35), (16, 39),
(17, 36), (17, 28), (17, 23);

-- 6. Seed Career-Interest Junction Entries (career_interests)
INSERT IGNORE INTO career_interests (career_id, interest_id) VALUES
(1, 1), (1, 8),
(2, 2), (2, 12),
(3, 3), (3, 6),
(4, 4),
(5, 5),
(6, 6), (6, 3),
(7, 7),
(8, 1), (8, 8),
(9, 8), (9, 4),
(10, 2),
(11, 9),
(12, 10),
(13, 13), (13, 12),
(14, 14), (14, 13),
(15, 15), (15, 13),
(16, 16), (16, 13),
(17, 17);

-- 7. Seed Standard Assessments (6 Assessments)
INSERT IGNORE INTO assessments (id, test_name, duration, total_marks) VALUES
(1, 'General Technical & Aptitude Assessment', 45, 100),
(2, 'Java Full Stack Developer Test', 30, 50),
(3, 'Data Analyst & SQL Skills Test', 30, 50),
(4, 'Frontend & Web Engineering Test', 30, 50),
(5, 'DevOps & Cloud Infrastructure Test', 35, 50),
(6, 'Cybersecurity Fundamentals Test', 30, 50);

-- ====================================================================
-- 8. SECTION 1: COMMON BASELINE QUESTIONS (Aptitude, Logic, English, CS Fundamentals - skill_id = NULL)
-- ====================================================================
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(1, 'If a train 150m long crosses a pole in 15 seconds, what is the speed of the train in km/h?', '30 km/h', '36 km/h', '45 km/h', '54 km/h', 'B', 'Medium', 'Aptitude', NULL),
(2, 'Find the missing number in series: 2, 6, 12, 20, 30, ?', '38', '40', '42', '44', 'C', 'Medium', 'Logical Reasoning', NULL),
(3, 'Choose the correct synonym for the word METICULOUS:', 'Careless', 'Careful', 'Quick', 'Lazy', 'B', 'Easy', 'English & Verbal Ability', NULL),
(4, 'What is the main function of the ALU in a CPU?', 'Store files', 'Perform arithmetic and logical operations', 'Control memory allocation', 'Display graphics', 'B', 'Easy', 'CS Fundamentals', NULL),
(5, 'If 5 workers complete a job in 12 days, how many days will 10 workers take to complete the same job?', '4 days', '6 days', '8 days', '10 days', 'B', 'Medium', 'Aptitude', NULL),
(6, 'Which logic gate produces a HIGH output only when both inputs are different?', 'AND Gate', 'OR Gate', 'XOR Gate', 'NAND Gate', 'C', 'Medium', 'Logical Reasoning', NULL),
(7, 'Fill in the blank with appropriate preposition: "She is proficient ___ Java programming."', 'at', 'in', 'with', 'on', 'B', 'Easy', 'English & Verbal Ability', NULL),
(8, 'Which component of an OS schedules threads for CPU execution?', 'File Manager', 'Process Scheduler', 'Memory Allocator', 'Device Driver', 'B', 'Medium', 'CS Fundamentals', NULL),
(9, 'A shopkeeper sells an item at 20% profit. If the selling price is Rs. 120, what is the cost price?', 'Rs. 80', 'Rs. 100', 'Rs. 120', 'Rs. 140', 'B', 'Medium', 'Aptitude', NULL),
(10, 'If A is the brother of B, B is the sister of C, and C is the father of D, how is A related to D?', 'Uncle', 'Nephew', 'Cousin', 'Brother', 'A', 'Medium', 'Logical Reasoning', NULL),
(11, 'Choose the correct antonym for the word BENEVOLENT:', 'Kind', 'Cruel', 'Generous', 'Helpful', 'B', 'Easy', 'English & Verbal Ability', NULL),
(12, 'What is the purpose of RAM in a computer system?', 'Permanent storage', 'Temporary storage for running programs', 'Display output', 'Process calculations', 'B', 'Easy', 'CS Fundamentals', NULL),
(13, 'The ratio of two numbers is 3:5. If 8 is added to each number, the ratio becomes 5:7. Find the smaller number.', '12', '15', '18', '21', 'A', 'Medium', 'Aptitude', NULL),
(14, 'If "CAT" is coded as "3120", how is "DOG" coded?', '4157', '4156', '3157', '3156', 'A', 'Medium', 'Logical Reasoning', NULL),
(15, 'Choose the word that best completes the sentence: "The committee decided to ___ the proposal until next week."', 'defer', 'differ', 'delay', 'differs', 'A', 'Easy', 'English & Verbal Ability', NULL),
(16, 'Which data structure follows LIFO principle?', 'Queue', 'Stack', 'Array', 'Linked List', 'B', 'Easy', 'CS Fundamentals', NULL),
(17, 'A boat travels upstream in 6 hours and downstream in 4 hours. If the speed of the stream is 2 km/h, find the speed of the boat in still water.', '8 km/h', '10 km/h', '12 km/h', '14 km/h', 'B', 'Medium', 'Aptitude', NULL),
(18, 'Find the odd one out: 8, 27, 64, 125, 216', '8', '27', '64', '125', 'A', 'Medium', 'Logical Reasoning', NULL),
(19, 'Choose the correct spelling:', 'Accomodate', 'Accommodate', 'Acommodate', 'Acomodate', 'B', 'Easy', 'English & Verbal Ability', NULL),
(20, 'What is the binary equivalent of decimal number 10?', '1010', '1100', '1001', '1110', 'A', 'Easy', 'CS Fundamentals', NULL),
(21, 'If the radius of a circle is increased by 50%, by what percentage does its area increase?', '100%', '125%', '150%', '175%', 'B', 'Hard', 'Aptitude', NULL),
(22, 'If "PENCIL" is written as "RGKEMN", how is "ERASER" written?', 'GTCUGP', 'GTCUGT', 'GTCUFP', 'GTCUGQ', 'B', 'Medium', 'Logical Reasoning', NULL),
(23, 'Choose the correct meaning of the idiom "Bite the bullet":', 'Eat something hard', 'Face a difficult situation bravely', 'Avoid confrontation', 'Speak harshly', 'B', 'Medium', 'English & Verbal Ability', NULL),
(24, 'What is the time complexity of binary search?', 'O(n)', 'O(log n)', 'O(n²)', 'O(1)', 'B', 'Medium', 'CS Fundamentals', NULL),
(25, 'A sum of money at simple interest doubles in 10 years. In how many years will it triple at the same rate?', '15 years', '20 years', '25 years', '30 years', 'B', 'Medium', 'Aptitude', NULL),
(26, 'If "MANGO" is coded as "4157", how is "APPLE" coded?', '5177', '5176', '6177', '6176', 'A', 'Medium', 'Logical Reasoning', NULL),
(27, 'Choose the correct form of verb: "She ___ to the gym every morning."', 'go', 'goes', 'going', 'gone', 'B', 'Easy', 'English & Verbal Ability', NULL),
(28, 'Which protocol is used for secure communication over the internet?', 'HTTP', 'FTP', 'HTTPS', 'SMTP', 'C', 'Easy', 'CS Fundamentals', NULL),
(29, 'Two pipes A and B can fill a tank in 20 and 30 minutes respectively. If both pipes are opened together, in how many minutes will the tank be filled?', '10 minutes', '12 minutes', '15 minutes', '18 minutes', 'B', 'Medium', 'Aptitude', NULL),
(30, 'Find the missing term: ACE, GIK, MOQ, ?', 'STU', 'SUV', 'SUW', 'STW', 'C', 'Medium', 'Logical Reasoning', NULL),
(31, 'Choose the correct synonym for the word EPHEMERAL:', 'Permanent', 'Temporary', 'Strong', 'Weak', 'B', 'Medium', 'English & Verbal Ability', NULL),
(32, 'What is the primary function of an operating system?', 'Run applications', 'Manage hardware and software resources', 'Create documents', 'Connect to internet', 'B', 'Easy', 'CS Fundamentals', NULL),
(33, 'The average of 5 consecutive odd numbers is 23. What is the largest number?', '25', '27', '29', '31', 'B', 'Easy', 'Aptitude', NULL),
(34, 'If "MANGO" is written as "NAMOG", how is "APPLE" written?', 'ELPPA', 'PELPA', 'EPPLA', 'PPLEA', 'A', 'Medium', 'Logical Reasoning', NULL),
(35, 'Choose the correct sentence:', 'He don\'t know the answer.', 'He doesn\'t know the answer.', 'He doesn\'t knows the answer.', 'He don\'t knows the answer.', 'B', 'Easy', 'English & Verbal Ability', NULL),
(36, 'What is the purpose of a firewall in network security?', 'Speed up network', 'Block unauthorized access', 'Store data', 'Encrypt data', 'B', 'Medium', 'CS Fundamentals', NULL),
(37, 'A person buys a shirt at 20% discount and sells it at 10% profit. If the marked price is Rs. 1000, what is his profit percentage?', '10%', '12.5%', '15%', '20%', 'A', 'Medium', 'Aptitude', NULL),
(38, 'Find the next number in the series: 1, 4, 9, 16, 25, ?', '30', '35', '36', '49', 'C', 'Easy', 'Logical Reasoning', NULL),
(39, 'Choose the correct preposition: "He is good ___ mathematics."', 'in', 'at', 'on', 'with', 'B', 'Easy', 'English & Verbal Ability', NULL),
(40, 'What is the difference between HTTP and HTTPS?', 'No difference', 'HTTPS is encrypted, HTTP is not', 'HTTP is faster', 'HTTPS is for images only', 'B', 'Easy', 'CS Fundamentals', NULL);

-- ====================================================================
-- 9. SECTION 2: SKILL-SPECIFIC TECHNICAL QUESTIONS (Linked to skill_id)
-- ====================================================================

-- Questions for Skill 1: Java (skill_id = 1)
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(41, 'What is the default value of a boolean variable in Java?', 'true', 'false', 'null', '0', 'B', 'Easy', 'Java', 1),
(42, 'Which keyword is used to create a class in Java?', 'class', 'Class', 'className', 'create', 'A', 'Easy', 'Java', 1),
(43, 'What is the size of an int variable in Java?', '16 bits', '32 bits', '64 bits', '8 bits', 'B', 'Easy', 'Java', 1),
(44, 'Which method is the entry point of a Java program?', 'start()', 'run()', 'main()', 'init()', 'C', 'Easy', 'Java', 1),
(45, 'What does the "static" keyword mean in Java?', 'Cannot be changed', 'Belongs to class not instance', 'Final value', 'No memory allocation', 'B', 'Medium', 'Java', 1),
(46, 'Which of these is not a Java primitive type?', 'int', 'float', 'String', 'boolean', 'C', 'Easy', 'Java', 1),
(47, 'What is method overloading in Java?', 'Same method name different parameters', 'Same method name same parameters', 'Different method name same parameters', 'None of the above', 'A', 'Medium', 'Java', 1),
(48, 'What is the purpose of the "final" keyword?', 'Variable cannot be modified', 'Method cannot be overridden', 'Class cannot be inherited', 'All of the above', 'D', 'Medium', 'Java', 1),
(49, 'Which exception is thrown when dividing by zero?', 'ArithmeticException', 'NullPointerException', 'ArrayIndexOutOfBoundsException', 'NumberFormatException', 'A', 'Easy', 'Java', 1),
(50, 'What is a constructor in Java?', 'A method to initialize objects', 'A method to destroy objects', 'A static method', 'A private method', 'A', 'Easy', 'Java', 1),
(51, 'What is the difference between == and equals()?', 'No difference', '== compares references, equals() compares values', '== compares values, equals() compares references', 'Both compare values', 'B', 'Medium', 'Java', 1),
(52, 'What is polymorphism in Java?', 'Multiple forms of a method', 'Single form of a method', 'No inheritance', 'No encapsulation', 'A', 'Medium', 'Java', 1),
(53, 'Which interface is used for iteration?', 'Iterable', 'Iterator', 'Collection', 'List', 'B', 'Medium', 'Java', 1),
(54, 'What is the purpose of the "this" keyword?', 'Refers to current object', 'Refers to parent class', 'Refers to static variable', 'Refers to null', 'A', 'Easy', 'Java', 1),
(55, 'What is garbage collection in Java?', 'Automatic memory management', 'Manual memory management', 'No memory management', 'Disk cleanup', 'A', 'Medium', 'Java', 1),
(56, 'Which collection class is thread-safe?', 'ArrayList', 'HashMap', 'Vector', 'LinkedList', 'C', 'Medium', 'Java', 1),
(57, 'What is an abstract class in Java?', 'Cannot be instantiated', 'Can be instantiated', 'Must have all methods implemented', 'No methods allowed', 'A', 'Medium', 'Java', 1),
(58, 'What is the purpose of the "super" keyword?', 'Refers to parent class', 'Refers to child class', 'Refers to current class', 'Refers to static method', 'A', 'Easy', 'Java', 1),
(59, 'Which modifier makes a variable accessible only within its class?', 'public', 'private', 'protected', 'default', 'B', 'Easy', 'Java', 1),
(60, 'What is a lambda expression in Java?', 'Anonymous function', 'Named function', 'Class', 'Interface', 'A', 'Hard', 'Java', 1);

-- Questions for Skill 2: Spring Boot (skill_id = 2)
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(61, 'What is Spring Boot?', 'Framework to simplify Spring development', 'Database tool', 'Testing framework', 'Build tool', 'A', 'Easy', 'Spring Boot', 2),
(62, 'Which annotation is used to mark a class as a Spring Boot application?', '@SpringBootApplication', '@Application', '@Boot', '@SpringApp', 'A', 'Easy', 'Spring Boot', 2),
(63, 'What is the default port for Spring Boot application?', '8080', '8081', '3000', '5000', 'A', 'Easy', 'Spring Boot', 2),
(64, 'Which annotation is used for dependency injection?', '@Autowired', '@Inject', '@Dependency', '@Resource', 'A', 'Easy', 'Spring Boot', 2),
(65, 'What is the purpose of @RestController?', 'Creates RESTful web services', 'Creates web pages', 'Database connection', 'Security configuration', 'A', 'Medium', 'Spring Boot', 2),
(66, 'What is Spring Boot Starter?', 'Dependency descriptor', 'Build tool', 'Testing tool', 'Database tool', 'A', 'Easy', 'Spring Boot', 2),
(67, 'Which annotation is used for configuration?', '@Configuration', '@Config', '@Setup', '@Init', 'A', 'Medium', 'Spring Boot', 2),
(68, 'What is the purpose of @Value annotation?', 'Inject property values', 'Inject beans', 'Create beans', 'Destroy beans', 'A', 'Medium', 'Spring Boot', 2),
(69, 'What is Actuator in Spring Boot?', 'Production-ready features', 'Testing tool', 'Build tool', 'Database tool', 'A', 'Medium', 'Spring Boot', 2),
(70, 'Which annotation is used for request mapping?', '@RequestMapping', '@Mapping', '@Request', '@Path', 'A', 'Easy', 'Spring Boot', 2);

-- Questions for Skill 3: React (skill_id = 3)
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(71, 'What is React?', 'JavaScript library for building UIs', 'Database tool', 'Backend framework', 'CSS framework', 'A', 'Easy', 'React', 3),
(72, 'What is JSX?', 'JavaScript XML syntax extension', 'Java XML', 'JSON XML', 'Python XML', 'A', 'Easy', 'React', 3),
(73, 'What is a component in React?', 'Reusable UI building block', 'Database table', 'API endpoint', 'CSS class', 'A', 'Easy', 'React', 3),
(74, 'What is useState used for?', 'Manage component state', 'Manage props', 'Manage context', 'Manage effects', 'A', 'Easy', 'React', 3),
(75, 'What is useEffect used for?', 'Handle side effects', 'Handle state', 'Handle props', 'Handle context', 'A', 'Medium', 'React', 3),
(76, 'What is the purpose of props?', 'Pass data to components', 'Manage state', 'Handle events', 'Make API calls', 'A', 'Easy', 'React', 3),
(77, 'What is the difference between state and props?', 'State is internal, props are external', 'Props are internal, state is external', 'No difference', 'Both are external', 'A', 'Medium', 'React', 3),
(78, 'What is a functional component?', 'Component as a function', 'Component as a class', 'Component as a variable', 'Component as an object', 'A', 'Easy', 'React', 3),
(79, 'What is Virtual DOM in React?', 'Lightweight in-memory representation of real DOM', 'Direct copy of real DOM', 'Database model', 'Browser extension', 'B', 'Medium', 'React', 3),
(80, 'Which Hook is used for side effects in functional React components?', 'useState', 'useEffect', 'useContext', 'useReducer', 'B', 'Easy', 'React', 3);

-- Questions for Skill 4: SQL & MySQL (skill_id = 4)
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(81, 'What does SQL stand for?', 'Structured Query Language', 'Simple Query Language', 'Standard Query Language', 'System Query Language', 'A', 'Easy', 'SQL & MySQL', 4),
(82, 'Which command is used to retrieve data from a database?', 'SELECT', 'GET', 'RETRIEVE', 'FETCH', 'A', 'Easy', 'SQL & MySQL', 4),
(83, 'Which clause is used to filter results?', 'WHERE', 'FILTER', 'HAVING', 'GROUP BY', 'A', 'Easy', 'SQL & MySQL', 4),
(84, 'Which operator is used for pattern matching?', 'LIKE', 'MATCH', 'PATTERN', 'SIMILAR', 'A', 'Easy', 'SQL & MySQL', 4),
(85, 'What is the purpose of ORDER BY?', 'Sort results', 'Filter results', 'Group results', 'Join results', 'A', 'Easy', 'SQL & MySQL', 4),
(86, 'Which function is used to count rows?', 'COUNT()', 'SUM()', 'AVG()', 'MAX()', 'A', 'Easy', 'SQL & MySQL', 4),
(87, 'What is the purpose of GROUP BY?', 'Group rows with same values', 'Sort rows', 'Filter rows', 'Join rows', 'A', 'Medium', 'SQL & MySQL', 4),
(88, 'Which SQL clause is used to filter records after aggregation?', 'WHERE', 'HAVING', 'GROUP BY', 'ORDER BY', 'B', 'Medium', 'SQL & MySQL', 4),
(89, 'Which command is used to remove all records from a table without logging individual row deletions?', 'DELETE', 'DROP', 'TRUNCATE', 'REMOVE', 'C', 'Medium', 'SQL & MySQL', 4),
(90, 'What is a primary key?', 'Unique identifier for each row', 'Foreign key', 'Index', 'Constraint', 'A', 'Easy', 'SQL & MySQL', 4);

-- Questions for Skill 5: Python (skill_id = 5)
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(91, 'What is Python?', 'High-level programming language', 'Database', 'Operating system', 'Hardware', 'A', 'Easy', 'Python', 5),
(92, 'What is the correct file extension for Python files?', '.py', '.python', '.pt', '.pyt', 'A', 'Easy', 'Python', 5),
(93, 'Which data structure in Python is immutable?', 'List', 'Dictionary', 'Tuple', 'Set', 'C', 'Easy', 'Python', 5),
(94, 'What is the correct syntax to define a function in Python?', 'function myFunc():', 'def myFunc():', 'create myFunc():', 'func myFunc():', 'B', 'Easy', 'Python', 5),
(95, 'What is a list comprehension in Python?', 'Concise way to create lists', 'List of functions', 'List of classes', 'List of dictionaries', 'A', 'Medium', 'Python', 5),
(96, 'What is the purpose of the "lambda" keyword in Python?', 'Create anonymous functions', 'Create named functions', 'Create classes', 'Create modules', 'A', 'Medium', 'Python', 5),
(97, 'What is the difference between "is" and "==" in Python?', 'is checks identity, == checks equality', '== checks identity, is checks equality', 'No difference', 'Both check equality', 'A', 'Medium', 'Python', 5),
(98, 'What is the purpose of the "pass" statement in Python?', 'Placeholder for future code', 'Exit loop', 'Skip iteration', 'Return value', 'A', 'Easy', 'Python', 5),
(99, 'What is a decorator in Python?', 'Function that modifies another function', 'Function that creates a class', 'Function that creates a module', 'Variable type', 'A', 'Hard', 'Python', 5),
(100, 'What is the purpose of the "__init__" method in Python?', 'Initialize object', 'Destroy object', 'Create object', 'Delete object', 'A', 'Medium', 'Python', 5);

-- ====================================================================
-- 10. SECTION 3: CAREER DISCOVERY & NON-IT TRANSITION QUESTIONS
-- ====================================================================
INSERT INTO questions (id, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, skill_id) VALUES
(101, 'What is your current educational background / domain?', 'Computer Science / IT', 'Mechanical / Civil / Electrical Eng', 'Commerce / Business / Finance', 'Arts / Design / Humanities', 'A', 'Easy', 'Discovery - Background', NULL),
(102, 'What is your primary career target or transition goal?', 'Target IT / Software Engineering', 'Target Business & Data Analysis', 'Target UI/UX & Digital Design', 'Target Core Non-IT Domain', 'A', 'Easy', 'Discovery - Goal', NULL),
(103, 'When analyzing a problem, which tool/method do you prefer using?', 'Code scripts & IDEs', 'Excel spreadsheets & SQL queries', 'Figma & visual wireframe diagrams', 'CAD models & physical diagrams', 'B', 'Medium', 'Discovery - Method', NULL),
(104, 'Which activity do you find most natural and rewarding?', 'Building software features & APIs', 'Analyzing financial trends & market data', 'Creating visual UI designs & graphics', 'Managing teams & leading client projects', 'B', 'Medium', 'Discovery - Activity', NULL),
(105, 'If transitioning from Non-IT to IT, which bridge area interests you most?', 'QA Software Testing & Automation', 'Business Analysis & Data Reporting', 'UI/UX Design & Frontend Development', 'Full-Stack Web Coding', 'A', 'Easy', 'Discovery - Bridge', NULL),
(106, 'Which skill do you consider your strongest asset today?', 'Logical Reasoning & Coding', 'Excel & Financial Analysis', 'Communication & Team Leadership', 'Creative Design & Visual Aesthetics', 'B', 'Easy', 'Discovery - Asset', NULL);
