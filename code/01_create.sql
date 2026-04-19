DROP DATABASE IF EXISTS supcount;
CREATE DATABASE supcount;

USE supcount;

CREATE TABLE utilisateur (
  id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
  email          VARCHAR(255) NOT NULL,
  mot_de_passe   VARCHAR(255) NOT NULL,
  nom_affiche    VARCHAR(100) NOT NULL,
  cree_le        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE groupe (
  id_groupe   INT AUTO_INCREMENT PRIMARY KEY,
  nom         VARCHAR(120) NOT NULL,
  cree_le     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  cree_par    INT NOT NULL,
  CONSTRAINT fk_groupe_cree_par
    FOREIGN KEY (cree_par) REFERENCES utilisateur(id_utilisateur)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE membre_groupe (
  id_groupe      INT NOT NULL,
  id_utilisateur INT NOT NULL,
  rejoint_le     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  role           ENUM('OWNER','MEMBER') NOT NULL DEFAULT 'MEMBER',
  PRIMARY KEY (id_groupe, id_utilisateur),
  CONSTRAINT fk_membre_groupe_groupe
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_membre_groupe_utilisateur
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE categorie (
  id_categorie INT AUTO_INCREMENT PRIMARY KEY,
  nom          VARCHAR(60) NOT NULL,
  UNIQUE (nom)
) ENGINE=InnoDB;

CREATE TABLE depense (
  id_depense     INT AUTO_INCREMENT PRIMARY KEY,
  id_groupe      INT NOT NULL,
  id_payeur      INT NOT NULL,
  id_categorie   INT NOT NULL,
  libelle        VARCHAR(140) NOT NULL,
  date_depense   DATE NOT NULL,
  montant_total  DECIMAL(10,2) NOT NULL,
  justificatif_url VARCHAR(500) NULL,

  CONSTRAINT fk_depense_groupe
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_depense_payeur
    FOREIGN KEY (id_payeur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE RESTRICT ON UPDATE CASCADE,

  CONSTRAINT fk_depense_categorie
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE depense_participant (
  id_depense     INT NOT NULL,
  id_utilisateur INT NOT NULL,
  montant_part   DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_depense, id_utilisateur),

  CONSTRAINT fk_part_depense
    FOREIGN KEY (id_depense) REFERENCES depense(id_depense)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_part_utilisateur
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE remboursement (
  id_remboursement INT AUTO_INCREMENT PRIMARY KEY,
  id_groupe        INT NOT NULL,
  id_debiteur      INT NOT NULL,
  id_crediteur     INT NOT NULL,
  date_remboursement DATE NOT NULL,
  montant          DECIMAL(10,2) NOT NULL,
  note             VARCHAR(200) NULL,

  CONSTRAINT fk_remb_groupe
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_remb_debiteur
    FOREIGN KEY (id_debiteur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE RESTRICT ON UPDATE CASCADE,

  CONSTRAINT fk_remb_crediteur
    FOREIGN KEY (id_crediteur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

SHOW TABLES;

