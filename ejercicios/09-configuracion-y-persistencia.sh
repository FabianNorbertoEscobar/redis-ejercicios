#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: consultar la configuración que se carga desde redis.conf.
redis CONFIG GET appendonly    # yes: AOF activado
redis CONFIG GET save          # snapshot según la configuración
redis CONFIG GET dir           # /data: volumen persistente

# Consigna: verificar que una clave sobrevive al reinicio del contenedor.
# Atención: este comando reinicia Redis y desconecta a los demás clientes.
redis SET curso:ej09:persistencia sobrevive
docker compose restart redis
valor=$(redis --raw GET curso:ej09:persistencia)
if [[ "$valor" != "sobrevive" ]]; then
    echo "La clave no sobrevivió al reinicio" >&2
    exit 1
fi
echo "Valor después del reinicio: $valor"

# AOF y RDB ayudan a persistir datos, pero no garantizan pérdida cero.
# Editá redis.conf y recreá el contenedor para aplicar cambios de configuración.
