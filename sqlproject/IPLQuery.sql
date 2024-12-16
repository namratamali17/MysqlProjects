select * from ipl;
SELECT COUNT(*) FROM IPL;

-- To get all matches played in a specific season (e.g., season 2024):
SELECT * FROM ipl WHERE season = 202;

-- To find all matches played in a specific city (e.g., Mumbai):
SELECT * FROM IPL WHERE city="Mumbai";

-- Find Matches Won by a Specific Team
SELECT * FROM ipl WHERE winner = 'MI';

-- Find Player of the Match for a Specific Season
SELECT player_of_match FROM ipl WHERE season = 2024;

--  Find Matches with a Specific Result
SELECT * FROM ipl WHERE method = 'DLS';

-- 8. Find Matches Between Two Specific Teams
SELECT * FROM ipl WHERE (team1 = 'MI' AND team2 = 'RCB') OR (team1 = 'RCB' AND team2 = 'MI');

--  Find Matches with a Specific Result Margin

SELECT * FROM ipl WHERE result_margin = 10;  
--  Find Matches with Super Over

SELECT * FROM ipl WHERE super_over = 'Yes';

--  Find the Toss Winner for a Specific Season

SELECT toss_winner FROM ipl WHERE season = 2024;
-- Find Matches by Venue
SELECT * FROM ipl WHERE venue = 'Wankhede Stadium';

-- Find the Highest Target Runs

SELECT * FROM ipl WHERE target_runs = (SELECT MAX(target_runs) FROM ipl);

--  Find the Matches Where the Target Runs Were Met
-- To find all matches where the target runs were met or chased:

SELECT * FROM ipl WHERE result LIKE '%won%';

-- Find Matches by Date Range
SELECT * FROM ipl WHERE date BETWEEN '2024-04-01' AND '2024-04-30';

--  Find Matches with 'Batting' Toss Decision
SELECT * FROM ipl WHERE toss_decision = 'Batting';

--  Find Matches Played in a Specific Venue and Result

SELECT * FROM ipl WHERE venue = 'Wankhede Stadium' AND winner = 'MI';
--  Find the Most Frequent Umpires

SELECT umpire1, COUNT(*) AS umpire_count FROM ipl GROUP BY umpire1 ORDER BY umpire_count DESC LIMIT 1;

SELECT umpire2, COUNT(*) AS umpire_count FROM ipl GROUP BY umpire2 ORDER BY umpire_count DESC LIMIT 1;
-- Update a Record (e.g., Change the Winner of a Match)

UPDATE ipl SET winner = 'RCB' WHERE id = 10;

-- . Delete a Record (e.g., Delete Match ID 15)

DELETE FROM ipl WHERE id = 15;


