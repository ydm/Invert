# Invert

Logically invert (some) C conditions.  Do not expect stars, that's not
even a real project.

#### TODO

Parsing, etc.

#### Output (yep, it's hard-coded)

```
1e-6f >= time && (0 >= mppp || mppp > 1000) && 0.005f > noise
1e-6f < time || (0 < mppp && mppp <= 1000) || 0.005f <= noise
```