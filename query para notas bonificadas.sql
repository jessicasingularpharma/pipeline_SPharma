-- Adicionar a nova coluna para categorizar as notas
ALTER TABLE gold.combined_notasfiscais
ADD COLUMN "BONIF" character varying(10);

-- Atualizar a nova coluna para as notas bonificadas
UPDATE gold.combined_notasfiscais
SET "BONIF" = 'BONIF'
WHERE "NRNOT" IN ('83947','582007','11608','85073','752946','752946','886238','151252','757840','154535','158161',
'6515','56848','762430','762212','7299','7570','184707','190308','88286','200239','772530','773363','22287','776404',
'227351','228375','131227','233091','234398','8885','252518','254689','254689','5287','263789','261024','27451','490515',
'292265','797285','299827','798883','803907','583923','348913','139760','822181','1203','132231','435563','841785',
'463594','855910','497010','172282','55394','128759','865784','867342','56689','549022','548647','869960','56689',
'568209','569969');

-- Atualizar as notas não bonificadas
UPDATE gold.combined_notasfiscais
SET "BONIF" = 'NF'
WHERE "BONIF" IS NULL;



