SELECT row_to_json(resultados) AS output_json
FROM (
	SELECT 
		ficha_producao.*,
		utilizador.*,
		tipo_mao_obra.*,
		(ficha_producao.horas * tipo_mao_obra.custo) AS custo_total,
		jsonb_agg(jsonb_build_object(
			'detalhe_ficha_producao', detalhe_ficha_producao.*,
			'componente', componente.*,
			'tipo_componente', tipo_componente.*,
			'armazem', armazem.*
		)) AS componentes
	FROM ficha_producao
	JOIN utilizador
		ON ficha_producao.utilizador_id = utilizador.id
	JOIN detalhe_ficha_producao
		ON ficha_producao.id = detalhe_ficha_producao.ficha_producao_id
	JOIN componente
		ON detalhe_ficha_producao.componente_id = componente.id
	JOIN tipo_mao_obra
		ON ficha_producao.tipo_mao_obra_id = tipo_mao_obra.id
	JOIN tipo_componente
		ON componente.tipo_id = tipo_componente.id
	JOIN armazem
		ON componente.armazem_id = armazem.id
	GROUP BY ficha_producao.id, utilizador.id, tipo_mao_obra.id
) AS resultados;