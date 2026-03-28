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
-- Top influencers (users with highest total engagement)
SELECT 
    u.user_id,
    u.username,
    COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS total_engagement
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY u.user_id, u.username
ORDER BY total_engagement DESC
LIMIT 10;

-- Virality report (posts with unusually high engagement)
SELECT 
    p.post_id,
    u.username,
    p.caption,
    COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS engagement
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, u.username, p.caption
HAVING engagement > (
    SELECT AVG(total_engagement)
    FROM (
        SELECT 
            p.post_id,
            COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS total_engagement
        FROM posts p
        LEFT JOIN likes l ON p.post_id = l.post_id
        LEFT JOIN comments c ON p.post_id = c.post_id
        GROUP BY p.post_id
    ) avg_table
)
ORDER BY engagement DESC;
-- User activity timeline (daily/weekly posting patterns)
SELECT 
    DATE(posted_at) AS post_date,
    COUNT(*) AS total_posts
FROM posts
GROUP BY DATE(posted_at)
ORDER BY post_date;

SELECT 
    WEEK(posted_at) AS week_number,
    COUNT(*) AS total_posts
FROM posts
GROUP BY WEEK(posted_at)
ORDER BY week_number;

-- Follower growth(who gained the most followers recently)
SELECT 
    u.user_id,
    u.username,
    COUNT(f.follower_id) AS new_followers
FROM users u
LEFT JOIN followers f ON u.user_id = f.following_id
WHERE f.follow_date >= NOW() - INTERVAL 30 DAY
GROUP BY u.user_id, u.username
ORDER BY new_followers DESC
LIMIT 10;

-- Trending hashtags (most used hashtags in last 30 days)
SELECT 
    p.post_id,
    COUNT(DISTINCT l.like_id) AS likes,
    COUNT(DISTINCT c.comment_id) AS comments,
    (COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id)) AS engagement
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id;
