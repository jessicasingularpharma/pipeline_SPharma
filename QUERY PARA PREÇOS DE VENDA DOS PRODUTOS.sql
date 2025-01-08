
SELECT "PD1"."CDPRO" AS "CDPRO",
       "PD1"."DESCR" AS "DESCR",
       "PD1"."GRUPO" AS "GRUPO",
       "PD1"."CDPRO" AS "CDPRI",
       "PD1"."UNIDA" AS "UNIDA",
       "PD1"."PRVEN" AS "PRVEN",
       "PD1"."PORTA" AS "PORTA"
FROM "temporary"."FC03000" "PD1"
UNION
SELECT "S"."CDSIN" AS "CDPRO",
       "S"."DESCR" AS "DESCR",
       'S' AS "GRUPO",
       "S"."CDPRO" AS "CDPRI",
       (SELECT "UNIDA" FROM "temporary"."FC03000" WHERE "CDPRO" = "S"."CDPRO") AS "UNIDA",
       (SELECT "PRVEN" FROM "temporary"."FC03000" WHERE "CDPRO" = "S"."CDPRO") AS "PRVEN",
       (SELECT "PORTA" FROM "temporary"."FC03000" WHERE "CDPRO" = "S"."CDPRO") AS "PORTA"
FROM "temporary"."FC03200" "S"
INNER JOIN "temporary"."FC03000" "PD2" ON ("S"."CDPRO" = "PD2"."CDPRO" AND "PD2"."INDDEL" = 'N')
ORDER BY 2;
