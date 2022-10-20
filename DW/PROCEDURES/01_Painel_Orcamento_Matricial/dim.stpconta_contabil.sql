USE [DW]
GO
/****** Object:  StoredProcedure [stg].[stpOM_Mesasamori]    Script Date: 08/07/2022 21:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpconta_contabil]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_conta_contabil') IS NOT NULL) 
		DROP TABLE DW.dim.temp_conta_contabil

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	 CONTA_REDUZIDA  AS cd_conta
	,DESC_CONTA      AS ds_conta_contabil
	,ORIGEM          AS [ds_origem]
INTO DW.dim.temp_conta_contabil  
FROM BI_Staging.[stg].[OM_SYM_COMPANY]



DELETE Destino
      FROM dim.conta_contabil Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_conta_contabil Origem -- TABELA TEMPORARIA
                         WHERE Origem.cd_conta	           = Destino.cd_conta AND
							   Origem.ds_origem		       = Destino.ds_origem 
							 );
								
								
	MERGE dim.conta_contabil		    AS Destino
    USING DW.dim.temp_conta_contabil	AS Origem
    ON (Destino.cd_conta	          = Origem.cd_conta AND
		Destino.ds_origem			  = Origem.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[ds_conta_contabil]						= Origem.[ds_conta_contabil]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ([cd_conta]
			 , [ds_conta_contabil]
			 , [ds_origem])
		VALUES ( Origem.[cd_conta]
				, Origem.[ds_conta_contabil]
				, Origem.[ds_origem]);
			



-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_conta_contabil') IS NOT NULL) 
		DROP TABLE DW.dim.temp_conta_contabil
		
END;

--select * from dim.conta_contabil
--select * from DW.dim.temp_conta_contabil

