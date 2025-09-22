# Desafio de Automação de Infraestrutura: Analytic Agent (V2.0)

Este repositório representa a **Versão 2.0** da solução para o Desafio de Analista de Infraestrutura. Diferente de uma abordagem inicial com um script único, esta versão foi refatorada para uma **arquitetura modular e mais robusta**, focada em escalabilidade e boas práticas de automação.

## Descrição

O objetivo principal da solução é gerenciar a instalação e o estado do "Analytic Agent" em um parque de máquinas Windows e Linux, garantindo conformidade, reduzindo o risco de erro humano e criando um registro de auditoria claro de todas as ações realizadas.

## Funcionalidades Principais

- **Leitura de Inventário em CSV:** Processa um arquivo `inventario.txt` no formato CSV para obter a lista de máquinas.
- **Arquitetura Modular:** Utiliza um script principal (`script.sh`) como orquestrador, que delega as tarefas específicas para scripts especialistas (`windows.sh`, `linux.sh`).
- **Simulação de Ações:** Simula de forma realista as operações de TI, incluindo:
    - Teste de conectividade (`ping`).
    - Atualização de versão do software.
    - Reativação de serviços inativos.
    - Probabilidade de falha para testar o tratamento de erros.
- **Geração de Relatório:** Produz um relatório detalhado no formato CSV na saída padrão, que pode ser facilmente salvo em um arquivo.
- **Códigos de Ação:** Utiliza um sistema de códigos numéricos para registrar as ações de forma padronizada, facilitando a filtragem e a análise dos logs.

## Estrutura do Projeto

- **`script.sh`**: O script orquestrador principal. Ele lê o inventário, decide qual especialista chamar e formata o relatório final.
- **`windows.sh`**: Script especialista com a lógica de simulação para máquinas Windows.
- **`linux.sh`**: Script especialista com a lógica de simulação para máquinas Linux.
- **`inventario.txt`**: Arquivo de inventário de exemplo no formato CSV.
- **`run_with_output_files.sh`**: Script de conveniência para executar o `script.sh` e salvar a saída em um arquivo de log com data e hora.
- **`README.md`**: Este arquivo.

## Como Usar

### Pré-requisitos

- Um ambiente de shell compatível com Bash (como Git Bash no Windows, ou qualquer terminal no Linux e macOS).

### Execução

O script principal (`script.sh`) foi projetado para imprimir o relatório CSV diretamente no terminal (saída padrão). Isso oferece flexibilidade para o usuário decidir o que fazer com o resultado.

1.  **Para visualizar o relatório no terminal:**
    ```bash
    ./script.sh
    ```

2.  **Para salvar o relatório em um arquivo (recomendado):**
    ```bash
    ./script.sh > relatorio_$(date +'%d-%m-%Y_%H-%M-%S').csv
    ```

3.  **Para salvar o log de processamento e o relatório CSV (usando o script `run_with_output_files.sh`):**
    ```bash
    ./run_with_output_files.sh
    ```
    Isso irá gerar um arquivo de log (`log_DATA.log`) que contém tanto as mensagens de depuração quanto o relatório CSV.

## Códigos de Ação

Os seguintes códigos são usados no relatório para categorizar as ações realizadas em cada máquina:

| Código | Descrição                      |
| :----- | :------------------------------- |
| `100`  | Ativação realizada com sucesso   |
| `101`  | Falha ao realizar ativação       |
| `102`  | Versão atualizada com sucesso    |
| `103`  | Falha ao realizar a atualização  |
| `104`  | Sucesso no teste de conectividade|
| `105`  | Falha ao conectar ao computador  |

## Melhorias Futuras

Para escalar esta solução para um ambiente de produção com centenas de máquinas, as seguintes melhorias poderiam ser implementadas:

- **Processamento Paralelo:** Modificar o orquestrador para verificar múltiplas máquinas ao mesmo tempo, reduzindo drasticamente o tempo total de execução.
- **Gerenciamento de Segredos:** Integrar o script com um "cofre" de senhas (como HashiCorp Vault) para gerenciar as credenciais de acesso às máquinas de forma segura, em vez de armazená-las localmente.