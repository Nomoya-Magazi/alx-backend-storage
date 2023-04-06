-- a SQL script that creates a stored procedure ComputeAverageScoreForUser that computes and store the average score for a student.
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser (
 IN p_user_id INT
)
BEGIN
    DECLARE avg_score DECIMAL(10,2);
    
    -- Compute average score for user
    SELECT AVG(score) INTO avg_score FROM corrections WHERE user_id = p_user_id;
    
    -- Update user's average score
    UPDATE users SET average_score = avg_score WHERE id = p_user_id;
END$$
DELIMITER ;	
