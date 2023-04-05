-- script that creates a table users following these requirements
-- id,email,name,country(enumeration of US, CO, TN)
CREATE TABLE IF NOT EXISTS users (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255),
	country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'
	);
