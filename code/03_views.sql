USE supcount;


CREATE VIEW vue_depenses_groupe AS
SELECT
  g.nom AS groupe,
  d.id_depense,
  d.libelle,
  d.date_depense,
  d.montant_total,
  u.nom_affiche AS payeur,
  c.nom AS categorie
FROM depense d
JOIN groupe g ON d.id_groupe = g.id_groupe
JOIN utilisateur u ON d.id_payeur = u.id_utilisateur
JOIN categorie c ON d.id_categorie = c.id_categorie;


SELECT * FROM vue_depenses_groupe;

CREATE VIEW vue_total_paye AS
SELECT
  g.nom AS groupe,
  u.nom_affiche AS utilisateur,
  SUM(d.montant_total) AS total_paye
FROM depense d
JOIN groupe g ON d.id_groupe = g.id_groupe
JOIN utilisateur u ON d.id_payeur = u.id_utilisateur
GROUP BY g.nom, u.nom_affiche;

SELECT * FROM vue_total_paye;


CREATE VIEW vue_total_du AS
SELECT
  g.nom AS groupe,
  u.nom_affiche AS utilisateur,
  SUM(dp.montant_part) AS total_du
FROM depense_participant dp
JOIN depense d ON dp.id_depense = d.id_depense
JOIN groupe g ON d.id_groupe = g.id_groupe
JOIN utilisateur u ON dp.id_utilisateur = u.id_utilisateur
GROUP BY g.nom, u.nom_affiche;

SELECT * FROM vue_total_du;


CREATE VIEW vue_solde_utilisateur AS
SELECT
  p.groupe,
  p.utilisateur,
  IFNULL(p.total_paye,0) - IFNULL(d.total_du,0) AS solde
FROM vue_total_paye p
LEFT JOIN vue_total_du d
  ON p.groupe = d.groupe
 AND p.utilisateur = d.utilisateur;

SELECT * FROM vue_solde_utilisateur;
