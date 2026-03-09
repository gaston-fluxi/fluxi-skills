---
name: pipeline-health
description: >
  Diagnóstico completo del pipeline de ventas: cobertura, velocity, conversión
  por etapa, deals estancados y alertas de riesgo. Produce un dashboard de
  salud con acciones priorizadas.
user-invocable: true
---

# /pipeline-health — Diagnóstico de Pipeline

## Propósito

Generar un diagnóstico completo y accionable del pipeline de ventas actual. No solo "qué está pasando" sino "por qué está pasando" y "qué hacer al respecto" en las próximas 48 horas.

## Cuándo Usar Este Comando

- Antes de una pipeline review semanal o mensual
- Cuando el forecast del período está en riesgo
- Al incorporar un nuevo sales manager que necesita entender el estado actual
- Cuando la dirección pide visibilidad sobre el pipeline de forma urgente
- Al final de cada trimestre para diagnosticar qué salió mal o bien

## Input Esperado

**Con datos estructurados:**
```
/pipeline-health
[Lista de deals activos con: nombre, etapa, valor, días en etapa actual, último contacto, rep asignado]
Objetivo del período: [€X]
Días restantes en el período: [N]
```

**Con descripción cualitativa:**
```
/pipeline-health
Pipeline total: €[X]. Objetivo del mes: €[Y].
Tenemos [N] deals activos. Los más importantes son: [describe].
Preocupaciones: [menciona]
```

---

## Proceso de Análisis

### Módulo 1 — Coverage Ratio

```
Coverage = Total Pipeline Value / Revenue Target del período
```

**Interpretación:**
| Coverage | Estado | Acción |
|----------|--------|--------|
| < 2x | 🔴 Crítico | Escalación inmediata. Pipeline building es la prioridad #1. |
| 2x – 3x | 🟡 Riesgo | Revisar calidad + generar pipeline adicional en paralelo. |
| 3x – 5x | 🟢 Saludable | Mantener calidad. Revisar si los deals de abajo tienen ICP fit. |
| > 5x | ⚠️ Revisar calidad | Pipeline inflado es peor que pipeline pequeño. Auditar ICP fit. |

**Ajuste de calidad:**
Si el 40%+ del pipeline es de deals con ICP fit bajo (<60 score), el coverage real es menor al número bruto.

### Módulo 2 — Análisis por Etapa (Stage Analysis)

Para cada etapa del pipeline, calcular:
- **Volumen**: # de deals y valor total en esa etapa
- **Tiempo promedio en etapa**: Días × deal promedio
- **Conversion rate de esa etapa**: % que avanza a la siguiente
- **Deals estancados**: Deals con tiempo en etapa > 1.5x el promedio histórico

**Detección de cuellos de botella:**
Si la tasa de conversión de una etapa cae >15% vs. el trimestre anterior → investigar:
1. ¿Cambió el proceso de calificación en la etapa anterior?
2. ¿Hay un problema de messaging/propuesta en esta etapa?
3. ¿El rep tiene el entrenamiento necesario para esta etapa?
4. ¿Hay un patrón de loss por competidor en esta etapa?

### Módulo 3 — Pipeline Velocity

```
Velocity = (# Deals activos × Win Rate % × ACV promedio) / Sales Cycle (días)
```

Calcular velocity total y por rep/segmento. La variación en velocity entre reps del mismo equipo revela:
- Reps con mayor velocity → ¿qué hacen diferente? → replicar
- Reps con velocity cayendo → coaching inmediato

**Velocity benchmark:**
Comparar con el mismo período del trimestre anterior y del año anterior. Una caída de velocity > 20% sin explicación es una señal de alerta mayor.

### Módulo 4 — Stuck Deals (Análisis de Deals Estancados)

**Criterio de "estancado":**
- Deal sin actividad registrada en >14 días (ajustar si el ciclo de venta típico es >60 días)
- Deal en la misma etapa por >1.5x el tiempo promedio histórico en esa etapa

**Para cada deal estancado, identificar:**
1. ¿Cuándo fue el último contacto real (no un email enviado sin respuesta)?
2. ¿Hay un next step agendado?
3. ¿El champion sigue activo o se fue de la empresa?
4. ¿Hay un competidor posicionado?

**Decisión binaria para cada deal estancado:**
- **Re-qualify activamente**: El rep debe tener una conversación honesta sobre si el deal sigue vivo esta semana
- **Mover a "On Hold" o "Lost"**: Si no hay respuesta o el champion desapareció → sacar del pipeline activo para no contaminar el forecast

### Módulo 5 — Análisis por Rep

Para cada rep, calcular:
- Pipeline total vs. objetivo individual
- Win rate de los últimos 90 días
- Deals estancados como % de su pipeline total
- Forecast commitment vs. weighted pipeline (¿están sobrecomitiendo?)

**Patrones de alerta por rep:**
- Win rate <15% → problema de calificación o de cierre
- >40% del pipeline en etapas tempranas → prospecting fuerte pero debilidad en avance
- >30% del pipeline en deals estancados → evitación de conversaciones difíciles
- Forecast >1.5x del weighted pipeline → sesgo de optimismo, ajustar

---

## Output del Comando

```
## 📊 Pipeline Health Diagnostic
**Período**: [fecha]
**Objetivo del período**: €[X]
**Días restantes**: [N]

### Resumen Ejecutivo
[Estado en 2–3 líneas: cobertura, mayor riesgo, y acción más urgente]

### Métricas de Cobertura
| Métrica | Valor | Benchmark | Estado |
|---------|-------|-----------|--------|
| Pipeline total | €X | — | — |
| Coverage ratio | Xx | 3–4x | 🟢/🟡/🔴 |
| Coverage ajustado por calidad | Xx | 3–4x | 🟢/🟡/🔴 |
| # Deals activos | N | — | — |
| ACV promedio | €X | — | — |

### Estado por Etapa
| Etapa | # Deals | Valor | Tiempo prom. (días) | Conv. rate | Estado |
|-------|---------|-------|-------------------|-----------|--------|
| Discovery | N | €X | X días | X% | 🟢/🟡/🔴 |
| ...   | ...     | ...   | ...               | ...       | ...    |

### 🚨 Deals Estancados ([N] deals = €X en riesgo)
| Deal | Etapa | Días estancado | Último contacto | Riesgo | Acción |
|------|-------|---------------|----------------|--------|--------|
| [Empresa] | [Etapa] | [N días] | [fecha] | Alto/Medio | Re-qualify / Cierre |

### Análisis por Rep
| Rep | Pipeline | Coverage | Win Rate (90d) | Deals Estancados | Estado |
|-----|---------|---------|---------------|-----------------|--------|
| [Nombre] | €X | Xx | X% | N (X%) | 🟢/🟡/🔴 |

### Pipeline Velocity
| Métrica | Valor Actual | vs. Trimestre Ant. | Tendencia |
|---------|-------------|-------------------|-----------|
| Velocity total | €X/día | ▲/▼ X% | ↑/↓/→ |

### ⚡ Acciones Priorizadas (próximas 48–72 hs)
1. **[Acción urgente]** — [Razón] — Owner: [Rep/Manager] — Deadline: [fecha]
2. **[Acción importante]** — [Razón] — Owner: [Rol] — Deadline: [fecha]
3. **[Acción estructural]** — [Razón] — Owner: [Rol] — Deadline: [fecha]

### 🚨 Alertas
- [Situación crítica que pone en riesgo el objetivo del período]
- [Deal individual de alto valor con señales de riesgo]
```

---

## Errores Comunes a Evitar

- **Contar el pipeline sin calificarlo** → el número grande da falsa tranquilidad
- **No diferenciar deals "vivos" de deals estancados** → contamina el forecast
- **Hacer la review sin definir acciones** → reviews de pipeline sin output = tiempo perdido
- **Medir solo coverage sin medir velocity** → puedes tener coverage suficiente pero con deals que no van a cerrar en el período
- **No segmentar por rep** → los problemas individuales quedan ocultos en el promedio del equipo
