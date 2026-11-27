# 4. Sorted sets

Un sorted set asocia cada miembro único con un puntaje. Redis lo ordena por
puntaje ascendente y, en caso de empate, por miembro.

## Practicá

1. Borrá `curso:ranking` y agregá a `ana` con 100 puntos, `beto` con 70 y
   `cami` con 90.
2. Mostrá el ranking de mayor a menor junto con los puntajes.
3. Sumale 20 puntos a `beto` y consultá su puntaje.
4. Mostrá los miembros con puntajes entre 90 y 100, incluidos ambos extremos.

**Comprobación:** inicialmente el ranking es `ana` (100), `cami` (90), `beto`
(70). Después, `beto` tiene 90 y los tres están en el rango solicitado.

<details>
<summary>Una solución posible</summary>

```redis
DEL curso:ranking
ZADD curso:ranking 100 ana 70 beto 90 cami
ZRANGE curso:ranking 0 -1 REV WITHSCORES
ZINCRBY curso:ranking 20 beto
ZSCORE curso:ranking beto
ZRANGE curso:ranking 90 100 BYSCORE WITHSCORES
```

</details>

**Desafío:** consultá la posición de `ana` de mayor a menor con `ZREVRANK`.
Recordá que las posiciones empiezan en cero.
