USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stp_unidade_gestora]    Script Date: 20/10/2022 23:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stp_unidade_gestora]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_unidade_gestora') IS NOT NULL) 
		DROP TABLE DW.dim.temp_unidade_gestora

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	 CODIGO_UNIDADE_GESTORA     AS [cd_unidade_gestora]
	,NOME_UNIDADE_GESTORA       AS [nm_unidade_gestora]
	,ORIGEM                     AS [ds_origem]
INTO DW.dim.temp_unidade_gestora  
FROM BI_Staging.[stg].[Receitas_publicas]



DELETE Destino
      FROM [dim].[unidade_gestora] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_unidade_gestora Origem -- TABELA TEMPORARIA (Origem)
                          WHERE Origem.cd_unidade_gestora  = Destino.cd_unidade_gestora
						   AND  Origem.ds_origem           = Destino.ds_origem 
						);
								
								
	MERGE dim.unidade_gestora	        AS Destino
    USING DW.dim.temp_unidade_gestora   AS Origem
		ON (Origem.cd_unidade_gestora  = Destino.cd_unidade_gestora AND
            Origem.ds_origem           = Destino.ds_origem
		   )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_unidade_gestora]	= Origem.[nm_unidade_gestora]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ( [cd_unidade_gestora]
			   , [nm_unidade_gestora]
			   , [ds_origem])
		VALUES ( Origem.[cd_unidade_gestora]
			   , Origem.[nm_unidade_gestora]
			   , Origem.[ds_origem]);
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_unidade_gestora') IS NOT NULL) 
		DROP TABLE DW.dim.temp_unidade_gestora
		
END;
