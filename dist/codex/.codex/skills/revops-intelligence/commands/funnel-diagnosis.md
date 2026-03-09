---
name: funnel-diagnosis
description: >
  Análisis completo del funnel de conversión de punta a punta: tasas por etapa,
  puntos de caída, time-in-stage, comparación con benchmarks y recomendaciones
  específicas por etapa problemática.
user-invokable: true
---

# /funnel-diagnosis — Funnel Diagnosis

## Propósito

Identificar exactamente dónde y por qué se pierde revenue en el proceso de ventas. No solo "la tasa de cierre es baja" sino "estamos perdiendo el 65% de los deals en la etapa de Proposal porque no hay multithreading y solo tenemos acceso al champion".

## Cuándo Usar Este Comando

- Al inicio de cada trimestre para evaluar la salud del proceso completo
- Cuando el pipeline es grande pero el revenue cerrado es bajo
- Cuando la dirección pregunta "¿dónde está el problema?"
- Antes de contratar más SDRs o AEs (verificar si el problema es de volumen o de conversión)
- Cuando se implementa un cambio de proceso y se quiere medir su impacto

## Input Esperado

```
/funnel-diagnosis
Período analizado: [trimestre/semestre]
Datos por etapa (volumen de entrada y de salida):

- Leads totales generados: [N]
- MQLs (Marketing Qualified Leads): [N]
- SQLs (Sales Qualified Leads): [N]
- Opportunities creadas: [N]
- Proposals enviadas: [N]
- Deals ganados: [N]

Tiempo promedio en cada etapa (días):
- Lead → MQL: [N] días
- MQL → SQL: [N] días
- SQL → Opportunity: [N] días
- Opportunity → Proposal: [N] días
- Proposal → Won: [N] días

ACV promedio de deals ganados: €[X]
Razones de pérdida más frecuentes: [lista]
```

---

## Proceso de Análisis

### Módulo 1 — Tasas de Conversión por Etapa

Calcular la conversión de cada paso del funnel y comparar con benchmarks:

**Etapas del funnel y benchmarks B2B SaaS:**
| Etapa | Conversión del Análisis | Benchmark B2B SaaS | Estado |
|-------|------------------------|-------------------|--------|
| Lead → MQL | X% | 20–35% | 🟢/🟡/🔴 |
| MQL → SQL | X% | 30–50% | 🟢/🟡/🔴 |
| SQL → Opportunity | X% | 50–70% | 🟢/🟡/🔴 |
| Opportunity → Proposal | X% | 60–80% | 🟢/🟡/🔴 |
| Proposal → Won | X% | 25–45% | 🟢/🟡/🔴 |
| **Lead → Won (overall)** | **X%** | **1–5%** | 🟢/🟡/🔴 |

**Nota sobre benchmarks**: Los benchmarks varían significativamente por industria, ACV, y modelo de venta. Un ciclo enterprise tiene conversiones más bajas en etapas tempranas pero más alta en Proposal → Won. Comparar siempre con el propio histórico antes de usar benchmarks externos.

### Módulo 2 — Identificación del Cuello de Botella Principal

El cuello de botella se identifica por la mayor caída relativa entre etapas:

```
Drop-off relativo = (1 - Conversion Rate de la etapa) × Valor en riesgo
```

**Criterio de priorización:**
No siempre el cuello de botella es la etapa con peor conversión — es la etapa cuya mejora generaría mayor impacto en revenue. Una mejora del 10% en Proposal → Won (con mucho valor en esa etapa) puede ser más valiosa que una mejora del 30% en Lead → MQL.

### Módulo 3 — Time-in-Stage Analysis

Para cada etapa, analizar:
- **Tiempo promedio en etapa** vs. benchmark histórico propio
- **Distribución**: ¿hay un subconjunto de deals que tarda 3x el promedio?
- **Correlación con outcome**: ¿los deals que tardan más en una etapa tienen peor win rate?

**Señales de alerta por tiempo:**
| Hallazgo | Interpretación |
|----------|---------------|
| SQL → Opportunity tarda >10 días | Proceso de calificación lento o sin criterios claros |
| Opportunity → Proposal tarda >14 días | Cuello de botella en elaboración de propuesta |
| Proposal → Won tarda >30 días | Proceso de decisión complejo o falta de urgencia |
| Varianza alta en el tiempo de cualquier etapa | Falta de proceso estandarizado |

### Módulo 4 — Análisis de Razones de Pérdida (Loss Reasons)

Para cada etapa donde se pierde un deal significativo, categorizar las razones:

**Categorías de loss reasons:**
1. **No decision / Status quo**: El prospecto decidió no cambiar nada (la opción más común y más subestimada)
2. **Competidor**: Eligieron otra solución
3. **Presupuesto**: No había budget o se congeló
4. **Timing**: No era el momento adecuado
5. **Mal fit**: El producto no resolvía el problema (si esto es frecuente → problema de ICP)
6. **Proceso interrumpido**: Cambio de interlocutor, restructuración, M&A

**Red flag**: Si "No decision" es la razón #1 de pérdida, el problema no es el producto ni el precio — es que no se está creando urgencia suficiente ni conectando el dolor con el costo de no actuar.

### Módulo 5 — Análisis por Segmento y Fuente

Desagregar el funnel por:
- **Fuente de lead**: ¿El outbound convierte mejor que el inbound? ¿Por qué?
- **Segmento** (SMB / Mid-Market / Enterprise): Cada segmento tiene un funnel diferente
- **Rep**: ¿Hay varianza significativa entre reps en la misma etapa?
- **Producto / SKU**: ¿Algunos productos tienen funnels más saludables?

La varianza entre segmentos suele revelar que el "problema del funnel" es en realidad un problema en un segmento específico — no global.

### Módulo 6 — Diagnóstico de Causa Raíz por Etapa

Para cada etapa problemática, el framework de causa raíz:

**Lead → MQL (problema de marketing):**
- ¿Es un problema de volumen (pocos leads) o de calidad (leads fuera del ICP)?
- ¿Los criterios de MQL están bien definidos y son consistentes?
- ¿Hay alineación entre marketing y ventas sobre qué es un "buen lead"?

**MQL → SQL (problema de SDR / BDR):**
- ¿Los SDRs están haciendo las preguntas de calificación correctas?
- ¿Hay un SLA de follow-up claro? (primer contacto en <1 hora de forma óptima)
- ¿El ICP está bien definido para los SDRs?

**SQL → Opportunity (problema de discovery):**
- ¿Los AEs están encontrando pain real o avanzando deals sin él?
- ¿Se valida presupuesto, autoridad, y urgencia en el discovery?
- ¿El handoff de SDR a AE transfiere el contexto necesario?

**Opportunity → Proposal (problema de proceso o capacidad):**
- ¿Los deals se avancan a Proposal sin multithreading suficiente?
- ¿Hay un proceso claro y estandarizado para elaborar propuestas?
- ¿Los AEs tienen templates y herramientas adecuadas?

**Proposal → Won (problema de cierre):**
- ¿El AE tiene acceso al economic buyer o solo al champion?
- ¿Se está abordando la objeción de precio de forma efectiva?
- ¿Hay competidores posicionados que no se están trabajando?
- ¿Hay un proceso de negotiation definido?

---

## Output del Comando

```
## 🔍 Funnel Diagnosis
**Período**: [trimestre/semestre año]
**Basado en**: [N] leads / [N] deals ganados

### Resumen Ejecutivo
[Estado del funnel en 2–3 líneas: cuál es la etapa más problemática, cuál es la causa raíz principal, y cuál es la acción de mayor impacto]

### Conversión por Etapa
| Etapa | Entradas | Salidas | Conv. Rate | Benchmark | Drop-off abs. | Estado |
|-------|---------|---------|-----------|-----------|--------------|--------|
| Lead → MQL | X | X | X% | 20–35% | X leads | 🟢/🟡/🔴 |
| MQL → SQL | X | X | X% | 30–50% | X | 🟢/🟡/🔴 |
| SQL → Opp | X | X | X% | 50–70% | X | 🟢/🟡/🔴 |
| Opp → Proposal | X | X | X% | 60–80% | X | 🟢/🟡/🔴 |
| Proposal → Won | X | X | X% | 25–45% | X | 🟢/🟡/🔴 |
| **Overall** | **X** | **X** | **X%** | 1–5% | — | 🟢/🟡/🔴 |

### Time-in-Stage
| Etapa | Tiempo Actual | Benchmark | Varianza | Estado |
|-------|--------------|-----------|---------|--------|
| Lead → MQL | X días | X días | ±X días | 🟢/🟡/🔴 |
| [resto de etapas] | ... | ... | ... | ... |

### 🎯 Cuello de Botella Principal
**Etapa**: [Etapa problemática]
**Impacto en revenue**: €X perdido por período (X deals × ACV promedio × drop-off)
**Causa raíz identificada**: [Diagnóstico]

### Razones de Pérdida (Loss Reasons)
| Razón | % de Deals Perdidos | € en Revenue |
|-------|--------------------|----|
| [Razón 1] | X% | €X |
| [Razón 2] | X% | €X |
| No decision / Status quo | X% | €X |

### Análisis por Segmento
| Segmento | Conv. Overall | vs. Promedio | Insight |
|----------|--------------|-------------|---------|
| SMB | X% | ▼/▲ X% | [Observación] |
| Mid-Market | X% | ▼/▲ X% | [Observación] |

### ⚡ Acciones Priorizadas por Impacto
1. **[Acción en etapa X]** — Impacto estimado: +X% conversión = €X adicionales/trimestre — Owner: [Rol] — Deadline: [fecha]
2. **[Acción en etapa Y]** — Impacto estimado: [mismo formato] — Owner: [Rol] — Deadline: [fecha]
3. **[Acción estructural]** — Impacto estimado: [mismo formato] — Owner: [Rol] — Deadline: [fecha]

### 🚨 Alertas
- [Si la conversión global está cayendo trimestre a trimestre]
- [Si una etapa específica tiene una caída abrupta reciente]
- [Si hay un problema sistemático de ICP (muchos deals de mal fit)]
```

---

## Errores Comunes a Evitar

- **Analizar el funnel como si fuera homogéneo** → siempre segmentar por fuente y por segmento
- **Optimizar la etapa que tiene la peor conversión** en lugar de la que tiene mayor impacto en revenue
- **Agregar más SDRs** cuando el problema es la conversión en Proposal → Won
- **Ignorar el time-in-stage** → una tasa de conversión puede ser "buena" pero el tiempo excesivo indica fricción
- **No analizar loss reasons** → sin entender por qué se pierde, no se puede mejorar
- **Usar solo benchmarks externos** sin comparar con el propio historial — el contexto propio es más relevante
