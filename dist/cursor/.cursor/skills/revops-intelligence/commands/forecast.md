---
name: forecast
description: >
  Genera un pronóstico de revenue con tres escenarios (peor caso, caso base,
  mejor caso), gap analysis vs. objetivo, y recomendaciones específicas para
  cerrar el gap. Ajusta por win rate histórico real del equipo.
user-invocable: true
---

# /forecast — Revenue Forecast

## Propósito

Producir un forecast de revenue riguroso, ajustado por datos históricos reales del equipo, con tres escenarios y un plan concreto para cerrar cualquier gap identificado. El objetivo no es "predecir el futuro" sino tomar decisiones hoy basadas en la mejor información disponible.

## Cuándo Usar Este Comando

- Al inicio de cada mes o trimestre para establecer el punto de partida
- En la revisión semanal de forecast con el equipo directivo
- Cuando el pipeline cambia significativamente (deal grande perdido o ganado)
- Para comunicar expectativas al board o a inversores
- Cuando el equipo debate si el objetivo del período es alcanzable

## Input Esperado

```
/forecast
Objetivo del período: €[X]
Período: [mes/trimestre] [año]
Días restantes en el período: [N]

Pipeline actual por etapa:
- Prospecting: €X ([N] deals)
- Discovery: €X ([N] deals)
- Proposal: €X ([N] deals)
- Negotiation: €X ([N] deals)
- Verbal Commit: €X ([N] deals)

Revenue ya cerrado este período: €[X]
Win rate histórico del equipo (últimos 90 días): [X%]
Slippage rate histórico (deals prometidos que no cerraron): [X%]
```

---

## Proceso de Análisis

### Módulo 1 — Pipeline Ponderado Base

Aplicar probabilidades por etapa al pipeline actual:

```
Forecast base = Σ (Deal Value × Stage Probability)
```

**Probabilidades por etapa (ajustar con datos propios):**
| Etapa | Probabilidad default | Ajuste recomendado |
|-------|---------------------|-------------------|
| Prospecting | 5% | Usar si el ciclo es <30 días, si no excluir |
| Discovery | 15% | — |
| Demo / Qualified | 30% | — |
| Proposal enviada | 50% | — |
| Negotiation | 75% | — |
| Verbal Commit | 90% | — |

**Importante**: Las probabilidades por etapa son hipótesis. Son un punto de partida, no el número final.

### Módulo 2 — Ajuste por Win Rate Real

Este es el paso que más equipos se saltan y que más impacto tiene en la precisión:

```
Win Rate Real = Deals ganados / Total deals trabajados (últimos 90 días)
Win Rate Asumido = Probabilidad promedio ponderada del pipeline actual

Factor de ajuste = Win Rate Real / Win Rate Asumido
Forecast ajustado = Forecast base × Factor de ajuste
```

**Ejemplo:**
- Pipeline ponderado base: €350K
- Win rate asumido implícito: 38%
- Win rate real del equipo (90 días): 24%
- Factor de ajuste: 24/38 = 0.63
- Forecast ajustado: €350K × 0.63 = **€220K** (no €350K)

Este ajuste es incómodo pero necesario. Un forecast sin este ajuste es optimismo disfrazado de análisis.

### Módulo 3 — Tres Escenarios

**Peor Caso (Floor)**
```
= (Deals en Negotiation + Verbal Commit) × 0.85
+ Revenue ya cerrado en el período
```
Descuento del 15% por slippage y deals que se caen en el último momento. Si el slippage histórico es mayor, usar ese número.

**Caso Base (Most Likely)**
```
= Forecast ajustado por win rate real
+ Revenue ya cerrado en el período
```
Este es el número que se comunica al liderazgo como "el número esperado".

**Mejor Caso (Best Case)**
```
= Caso base
+ Deals en Proposal con ≥3 interacciones recientes × 0.65
+ Revenue ya cerrado en el período
```
El mejor caso solo incluye deals con engagement activo. No incluir "el deal de €200K que el rep dice que va a cerrar" sin evidencia.

### Módulo 4 — Gap Analysis

```
Gap = Objetivo del período − Forecast caso base
```

Si el gap es positivo (se va a cumplir el objetivo): identificar riesgos de slippage y cuáles son los deals críticos a proteger.

Si el gap es negativo (shortfall proyectado):
```
Pipeline adicional necesario = Gap / Win Rate Real
Deals adicionales necesarios = Pipeline adicional / ACV promedio
```

**Tiempo de generación:**
¿Es posible generar ese pipeline adicional con los días restantes del período?
```
Tiempo de generación mínimo = Sales cycle promedio en días
Si días restantes < Sales cycle promedio → el gap NO puede cerrarse con nuevo pipeline
```
En ese caso, el plan de acción debe enfocarse en:
1. Proteger los deals existentes (evitar slippage)
2. Acelerar deals en etapas intermedias
3. Negociar objetivos o revisar con liderazgo

### Módulo 5 — Deal-Level Commit

Identificar los deals específicos que componen el "commit" del período:
- ¿Cuáles son los 5–10 deals que el equipo se compromete a cerrar?
- ¿Qué riesgo específico tiene cada uno?
- ¿Cuál es el plan de mitigación para cada riesgo?

El commit es diferente al forecast: el forecast es probabilístico, el commit es un compromiso concreto del equipo.

---

## Output del Comando

```
## 🔮 Revenue Forecast
**Período**: [mes/trimestre año]
**Fecha del forecast**: [fecha]
**Días restantes**: [N]

### Resumen Ejecutivo
[Estado en 2–3 líneas: ¿vamos a cumplir el objetivo? ¿Cuál es el gap? ¿Cuál es la acción más urgente?]

### Escenarios de Forecast
| Escenario | Proyección | vs. Objetivo | Probabilidad |
|-----------|-----------|-------------|-------------|
| Peor caso | €X | ▼ X% | 20% |
| Caso base | €X | ▲/▼ X% | 60% |
| Mejor caso | €X | ▲ X% | 20% |

Revenue ya cerrado: €X (X% del objetivo)
Objetivo del período: €X

### Pipeline Ponderado Detallado
| Etapa | Pipeline | Prob. | Weighted | Deals |
|-------|---------|-------|---------|-------|
| Verbal Commit | €X | 90% | €X | N |
| Negotiation | €X | 75% | €X | N |
| Proposal | €X | 50% | €X | N |
| Qualified | €X | 30% | €X | N |
| Discovery | €X | 15% | €X | N |
| **Total** | **€X** | — | **€X** | **N** |

Factor de ajuste (win rate real vs. asumido): ×X.XX
**Forecast ajustado**: **€X**

### Gap Analysis
| Métrica | Valor |
|---------|-------|
| Objetivo | €X |
| Forecast caso base | €X |
| Gap | €X (▲/▼ X%) |
| Pipeline adicional necesario | €X |
| Deals adicionales necesarios | N deals de €X ACV |
| ¿Es alcanzable con días restantes? | Sí / No (ciclo promedio: X días) |

### Deals en Commit (promesas concretas)
| Deal | Etapa | Valor | Fecha de cierre | Riesgo | Mitigation |
|------|-------|-------|----------------|--------|------------|
| [Empresa] | [Etapa] | €X | [fecha] | Bajo/Medio/Alto | [Acción] |

### ⚡ Acciones para Cerrar el Gap
1. **[Acción concreta]** — Impacto: €X — Owner: [Rol] — Deadline: [fecha]
2. **[Acción concreta]** — Impacto: €X — Owner: [Rol] — Deadline: [fecha]
3. **[Acción estructural]** — Impacto: €X — Owner: [Rol] — Deadline: [fecha]

### 🚨 Alertas
- [Deals de alto valor con riesgo de slippage]
- [Si el objetivo es inalcanzable en el período — con justificación de datos]
- [Tendencias negativas en el win rate reciente]
```

---

## Errores Comunes a Evitar

- **No ajustar por win rate real** → el forecast queda inflado sistemáticamente
- **Incluir el "mejor caso" como el forecast** → genera expectativas falsas y pierde credibilidad
- **Cambiar el forecast semanalmente sin explicación** → el forecast debe ser estable o el cambio debe explicarse
- **Confundir "pipeline ponderado" con "revenue comprometido"** → son categorías distintas
- **No hacer gap analysis** → si no sabes el gap, no puedes planear cómo cerrarlo
- **Forecast de equipo sin desglose por rep** → los problemas individuales desaparecen en el agregado
