USE supcount;
DELIMITER $$

CREATE PROCEDURE ajouter_depense (
  IN p_id_groupe INT,
  IN p_id_payeur INT,
  IN p_id_categorie INT,
  IN p_libelle VARCHAR(140),
  IN p_date DATE,
  IN p_montant DECIMAL(10,2)
)
BEGIN
  INSERT INTO depense
    (id_groupe, id_payeur, id_categorie, libelle, date_depense, montant_total)
  VALUES
    (p_id_groupe, p_id_payeur, p_id_categorie, p_libelle, p_date, p_montant);
END$$

DELIMITER ;

CALL ajouter_depense(1,1,1,'Taxi retour','2024-06-04',60);

DELIMITER $$

CREATE PROCEDURE total_depense_utilisateur (
  IN p_id_groupe INT
)
BEGIN
  SELECT
    u.nom_affiche AS utilisateur,
    SUM(d.montant_total) AS total_paye
  FROM depense d
  JOIN utilisateur u ON d.id_payeur = u.id_utilisateur
  WHERE d.id_groupe = p_id_groupe
  GROUP BY u.nom_affiche;
END$$

DELIMITER ;


