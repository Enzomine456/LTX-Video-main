#!/bin/bash

# Tenta ativar o Python 3.12 com mise
OUTPUT=$(mise use -g python@3.12 2>&1)

# Verifica se ocorreu erro de gzip
if echo "$OUTPUT" | grep -qi "cabeçalho gzip inválido"; then
  echo -e "\e[1;34m🔧 Mise:\e[0m Instalando Python pré-compilado de \e[1mindygreg/python-build-standalone\e[0m"

  echo -e "\e[1;33m💡 Dica:\e[0m Se você tiver problemas com esse Python (ex: ao usar \e[1mPoetry\e[0m), mude para o backend \e[1mpython-build\e[0m:"
  echo -e "  \e[1;37mmise settings set python_plugin_use_build 1\e[0m"

  echo -e "\e[1;36m⚙️ Executando:\e[0m mise settings set python_compile 1"

  echo -e "\e[1;32m⬇️ Baixando:\e[0m cpython-3.12.11+20250723-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst"
  echo -e "\e[1;34m📦 Instalando:\e[0m cpython-3.12.11+20250723-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst"

  echo -e "\e[1;31m❌ Erro:\e[0m Falha ao extrair o arquivo:"
  echo -e "  \e[3m~/.local/share/mise/downloads/python/3.12.11/cpython-3.12.11+20250723-*.tar.zst\e[0m"
  echo -e "  → para \e[3m~/.local/share/mise/downloads/python/3.12.11\e[0m"

  echo -e "\e[1;31m🚫 Causa:\e[0m Falha ao iterar sobre o arquivo – \e[1mcabeçalho gzip inválido\e[0m."

  echo -e "\e[1;33m🧪 Diagnóstico:\e[0m Execute com \e[1;37m--verbose\e[0m ou defina \e[1;37mMISE_VERBOSE=1\e[0m para mais detalhes."

  echo -e "\e[1;31m📛 Comando malsucedido:\e[0m mise use -g python@3.12"
else
  echo -e "\e[1;32m✅ Python 3.12 instalado com sucesso via mise!\e[0m"
fi
