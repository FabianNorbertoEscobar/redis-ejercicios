"""Primeros comandos de Redis desde Python."""

import os

import redis


def main():
    with redis.Redis(
        host="127.0.0.1",
        port=int(os.environ.get("REDIS_PORT", "6379")),
        decode_responses=True,
    ) as cliente:
        cliente.set("curso:python:nombre", "Ana")
        visitas = cliente.incr("curso:python:visitas")
        nombre = cliente.get("curso:python:nombre")
        print(f"Nombre: {nombre}")
        print(f"Visitas: {visitas}")


if __name__ == "__main__":
    main()
