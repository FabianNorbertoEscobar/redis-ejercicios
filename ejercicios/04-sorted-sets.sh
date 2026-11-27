#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: crear un ranking ordenado por puntaje.
redis DEL curso:ej04:ranking
redis ZADD curso:ej04:ranking 100 ana 70 beto 90 cami
redis ZRANGE curso:ej04:ranking 0 -1 REV WITHSCORES  # ana, cami, beto

# Consigna: actualizar un puntaje y consultar el rango inclusivo 90-100.
redis ZINCRBY curso:ej04:ranking 20 beto
redis ZSCORE curso:ej04:ranking beto                 # 90
redis ZRANGE curso:ej04:ranking 90 100 BYSCORE WITHSCORES
redis ZREVRANK curso:ej04:ranking ana                # 0: primera posición
