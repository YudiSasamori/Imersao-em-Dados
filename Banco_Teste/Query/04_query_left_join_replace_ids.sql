SELECT * FROM fato.aplicacoes
SELECT * FROM dim.pessoa
SELECT * FROM dim.profissao
SELECT * FROM dim.investimentos
SELECT * FROM dim.cor_preferida
SELECT * FROM dim.faculdade
SELECT * FROM dim.calendario
SELECT * FROM dim.emocao


SELECT 
	 id_pessoa
	,id_profissao
	,id_investimento
	,id_cor
	,id_faculdade
	,id_data
	,id_emocao
FROM fato.aplicacoes A



SELECT 
	 CONCAT(B.nm_nome,' ', B.nm_sobrenome)   AS NOME_COMPLETO
	,CONCAT(B.nm_cidade, '-',B.nm_estado)    AS CIDADE_ESTADO
	,C.ds_profissao                          AS PROFISSAO
	,D.ds_tipo_investimento                  AS INVESTIMENTOS
	,E.nm_cor                                AS COR
	,F.ds_nome                               AS FACULDADE
	,CAST(H.dt_data AS date)                 AS DATA
	,I.ds_emocao                             AS EMOCAO
FROM fato.aplicacoes          A
LEFT JOIN dim.pessoa          B    ON  A.id_pessoa        =  B.id
LEFT JOIN dim.profissao       C    ON  A.id_profissao     =  C.id
LEFT JOIN dim.investimentos   D    ON  A.id_investimento  =  D.id
LEFT JOIN dim.cor_preferida   E    ON  A.id_cor           =  E.id
LEFT JOIN dim.faculdade       F    ON  A.id_faculdade     =  F.id
LEFT JOIN dim.calendario      H    ON  A.id_data          =  H.id_data
LEFT JOIN dim.emocao          I    ON  A.id_emocao        =  I.id

