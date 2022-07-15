USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stppacote]    Script Date: 11/07/2022 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SELECT * FROM BI_Staging.stg.OM_Metas_SYM_COMPANY

ALTER PROCEDURE [fato].[stp.OM_metas]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_OM_metas') IS NOT NULL) 
		DROP TABLE DW.fato.temp_OM_metas

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA

SELECT DISTINCT 
	 CAST(Data AS date)   AS dt_data
	,COD_CENTRO_CUSTO     AS cd_centro_custo
	,CONTA_REDUZIDA       AS cd_conta_reduzida
	,META                 AS ds_meta
	,ORIGEM               AS ds_origem
INTO DW.fato.temp_OM_metas 
FROM BI_Staging.[stg].[OM_Metas_SYM_COMPANY]


TRUNCATE TABLE fato.OM_metas

INSERT INTO fato.OM_metas
SELECT * FROM DW.fato.temp_OM_metas  


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_OM_metas ') IS NOT NULL) 
		DROP TABLE DW.fato.temp_OM_metas 
	
END;
