/*Qual pessoa realizou maior investimento no mes de março e qual a pessoa realizou menor investimento no mes de abril*/




SELECT * FROM dim.calendario
SELECT * FROM dim.cor_preferida
SELECT * FROM dim.emocao
SELECT * FROM dim.faculdade
SELECT * FROM dim.investimentos
SELECT * FROM dim.pessoa
SELECT * FROM dim.profissao
SELECT * FROM fato.aplicacoes



SELECT 
	 A.id_pessoa
	,A.id_profissao
	,A.id_investimento
	,A.id_cor
	,A.id_faculdade
	,A.id_data
	,A.id_emocao
	,A.valor
FROM fato.aplicacoes A
LEFT JOIN dim.pessoa B ON A.id_pessoa = B.id



USE Banco_Teste

SELECT 
	 CONCAT(B.nm_nome, ' ',B.nm_sobrenome)     AS NOME
	--,C.ds_tipo_investimento                    AS INVESTIMENTO
	,CAST(D.dt_data AS date)                   AS DATA
	,SUM(A.valor)                              AS VALOR
FROM fato.aplicacoes          A
LEFT JOIN dim.pessoa          B   ON  A.id_pessoa        =  B.id
LEFT JOIN dim.investimentos   C   ON  A.id_investimento  =  C.id
LEFT JOIN dim.calendario      D   ON  A.id_data         =  D.id_data
WHERE 1=1
	AND MONTH(D.dt_data) = '03'
	--AND MONTH(D.dt_data) = '04'
GROUP BY CONCAT(B.nm_nome, ' ',B.nm_sobrenome)
--	    ,C.ds_tipo_investimento
		,CAST(D.dt_data AS date)
ORDER BY VALOR DESC