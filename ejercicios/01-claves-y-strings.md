# 1. Claves y strings

En Redis guardamos **claves** y valores, no variables de un lenguaje de
programación. Una clave puede contener un string; los números también se
almacenan como strings. Abrí `redis-cli` como se indica en el README.

## Practicá

1. Guardá tu nombre en `curso:nombre` y recuperalo.
2. Guardá `Hola` en `curso:saludo` y agregale ` Redis` al final.
3. Consultá el tipo de `curso:saludo` y si existe `curso:inexistente`.
4. Borrá `curso:saludo` y consultalo de nuevo.

**Comprobación:** el saludo completo es `Hola Redis`, su tipo es `string`,
`EXISTS` devuelve `0` para la clave inexistente y `GET` devuelve `(nil)` para
la clave borrada.

<details>
<summary>Una solución posible</summary>

```redis
SET curso:nombre "Ana"
GET curso:nombre
SET curso:saludo "Hola"
APPEND curso:saludo " Redis"
GET curso:saludo
TYPE curso:saludo
EXISTS curso:inexistente
DEL curso:saludo
GET curso:saludo
```

</details>

**Desafío:** probá `SET curso:nombre "Otra persona" NX` cuando la clave ya
existe. ¿Cambia el valor? Buscá también qué hace la opción `XX`.
