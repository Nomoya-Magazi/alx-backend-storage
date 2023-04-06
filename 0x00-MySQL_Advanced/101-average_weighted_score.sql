-- SQL script that creates a stored procedure ComputeAverageWeightedScoreForUsers that computes and stores the average weighted score for all students
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE total_weighted_score INT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;

    -- Declare a cursor to iterate over all user IDs
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;

    -- Declare continue handler for when there are no more rows in the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN user_cursor;

    -- Loop over all user IDs
    user_loop: LOOP
        -- Fetch the next user ID
        FETCH user_cursor INTO user_id;

        -- If there are no more rows, exit the loop
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Calculate the total weighted score and total weight for this user
        SELECT SUM(corrections.score * projects.weight)
            INTO total_weighted_score
            FROM corrections
            INNER JOIN projects
                ON corrections.project_id = projects.id
            WHERE corrections.user_id = user_id;

        SELECT SUM(projects.weight)
            INTO total_weight
            FROM corrections
            INNER JOIN projects
                ON corrections.project_id = projects.id
            WHERE corrections.user_id = user_id;

        -- If the total weight is 0, set the average score to 0 for this user
        IF total_weight = 0 THEN
            UPDATE users
                SET users.average_score = 0
                WHERE users.id = user_id;
        ELSE
            -- Otherwise, update the average score for this user
            UPDATE users
                SET users.average_score = total_weighted_score / total_weight
                WHERE users.id = user_id;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END $$
DELIMITER ;

