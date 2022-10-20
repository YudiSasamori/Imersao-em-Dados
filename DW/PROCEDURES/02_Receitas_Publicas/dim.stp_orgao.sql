USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stparea]    Script Date: 11/07/2022 21:56:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stp_orgao]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_orgao') IS NOT NULL) 
		DROP TABLE DW.dim.temp_orgao

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	 CODIGO_ORGAO      AS [cd_orgao]
	,NOME_ORGAO        AS [nm_orgao]
	,ORIGEM            AS [ds_origem]
INTO DW.dim.temp_orgao  
FROM BI_Staging.[stg].[Receitas_publicas]


DELETE Destino
      FROM [dim].[orgao] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_orgao     Origem -- TABELA TEMPORARIA (Origem)
                         WHERE Origem.cd_orgao	          = Destino.cd_orgao AND
							   Origem.ds_origem           = Destino.ds_origem 
							 );
								
								
	MERGE dim.orgao   	       AS Destino
    USING DW.dim.temp_orgao    AS Origem
    ON (Origem.cd_orgao       = Destino.cd_orgao AND
        Origem.nm_orgao       = Destino.nm_orgao 
		)
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_orgao]						= Origem.[nm_orgao]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ( [cd_orgao]
			   , [nm_orgao]
			   , [ds_origem])
		VALUES ( Origem.[cd_orgao]
			   , Origem.[nm_orgao]
			   , Origem.[ds_origem]);
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_orgao') IS NOT NULL) 
		DROP TABLE DW.dim.temp_orgao
		
END;