CREATE TABLE IF NOT EXISTS gold.laboratorio
(
    "TPLAB" text,
    "DESCRLAB" text,
    "TPFORMAFARMA" text
);

INSERT INTO gold.laboratorio ("TPLAB", "DESCRLAB", "TPFORMAFARMA")
SELECT a."TPLAB", a."DESCRLAB", b."TPFORMAFARMA"
FROM temporary."FC0D000" a
LEFT JOIN temporary."FC0D100" b ON a."TPLAB" = b."TPLAB";
