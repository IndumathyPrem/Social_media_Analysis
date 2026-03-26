USE SocialMediaDB;

-- 1. Users starting with 'a'
SELECT * FROM users
WHERE username LIKE 'a%';

-- 2. Posts with NULL captions
SELECT * FROM posts
WHERE caption IS NULL;

-- 3. Email domain filter
SELECT * FROM users
WHERE SUBSTRING_INDEX(email,'@',-1)
IN ('gmail.com','hotmail.com','yahoo.com');

-- 4. Top 5 active users
SELECT user_id, COUNT(*) AS total_posts
FROM posts
GROUP BY user_id
ORDER BY total_posts DESC
LIMIT 5;

-- 5. Posts per day (>10)
SELECT DATE(posted_at) AS post_date,
COUNT(*) AS total_posts
FROM posts
GROUP BY DATE(posted_at)
HAVING COUNT(*) > 10;

-- 6. Post engagement report
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
GROUP BY p.post_id, u.username, p.caption;

-- 7. Users who liked OR commented
SELECT u.username
FROM users u
JOIN comments c ON u.user_id = c.user_id
UNION
SELECT u.username
FROM users u
JOIN likes l ON u.user_id = l.user_id;

-- 8. Uppercase usernames
SELECT UPPER(username) FROM users;

-- 9. Caption length
SELECT LENGTH(caption) FROM posts;

--10.Trigger
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER after_like
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    INSERT INTO notifications (user_id, message)
    VALUES (NEW.user_id, 'You liked a post');
END $$

DELIMITER ;

--11.View
CREATE VIEW post_summary AS
SELECT 
    p.post_id,
    u.username,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, u.username;
