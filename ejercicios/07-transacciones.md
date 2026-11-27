# 7. Transacciones

`MULTI` encola comandos y `EXEC` los ejecuta sin intercalar comandos de otros
clientes. Redis no hace rollback automático de errores de ejecución: los demás
comandos encolados pueden ejecutarse. `DISCARD` cancela la cola antes de `EXEC`.

## Practicá

1. Inicializá `curso:saldo` en `100`.
2. Dentro de una transacción, restale `30` y sumale `10`. Ejecutala y consultá
   el saldo.
3. Iniciá otra transacción, encolá una resta de `50` y cancelala.
4. Consultá nuevamente el saldo.

**Comprobación:** luego de la primera transacción el saldo es `80`; tras
cancelar la segunda sigue siendo `80`. Antes de `EXEC`, los comandos muestran
`QUEUED`, no su resultado final.

<details>
<summary>Una solución posible</summary>

```redis
SET curso:saldo 100
MULTI
DECRBY curso:saldo 30
INCRBY curso:saldo 10
EXEC
GET curso:saldo
MULTI
DECRBY curso:saldo 50
DISCARD
GET curso:saldo
```

</details>

## Desafío: concurrencia optimista

Abrí dos consolas `redis-cli`. En la primera ejecutá `WATCH curso:saldo` y
`GET curso:saldo`. En la segunda modificá la clave con `INCR curso:saldo`.
Volvé a la primera y ejecutá `MULTI`, `DECRBY curso:saldo 10` y `EXEC`.
La transacción se aborta porque la clave observada cambió. Para reintentar,
volvé a observar y leer la clave antes de preparar otra transacción.
