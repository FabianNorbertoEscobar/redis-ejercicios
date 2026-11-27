# Redis: ejercicios introductorios

Un recorrido práctico para aprender Redis usando Docker, `redis-cli` y Python.
Cada módulo incluye consignas, resultados esperados y soluciones para consultar
después de intentarlo. Podés repetir los ejercicios: usan claves de ejemplo.

## Requisitos

- Docker y el complemento Docker Compose (`docker compose`).
- Para el último módulo: Python 3.9 o superior y `pip`.

## Empezar

Desde esta carpeta, iniciá Redis y abrí su consola:

```bash
docker compose up -d
docker compose exec redis redis-cli
```

En `redis-cli`, ejecutá `PING`: debería responder `PONG`. Escribí `QUIT` para
salir. Los bloques marcados como `redis` se ejecutan **dentro de redis-cli**;
los marcados como `bash`, en una terminal del sistema.

El servidor escucha en `127.0.0.1:6379` de tu máquina. Si ese puerto ya está
ocupado, cambiá el puerto del lado izquierdo en `compose.yaml` y usá ese mismo
puerto para conectar desde Python. `docker compose exec` sigue funcionando igual.

## Recorrido

1. [Claves y strings](ejercicios/01-claves-y-strings.md)
2. [Operaciones básicas y contadores](ejercicios/02-operaciones.md)
3. [Sets](ejercicios/03-sets.md)
4. [Sorted sets](ejercicios/04-sorted-sets.md)
5. [Hashes](ejercicios/05-hashes.md)
6. [Expiración](ejercicios/06-expiracion.md)
7. [Transacciones](ejercicios/07-transacciones.md)
8. [Pub/Sub](ejercicios/08-pubsub.md)
9. [Configuración y persistencia](ejercicios/09-configuracion-y-persistencia.md)
10. [Conexión con Python](ejercicios/10-python.md)

## Detener y retomar

```bash
docker compose stop       # Detiene el servidor, conserva los datos.
docker compose start      # Lo inicia de nuevo.
docker compose down       # Quita el contenedor, conserva el volumen.
```

Los datos se guardan en un volumen de Docker. Para **borrar todos los datos de
este proyecto**, ejecutá `docker compose down -v`: esto elimina también el volumen.
No ejecutes `FLUSHALL` en servidores compartidos o con datos importantes.

La configuración es para aprendizaje local: no tiene contraseña ni TLS. No
expongas el puerto a Internet ni la uses tal cual en producción. Redis es
case-insensitive para los comandos, pero las claves y los valores distinguen
mayúsculas de minúsculas.
