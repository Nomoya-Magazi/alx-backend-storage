-- a SQL script that creates a stored procedure AddBonus that adds a new correction for a student.
DELIMITER $$ ;
CREATE PROCEDURE AddBonus(
	IN p_user_id INT,
	IN p_project_name VARCHAR(255),
	IN P_score INT
)
BEGIN
	DECLARE project_id INT;

-- Check if project exists or create it
    SELECT id INTO project_id FROM projects WHERE name = p_project_name;
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;
    
    -- Add correction for student
    INSERT INTO corrections (user_id, project_id, score) VALUES (p_user_id, project_id, p_score);
END$$
DELIMITER ;
aii
