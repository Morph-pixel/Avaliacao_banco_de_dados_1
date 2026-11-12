-- Questao 1: 
--Quantas linhas da tabela fato_vendas não têm cliente identificado (id_cliente vazio)? 
SELECT COUNT (*) 
FROM fato_vendas 
WHERE id_cliente is NULL; 
-- Resposta: 906 

-- Questao 2: 
-- Quantos clientes diferentes aparecem na tabela fato_vendas? 
SELECT COUNT (DISTINCT id_cliente) AS clientes_separados 
FROM fato_vendas; 

-- Resposta: 746 

--Questao 3: 
--Qual foi o faturamento total (soma de valor_total) de todas as vendas de 2025? 
SELECT SUM(valor_total) AS total_2025
FROM fato_vendas 
WHERE data_venda BETWEEN '2025-01-01' and '2025-12-31'; 
--Resposta: 388250.31 

--Questao 4:
--Liste, sem repetição e em ordem alfabética, as marcas dos produtos da categoria Higiene. 
SELECT DISTINCT marca AS marcas_higiene 
FROM dim_produto 
WHERE categoria = 'Higiene' 
ORDER BY marca ASC;
/* 
Resposta: 
"Colgate"
"Dove"
"Elseve"
"Huggies"
"Lux"
"Mili"
"Neve"
"Nivea"
"Oral-B"
"Pampers"
"Pantene"
"Personal"
"Protex"
"Rexona"
"Seda"
"Sorriso"
*/ 

--Questao 5: 
--Qual é o valor médio de valor_total das vendas do canal Aplicativo?
SELECT AVG(valor_total) AS med_apli
FROM fato_vendas 
WHERE canal = 'Aplicativo'; 

--Resposta: 
--52.2665833630846126 

--Questao 6: 
--Quantos produtos da categoria Bebidas têm preco_tabela acima de R$ 10,00? 
SELECT COUNT(id_produto) AS bed_10 
FROM dim_produto 
WHERE preco_tabela > 10.0 AND categoria = 'Bebidas';
--Resposta:20 

--Questao 7: 
--Mostre o nome, a marca e o preço de tabela do produto mais caro do catálogo. Em caso
--de empate no preço, traga o primeiro em ordem alfabética de nome
SELECT nome_produto,marca,preco_tabela
FROM dim_produto 
ORDER BY preco_tabela DESC,nome_produto ASC 
LIMIT 1; 
-- Resposta:"Ração para Cães 10kg"	"Premier" 140.29 

--Questao 8: 
--Quantos produtos existem em cada categoria? Ordene da categoria com mais produtos
--para a com menos; em caso de empate, por nome da categoria(A–Z) 
SELECT categoria,
COUNT(*) AS quantidade_produtos
FROM dim_produto
GROUP BY categoria
ORDER BY quantidade_produtos DESC, categoria ASC; 
/* 
Resposta: 
"Mercearia"	49
"Bebidas"	39
"Higiene"	34
"Laticínios"	32
"Limpeza"	27
"Congelados"	20
"Carnes"	13
"Padaria"	10
"Hortifruti"	8
"Pet"	8 
*/

--Questao 9: 
-- Qual é o preço médio de tabela de cada categoria? ordene do maior preço médio para o
--menor. 
SELECT categoria, 
AVG(preco_tabela) AS media_produtos
FROM dim_produto
GROUP BY categoria
ORDER BY media_produtos DESC; 
/* 
Resposta: 
"Pet" 76.1500000000000000
"Carnes" 37.8230769230769231
"Congelados" 33.1800000000000000
"Higiene" 25.8452941176470588
"Bebidas" 19.2646153846153846
"Limpeza" 17.5674074074074074
"Laticínios" 14.5062500000000000
"Mercearia"	14.4977551020408163
"Padaria" 8.2220000000000000
"Hortifruti" 6.2400000000000000 
*/ 

--Questao 10: 
--Quantos clientes há em cada cidade? Mostre apenas as cidades com pelo menos 60
--clientes, da maior quantidade para a menor; em caso de empate, por nome da cidade (A–Z). 
SELECT cidade, 
COUNT (id_cliente) AS qtd_cidade 
FROM dim_cliente 
GROUP BY cidade 
HAVING COUNT(id_cliente) >= 60 
ORDER BY qtd_cidade DESC, cidade ASC;
/*
Resposta: 
"Brasília"	245
"Taguatinga"	92
"Ceilândia"	81
"Goiânia"	68
"Águas Claras"	64
"Samambaia"	63
*/ 

--Questao 11: 
--Quantos clientes não informaram e-mail? 
SELECT COUNT (*)
FROM dim_cliente 
WHERE email IS NULL;  
--Resposta: 75 

--Questao 12: 
--Quantas clientes do sexo feminino nasceram entre 01/01/1990 e 31/12/1999 ?
SELECT COUNT(id_cliente) AS fem_aniv
FROM dim_cliente
WHERE data_nascimento BETWEEN '1990-01-01' and '1999-12-31' AND sexo = 'F';
--Resposta: 74 

--Questao 13: 
--Quantos clientes têm Ana como primeiro nome? (Atenção: nomes como Analu ou Anabela não contam.) 
SELECT COUNT (id_cliente) AS Anas 
FROM dim_cliente 
WHERE nome LIKE 'Ana %'
OR nome = 'Ana'; 
-- Resposta: 11 

--Questao 14: 
--Quantas lojas existem em cada UF? Mostre apenas as UFs com mais de 3 lojas, 
--da maior quantidade para a menor.
SELECT uf,
COUNT(id_loja) AS qtd_loja 
FROM dim_loja 
GROUP BY uf
HAVING COUNT(id_loja) > 3
ORDER BY qtd_loja DESC;

--Questao 15: 
--Liste o nome, a cidade e a data de inauguração das lojas inauguradas antes de
--01/01/2007, da mais antiga para a mais recente 
SELECT nome_loja,cidade,data_inauguracao 
FROM dim_loja 
WHERE data_inauguracao < '2007-01-01' 
ORDER BY data_inauguracao; 
/* 
Resposta: 
"Bom Dia Cruzeiro"	"Brasília"	"2005-01-20"
"Bom Dia Jardim Tiradentes"	"Aparecida de Goiânia"	"2005-03-14"
"Bom Dia Sobradinho I"	"Sobradinho"	"2005-04-15"
"Bom Dia Aparecida Centro"	"Aparecida de Goiânia"	"2005-06-04"
"Bom Dia Colônia Agrícola Samambaia"	"Vicente Pires"	"2005-08-07"
"Bom Dia Octogonal"	"Brasília"	"2005-08-21"
"Bom Dia Sobradinho II"	"Sobradinho"	"2005-10-15"
"Bom Dia Samambaia Norte"	"Samambaia"	"2006-04-07"
"Bom Dia Centro Uberlândia"	"Uberlândia"	"2006-04-12"
"Bom Dia Pistão Sul"	"Taguatinga"	"2006-08-12"
"Bom Dia Jardim Goiás"	"Goiânia"	"2006-12-06"
"Bom Dia Luziânia Centro"	"Luziânia"	"2006-12-07"
"Bom Dia Taguatinga Centro"	"Taguatinga"	"2006-12-16"
"Bom Dia P Norte"	"Ceilândia"	"2006-12-20" 
*/ 

--Questao 16 
--Qual foi o faturamento de cada canal de venda em 2025?Ordene do maior faturamento
--para o menor.  
SELECT canal, 
SUM(valor_total) AS fat_canal 
FROM fato_vendas 
WHERE data_venda BETWEEN '2025-01-01' AND '2025-12-31' 
GROUP BY canal
ORDER BY fat_canal DESC;
/* 
Resposta: 
"Loja física" 276534.24
"Aplicativo" 76340.05
"Site"	35376.02 
*/ 

--Questao 17 
--Considerando apenas o canal Loja física, mostre, para cada forma de pagamento,
--a quantidade de linhas de venda e o faturamento. 
--Ordene do maior faturamento para o menor. 
SELECT forma_pagamento, 
COUNT(id_venda) AS qtd_vendas,
SUM(valor_total) AS fat_vendas
FROM fato_vendas 
WHERE canal = 'Loja física'
GROUP BY forma_pagamento  
ORDER BY fat_vendas DESC; 
--Resposta: 
/*
 forma_pagamento                   qtd_vendas   fat_vendas
"Cartão de crédito"	                  3237	    166687.46
"Cartão de débito"	                  3222	    163300.11
"Pix"	                              2684	    141486.51
"Dinheiro"	                          1627	     80073.40 
*/ 

--Questao 18: 
--Quais são os 10 produtos (id_produto) com mais unidades vendidas (soma de
--quantidade)? Ordene da maior soma para a menor; em caso de empate, 
--pelo menor id_produto.
SELECT id_produto, 
SUM (quantidade) AS soma_qtd 
FROM fato_vendas 
GROUP BY id_produto
ORDER BY soma_qtd DESC, id_produto ASC 
LIMIT 10;
/* 
Resposta: 
id_produto    soma_qtd
    28	       1333
    89	        827
   224	        804
   136	        587
   163	        555
   113	        532
   132	        504
   223	        470
     6	        436
   127	        374
*/ 

--Questao 19: 
--Quais são as 5 lojas (id_loja) com maior faturamento em 2024? 
--Mostre o id_loja e o faturamento, do maior para o menor.
SELECT id_loja, 
SUM(valor_total) AS fat_loja
FROM fato_vendas 
WHERE data_venda BETWEEN '2024-01-01' AND '2024-12-31' 
GROUP BY id_loja 
ORDER BY fat_loja DESC
LIMIT 5; 
--Resposta: 
/*
3	23884.53
17	13507.46
6	12672.20
56	11476.51
4	10963.94 
*/

--Questao 20 
--Quantas linhas de venda cada loja (id_loja) tem? 
--Mostre apenas as lojas com mais de 300 linhas, da maior quantidade para a menor.
SELECT id_loja, 
COUNT(id_venda) AS qtd_vendas 
FROM fato_vendas 
GROUP BY id_loja 
HAVING COUNT (id_venda) > 300 
ORDER BY qtd_vendas DESC;
--Resposta: 
/* 
id_loja   qtd_vendas
   3	     886
  49	     476
  11	     459
   6	     444
   9	     440
   4	     434
  56	     429
   2	     420
  17	     410
  23	     316 
*/

--Questao 21: 
--Quais clientes (id_cliente) têm 70 ou mais linhas de venda? Mostre o id_cliente
--e a quantidade, da maior para a menor; em caso de empate, pelo menor id_cliente. 
--Desconsidere a vendas sem cliente 
SELECT id_cliente, 
COUNT(id_venda) AS qtd_vendas 
FROM fato_vendas 
WHERE id_cliente IS NOT NULL
GROUP BY id_cliente 
HAVING COUNT(id_venda) >= 70 
ORDER BY qtd_vendas DESC,id_cliente ASC; 
--Resposta: 
/* 
id_cliente   qtd_vendas
    416	        169
    684	        135
      9	        126
    186	        122
    563	        113
    323	         97
    395	         95
    290	         81
    501          78
     90	         75
    129	         75
    198	         71
    242	         70
*/

--Questao 22: 
--Quantas linhas de venda tiveram desconto (maior que zero) e 
--qual foi o valor médio desse desconto? Arredonde a média para 2 casas decimais.
SELECT COUNT(desconto) AS qtd_desconto, 
ROUND(AVG(desconto),2) AS med_desconto 
FROM fato_vendas 
WHERE desconto > 0.00;
--Resposta: 
/*  
qtd_desconto     med_desconto 
   2653	             5.25
*/

--Questao 23: 
--Qual foi o menor e o maior valor_total de uma linha de venda em dezembro de
--2025? 
SELECT MIN(valor_total) AS valor_min, 
MAX(valor_total) AS valor_max 
FROM fato_vendas 
WHERE data_venda BETWEEN '2025-12-01' AND '2025-12-31'; 
--Resposta: 
/*
valor_min	valor_max
  2.67	      654.20
*/ 

--Questao 24:
--Quantas linhas de venda foram registradas no dia 24/12/2025
--e qual foi o faturamento desse dia?
SELECT data_venda,
COUNT(data_venda) AS qtd_24, 
SUM(valor_total) AS fat_24 
FROM fato_vendas 
WHERE data_venda = '2025-12-24'
GROUP BY data_venda;
--Resposta: 
/* 
 data_venda	     qtd_24 	fat_24
"2025-12-24"	   24	    1281.83
*/

--Questao 25
--Considerando as vendas do canal Site em 2025 que tiveram desconto, mostre:
--id_venda, o valor bruto (quantidade × preco_unitario), o desconto, o valor_total e o percentual
--de desconto sobre o valor bruto. Ordene do maior percentual para o menor; em caso de empate, pelo
--menor id_venda. Mostre apenas as 10 primeiras linhas 
SELECT id_venda, 
	quantidade * preco_unitario AS valor_bruto, 
		desconto,  
	ROUND(desconto/(quantidade * preco_unitario) * 100,2) AS porc_desc, 
		valor_total
FROM fato_vendas 
WHERE data_venda BETWEEN '2025-01-01' AND '2025-12-31' AND canal = 'Site'
GROUP BY id_venda,desconto,valor_total
ORDER BY porc_desc DESC, id_venda ASC 
LIMIT 10;
		
	



