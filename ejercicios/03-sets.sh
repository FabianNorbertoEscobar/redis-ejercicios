#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/comun.sh"

# Consigna: representar participantes de dos cursos con conjuntos sin duplicados.
redis DEL curso:ej03:redis curso:ej03:python
redis SADD curso:ej03:redis ana beto cami
redis SADD curso:ej03:python beto dani
redis SADD curso:ej03:redis ana     # 0: ya estaba
redis SCARD curso:ej03:redis        # 3

# Consigna: comparar los conjuntos. El orden de los resultados puede variar.
redis SINTER curso:ej03:redis curso:ej03:python  # beto
redis SUNION curso:ej03:redis curso:ej03:python  # 4 participantes
redis SDIFF curso:ej03:redis curso:ej03:python   # ana y cami
redis SISMEMBER curso:ej03:redis dani            # 0
redis SADD curso:ej03:redis dani
redis SISMEMBER curso:ej03:redis dani            # 1
