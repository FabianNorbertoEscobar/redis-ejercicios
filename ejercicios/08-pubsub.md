# 8. Pub/Sub

Pub/Sub permite publicar mensajes en canales a los que otros clientes están
suscritos. Los mensajes no se guardan para suscriptores que no están conectados.

## Practicá

Necesitás dos terminales. En cada una abrí `docker compose exec redis redis-cli`.

1. En la primera, suscribite al canal `curso:noticias`.
2. En la segunda, publicá `Hola Redis` en ese canal.
3. Publicá un segundo mensaje y observá ambas respuestas.
4. Salí de la consola suscrita con `Ctrl+C` y publicá otro mensaje.

**Comprobación:** la primera consola recibe los primeros dos mensajes. `PUBLISH`
devuelve `1` mientras hay un suscriptor y `0` después de que se desconecta.
El último mensaje no se entrega si el cliente vuelve a suscribirse.

<details>
<summary>Una solución posible</summary>

Primera consola:

```redis
SUBSCRIBE curso:noticias
```

Segunda consola:

```redis
PUBLISH curso:noticias "Hola Redis"
PUBLISH curso:noticias "Segundo mensaje"
```

Después de cerrar la primera consola:

```redis
PUBLISH curso:noticias "Sin suscriptores"
```

</details>

**Desafío:** probá `PSUBSCRIBE curso:*` y publicá en dos canales distintos
que coincidan con el patrón.
