ALTER VIEW [dbo].[vw.fato_aplicacoes] AS

select    
        A.id_pessoa,
        B.nm_nome,
        B.nm_sobrenome,
        C.id as id_profissao,
        C.ds_profissao,
        D.id as id_investimento,
        D.ds_tipo_investimento,
        E.id as id_cor,
        E.nm_cor,
        F.id_data,
        F.dt_data,
        G.id as id_emocao,
        G.ds_emocao,
        H.id as id_faculdade,
        H.ds_nome as nm_faculdade
from fato.aplicacoes A
LEFT JOIN dim.pessoa B ON A.id_pessoa = B.id
LEFT JOIN dim.profissao C ON C.id = A.id_profissao
LEFT JOIN dim.investimentos D ON D.id = A.id_investimento
LEFT JOIN dim.cor_preferida E ON E.id = A.id_cor
LEFT JOIN dim.calendario F ON F.id_data = A.id_data
LEFT JOIN dim.emocao G ON G.id = A.id_emocao
LEFT JOIN dim.faculdade H on H.id = A.id_faculdade
where 1=1