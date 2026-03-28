 Social Media Database (SQL Project)

 Overview

This project simulates a real-world social media database using MySQL.

It includes users, posts, likes, comments, and follower relationships.

---
 Database Features

* User management system
* Post creation with timestamps
* Like & comment functionality
* Follower-following relationships

---
 Concepts Covered

* Primary & Foreign Keys
* Constraints & Data Integrity
* Joins (INNER, LEFT)
* Aggregations (COUNT, GROUP BY, HAVING)
* Filtering (WHERE, LIKE, IN, BETWEEN)
* UNION operations

---

 Sample Insights

Analytical Insights
 1. Top Influencers
Identified users with the highest engagement (likes + comments), helping determine key contributors on the platform.
 2. Virality Analysis
Detected posts with unusually high engagement compared to average engagement levels.
3. User Activity Timeline
Analyzed daily and weekly posting trends to understand user behavior patterns.
 4. Follower Growth
Tracked users who gained the most followers in recent time periods.
5. Trending Hashtags
Extracted and ranked hashtags based on usage in recent posts to identify trending topics.


---

How to Run

1. Create database:

   ```sql
   CREATE DATABASE SocialMediaDB;
   USE SocialMediaDB;
   ```

2. Run schema + inserts

3. Execute queries section

---

 File Structure
 
social-media-db/

│─ 1_schema.sql

│─ 2_sample_data.sql

│─ 3_queries.sql

│─ social_media_platform.sql → Full project file

│─ README.md → Documentation

---

Future Improvements

* Add stored procedures
* Add triggers (notifications system)
* Add indexes for performance
* Build Power BI dashboard

---

Author

Indumathy

