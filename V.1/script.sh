#!/bin/bash
#Criação do relatório de ações realizadas no sistema
data=$(date +'%d-%m-%Y_%H-%M-%S')
relatorio="relatorio_${data}.csv"

VERSION="3.5.1"

# Cabeçalho do relatório
echo "Maquina,DataHora,AcaoRealizada,Detalhes" > $relatorio

# Leitura do arquivo de máquinas
while read linha_nome
do
# Lê as próximas 4 linhas para completar o bloco de informações da máquina
    read linha_so
    read linha_versao
    read linha_status
    read linha_ignorar
# Extrai as informações relevantes
    maquina=$(echo $linha_nome | cut -d':' -f2 | xargs)
    so=$(echo $linha_so | cut -d':' -f2 | xargs)
    versao=$(echo $linha_versao | cut -d':' -f2 | xargs)
    status=$(echo $linha_status | cut -d':' -f2 | xargs)

# Verifica as condições e registra as ações no relatório
    if( [ "$versao" != $VERSION ] ); then
        acao="Atualizacao"
        detalhes="Atualizado para a versao $VERSION e servico iniciado"
        data_hora=$(date +'%d-%m-%Y %H:%M:%S')
        echo "$maquina,$data_hora,$acao,$detalhes" >> $relatorio

    elif( [ "$status" == "Inativo" ] ); then
        acao="Reativacao"
        detalhes="Maquina reativada e servico iniciado"
        data_hora=$(date +'%d-%m-%Y %H:%M:%S')
        echo "$maquina,$data_hora,$acao,$detalhes" >> $relatorio
    else
        acao="Verificacao"
        detalhes="Nenhuma acao necessaria"
        data_hora=$(date +'%d-%m-%Y %H:%M:%S')
        echo "$maquina,$data_hora,$acao,$detalhes" >> $relatorio
    fi
done < inventario.txt