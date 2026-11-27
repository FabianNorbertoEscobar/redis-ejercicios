#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: guardar los campos de un usuario en una sola clave.
redis DEL curso:ej05:usuario:1
redis HSET curso:ej05:usuario:1 nombre Ana ciudad Rosario puntos 10
redis HGET curso:ej05:usuario:1 nombre
redis HGETALL curso:ej05:usuario:1    # el orden de los campos puede variar

# Consigna: sumar puntos y quitar un campo.
redis HINCRBY curso:ej05:usuario:1 puntos 5
redis HDEL curso:ej05:usuario:1 ciudad
redis HGET curso:ej05:usuario:1 puntos      # 15
redis HEXISTS curso:ej05:usuario:1 ciudad   # 0
redis HSET curso:ej05:usuario:1 email ana@example.com
redis HMGET curso:ej05:usuario:1 nombre email
