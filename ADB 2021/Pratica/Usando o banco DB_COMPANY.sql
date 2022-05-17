use db_company;

select matricula, nome, nm_cargo, salario
from tb_empregado, tb_cargo, tb_departamento
where fk_cargo = id_cargo
and fk_departamento = id_departamento
order by nome;

select matricula, nome, nm_cargo, salario, nm_departamento
from tb_empregado
	inner join tb_cargo 			on fk_cargo = id_cargo
    inner join tb_departamento 		on fk_departamento = id_departamento
    order by nome;
    
select matricula, nome, nm_departamento 
from  tb_departamento LEFT JOIN tb_empregado
ON  fk_departamento = id_departamento ;

select matricula, nome, nm_departamento 
from  tb_departamento LEFT JOIN tb_empregado
ON  fk_departamento = id_departamento 
where fk_departamento is null;

select matricula, nome, nm_departamento 
from  tb_empregado right JOIN tb_departamento
ON  fk_departamento = id_departamento ;

select matricula, nome, nm_departamento 
from  tb_empregado right JOIN tb_departamento
ON  fk_departamento = id_departamento 
where fk_departamento is null;

desc tb_empregado;