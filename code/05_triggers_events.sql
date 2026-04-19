USE supcount;

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE TRIGGER trg_depense_payeur_membre
BEFORE INSERT ON depense
FOR EACH ROW
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM membre_groupe
    WHERE id_groupe = NEW.id_groupe
      AND id_utilisateur = NEW.id_payeur
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Payeur non membre du groupe';
  END IF;
END$$


CREATE TRIGGER trg_depense_montant_positif
BEFORE INSERT ON depense
FOR EACH ROW
BEGIN
  IF NEW.montant_total <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Montant de depense invalide';
  END IF;
END$$

CREATE TRIGGER trg_remboursement_montant_positif
BEFORE INSERT ON remboursement
FOR EACH ROW
BEGIN
  IF NEW.montant <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Montant de remboursement invalide';
  END IF;
END$$

DELIMITER ;

CREATE TABLE IF NOT EXISTS invitation (
  id_invitation INT AUTO_INCREMENT PRIMARY KEY,
  id_groupe INT NOT NULL,
  email_invite VARCHAR(255) NOT NULL,
  cree_le DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expire_le DATETIME NOT NULL,
  CONSTRAINT fk_invitation_groupe
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe)
    ON DELETE CASCADE
) ENGINE=InnoDB;

DELIMITER $$

CREATE EVENT ev_purge_invitations
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  DELETE FROM invitation
  WHERE expire_le < NOW();
END$$

DELIMITER ;


CREATE TABLE IF NOT EXISTS depense_archive LIKE depense;


DELIMITER $$

CREATE EVENT ev_archive_depenses
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
  INSERT INTO depense_archive
  SELECT *
  FROM depense
  WHERE date_depense < DATE_SUB(CURDATE(), INTERVAL 12 MONTH);

  DELETE FROM depense
  WHERE date_depense < DATE_SUB(CURDATE(), INTERVAL 12 MONTH);
END$$

DELIMITER ;

SHOW TRIGGERS;
SHOW EVENTS;



