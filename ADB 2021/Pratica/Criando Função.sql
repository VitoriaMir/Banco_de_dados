select rand();
select rand() *100;
select floor(rand() *1000);

/*Gerar um número entre 5 e 15*/
/*FLOOR(rand() * (<max> - <min> + 1) + <min> */

select floor(rand() * (15 - 5 - 1)) + 5;
select floor(rand() * 11) + 5;
select floor(rand() * (10)) + 1;

/*Criar uma função fn_sorteio que irá receber como parametro o num_min int e o num_max int e retornará um inteiro do numero sorteado*/

delimiter $$
  drop function if exists fn_sorteio $$
  create function fn_sorteio( num_min int, num_max int) returns int
  begin
  declare troca int;
  declare sorteio int;
  if (num_min > num_max)then
    set troca = num_min ;
    set num_min = num_max;
    set num_max = troca;
  end if;
  select floor(rand() * (num_max - num_min + 1)) + num_min into sorteio;
  return sorteio;
      end $$
 delimiter ;
 select fn_sorteio (12,7) ;

select * from cliente ;
select * from cliente limit 5,1;

/*Criar uma função fn_sorteio_cliente que não tem parâmetros, a função fn_sorteio_cliente deverá fazer o sorteio de um cliente da tabela cliente. 
  Ao final, a função deverá retornar o cpf concatenado com o nome do cliente.
  Dica: para saber o tamanho da tabela select count(cpf) na tabela cliente utilize a fn_num_sorteio para retornar a linha (registro) do cliente sorteado
*/
 delimiter $$
	drop function if exists fn_sorteio_cliente $$
	create function fn_sorteio_cliente () returns varchar(80)
	begin
		declare num_sorteio int;
		declare ganhador varchar(80);
		declare tamanho_tabela int;
		select count(cpf) into tamanho_tabela from cliente;
		set num_sorteio = fn_sorteio(1, tamanho_tabela);
		set num_sorteio = num_sorteio - 1;
		select concat(cpf, '  ', nome) into ganhador from cliente limit num_sorteio, 1;
		return ganhador;
	end $$
 delimiter ;
 select fn_sorteio_cliente () ; 
 