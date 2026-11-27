#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: suscribir un cliente y publicar dos mensajes desde otro.
# El canal es único por ejecución para no interferir con otros ejercicios.
canal="curso:ej08:noticias:$$"
coproc SUSCRIPTOR { redis --raw; }
pid=$SUSCRIPTOR_PID
entrada=${SUSCRIPTOR[1]}
salida=${SUSCRIPTOR[0]}
limpiar() {
    exec {entrada}>&-
    wait "$pid" || true
}
trap limpiar EXIT

# Redis responde con tres líneas: tipo, canal y cantidad o mensaje.
leer_evento() {
    local tipo canal_recibido contenido
    if ! IFS= read -r -t 10 tipo <&"$salida" ||
       ! IFS= read -r -t 10 canal_recibido <&"$salida" ||
       ! IFS= read -r -t 10 contenido <&"$salida"; then
        echo "No se recibió el evento de Pub/Sub a tiempo" >&2
        return 1
    fi
    if [[ "$tipo" != "$1" || "$canal_recibido" != "$canal" || "$contenido" != "$2" ]]; then
        echo "Evento inesperado: $tipo / $canal_recibido / $contenido" >&2
        return 1
    fi
    echo "$tipo: $contenido"
}

printf 'SUBSCRIBE %s\n' "$canal" >&"$entrada"
leer_evento subscribe 1             # esperar antes de publicar
redis PUBLISH "$canal" "Hola Redis"  # 1 suscriptor
leer_evento message "Hola Redis"
redis PUBLISH "$canal" "Segundo mensaje"
leer_evento message "Segundo mensaje"

# Cerrar la entrada termina redis-cli y libera la suscripción.
# Pub/Sub no conserva mensajes para clientes desconectados.
