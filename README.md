# Redis: ejercicios prácticos

Ejercicios **resueltos y ejecutables** para practicar Redis con `redis-cli`,
Docker y Python. Cada script contiene las consignas y aclaraciones como
comentarios. Leelos, ejecutalos y modificá los comandos para experimentar.

## Preparación

Necesitás Docker, Docker Compose y Bash (en Windows, por ejemplo, WSL).
Desde la raíz del proyecto:

```bash
docker compose up -d
bash ejercicios/01-claves-y-strings.sh
```

Los scripts usan `docker compose exec` para ejecutar `redis-cli` dentro del
contenedor. También podés abrir la consola y probar comandos por tu cuenta:

```bash
docker compose exec redis redis-cli
```

## Ejercicios

Ejecutá los scripts desde la raíz del repositorio:

| Tema | Comando |
| --- | --- |
| Claves y strings | `bash ejercicios/01-claves-y-strings.sh` |
| Operaciones y contadores | `bash ejercicios/02-operaciones.sh` |
| Sets | `bash ejercicios/03-sets.sh` |
| Sorted sets | `bash ejercicios/04-sorted-sets.sh` |
| Hashes | `bash ejercicios/05-hashes.sh` |
| Expiración | `bash ejercicios/06-expiracion.sh` |
| Transacciones | `bash ejercicios/07-transacciones.sh` |
| Pub/Sub | `bash ejercicios/08-pubsub.sh` |
| Configuración y persistencia | `bash ejercicios/09-configuracion-y-persistencia.sh` |
| Python | `python ejercicios/10-python.py` |

El ejercicio de persistencia **reinicia el contenedor Redis**. Los scripts
modifican sus propias claves `curso:ejXX:*`; podés volver a ejecutarlos sin
usar `FLUSHALL`. El ejercicio de Pub/Sub necesita unos segundos y crea un canal
temporal.

## Python

Con Python 3.9 o superior:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python ejercicios/10-python.py
```

En Windows, activá el entorno con `.venv\Scripts\activate`. El script conecta a
`127.0.0.1:6379`; si cambiaste el puerto publicado en `compose.yaml`, indicá
el nuevo puerto, por ejemplo: `REDIS_PORT=6380 python ejercicios/10-python.py`.

## Detener el entorno

`docker compose stop` detiene Redis y `docker compose start` lo vuelve a
iniciar. `docker compose down` elimina el contenedor, pero conserva el volumen.
**`docker compose down -v` elimina también el volumen y todos sus datos.**

La configuración es solo para aprendizaje local: el puerto se publica en
`127.0.0.1`, sin contraseña ni TLS. No la expongas a Internet ni la uses tal
cual en producción.
