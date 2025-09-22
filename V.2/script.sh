#!/bin/bash

## Como usar esse script:
# Para visualizar o resultado no terminal:
# ./script.sh

# Para salvar o resultado em um arquivo de relatório:
# ./script.sh > relatorio_$(date +'%d-%m-%Y_%H-%M-%S').csv

# Para salvar o resultado em um arquivo de log e também ver na tela:
# ./script.sh | tee log_$(date +'%d-%m-%Y_%H-%M-%S').log


VERSION="3.5.1"

# Imprime o cabeçalho diretamente na saída padrão (terminal)
echo "Maquina,DataHora,AcaoRealizada,Detalhes"

# Leitura do arquivo de máquinas
while IFS="," read -r NOME SISTEMA VERSAO STATUS
do
    # O echo abaixo é para log de progresso, ele vai para o erro padrão para não sujar a saída CSV
    echo "$(date +'%d-%m-%Y_%H-%M-%S') processando maquina: $NOME" >&2

    if [ "$SISTEMA" == "Windows" ]; then
        saida_=$(./windows.sh $NOME $SISTEMA $VERSAO $STATUS $VERSION)
    elif [ "$SISTEMA" == "Linux" ]; then
        saida_=$(./linux.sh $NOME $SISTEMA $VERSAO $STATUS $VERSION)
    fi
    
    echo "$saida_" | grep -Eo "ACOES_REALIZADAS.*" | grep -Eo "[0-9]{3}" | while read acao; do
            case $acao in
                100)
                    acao_desc="Ativacao"
                    detalhes="Maquina ativada com sucesso"
                    ;;
                101)
                    acao_desc="FalhaAtivacao"
                    detalhes="Falha ao ativar a maquina"
                    ;;
                102)
                    acao_desc="Atualizacao"
                    detalhes="Maquina atualizada com sucesso"
                    ;;
                103)
                    acao_desc="FalhaAtualizacao"
                    detalhes="Falha ao atualizar a maquina"
                    ;;
                104)
                    acao_desc="ConectividadeOK"
                    detalhes="Teste de conectividade OK"
                    ;;
                105)
                    acao_desc="FalhaConectividade"
                    detalhes="Falha no teste de conectividade"
                    ;;
                *)
                    acao_desc="Desconhecida"
                    detalhes="Acao desconhecida realizada"
                    ;;
            esac
            data_hora=$(date +'%d-%m-%Y_%H-%M-%S')
            # Imprime a linha de dados CSV diretamente na saída padrão (terminal)
            echo "$NOME,$data_hora,$acao_desc,$detalhes"
        done

done < <(tail -n +2 inventario.txt)