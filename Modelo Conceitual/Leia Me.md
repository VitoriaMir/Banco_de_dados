**Exercícios**

**Exercício 1 - Criar um modelo conceitual**
Dados os requisitos abaixo, modele usando o MER
1 – Departamento com os atributos: nome, número, localização
2 – Empregado com os atributos: nome, CPF, sexo, endereço, rua, bairro, complemento, cidade, estado, cep, telefone com ddd e número, salario, data de nascimento, idade. O CPF é atributo identificador.
3 – Empresa com os atributos: nome da empresa, CNPJ.
4 – Criar o relacionamento (trabalha) entre Departamento e Empregado
5 – Criar o relacionamento (possui) entre Empresa e Departamento, com as seguintes regras: uma empresa pode possuir de 1 a vários departamentos e um departamento pertence somente a uma única empresa.

**Exercício 2 - Criar um modelo conceitual**
1 – Criar um modelo de dados para agendar consulta numa clínica médica. É necessário manter os dados dos Médico que são CRM, nome e especialidade. 
2 – Também é necessário manter os dados do paciente: código do paciente que é um identificador, nome, dois telefone para contato e data de nascimento.
3 – Sobre a consulta é necessário manter os dados data e hora da consulta e criar um código de identificação para a consulta.
4 – As regras são um médico pode agendar várias consultas e uma consulta é agendada com um único médico
5 – um paciente pode marcar várias consultas mas uma consulta é marcada para um único paciente, apenas.


**Exercício 3 - Criar um modelo conceitual e lógico**
Uma ONG tem voluntários que pode ser pessoa física ou jurídica, cada voluntário tem um identificação própria, pessoa física tem cpf, nome, data de nascimento, email e telefone, as pessoas jurídicas tem cnpj, nome da empresa, nome fantasia e nome do responsável, email e telefone. A ONG tem vários projetos que podem trabalhar vários voluntários e um voluntário pode trabalhar em vários projetos, cada projeto tem uma identificação e um nome do projeto e um valor de orçamento que pode ser gasto com o projeto. É necessário armazenar para cada voluntário a data que ele começou e terminou de trabalhar no projeto e também a função dele no projeto que trabalhou.  


**Exercício 4 - Criar um modelo conceitual**
APURAÇÃO ELEITORAL. Para facilitar o processamento da apuração eleitoral da eleição, o TRE (Tribunal Regional Eleitoral) resolveu informatizar esse processo. Sabe-se que cada localidade é dividida em várias zonas eleitorais que, por sua vez, são divididas em várias seções nas quais os eleitores estão vinculados. O candidato a um cargo público deve estar vinculado a um único partido político. Um partido pode ter vários candidatos. 
Elabore os MODELOS que represente os dados referentes a esse processo, juntamente com os principais atributos, chaves (primárias e estrangeiras). Coloque os atributos de acordo com a necessidade.


**Exercício 5 - Criar um modelo conceitual**
Você irá elaborar um  modelo  de  dados  para  atender as  necessidades: 
O cadastro dos usuários com endereço completo; Os usuários estão classificados entre alunos que possuem RA (registro acadêmico), professores (matricula e titulação) e funcionários (matricula e cargo); 
Os livros da biblioteca têm os seguintes dados título do livro, ISBN, ano de publicação, edição, editora, autores. Um livro pode ter vários exemplares para empréstimo. Um livro pode ter diversos autores e um autor pode ter publicado vários livros. 
Uma editora pode ter vários livros publicados e um livro pertence a uma editora; 
Cada usuário pode fazer até 5 empréstimos por vez. Para cada empréstimo de livro é necessário armazenar a data de empréstimo, data de devolução e a data de entrega, multa em caso de atraso, É importante armazenar o histórico dos empréstimos feitos.


**Exercício 6 - Criar um modelo conceitual**
Uma aplicação permite que os usuários notifiquem a ocorrência de eventos que ele presencia durante seu percurso, tais como acidente de transito ou trânsito lento. Em um possível cenário, esta notificação é enviada para um servidor centralizado, o qual é responsável por disseminar a notificação para os demais usuários do aplicativo. Faça a modelagem de uma base de dados, usando o modelo relacional para o armazenamento de dados referentes aos usuários, eventos e notificações enviadas.
A equipe de desenvolvimento deseja adicionar características ao modelo:
cada notificação deve ter uma data e hora
Um usuário pode notificar vários eventos e um evento pode ser notificado por vários usuários. 
Cada notificação deverá a localização de latitude e longitude, data e hora da notificação
Para o evento ter a identificação e  a descrição
O usuário deverá ter nome e CPF  


**Exercício 7 - Criar um modelo conceitual**
Um zoológico planeja adquirir um sistema para gerenciar as suas tarefas diárias. O sistema para esse zoológico deve ser capaz de cadastrar os seus animais, bem como os seus funcionários.
O sistema deve reconhecer também a que classe um determinado animal pertence: mamífero, réptil ou ave. Além disso, cada classe deve conter uma descrição técnica sobre as suas características específicas.
Os animais do zoológico devem ser identificados por um código de identificação, devendo o sistema registrar o seu nome, espécie, cor e altura. Cada animal é mantido em algum tipo de container e o sistema deve saber o seu tipo, por exemplo: um poço, uma jaula, um viveiro, um tanque, etc. Cada container fica localizado em uma ala do zoológico e o sistema deve indicar qual é essa ala onde ele se encontra para facilitar o agendamento de atividades.
Os funcionários que trabalham nesse zoológico podem ser veterinários, cuidadores de animais, zeladores ou trabalharem em setores administrativos. Todos os funcionários devem conter nome, data de nascimento, CPF, RG, endereço completo e o cargo que desempenham. No caso dos veterinários, deve conter ainda o CRMV (Carteira do Conselho Regional de Medicina Veterinária).
O sistema deve possuir um módulo para agendar dia e hora para as consultas de cada animal com os veterinários, tendo em vista que cada animal deve ser tratado sempre pelo mesmo veterinário, para que ele possa fazer acompanhamentos(Prontuário) em longo prazo com o seu paciente, ressaltando que um veterinário pode atender, no máximo, 15 animais, sendo este o número ideal para que o veterinário consiga manter a qualidade do seu trabalho.
O sistema deve também ser capaz de agendar dia e horário específico para a limpeza dos containers dos animais.







