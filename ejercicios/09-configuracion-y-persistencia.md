# 9. Configuración y persistencia

El archivo [`redis.conf`](../redis.conf) activa AOF y un snapshot RDB cuando
hubo al menos un cambio en 60 segundos. AOF registra operaciones de escritura;
RDB guarda instantáneas. Tener persistencia no garantiza que nunca se pierda
ningún dato: la durabilidad depende, entre otras cosas, de la sincronización
de AOF y de cómo se detenga el servidor.

## Practicá

1. En `redis-cli`, consultá las opciones `appendonly`, `save` y `dir` con
   `CONFIG GET`. Comprobá que los datos se escriben en `/data`.
2. Guardá `curso:persistencia` con el valor `sobrevive`.
3. Salí de `redis-cli`, reiniciá el servicio y volvé a consultar la clave.
4. Revisá el volumen configurado en `compose.yaml`. ¿Qué comando del README
   elimina ese volumen y, por lo tanto, los datos?

**Comprobación:** `appendonly` responde `yes` y la clave conserva el valor
después del reinicio. El volumen sobrevive a `docker compose down`, pero no a
`docker compose down -v`.

<details>
<summary>Una solución posible</summary>

En `redis-cli`:

```redis
CONFIG GET appendonly
CONFIG GET save
CONFIG GET dir
SET curso:persistencia sobrevive
QUIT
```

En la terminal:

```bash
docker compose restart redis
docker compose exec redis redis-cli GET curso:persistencia
```

</details>

**Desafío:** cambiá `save 60 1` por `save 120 1` en `redis.conf`, recreá el
contenedor con `docker compose up -d --force-recreate redis` y verificá la
opción. Restaurá después el archivo y recreá el contenedor. El archivo está
montado en modo lectura: para que un cambio persistente se aplique, editá el
archivo y recreá el contenedor; no dependas de `CONFIG REWRITE`.
