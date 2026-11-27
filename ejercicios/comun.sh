#!/usr/bin/env bash
# Ejecutar redis-cli dentro del servicio, independientemente del directorio actual.
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit 1

redis() {
    docker compose exec -T redis redis-cli -e "$@"
}
