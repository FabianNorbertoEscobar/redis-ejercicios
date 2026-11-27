# 5. Hashes

Un hash agrupa campos y valores bajo una clave: es útil para representar un
objeto simple sin guardar cada propiedad como una clave independiente.

## Practicá

1. Borrá `curso:usuario:1` y creá un hash con `nombre` = `Ana`,
   `ciudad` = `Rosario` y `puntos` = `10`.
2. Leé el nombre y después todos los campos.
3. Incrementá los puntos en 5 y borrá el campo `ciudad`.
4. Comprobá el valor de `puntos` y si existe el campo borrado.

**Comprobación:** `puntos` vale `15` y `HEXISTS` devuelve `0` para `ciudad`.
El orden de `HGETALL` no es una garantía.

<details>
<summary>Una solución posible</summary>

```redis
DEL curso:usuario:1
HSET curso:usuario:1 nombre Ana ciudad Rosario puntos 10
HGET curso:usuario:1 nombre
HGETALL curso:usuario:1
HINCRBY curso:usuario:1 puntos 5
HDEL curso:usuario:1 ciudad
HGET curso:usuario:1 puntos
HEXISTS curso:usuario:1 ciudad
```

</details>

**Desafío:** agregá un campo `email` y leé únicamente `nombre` y `email` con
`HMGET`.
