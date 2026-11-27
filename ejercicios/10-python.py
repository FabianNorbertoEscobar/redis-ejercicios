#!/usr/bin/env python3
"""Ejercicios resueltos con redis-py. Ejecutar con Redis iniciado."""

import os

import redis


def main():
    with redis.Redis(
        host="127.0.0.1",
        port=int(os.environ.get("REDIS_PORT", "6379")),
        decode_responses=True,
    ) as cliente:
        # Consigna: guardar un nombre e incrementar un contador.
        cliente.set("curso:ej10:nombre", "Ana")
        cliente.set("curso:ej10:visitas", 0)
        visitas = cliente.incr("curso:ej10:visitas")
        print("Nombre:", cliente.get("curso:ej10:nombre"))
        print("Visitas:", visitas)  # 1

        # Consigna: trabajar con un hash, una clave temporal y un set.
        cliente.hset("curso:ej10:usuario", mapping={"ciudad": "Rosario"})
        print("Ciudad:", cliente.hget("curso:ej10:usuario", "ciudad"))
        cliente.set("curso:ej10:temporal", "hola", ex=30)
        print("TTL:", cliente.ttl("curso:ej10:temporal"))
        cliente.delete("curso:ej10:lenguajes")
        cliente.sadd("curso:ej10:lenguajes", "Python", "Redis")
        print("Lenguajes:", sorted(cliente.smembers("curso:ej10:lenguajes")))

        # Consigna: agrupar dos incrementos en una transacción.
        with cliente.pipeline() as transaccion:
            transaccion.incr("curso:ej10:visitas")
            transaccion.incr("curso:ej10:visitas")
            print("Transacción:", transaccion.execute())  # [2, 3]

        # Consigna: observar un cambio concurrente con WATCH.
        cliente.set("curso:ej10:saldo", 100)
        with cliente.pipeline() as transaccion:
            try:
                transaccion.watch("curso:ej10:saldo")
                print("Saldo observado:", transaccion.get("curso:ej10:saldo"))
                cliente.incr("curso:ej10:saldo")  # otra conexión modifica la clave
                transaccion.multi()
                transaccion.decrby("curso:ej10:saldo", 10)
                transaccion.execute()
            except redis.WatchError:
                print("Transacción cancelada: el saldo cambió")
        print("Saldo final:", cliente.get("curso:ej10:saldo"))  # 101


if __name__ == "__main__":
    main()
