#!/bin/bash

echo -e "\e[1;34m🔧 Instalando dependências necessárias\e[0m\n"

echo -e "Mise está instalando Python pré-compilado de \e[1mindygreg/python-build-standalone\e[0m."

echo -e "\nSe você tiver problemas com esta instalação do Python (por exemplo, ao executar \e[1mPoetry\e[0m), mude para o backend \e[1mpython-build\e[0m."

echo -e "\nExecutando:\n  \e[1m mise settings set python_compile 1\e[0m"

echo -e "\nBaixando:\n  \e[1mcpython-3.12.11+20250723-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst\e[0m"

echo -e "\nInstalando:\n  \e[1mcpython-3.12.11+20250723-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst\e[0m"

echo -e "\n\e[1;31m❌ Erro:\e[0m"
echo -e "O Mise falhou ao extrair o arquivo:"
echo -e "  \e[3m~/.local/share/mise/downloads/python/3.12.11/cpython-3.12.11+20250723-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst\e[0m"
echo -e "  para"
echo -e "  \e[3m~/.local/share/mise/downloads/python/3.12.11\e[0m"

echo -e "\nMise falhou ao iterar sobre o arquivo:"
echo -e "  \e[1mcabeçalho gzip inválido\e[0m"

echo -e "\nExecute com \e[1m--verbose\e[0m ou defina \e[1mMISE_VERBOSE=1\e[0m para mais informações."

echo -e "\nComando malsucedido:"
echo -e "  \e[1m mise use -g python@3.12\e[0m"
