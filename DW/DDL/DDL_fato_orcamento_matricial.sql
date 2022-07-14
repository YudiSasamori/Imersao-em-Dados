 CREATE TABLE fato.orcamento_matricial(
		  dt_data               DATE
		 ,cd_conta_cantabil     INT
		 ,cd_area               INT
		 ,cd_pacote             INT
		 ,cd_centro_custo       INT
		 ,ds_debito_credito     VARCHAR(2)
		 ,vl_valor_lancto       FLOAT(16)
		 ,ds_origem             VARCHAR(50)
		 ,cd_diretor            INT
		 ,cd_gerente            INT
		 )