#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: crear una sesión temporal y observar su vencimiento.
redis SET curso:ej06:sesion activa EX 30
redis TTL curso:ej06:sesion
redis GET curso:ej06:sesion
redis EXPIRE curso:ej06:sesion 2
sleep 3
redis GET curso:ej06:sesion           # valor inexistente
redis TTL curso:ej06:sesion           # -2: la clave no existe

# Consigna: quitar el vencimiento sin borrar el valor.
redis SET curso:ej06:preferencia oscuro EX 60
redis PERSIST curso:ej06:preferencia
redis TTL curso:ej06:preferencia       # -1: existe sin vencimiento

# SET normalmente quita el TTL; KEEPTTL lo conserva.
redis SET curso:ej06:temporal primero EX 60
redis SET curso:ej06:temporal segundo KEEPTTL
redis TTL curso:ej06:temporal          # sigue teniendo vencimiento
redis SET curso:ej06:temporal tercero
redis TTL curso:ej06:temporal          # -1
