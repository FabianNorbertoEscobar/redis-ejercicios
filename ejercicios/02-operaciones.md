# 2. Operaciones básicas y contadores

Redis puede incrementar strings que representan números enteros. Cada
operación individual se ejecuta de forma atómica.

## Practicá

1. Inicializá `curso:visitas` en `0`.
2. Incrementalo dos veces y sumale `8` en una sola operación.
3. Restale `3` y recuperá el resultado.
4. Guardá dos claves, `curso:ciudad` y `curso:pais`, con una sola instrucción;
   leelas juntas.

**Comprobación:** el contador termina en `7`; la lectura conjunta devuelve los
dos valores en el mismo orden en que se pidieron.

<details>
<summary>Una solución posible</summary>

```redis
SET curso:visitas 0
INCR curso:visitas
INCR curso:visitas
INCRBY curso:visitas 8
DECRBY curso:visitas 3
GET curso:visitas
MSET curso:ciudad "Buenos Aires" curso:pais "Argentina"
MGET curso:ciudad curso:pais
```

</details>

**Desafío:** creá un string que no sea numérico e intentá incrementarlo.
Observá el error y verificá que su valor original no cambió.
