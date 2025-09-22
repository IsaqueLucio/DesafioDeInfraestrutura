#!/bin/bash

NOME=$1
SISTEMA=$2
VERSAO=$3
STATUS=$4
TARGET_VERSION=$5

echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Iniciando o script para Linux na máquina $NOME com a versâo $VERSAO e status $STATUS."

declare -a ACOES_REALIZADAS

echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Realizando teste de conectividade no Linux, executando ping no $NOME."
if [ $((RANDOM%2)) -eq 0 ]; then
    echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Conectividade O.K no Linux."
    ACOES_REALIZADAS+=("104")

    # A lógica de versão e status só roda se a conectividade for OK
    if [ "$VERSAO" != "$TARGET_VERSION" ] ; then
        echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Versão diferente do esperado no Linux."
        if [ $((RANDOM%2)) -eq 0 ]; then
            echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Atualização no Linux realizada com sucesso."
            ACOES_REALIZADAS+=("102")
        else
            echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Falha na atualização no Linux."
            ACOES_REALIZADAS+=("103")
        fi
    fi

    if [ "$STATUS" != "Ativo" ] ; then
        echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Maquina inativa do Linux."
        if [ $((RANDOM%2)) -eq 0 ]; then
            echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Ativando a máquina no Linux."
            ACOES_REALIZADAS+=("100")
        else
            echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Falha na ativação no Linux."
            ACOES_REALIZADAS+=("101")
        fi
    fi

else
    echo "$(date +'%d-%m-%Y_%H-%M-%S%N') Falha na conectividade no Linux."
    ACOES_REALIZADAS+=("105")
    # Imprime as ações ANTES de sair para que o script principal receba o erro
    echo "$(date +'%d-%m-%Y_%H-%M-%S%N') ACOES_REALIZADAS ${ACOES_REALIZADAS[@]}"
    exit 1
fi

echo "$(date +'%d-%m-%Y_%H-%M-%S%N') ACOES_REALIZADAS ${ACOES_REALIZADAS[@]}"