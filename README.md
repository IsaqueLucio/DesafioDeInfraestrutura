# Desafio Técnico - Analista de Infraestrutura Jr

Este repositório contém a resolução do **Desafio Técnico para a vaga de Analista de Infraestrutura Júnior**, proposto em setembro de 2025.

O objetivo é simular a gestão do aplicativo **Analytic Agent**, garantindo que ele esteja instalado na versão correta (3.5.1) em todas as máquinas listadas em um inventário.

##  Objetivos do Desafio

1. **Consulta ao inventário:** Ler um arquivo `inventario.txt` contendo o nome da máquina, sistema operacional e versão instalada do software.
2. **Automação com Bash:**
   * Se a versão estiver desatualizada ou não instalada → simular a instalação da versão 3.5.1.
   * Se a versão estiver correta → simular a verificação do serviço; caso esteja inativo, simular a ativação.
3. **Relatório:** Gerar um `relatorio.csv` registrando todas as ações realizadas pelo script.
4. **Documentação:** Explicar o raciocínio, riscos de confiar em inventários estáticos, tratamento de erros e possíveis melhorias para escalar a solução.

##  Estrutura do Repositório

* `inventario.txt` → Arquivo de inventário simulado.
* `script.sh` → Script em Bash que realiza as verificações e ações.
* `relatorio.csv` → Relatório gerado automaticamente com os resultados.
* `docs/analise.txt` → Documento com respostas sobre processo, riscos, tratamento de erros e escalabilidade.

##  Tecnologias Utilizadas

* **Bash (Shell Script)**
* Estruturas de repetição, condicionais e manipulação de arquivos
* Geração e formatação de relatórios em CSV

##  Documentação

Na pasta `docs/` estão as respostas às questões propostas no desafio, incluindo:

* Processo e autonomia na resolução.
* Considerações de segurança e conformidade.
* Estratégias de tratamento de erros.
* Propostas de melhorias e escalabilidade.

##  Autor

Desenvolvido por **Isaque Lucio** como parte do processo seletivo para a vaga de **Analista de Infraestrutura Jr**.
