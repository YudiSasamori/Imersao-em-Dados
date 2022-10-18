USE [BI_Staging]
GO
/****** Object:  StoredProcedure [stg].[stpOM_SYM_COMPANY]    Script Date: 12/07/2022 21:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [stg].[stpReceitas_Publicas]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_Receitas_Publicas') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_Receitas_Publicas

-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA
SELECT * INTO BI_Staging.stg.temp_Receitas_Publicas 
FROM(
	SELECT * FROM [PROD].[dbo].[2020_Receitas]
	UNION ALL
	SELECT * FROM [PROD].[dbo].[2021_Receitas]
	UNION ALL
	SELECT * FROM [PROD].[dbo].[2022_Receitas]
	) A


-- GARANTE QUE A TABELA DESTINO NO BI_STAGING ESTEJA LIMPA
TRUNCATE TABLE [stg].[Receitas_Publicas]

-- GARANTINDO QUE ESTÁ LIMPO, INSERIMOS TODOS OS DADOS NOVAMENTE, A PARTIR DA TABELA TEMPORARIA
INSERT INTO [stg].[Receitas_Publicas]
SELECT * FROM BI_Staging.stg.temp_Receitas_Publicas 

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_Receitas_Publicas ') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_Receitas_Publicas 

END;
