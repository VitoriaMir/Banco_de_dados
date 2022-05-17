/*É possivel ter uma coluna coluna do banco mysql no formato 
  JSON */
create database bd_teste_json;
use bd_teste_json;
/*forma errada */
create table A_EXEMPLO 
(
    dados varchar(255) 
);    
insert into A_EXEMPLO
  (dados) values ('{
  "nome": "Aline",
  "matricula": 123
  "email": "aline@gmail.com"
}');
select * from A_EXEMPLO;

/*FORMA CERTA*/
drop table A_EXEMPLO;
create table A_EXEMPLO 
(
    dados json
);
insert into A_EXEMPLO
  (dados) values ('{
  "nome": "Gustavo",
  "matricula": 567,
  "email": "gustavo@gmail.com"
}');
select * from A_EXEMPLO;   
desc A_EXEMPLO;

select dados
 from A_EXEMPLO;
 
 select dados
   from A_EXEMPLO
   where dados like '%aline%';
/*selecionando da coluna json - observe que o resultado vem com aspa dupla nos campos varchar*/   
select JSON_EXTRACT(dados, "$.nome") as nome,
       json_extract(dados, "$.matricula") as matricula,
       json_extract(dados, "$.email") as email,
       dados
  from A_EXEMPLO;
  
insert into A_EXEMPLO
  (dados) values ('{
  "cpf": "484",
  "nome": "Erica",
  "matricula": 852,
  "email": "erica@gmail.com"
}');  

/*seleciona a chaves da coluna json de forma distinta*/
select distinct json_keys(dados)
   from A_EXEMPLO;  
  
  
create table municipios_2 
(   
    microrregiao json,
	regiao_imediata json,
    id int primary key,
    nome varchar(100)
);    


select * from municipios_2;



select JSON_EXTRACT(dados, "$.nome") as nome,
       json_extract(dados, "$.matricula") as matricula,
       json_extract(dados, "$.email") as email,
       dados
  from A_EXEMPLO;
 /*remover aspas duplas */ 
  select replace('casa', 'a', '@');
 
  select replace(JSON_EXTRACT(dados, "$.nome"), '"', '') as nome,
       json_extract(dados, "$.matricula") as matricula,
       replace(json_extract(dados, "$.email"), '"', '') as email,
       dados
  from A_EXEMPLO;
  /*outra forma de fazer mais fácil*/
  select dados ->> '$.nome'   as nome ,
         dados ->> '$.matricula' as matricula,
         dados ->> '$.email' as email
   from  A_exemplo;
  
  
  select json_keys(microrregiao)
    from municipios_2;
    

  select json_keys(microrregiao, '$.mesorregiao')
    from municipios_2;  
    
    
  /*select as chaves da tabela municipio*/
  select * from municipios_2;
  
  select distinct 
         json_keys(microrregiao) as microrregiao ,
         json_keys(microrregiao, '$.mesorregiao') as mesorregiao,
         json_keys(microrregiao, '$.mesorregiao.UF') as mesorregiao_UF,
         json_keys(microrregiao, '$.mesorregiao.UF.regiao') as mesorregiao_UF_regiao,
         json_keys(regiao_imediata) as regiao_imediata,
         json_keys(regiao_imediata, '$.regiao_intermediaria') as regiao_intermediaria,
         json_keys(regiao_imediata, '$.regiao_intermediaria.UF') as regiao_intermediaria_UF,
         json_keys(regiao_imediata, '$.regiao_intermediaria.UF.regiao') as regiao_intermediaria_UF_regiao
    from  municipios_2;
    
    
  /*selecione as cidades do estado DF */
  select nome, 
         microrregiao ->> '$.mesorregiao.UF.sigla'
    from municipios_2 
  where  microrregiao ->> '$.mesorregiao.UF.sigla' = 'DF'; 
  
/*selecione as cidades do estado GO, exiba o nome da regiao, 
    o nome do estado e sigla do estado ordenadas pela nome do municipio*/
  select nome, 
         microrregiao ->> '$.mesorregiao.UF.sigla' as UF,
         microrregiao ->> '$.mesorregiao.UF.nome' as estado,
         microrregiao ->> '$.mesorregiao.UF.regiao.nome' as regiao
    from municipios_2 
  where  microrregiao ->> '$.mesorregiao.UF.sigla' = 'GO'
  order by nome;

/*Contar quantos municipios_2 tem em cada estado em ordem decrescente de quantidade 
	municipios_2*/
select microrregiao ->> '$.mesorregiao.UF.nome' as estado,
       count(id)
  from municipios_2
  group by 1 
  order by 2 desc;

/*Contar quantos estados tem em cada regiao*/
select microrregiao ->> '$.mesorregiao.UF.regiao.nome' as regiao,
       count(distinct  microrregiao ->>  '$.mesorregiao.UF.nome')
  from municipios_2
  group by 1
  order by 2 desc;
  
  
/*Selecionar o nome da mesorregiao ordenadas em ordem crescente*/ 
select microrregiao ->> '$.mesorregiao.nome'
  from municipios_2
  order by 1 asc;

/*Selecionar o nome da mesorregiao e o nome da 
  microrregiao dos estados de GO, MG e DF*/  
select microrregiao ->> '$.mesorregiao.nome' as mesorregiao,
	   microrregiao ->> '$.nome' as microrregiao,
       nome as municipio,
       microrregiao ->> '$.mesorregiao.UF.nome' as estado
    from municipios_2 
  where  microrregiao ->> '$.mesorregiao.UF.sigla' in('GO', 'DF','MG')
  order by 1,2;
  
/*Contar quantas mesorregiao tem cada estado*/  
 select microrregiao ->> '$.mesorregiao.UF.nome' as estado,
        count( distinct microrregiao ->> '$.mesorregiao.nome') as total_mesorregiao,
		count( distinct microrregiao ->> '$.nome') as total_microregiao
  from municipios_2
  group by 1; 
  
  
/*selecionar o nome do municipio , concatenar o nome estado com 
nome da microrregiao e nome da mesorregiao, dos estados de SP e RJ*/
SELECT concat(microrregiao ->> '$.mesorregiao.UF.nome',
			  microrregiao ->> '$.nome',
              microrregiao ->> '$.mesorregiao.nome')
	from municipios_2;

/*criar uma nova vw_municipios 
  ID_MUNICIPIO 
  NOME_MUNICIPIO 
  ESTADO 
  SIGLA 
  NOME_DA_MESORREGIAO 
  NOME_DA_MICRORREGIAO
  NOME_REGIAO
*/ 




