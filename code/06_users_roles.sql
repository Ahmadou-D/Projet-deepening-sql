USE supcount;

CREATE ROLE IF NOT EXISTS role_app;
CREATE ROLE IF NOT EXISTS role_admin;
CREATE ROLE IF NOT EXISTS role_readonly;

GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.utilisateur TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.groupe TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.membre_groupe TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.categorie TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.depense TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.depense_participant TO role_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON supcount.remboursement TO role_app;

GRANT SELECT ON supcount.* TO role_readonly;

GRANT ALL PRIVILEGES ON supcount.* TO role_admin;

CREATE USER IF NOT EXISTS 'supcount_app'@'localhost' IDENTIFIED BY 'App#2025!';
CREATE USER IF NOT EXISTS 'supcount_admin'@'localhost' IDENTIFIED BY 'Admin#2025!';
CREATE USER IF NOT EXISTS 'supcount_read'@'localhost' IDENTIFIED BY 'Read#2025!';

GRANT role_app TO 'supcount_app'@'localhost';
GRANT role_admin TO 'supcount_admin'@'localhost';
GRANT role_readonly TO 'supcount_read'@'localhost';

SET DEFAULT ROLE role_app TO 'supcount_app'@'localhost';
SET DEFAULT ROLE role_admin TO 'supcount_admin'@'localhost';
SET DEFAULT ROLE role_readonly TO 'supcount_read'@'localhost';

SHOW GRANTS FOR 'supcount_app'@'localhost';
SHOW GRANTS FOR 'supcount_admin'@'localhost';
SHOW GRANTS FOR 'supcount_read'@'localhost';
