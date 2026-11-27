# 10. Conexión con Python

El ejemplo usa `redis-py` para guardar un nombre, incrementar un contador y
leer ambos valores. El servidor debe estar iniciado como indica el README.

## Preparación

En una terminal, desde la raíz del proyecto:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python python/ejemplo.py
```

En Windows, activá el entorno con `.venv\Scripts\activate` en lugar de `source`.
Si cambiaste el puerto publicado, ejecutá, por ejemplo,
`REDIS_PORT=6380 python python/ejemplo.py` en Linux/macOS, o configurá la
variable de entorno equivalente en Windows.

**Comprobación:** el programa muestra el nombre `Ana` y un número de visitas.
Cada ejecución incrementa el contador en uno. Si Redis no está disponible,
el error de conexión se muestra en lugar de simular un resultado exitoso.

## Practicá

1. Leé `python/ejemplo.py` e identificá dónde se crea el cliente.
2. Agregá un campo `ciudad` a un hash `curso:python:usuario` y leelo.
3. Creá una clave temporal con vencimiento de 30 segundos y consultá su TTL.
4. Creá un set de dos lenguajes y mostrálos. Recordá que no tienen orden
   garantizado.

<details>
<summary>Pistas para agregar dentro del bloque del cliente</summary>

```python
cliente.hset("curso:python:usuario", mapping={"ciudad": "Rosario"})
print(cliente.hget("curso:python:usuario", "ciudad"))
cliente.set("curso:python:temporal", "hola", ex=30)
print(cliente.ttl("curso:python:temporal"))
cliente.sadd("curso:python:lenguajes", "Python", "Redis")
print(cliente.smembers("curso:python:lenguajes"))
```

</details>

**Desafío:** usá un pipeline transaccional (`cliente.pipeline()`) para
encolar dos incrementos y ejecutarlos juntos con `execute()`.
