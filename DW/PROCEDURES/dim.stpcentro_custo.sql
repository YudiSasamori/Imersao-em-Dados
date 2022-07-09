USE [DW]
GO
/****** Object:  StoredProcedure [stg].[stpOM_Mesasamori]    Script Date: 08/07/2022 21:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpcentro_custo]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_centro_custo') IS NOT NULL) 
		DROP TABLE DW.dim.temp_centro_custo

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	 COD_CENTRO_CUSTO  AS cd_centro_custo
	,DESC_CC           AS ds_cc
	,ORIGEM            AS [ds_origem]
INTO DW.dim.temp_centro_custo  
FROM BI_Staging.[stg].[OM_SYM_COMPANY]



DELETE Destino
      FROM [dim].[centro_custo] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_centro_custo Origem -- TABELA TEMPORARIA
                         WHERE Origem.cd_centro_custo	   = Destino.cd_centro_custo AND
							   Origem.ds_origem		       = Destino.ds_origem 
							 );
								
								
	MERGE dim.centro_custo		        AS Destino
    USING DW.dim.temp_centro_custo	    AS Origem
    ON (Destino.cd_centro_custo	      = Origem.cd_centro_custo AND
		Destino.ds_origem			  = Origem.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[ds_cc]						= Origem.[ds_cc]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ([cd_centro_custo]
			 , [ds_cc]
			 , [ds_origem])
		VALUES ( Origem.[cd_centro_custo]
				, Origem.[ds_cc]
				, Origem.[ds_origem]);
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_centro_custo') IS NOT NULL) 
		DROP TABLE DW.dim.temp_centro_custo
		
END;

