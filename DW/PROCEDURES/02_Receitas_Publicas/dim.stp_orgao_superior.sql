USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stparea]    Script Date: 11/07/2022 21:56:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stp_orgao_superior]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_orgao_superior') IS NOT NULL) 
		DROP TABLE DW.dim.temp_orgao_superior

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	 CODIGO_ORGAO_SUPERIOR     AS [cd_orgao_superior]
	,NOME_ORGAO_SUPERIOR       AS [nm_orgao_superior]
	,ORIGEM                    AS [ds_origem]
INTO DW.dim.temp_orgao_superior  
FROM BI_Staging.[stg].[Receitas_publicas]


DELETE Destino
      FROM [dim].[orgao_superior] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_orgao_superior Origem -- TABELA TEMPORARIA (Origem)
                         WHERE Origem.cd_orgao_superior	   = Destino.cd_orgao_superior AND
							   Origem.ds_origem            = Destino.ds_origem 
							 );
								
								
	MERGE dim.orgao_superior	        AS Destino
    USING DW.dim.temp_orgao_superior    AS Origem
    ON (Origem.cd_orgao_superior       = Destino.cd_orgao_superior AND
        Origem.nm_orgao_superior       = Destino.nm_orgao_superior 
		)
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_orgao_superior]						= Origem.[nm_orgao_superior]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ( [cd_orgao_superior]
			   , [nm_orgao_superior]
			   , [ds_origem])
		VALUES ( Origem.[cd_orgao_superior]
			   , Origem.[nm_orgao_superior]
			   , Origem.[ds_origem]);
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_orgao_superior') IS NOT NULL) 
		DROP TABLE DW.dim.temp_orgao_superior
		
END;