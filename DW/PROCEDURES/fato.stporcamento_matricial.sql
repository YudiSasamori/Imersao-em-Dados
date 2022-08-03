USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stppacote]    Script Date: 11/07/2022 23:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [fato].[stporcamento_matricial]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.fato.temp_orcamento_matricial

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT
	 CAST(Data AS date)       AS dt_data
		,CONTA_REDUZIDA       AS cd_conta_cantabil
		,COD_AREA             AS cd_area
		,COD_PACOTE           AS cd_pacote
		,COD_CENTRO_CUSTO     AS cd_centro_custo
		,DEBITO_CREDITO       AS ds_debito_credito
		,VALOR_LANCTO         AS vl_valor_lancto
		,ORIGEM               AS ds_origem
		,COD_DIRETOR          AS cd_diretor
		,COD_GERENTE          AS cd_gerente
INTO DW.fato.temp_orcamento_matricial 
FROM BI_Staging.[stg].[OM_SYM_COMPANY]


TRUNCATE TABLE fato.orcamento_matricial

INSERT INTO fato.orcamento_matricial
SELECT * FROM DW.fato.temp_orcamento_matricial 


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.dim.temp_orcamento_matricial
	
END;
