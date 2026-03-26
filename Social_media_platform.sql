-- create database
create database IF NOT EXISTS SocialMediaDB;
use SocialMediaDB;

/*Today's challenge-KEYS, CONSTRAINTS, INSERT/UPDATE/DELETE
Challenge 1 — Posts Table with Constraints
Create a posts table:
Column -Type  -Constraint
post_id-INT- PK, auto_increment
user_id- INT -FK → users.user_id
caption-TEXT
posted_at-DATETIME ->DEFAULT CURRENT-TIMESTAMP
*/
-- users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- post table
CREATE TABLE IF NOT EXISTS Posts (
    post_id INT PRIMARY KEY auto_increment,
    user_id INT,
    caption VARCHAR(100),
    posted_at DateTime Default current_timestamp,
     FOREIGN KEY (user_id) REFERENCES users(user_id)
   );
-- Followers table
/*
Create a followers table:
Column-Type-->Constraint
follower_id-INT-->FK → users.user_id
following_id-INT-->FK → users.user_id
follow_date-DATETIME-->DEFAULT CURRENT_TIMESTAMP */
CREATE TABLE IF NOT EXISTS followers (
    follower_id INT ,
    following_id INT ,
    follow_date DateTime Default current_timestamp,
	FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (following_id) REFERENCES users(user_id)
   );
-- Insert Data
INSERT INTO users (username, email) VALUES
('alice','alice@gmail.com'),
('alex','alex@hotmail.com'),
('anna','anna@yahoo.com'),
('adam','adam@gmail.com'),
('aaron','aaron@yahoo.com'),
('ben','ben@gmail.com'),
('bella','bella@hotmail.com'),
('brian','brian@yahoo.com'),
('bruce','bruce@gmail.com'),
('bianca','bianca@hotmail.com'),
('charlie','charlie@gmail.com'),
('chris','chris@yahoo.com'),
('clara','clara@gmail.com'),
('carl','carl@hotmail.com'),
('cathy','cathy@yahoo.com'),
('david','david@gmail.com'),
('daniel','daniel@yahoo.com'),
('diana','diana@hotmail.com'),
('derek','derek@gmail.com'),
('daisy','daisy@yahoo.com'),
('eva','eva@gmail.com'),
('ethan','ethan@hotmail.com'),
('ella','ella@yahoo.com'),
('edward','edward@gmail.com'),
('emily','emily@hotmail.com'),
('frank','frank@gmail.com'),
('fiona','fiona@yahoo.com'),
('fred','fred@hotmail.com'),
('faith','faith@gmail.com'),
('felix','felix@yahoo.com'),
('george','george@gmail.com'),
('grace','grace@hotmail.com'),
('gary','gary@yahoo.com'),
('gina','gina@gmail.com'),
('gavin','gavin@hotmail.com'),
('harry','harry@gmail.com'),
('hannah','hannah@yahoo.com'),
('henry','henry@hotmail.com'),
('hazel','hazel@gmail.com'),
('helen','helen@yahoo.com'),
('ivan','ivan@gmail.com'),
('irene','irene@hotmail.com'),
('isaac','isaac@yahoo.com'),
('ivy','ivy@gmail.com'),
('jack','jack@hotmail.com'),
('jane','jane@yahoo.com'),
('john','john@gmail.com'),
('julia','julia@hotmail.com'),
('jason','jason@yahoo.com'),
('jenny','jenny@gmail.com');
Select *  from users;

INSERT INTO posts (user_id, caption) VALUES
(1,'Morning coffee'),(2,'Learning SQL'),(3,NULL),(4,'Happy coding'),
(5,'Database practice'),(6,'Hello world'),(7,'First post'),
(8,'Exploring MySQL'),(9,'Study time'),(10,'Weekend vibes'),
(11,'Working on project'),(12,NULL),(13,'Good morning'),
(14,'Practice makes perfect'),(15,'Learning joins'),
(16,'Data analytics'),(17,'SQL challenge'),
(18,'Query practice'),(19,'Debugging code'),
(20,'Learning constraints'),(21,'Trying new queries'),
(22,'Reading documentation'),(23,NULL),(24,'Coding day'),
(25,'Practice SQL daily'),(26,'Backend learning'),
(27,'Simple insert test'),(28,'Working with tables'),
(29,'Query optimization'),(30,'Database design'),
(31,'Normalization study'),(32,NULL),(33,'Weekend coding'),
(34,'Testing queries'),(35,'Data practice'),
(36,'SQL is fun'),(37,'Working late'),
(38,'Reading about indexes'),(39,'Practice dataset'),
(40,'Learning foreign keys'),(41,'Database project'),
(42,NULL),(43,'Learning constraints'),
(44,'SQL practice'),(45,'Mini project'),
(46,'Study session'),(47,'Working with joins'),
(48,'Testing updates'),(49,'SQL challenge today'),
(50,'Learning every day');
select * from posts;
Select * from followers;
INSERT INTO followers (follower_id, following_id) VALUES
(1,2),
(2,3),
(3,4),
(4,5),
(5,6),
(6,7),
(7,8),
(8,9),
(9,10),
(10,11),
(11,12),
(12,13),
(13,14),
(14,15),
(15,16),
(16,17),
(17,18),
(18,19),
(19,20),
(20,21),
(21,22),
(22,23),
(23,24),
(24,25),
(25,26),
(26,27),
(27,28),
(28,29),
(29,30),
(30,31),
(31,32),
(32,33),
(33,34),
(34,35),
(35,36),
(36,37),
(37,38),
(38,39),
(39,40),
(40,41),
(41,42),
(42,43),
(43,44),
(44,45),
(45,46),
(46,47),
(47,48),
(48,49),
(49,50);

-- ** DISTINCT, WHERE, IN, BETWEEN, NULL checks** **Challenge 1 — Filter Users**
-- Retrieve all users whose username starts with “a”.
select * from users
where username like "A%";

-- **Challenge 2 — Posts Filter** Get posts posted BETWEEN '2024-01-01' AND '2024-12-31'.(-- Returns null as our post has auto time)
select * from posts
where posted_at between '2024-01-01' AND '2024-12-31';

-- **Challenge 3 — NULL checks ** Find posts that have NULL captions.
select * from posts
where caption IS NULL;

-- **Challenge 4 — IN Clause**Find users whose email domain is in:(@gmail.com, @hotmail.com, @yahoo.com) 
-- In clause is used with substring_index to extract the email  with delimiter @ and -1 return right side of delimiter
SELECT * FROM users
WHERE SUBSTRING_INDEX(email,'@',-1)
IN ('gmail.com','hotmail.com','yahoo.com');

--  Top Active Users Sort users by number of posts (DESC) and LIMIT 5
SELECT user_id, COUNT(*) AS total_posts
FROM posts
GROUP BY user_id
ORDER BY total_posts DESC
LIMIT 5;
-- Group by Posts Per Day Group posts by DATE(posted_at) and return:date total posts Only show days with more than 10 posts (HAVING).
select * from users;
SELECT DATE(posted_at) AS post_date,
COUNT(*) AS total_posts
FROM posts
GROUP BY DATE(posted_at)
HAVING COUNT(*) > 10;

-- session 19-03-2026 -- Challenge 1 — Comments Table Create:comments comment_id (PK) post_id (FK) user_id (FK) comment_text commented_at likes like_id (PK) post_id (FK) user_id (FK) liked_at
CREATE TABLE IF NOT EXISTS comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment_text VARCHAR(250),
    commented_at DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
CREATE TABLE IF NOT EXISTS likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    liked_at DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1,2,'Nice post!','2024-01-01'),
(1,3,'Loved it','2024-01-01'),
(2,1,'Great learning','2024-01-02'),
(2,4,'Very helpful','2024-01-02'),
(3,5,'Interesting','2024-01-03'),
(4,6,'Awesome','2024-01-03'),
(5,7,'Keep going','2024-01-04'),
(6,8,'Well done','2024-01-04'),
(7,9,'Cool','2024-01-05'),
(8,10,'Nice explanation','2024-01-05'),
(9,11,'Helpful','2024-01-06'),
(10,12,'Good one','2024-01-06'),
(1,4,'Amazing','2024-01-07'),
(2,5,'Super','2024-01-07'),
(3,6,'Great','2024-01-08');

INSERT INTO likes (post_id, user_id, liked_at) VALUES
(1,2,'2024-01-01'),
(1,3,'2024-01-01'),
(1,4,'2024-01-01'),
(2,1,'2024-01-02'),
(2,3,'2024-01-02'),
(3,5,'2024-01-03'),
(4,6,'2024-01-03'),
(5,7,'2024-01-04'),
(6,8,'2024-01-04'),
(7,9,'2024-01-05'),
(8,10,'2024-01-05'),
(9,11,'2024-01-06'),
(10,12,'2024-01-06'),
(1,5,'2024-01-07'),
(2,6,'2024-01-07');
-- Challenge 2 — JOIN Report Display: post_id, username, caption, total likes, total comments.
SELECT 
    p.post_id,
    u.username,
    p.caption,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, u.username, p.caption
ORDER BY p.post_id;

-- Challenge 3 — Built-in Functions
-- Show usernames in UPPER case.
select upper(username) from users;
-- Extract month name from posted_at.
select monthname(posted_at) from posts;
-- Return the length of each caption.
select length(caption) from posts;

-- Challenge 4 — UNION
-- Combine list of users who commented OR liked.
SELECT u.username
FROM users u
JOIN comments c ON u.user_id = c.user_id
UNION
SELECT u.username
FROM users u
JOIN likes l ON u.user_id = l.user_id;
