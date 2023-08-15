select * from tb_pais;

/* 1 - selecione o nome do pais, code, iso, populacao, capital e continente de todos os paises*/
select P.nm_pais as País, P.cod_pais as Sigla, P.iso_pais, P.populacao as População, P.capital as Capital, C.nm_continente as Continente
from tb_pais as P
inner join tb_continente as C			on P.cod_continente =  C.cod_continente
    order by P.nm_pais;

/* 2 - selecione o nome do pais, code, iso, populacao e continente de todos os paises da america do sul*/
select P.nm_pais as País, P.cod_pais as Sigla, P.iso_pais, P.populacao as População,  C.nm_continente as Continente
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where C.nm_continente like 'America do Sul'
    order by P.nm_pais;

/* 3 - selecione a contagem de paises por continente*/
select nm_continente, count(nm_pais) as Total_Pais
from tb_pais as P
  inner join tb_continente as C			on C.cod_continente = P.cod_continente     
group by nm_continente
order by nm_continente;

/* 4 - selecione o nome do pico mais alto e nome do pico mais baixo e qual paises ele fica*/
select nm_pico, elevacao, M.montanha, nm_pais
from tb_pico as Pi
inner join tb_montanha as M				on M.cod_montanha = Pi.cod_montanha
inner join rl_montanha_pais as RL		on Rl.cod_montanha = M.cod_montanha
inner join tb_pais as P					on P.cod_pais = RL.cod_pais
where elevacao = (select max(elevacao) from tb_pico)
or elevacao = (select min(elevacao) from tb_pico);

/* 5 - selecione todas as montanhas e qual pais ela fica*/
select M.montanha, nm_pais
from tb_montanha as M	
inner join	rl_montanha_pais as RL		on M.cod_montanha = RL.cod_montanha
inner join 	tb_pais as P	        	on P.cod_pais = RL.cod_pais
order by nm_pais;

/* 6 - selecione todas os picos e qual montanha ele fica e qual pais pertence*/
select nm_pico, M.montanha, nm_pais
from tb_pico as Pi
inner join tb_montanha as M				on M.cod_montanha = Pi.cod_montanha
inner join rl_montanha_pais as RL		on Rl.cod_montanha = M.cod_montanha
inner join tb_pais as P					on P.cod_pais = RL.cod_pais
order by nm_pico;

/* 7 - selecione soma da populacao por continente*/
select nm_continente as Continente, count(populacao) as População
from tb_continente as C 
inner join tb_pais 	as P					on P.cod_continente = C.cod_continente
group by nm_continente;

/* 8 - selecione o nome do pais mais populoso*/
select nm_pais as Pais, populacao
from tb_pais as P	
where populacao = (select max(populacao) from tb_pais);

/* 9 - selecione o 10 primeiro paises mais populosos*/
select nm_pais, populacao
from tb_pais	
order by populacao desc limit 10;

/* 10 - selecione o pais com a maior area de superficie*/
select P.nm_pais, areasuperficie
from tb_pais as P	
where areasuperficie = (select max(areasuperficie) from tb_pais);

/* 11 - selecione o pais com a menor area de superficie */
select P.nm_pais, areasuperficie
from tb_pais as P	
where areasuperficie = (select min(areasuperficie) from tb_pais);

/* 12 - selecione o pais com a menor populacao*/
select nm_pais, populacao
from tb_pais as P	
where populacao = (select min(populacao) from tb_pais);

/* 13 - selecione todos os rios do Brasil*/
select nm_rio, nm_pais 
from tb_rios as R
inner join rl_pais_rio as RL 	on RL.cod_rio = R.cod_rio
inner join tb_pais as P			on RL.cod_pais = P.cod_pais
where nm_pais = 'Brazil'
    order by nm_rio ;
    
/* 14 - selecione todos os rios da América do sul e América do Norte*/
select nm_rio, nm_pais, nm_continente 
from tb_rios as R
inner join rl_pais_rio as RL 	    on RL.cod_rio = R.cod_rio
inner join tb_pais as P			    on RL.cod_pais = P.cod_pais
inner join tb_continente as C		on C.cod_continente = P.cod_continente
where nm_continente in ('América do sul', 'América do Norte')
    order by nm_continente ;

/* 15 - Selecione a contagem de rios por pais*/
select count(nm_rio) total_Rios, nm_pais
from tb_rios as R
inner join rl_pais_rio as RL 	    on RL.cod_rio = R.cod_rio
inner join tb_pais as P			    on RL.cod_pais = P.cod_pais
group by nm_pais
order by 2;

/* 16 - Selecione todos os paises que tem a moeda dolar*/
select  nm_pais, descricao
from tb_moeda as M
inner join tb_pais as P			    on P.cod_moeda = M.cod_moeda
where descricao like '%Dollar%'
order by 1;

/* 17 - Selecione  o nome do rio de maior comprimento e qual pais ele fica*/
select nm_rio, comprimento, nm_pais
from tb_rios as R
inner join rl_pais_rio as RL 	    on RL.cod_rio = R.cod_rio
inner join tb_pais as P			    on RL.cod_pais = P.cod_pais
where comprimento = (select min(comprimento) from tb_rios);

/* 18 - Selecione o nome de paises que não tem rios */
select count(nm_rio) total_Rios, nm_pais
from tb_rios as R
right join rl_pais_rio as RL 	    on RL.cod_rio = R.cod_rio
right join tb_pais as P			    on RL.cod_pais = P.cod_pais
where rl.cod_rio is null
group by nm_pais
order by 1;

/* 19 - Selecione o nome de paises que não tem montanha */
select nm_pais
from tb_pais as P
left join rl_montanha_pais as RLM 	    on RLM.cod_pais = P.cod_pais
where rlm.cod_pais is null
order by nm_pais;

/* 20 - Selecione o nome de continente que não tem paises cadastrados */
select nm_continente
from tb_continente as C 
left join tb_pais as P 					on P.cod_continente = C.cod_continente
where C.cod_continente is null
order by nm_continente;

-- PARTE I

-- 1 - Selecionar todos os dados do país Brasil (Brazil);
select * from tb_pais as P
where nm_pais = 'Brazil';

-- 2 - Selecionar a quantidade de paises cadastrados;
select count(cod_pais) as TotalPaises
from tb_pais;

-- 3 - Selecionar todos os paises da America do Sul;
select P.nm_pais as País, P.cod_pais as Sigla
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where C.nm_continente like 'America do Sul'
    order by P.nm_pais;
    
-- 4 - Selecionar a quantidade de paises da America do Sul;
select P.nm_pais as País, count(P.cod_pais) as Sigla
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where C.nm_continente like 'America do Sul'
    order by P.nm_pais;

-- 5 - Selecionar as linguagens da Africa do sul;

select  idioma
from tb_pais as P
inner join tb_idioma as I			on I.cod_pais = P.cod_pais
where P.nm_pais like 'South Africa';

-- 6 - Selecionar todos os paises que iniciam com a letra 'A'
select P.nm_pais as País, P.cod_pais as Sigla
from tb_pais as P
where P.nm_pais like 'A%'
    order by P.nm_pais;

-- 7 - Selecionar o país e a população do país mais populoso;
select nm_pais, populacao
from tb_pais as P	
where populacao = (select max(populacao) from tb_pais);

-- 8 - Selecionar todas as cidades cadastradas do Brasil;
select nm_cidade as Cidade from tb_pais as P
inner join tb_cidade as C				on C.cod_pais = P.cod_pais
where nm_pais = 'Brazil';

-- 9 - Selecionar todas as cidades cadastradas do Estados Unidos;
select nm_cidade as Cidade from tb_pais as P
inner join tb_cidade as C				on C.cod_pais = P.cod_pais
where nm_pais = 'United States';

-- 10 - Selecionar o país mais populoso da America do Sul;
select nm_pais, populacao
from tb_pais as P	
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where populacao = (select max(populacao) from tb_pais as  P 
					inner join tb_continente as C	on C.cod_continente = P.cod_continente 
                    where nm_continente = 'America do Sul')
order by populacao desc limit 1;


-- PARTE II

-- 11 - Selecionar o code, iso, nome do pais de todos os paises da Asia
select nm_pais, P.cod_pais, iso_pais
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where nm_continente like 'Asia';

-- 12 - Selecionar o nome do pais e populacao do país com maior area de superficie;
select P.nm_pais, areasuperficie, populacao
from tb_pais as P	
where areasuperficie = (select max(areasuperficie) from tb_pais);

-- 13 - Selecionar o nome das 10 cidades mais populosas do mundo e qual o nome do país;
select nm_pais, P.populacao as PopulaçãoPais, nm_cidade, C.populacao as PopulaçãoCidade
from tb_pais as P	
inner join tb_cidade as C				on C.cod_pais = P.cod_pais
order by C.populacao desc limit 10;

-- 14 - Selecionar todos os paises da Europa
select P.nm_pais as País, P.cod_pais as Sigla
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where C.nm_continente like 'Europa'
    order by P.nm_pais;

-- PARTE III

/*15 - Contar quantos paises tem por continente;*/
select nm_continente, count(nm_pais) as Total_Pais
from tb_pais as P
  inner join tb_continente as C			on C.cod_continente = P.cod_continente     
group by nm_continente
order by nm_continente;

/*16 - Somar a populacao de todas as cidades cadastradas no brasil;*/
select nm_pais, sum(P.populacao) as Populacao
from tb_pais as P
where nm_pais = 'Brazil';

/*17 - Alterar a população (atualizar) da china; (pesquisar na internet)*/
update tb_pais set populacao = 1439323776
where cod_pais = 'CN';
 
	select * from tb_pais as P
		where nm_pais = 'China';
 
/*18 - Alterar a população (atualizar) da india; (pesquisar na internet)*/
update tb_pais set populacao = 1380004385
where cod_pais = 'IN';

	select * from tb_pais as P
		where nm_pais = 'India';

/*19 - Somar a populacao de todos os paises da America do Norte;*/
select C.nm_continente as Continente, sum(P.populacao) as População
from tb_pais as P
inner join tb_continente as C			on C.cod_continente = P.cod_continente
where C.nm_continente like 'America do Norte'
    order by P.nm_pais;


/*20 - Selecionar a quantidade de cidades cadastradas por estado do brasil;*/
select count(nm_cidade) as Total_Cidade
from tb_cidade as C
  inner join tb_pais as P			on C.cod_pais = P.cod_pais    
order by nm_pais;

/*21 - Selecione o calculo da Populacao e dividida pela area de superficie da china e da india;*/
select nm_pais, populacao / areasuperficie as densidade
from tb_pais
where nm_pais in ('India','China');