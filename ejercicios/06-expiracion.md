# 6. Expiración

Una clave con tiempo de vida se elimina cuando vence. `TTL` devuelve los
segundos restantes, `-1` si existe sin vencimiento y `-2` si no existe.

## Practicá

1. Creá `curso:sesion` con valor `activa` y vencimiento de 30 segundos.
2. Consultá su tiempo restante y recuperá el valor antes de que venza.
3. Cambiá el vencimiento a 5 segundos. Esperá al menos 5 segundos y consultá
   la clave y su TTL.
4. Creá `curso:preferencia` con vencimiento, quitáselo y consultá su TTL.

**Comprobación:** la sesión desaparece y su TTL termina en `-2`; la preferencia
sigue existiendo y su TTL es `-1`. El tiempo restante puede disminuir mientras
ejecutás los comandos.

<details>
<summary>Una solución posible</summary>

```redis
SET curso:sesion activa EX 30
TTL curso:sesion
GET curso:sesion
EXPIRE curso:sesion 5
```

Esperá al menos 5 segundos y continuá:

```redis
GET curso:sesion
TTL curso:sesion
SET curso:preferencia oscuro EX 60
PERSIST curso:preferencia
TTL curso:preferencia
```

</details>

**Desafío:** creá una clave con vencimiento y sobrescribila con `SET` sin
`EX`. ¿Qué ocurre con su TTL? Investigá la opción `KEEPTTL`.
