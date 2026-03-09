---
name: revops-intelligence
description: >
  Skill de Revenue Operations que guía análisis profundos de pipeline, forecasting,
  ICP, lead scoring y más. Usalo cuando el usuario pida análisis comerciales,
  diagnósticos de ventas, o cualquier tarea de RevOps. Genera insights accionables
  basados en frameworks probados, no análisis genéricos.
---

# RevOps Intelligence

## Filosofía del Skill

Antes de analizar cualquier dato, siempre establecé el contexto del negocio:

- **Industria y modelo de negocio**: ¿B2B SaaS, servicios, producto físico, marketplace?
- **Modelo de venta**: ¿self-serve, inside sales, field sales, PLG, channel?
- **Tamaño del equipo**: ¿SDRs, AEs, CSMs? ¿Hay RevOps dedicado?
- **Stack de herramientas**: ¿HubSpot, Salesforce, Pipedrive? ¿Integración con BI?
- **Etapa de la empresa**: ¿Pre-PMF (<1M ARR), Growth (1–10M), Scale (10M+)?
- **Ciclo de venta típico**: ¿Transaccional (<30 días) o enterprise (90–180 días)?

**Regla de oro**: Nunca des un análisis genérico. Cada insight debe ser específico al contexto del negocio, con acciones concretas, métricas medibles y un responsable claro.

**Segunda regla**: Si el usuario no provee datos suficientes, hacé las preguntas mínimas necesarias antes de generar el análisis. Un análisis sin datos es peor que no hacer el análisis.

---

## Frameworks de RevOps

### 1. Pipeline Management

**Coverage Ratio**
- Benchmark ideal para cierre mensual: **3–4x del objetivo**
- Para negocios enterprise con ciclo largo: **5–6x** (más variabilidad)
- Fórmula: `Coverage = Pipeline total / Revenue target del período`
- Por debajo de 3x → riesgo alto de shortfall, escalación inmediata
- Por encima de 5x → posible problema de calidad, auditar ICP fit de los deals

**Pipeline Velocity**
Mide cuánto revenue genera el pipeline por día:
```
Velocity = (# Deals × Win Rate % × Avg Deal Size $) / Sales Cycle (días)
```
- Un aumento de velocity sin más headcount = mayor eficiencia
- Velocity cayendo con mismo volumen = cuello de botella en alguna etapa
- Desglosar velocity por rep, por segmento, y por fuente de lead

**Conversion Rates por Etapa**
Benchmarks B2B SaaS (ajustar por contexto):
| Etapa | Benchmark |
|-------|-----------|
| MQL → SQL | 20–35% |
| SQL → Opportunity | 40–60% |
| Opportunity → Proposal | 50–70% |
| Proposal → Won | 25–40% |
| Overall lead-to-close | 1–5% |

Por debajo del benchmark en una etapa → investigar el handoff y los criterios de avance. No asumir que el problema está en la etapa que falla — puede estar en la etapa anterior.

**Stuck Deals (Deals Estancados)**
- Definición: sin actividad registrada en >14 días (ajustar si el ciclo es largo)
- Causas más comunes: champion perdió tracción interna, presupuesto congelado, competidor ganó momentum, el rep evita la conversación difícil
- Acción: re-qualificar activamente o mover a "lost" y liberar tiempo del rep

---

### 2. Revenue Forecasting

**Pipeline Ponderado (Weighted Pipeline)**
```
Forecast = Σ (Deal Value × Stage Probability)
```

Probabilidades por etapa (ajustar con historial propio — estas son defaults):
| Etapa | Probabilidad default |
|-------|---------------------|
| Prospecting | 5% |
| Discovery | 15% |
| Demo / Qualified | 30% |
| Proposal enviada | 50% |
| Negotiation | 75% |
| Verbal Commit | 90% |
| Won | 100% |

**Ajuste Crítico por Win Rate Real**
Las probabilidades por etapa son hipótesis. El ajuste real viene del historial:
```
Adjusted Forecast = Weighted Pipeline × (Actual Win Rate / Assumed Win Rate)
```
Si el win rate real del equipo es 28% pero las probabilidades asumen 40%, el forecast está inflado un 43%. Esto es el error más común en forecasting.

**Tres Escenarios de Forecast**
1. **Peor caso**: Solo deals en Negotiation+ × 0.85 (descuento por slippage histórico)
2. **Caso base**: Pipeline ponderado ajustado por win rate histórico del equipo
3. **Mejor caso**: Caso base + deals en Proposal con 3+ interacciones recientes

**Gap Analysis**
```
Gap = Revenue Target − Forecast (caso base)
Pipeline adicional necesario = Gap / Win Rate
```
Si el gap requiere más pipeline del que se puede generar en el tiempo restante → escalación urgente a liderazgo, revisión de target, o plan de contingencia.

**Slippage Rate**
Porcentaje de deals que se prometieron para un período y no cerraron:
- Slippage > 20% → problema sistémico de calificación o de presión interna para sobrometer
- Medir slippage por rep para identificar patrones individuales

---

### 3. ICP Definition (Ideal Customer Profile)

**Análisis de Deals Ganados**
Extraer patrones de los últimos 20–50 deals cerrados (no de todos los deals — solo ganados):

*Firmographics:*
- Industria y vertical específico (no "tecnología" — "B2B SaaS de HR Tech para medianas empresas")
- Headcount: rango exacto, no amplio
- ARR/Revenue estimado de la empresa cliente
- Stage de funding (Bootstrapped, Seed, Series A–C, PE-backed)
- Geografía y mercado

*Buyer Profile:*
- Cargo del economic buyer (quien firma)
- Cargo del champion (quien impulsa internamente)
- Cargo del influencer / evaluador técnico
- Número de stakeholders involucrados en el proceso de decisión

*Deal Characteristics:*
- Ticket promedio (ACV/ARR)
- Ciclo de venta promedio en días (desde primer outreach hasta firma)
- Win rate en ese segmento
- LTV estimado (ACV × años promedio de retención)
- Fuente del deal (outbound, inbound, referral, partner)

**ICP Primario vs Secundario**
- **Primario**: Deals con win rate >40%, ciclo <promedio general, LTV más alto. Aquí va el 70% de la energía de prospecting.
- **Secundario**: Deals viables con mayor fricción. Válidos pero no para priorizar proactivamente.
- **Excluir**: Segmentos con win rate <15% o ciclo >3x el promedio — costo de oportunidad alto.

**Market Sizing**
```
TAM = # total de empresas en el espacio × ACV promedio
SAM = TAM × (% alcanzable con modelo GTM actual)
SOM = SAM × (capacidad del equipo × win rate × 12 meses)
```

---

### 4. Lead Scoring

**Modelo Multi-Dimensional (tres ejes)**

*Fit Score (0–100)* — ¿Qué tan parecido es al ICP?
| Criterio | Puntos |
|----------|--------|
| Industria exacta del ICP primario | 30 |
| Tamaño de empresa en el rango objetivo | 25 |
| Contacto es decision maker o tiene acceso directo | 25 |
| Stack tecnológico compatible / integrable | 10 |
| Geografía objetivo | 10 |

*Engagement Score (0–100)* — ¿Qué tan interesado está?
| Señal | Puntos |
|-------|--------|
| Demo solicitada o aceptada | 40 |
| Pricing page visitada (si trackeable) | 20 |
| Contenido de ROI/casos de uso consumido | 15 |
| Email reply rate alto (>2 respuestas) | 15 |
| LinkedIn engagement o mensaje directo | 10 |

*Timing Score (0–100)* — ¿Hay urgencia real?
| Señal | Puntos |
|-------|--------|
| Budget declarado disponible | 40 |
| Pain point activo mencionado en conversación | 30 |
| Timeline de implementación <90 días | 20 |
| Evaluación de competidores en curso | 10 |

**Score Total Ponderado**
```
Total = (Fit × 0.40) + (Engagement × 0.35) + (Timing × 0.25)
```

**Tiers de Acción**
| Tier | Score | Acción |
|------|-------|--------|
| A | 80–100 | Prioridad máxima — contactar en <24hs, asignar AE senior |
| B | 60–79 | Alta prioridad — secuencia acelerada, 3 touchpoints en 5 días |
| C | 40–59 | Media prioridad — nurturing estándar, revisión en 30 días |
| D | <40 | Baja prioridad — nurturing automatizado, sin tiempo de rep |

---

### 5. Churn Risk Assessment

**Señales de Alerta Temprana (Early Warning Signals)**
Ordenadas por peso predictivo:
1. **Engagement decay**: Uso/logins cayó >30% vs. promedio de los últimos 90 días
2. **Stakeholder churn**: El champion o decision maker renunció o cambió de rol
3. **Soporte problemático**: Tickets abiertos >7 días, CSAT < 7/10, quejas recurrentes del mismo tipo
4. **Sin expansión**: Cuenta sin upsell o cross-sell en los últimos 90 días (para cuentas maduras)
5. **Competidor posicionado**: Mención directa o indirecta de evaluación de alternativas
6. **Renovación próxima sin señales**: Contrato vence en <90 días sin QBR o conversación de expansión

**Health Score por Cuenta (0–100)**
| Dimensión | Peso | Qué medir |
|-----------|------|-----------|
| Uso del producto | 30% | Logins, features activadas, volumen de uso |
| Engagement con CS/AM | 20% | Respuesta a emails, asistencia a QBRs, NPS |
| Adopción de features clave | 20% | % de features del plan utilizadas activamente |
| Satisfacción (NPS/CSAT) | 15% | Score más reciente (ponderar tendencia) |
| Expansión/upsell | 15% | Crecimiento del uso o ACV en últimos 6 meses |

**Playbooks por Nivel de Riesgo**
- **Alto riesgo (<40)**: Executive Sponsor outreach en <48hs + QBR urgente + plan de rescate con executive interno
- **Riesgo medio (40–65)**: CSM proactive outreach + value review + identificar new champion si el anterior se fue
- **Bajo riesgo (>65)**: Cadencia estándar + identificar oportunidades de expansión

---

## Anti-Patrones de RevOps

### ❌ Forecast basado en gut feeling
**El problema**: "El rep dice que va a cerrar 3 deals este mes" sin historial ni criterios objetivos.
**La solución**: Pipeline ponderado + ajuste por win rate histórico del rep (no del equipo general). El optimismo del rep es un sesgo documentado — los datos históricos superan las predicciones individuales en 70%+ de los casos.

### ❌ Medir pipeline solo por volumen
**El problema**: "Tenemos €2M en pipeline" se reporta como señal positiva sin analizar calidad.
**La solución**: €2M de pipeline con 30% de ICP fit < €700K con 90% de ICP fit. Siempre reportar pipeline ajustado por calidad: ICP fit score promedio, edad de los deals, y cobertura ponderada.

### ❌ Tratar todos los deals igual
**El problema**: El rep dedica el mismo tiempo a un deal de €3K que a uno de €60K.
**La solución**: Implementar tiering de deals. Los deals del top 20% por potencial deben recibir el 60–70% del tiempo del AE. Usar el scoring de leads para priorizar la agenda del equipo.

### ❌ Ignorar velocity en favor de tamaño
**El problema**: Priorizar el "deal grande" que lleva 5 meses sin avanzar porque "es estratégico".
**La solución**: Un deal con ciclo >2x el promedio tiene >60% de probabilidad de perderse. Definir "stale date" explícita: si el deal supera X días sin avanzar una etapa, re-qualificar activamente o mover a nurturing. El costo de oportunidad de perseguir deals estancados es enorme.

### ❌ Pipeline reviews sin acciones concretas
**El problema**: Reviews semanales que terminan en "vamos bien" o "el deal está en negociación".
**La solución**: Cada deal discutido sale de la review con: (1) próxima acción específica, (2) responsable nombrado, (3) fecha de seguimiento. Sin estos tres elementos, el tiempo de la review fue desperdiciado.

### ❌ Medir solo lagging indicators
**El problema**: Mirar el revenue cerrado del mes anterior como señal de salud del negocio.
**La solución**: El revenue cerrado es historia. Los leading indicators predicen el futuro con 30–90 días de anticipación: meetings agendadas esta semana, SQLs generados este mes, proposals enviadas, pipeline creado vs. objetivo. Construir un dashboard de leading indicators y revisarlo semanalmente.

### ❌ No segmentar el análisis por fuente
**El problema**: Analizar el pipeline como un bloque homogéneo.
**La solución**: Los deals de outbound, inbound y referral tienen win rates, ciclos y LTVs radicalmente diferentes. Un análisis útil siempre segmenta por fuente y por segmento (SMB/Mid/Enterprise).

---

## Formato de Output Estándar

Todos los análisis generados con este skill deben seguir esta estructura:

```
## 📊 [Nombre del Análisis]
**Período analizado**: [fecha o rango]
**Fuente de datos**: [CRM / CSV / descripción cualitativa]

### Resumen Ejecutivo
[2–3 líneas: estado actual, situación más crítica, y oportunidad principal]

### Métricas Clave
| Métrica | Valor Actual | Benchmark | Estado |
|---------|-------------|-----------|--------|
| ...     | ...         | ...       | 🟢/🟡/🔴 |

### Hallazgos Principales
1. [Hallazgo con dato concreto y contexto]
2. [Hallazgo con dato concreto y contexto]
3. ...

### ⚡ Acciones Sugeridas (priorizadas por impacto)
1. **[Acción específica]** — [Por qué / impacto esperado] — Owner: [Rol] — Deadline: [Timeframe]
2. ...

### 🚨 Alertas
- [Situaciones críticas que requieren atención inmediata]
```

---

## Contexto de Uso

Este skill se activa automáticamente cuando el usuario pide:
- Análisis de pipeline o forecast de revenue
- Diagnóstico de funnel o tasas de conversión
- Evaluación de leads o calificación de cuentas
- Reviews de deals específicos o de toda la cartera
- Estrategia de ICP o segmentación de mercado
- Análisis de churn o health de cuentas existentes
- Cualquier pregunta sobre métricas de ventas y su interpretación

Usá los comandos especializados para análisis profundos, o este skill como contexto de RevOps para cualquier conversación comercial.
