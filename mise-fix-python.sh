#!/bin/bash

PYTHON_VERSION="3.12"
DOWNLOAD_DIR="$HOME/.local/share/mise/downloads/python/$PYTHON_VERSION"
TAR_PATTERN="cpython-$PYTHON_VERSION*tar.zst"

echo -e "\e[1;34m🔧 Mise: tentando usar Python $PYTHON_VERSION...\e[0m"

OUTPUT=$(mise use -g python@"$PYTHON_VERSION" 2>&1) || true

if echo "$OUTPUT" | grep -qi "cabeçalho gzip inválido"; then
  echo -e "\e[1;31m❌ Erro detectado: cabeçalho gzip inválido ao extrair o arquivo.\e[0m"
  echo -e "\e[1;33m🧹 Limpando arquivo corrompido...\e[0m"
  rm -fv "$DOWNLOAD_DIR"/$TAR_PATTERN || true

  echo -e "\e[1;36m♻️ Tentando reinstalar Python $PYTHON_VERSION via mise...\e[0m"
  OUTPUT_REINSTALL=$(mise use -g python@"$PYTHON_VERSION" 2>&1) || true

  if echo "$OUTPUT_REINSTALL" | grep -qi "cabeçalho gzip inválido"; then
    echo -e "\e[1;31m⚠️ Reinstalação falhou novamente pelo mesmo erro.\e[0m"
    echo -e "\e[1;33m🛑 Este erro ocorreu permanentemente. Por favor, execute com \e[1m--verbose\e ou defina \e[1mMISE_VERBOSE=1\e para mais detalhes.\e[0m"
    exit 1
  else
    echo -e "\e[1;32m✅ Python $PYTHON_VERSION reinstalado com sucesso via mise!\e[0m"
  fi

elif echo "$OUTPUT" | grep -qi "failed"; then
  echo -e "\e[1;31m⚠️ Erro desconhecido durante a instalação:\e[0m"
  echo "$OUTPUT"
  exit 1
else
  echo -e "\e[1;32m✅ Python $PYTHON_VERSION instalado com sucesso via mise!\e[0m"
fi
