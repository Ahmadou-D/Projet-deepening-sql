USE supcount;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE depense_participant;
TRUNCATE TABLE depense;
TRUNCATE TABLE membre_groupe;
TRUNCATE TABLE remboursement;
TRUNCATE TABLE groupe;
TRUNCATE TABLE categorie;
TRUNCATE TABLE utilisateur;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO utilisateur (email, mot_de_passe, nom_affiche) VALUES
('louise@mail.com','hash','Louise'),
('maxime@mail.com','hash','Maxime'),
('rosa@mail.com','hash','Rosa'),
('karl@mail.com','hash','Karl'),
('emma@mail.com','hash','Emma'),
('paul@mail.com','hash','Paul'),
('nina@mail.com','hash','Nina'),
('leo@mail.com','hash','Leo'),
('jade@mail.com','hash','Jade'),
('tom@mail.com','hash','Tom'),
('sara@mail.com','hash','Sara'),
('alex@mail.com','hash','Alex');

INSERT INTO categorie (nom) VALUES
('Transport'), ('Logement'), ('Courses'), ('Restaurant'), ('Activités');

INSERT INTO groupe (nom, cree_par) VALUES
('Week-end Suisse', 1),
('Colocation Paris', 5),
('Vacances Espagne', 8),
('Projet Startup', 11);

INSERT INTO membre_groupe VALUES
(1,1,NOW(),'OWNER'),(1,2,NOW(),'MEMBER'),(1,3,NOW(),'MEMBER'),(1,4,NOW(),'MEMBER'),
(2,5,NOW(),'OWNER'),(2,6,NOW(),'MEMBER'),(2,7,NOW(),'MEMBER'),
(3,8,NOW(),'OWNER'),(3,9,NOW(),'MEMBER'),(3,10,NOW(),'MEMBER'),
(4,11,NOW(),'OWNER'),(4,12,NOW(),'MEMBER'),(4,1,NOW(),'MEMBER');

INSERT INTO depense (id_groupe,id_payeur,id_categorie,libelle,date_depense,montant_total) VALUES

(1,1,1,'Essence','2024-06-01',350),
(1,2,2,'Airbnb','2024-06-01',400),
(1,3,3,'Courses','2024-06-02',150),
(1,4,5,'Activités','2024-06-02',200),
(1,1,4,'Restaurant','2024-06-03',180),

(2,5,2,'Loyer Juin','2024-06-01',900),
(2,6,3,'Courses semaine','2024-06-02',120),
(2,7,1,'Carte Navigo','2024-06-03',75),
(2,5,4,'Dîner coloc','2024-06-04',60),
(2,6,5,'Internet','2024-06-05',45),

(3,8,1,'Vol aller','2024-07-01',300),
(3,9,2,'Hôtel','2024-07-01',450),
(3,10,3,'Courses','2024-07-02',90),
(3,8,5,'Excursion','2024-07-03',210),
(3,9,4,'Restaurant tapas','2024-07-03',150),

(4,11,1,'Co-working','2024-08-01',150),
(4,12,4,'Déjeuner client','2024-08-01',90),
(4,1,5,'Outils SaaS','2024-08-02',60),
(4,11,3,'Fournitures','2024-08-03',45),
(4,12,2,'Hébergement site','2024-08-03',30);

INSERT INTO depense_participant VALUES

(1,1,87.5),(1,2,87.5),(1,3,87.5),(1,4,87.5),
(2,1,100),(2,2,100),(2,3,100),(2,4,100),
(3,1,37.5),(3,2,37.5),(3,3,37.5),(3,4,37.5),
(4,1,50),(4,2,50),(4,3,50),(4,4,50),
(5,1,45),(5,2,45),(5,3,45),(5,4,45),

(6,5,300),(6,6,300),(6,7,300),
(7,5,40),(7,6,40),(7,7,40),
(8,5,25),(8,6,25),(8,7,25),
(9,5,20),(9,6,20),(9,7,20),
(10,5,15),(10,6,15),(10,7,15),

(11,8,100),(11,9,100),(11,10,100),
(12,8,150),(12,9,150),(12,10,150),
(13,8,30),(13,9,30),(13,10,30),
(14,8,70),(14,9,70),(14,10,70),
(15,8,50),(15,9,50),(15,10,50),

(16,11,50),(16,12,50),(16,1,50),
(17,11,30),(17,12,30),(17,1,30),
(18,11,20),(18,12,20),(18,1,20),
(19,11,15),(19,12,15),(19,1,15),
(20,11,10),(20,12,10),(20,1,10);

SELECT COUNT(*) AS nb_utilisateurs FROM utilisateur;
SELECT COUNT(*) AS nb_groupes FROM groupe;

SELECT id_groupe, COUNT(*) AS nb_membres
FROM membre_groupe
GROUP BY id_groupe;

SELECT id_groupe, COUNT(*) AS nb_depenses
FROM depense
GROUP BY id_groupe;

SELECT d.id_depense
FROM depense d
LEFT JOIN depense_participant dp ON dp.id_depense = d.id_depense
GROUP BY d.id_depense
HAVING COUNT(dp.id_utilisateur) = 0;

