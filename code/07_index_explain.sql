USE supcount;

EXPLAIN
SELECT id_depense, id_groupe, date_depense, montant_total
FROM depense
WHERE id_groupe = 1
ORDER BY date_depense;

CREATE INDEX idx_depense_groupe_date
ON depense (id_groupe, date_depense);

EXPLAIN
SELECT id_depense, id_groupe, date_depense, montant_total
FROM depense
WHERE id_groupe = 1
ORDER BY date_depense;
