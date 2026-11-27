#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: usar un string numérico como contador; cada operación es atómica.
redis SET curso:ej02:visitas 0
redis INCR curso:ej02:visitas
redis INCR curso:ej02:visitas
redis INCRBY curso:ej02:visitas 8
redis DECRBY curso:ej02:visitas 3
redis GET curso:ej02:visitas         # 7

# Consigna: guardar y leer varias claves en una sola instrucción.
redis MSET curso:ej02:ciudad "Buenos Aires" curso:ej02:pais "Argentina"
redis MGET curso:ej02:ciudad curso:ej02:pais

# Consigna: observar el error al incrementar un valor no numérico.
redis SET curso:ej02:texto "hola"
if error=$(redis INCR curso:ej02:texto 2>&1); then
    echo "Se esperaba un error al incrementar un texto" >&2
    exit 1
elif [[ "$error" == *"not an integer"* ]]; then
    echo "Error esperado: el valor no es un entero"
else
    echo "$error" >&2
    exit 1
fi
redis GET curso:ej02:texto           # hola, no cambió
