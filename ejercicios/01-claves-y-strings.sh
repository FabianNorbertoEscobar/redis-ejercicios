#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: guardar y recuperar un nombre. Redis almacena claves, no variables.
redis SET curso:ej01:nombre "Ana"
redis GET curso:ej01:nombre

# Consigna: construir un saludo y consultar su tipo.
redis SET curso:ej01:saludo "Hola"
redis APPEND curso:ej01:saludo " Redis"
redis GET curso:ej01:saludo          # Hola Redis
redis TYPE curso:ej01:saludo         # string

# Consigna: comprobar una clave inexistente y borrar el saludo.
redis DEL curso:ej01:inexistente
redis EXISTS curso:ej01:inexistente  # 0
redis DEL curso:ej01:saludo
redis GET curso:ej01:saludo          # valor inexistente

# NX no sobrescribe una clave existente; XX solo escribe si existe.
redis SET curso:ej01:nombre "Otra persona" NX
redis GET curso:ej01:nombre          # Ana
redis SET curso:ej01:nombre "Beto" XX
redis GET curso:ej01:nombre          # Beto
