#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: realizar dos operaciones juntas sobre el saldo.
redis SET curso:ej07:saldo 100
# MULTI y EXEC deben usar la misma conexión: enviamos todo a un solo redis-cli.
redis <<'REDIS'
MULTI
DECRBY curso:ej07:saldo 30
INCRBY curso:ej07:saldo 10
EXEC
REDIS
redis GET curso:ej07:saldo             # 80

# Consigna: cancelar una transacción antes de ejecutarla.
redis <<'REDIS'
MULTI
DECRBY curso:ej07:saldo 50
DISCARD
REDIS
redis GET curso:ej07:saldo             # sigue en 80

# Redis no hace rollback de errores durante EXEC: los demás comandos pueden
# ejecutarse. En 10-python.py se practica WATCH con dos conexiones.
