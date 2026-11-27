# 3. Sets

Un set es una colección de miembros únicos y sin orden garantizado. Es útil,
por ejemplo, para representar etiquetas o participantes.

## Practicá

1. Borrá `curso:redis` y `curso:python` para empezar desde cero.
2. Agregá `ana`, `beto` y `cami` al set de Redis; agregá `beto` y `dani`
   al de Python.
3. Agregá `ana` otra vez y comprobá cuántos miembros tiene el primer set.
4. Consultá quiénes están en ambos cursos, quiénes están en al menos uno y
   quiénes están en Redis pero no en Python.

**Comprobación:** el primer set tiene 3 miembros; la intersección contiene
solo `beto`; la unión contiene 4 miembros; la diferencia contiene `ana` y
`cami`. El orden de los resultados puede variar.

<details>
<summary>Una solución posible</summary>

```redis
DEL curso:redis curso:python
SADD curso:redis ana beto cami
SADD curso:python beto dani
SADD curso:redis ana
SCARD curso:redis
SINTER curso:redis curso:python
SUNION curso:redis curso:python
SDIFF curso:redis curso:python
```

</details>

**Desafío:** verificá si `dani` está en `curso:redis` y luego agregalo. ¿Qué
devuelve `SADD` cuando el miembro ya existía?
