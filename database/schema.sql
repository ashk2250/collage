PRAGMA foreign_keys = ON;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    start_year INT,
    graduation_year INT,
    enrollment_date DATE,
    credits_completed INT,
    keywords TEXT,
    major VARCHAR(255),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(50) NOT NULL,
    catalog_number INT NOT NULL,
    credit_hours INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    instructor_id VARCHAR(255) NOT NULL,
    topic_description TEXT NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT NOT NULL,
    class_topic VARCHAR(255) NOT NULL,
    enrollment_status VARCHAR(255),
    ai_img_url VARCHAR(255),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE CASCADE
);

CREATE TABLE instructors(
  instructor_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(256) NOT NULL,
  department VARCHAR(256) NOT NULL,
  email VARCHAR(256) UNIQUE
);

CREATE TABLE course_ratings(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  course_id INT,
  rating INT, -- a scale from 1 to 5, 5 being the best
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
)

CREATE TABLE instructor_ratings(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  instructor_id INT,
  rating INT, -- a scale from 1 to 5, 5 being the best
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE CASCADE,
)

CREATE TABLE connections(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id_1 INT, -- user_id_1 follows user_id_2
  user_id_2 INT,
  FOREIGN KEY (user_id_1) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id_2) REFERENCES users(user_id) ON DELETE CASCADE,
)

CREATE TABLE saved_courses(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  course_id INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
)

--Pull Req 7/25
CREATE TABLE profile_viewers (
    viewer_id INT NOT NULL,
    viewed_id INT NOT NULL,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (viewer_id, viewed_id),
    FOREIGN KEY (viewer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (viewed_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- stores a list of all possible interests
CREATE TABLE interests (
    interest_id INT AUTO_INCREMENT PRIMARY KEY,
    interest_name VARCHAR(255) NOT NULL UNIQUE
);

--INSERT INTERESTS
 /*INSERT INTO interests (interest_name) VALUES ('science');
INSERT INTO interests (interest_name) VALUES ('business');
INSERT INTO interests (interest_name) VALUES ('literature');
INSERT INTO interests (interest_name) VALUES ('political science'); */

--ADD USER INTEREST
/*INSERT INTO user_interests (user_id, interest_id)
VALUES (1, (SELECT interest_id FROM interests WHERE interest_name = 'science'));*/

--links users to their selected interests
CREATE TABLE user_interests (
    user_id INT NOT NULL,
    interest_id INT NOT NULL,
    PRIMARY KEY (user_id, interest_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (interest_id) REFERENCES interests(interest_id) ON DELETE CASCADE
);

--Retreive User Interest
/*SELECT i.interest_name
FROM user_interests ui
JOIN interests i ON ui.interest_id = i.interest_id
WHERE ui.user_id = 1;*/
