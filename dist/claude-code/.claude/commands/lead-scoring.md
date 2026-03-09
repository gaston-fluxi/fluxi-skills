---
name: lead-scoring
description: >
  Construye o calibra un modelo de lead scoring multicritério: fit de ICP,
  señales de engagement, timing de compra y puntuación compuesta con umbrales
  de acción para SDRs y AEs.
user-invocable: true
---

# /lead-scoring — Lead Scoring & Priorización

## Propósito

Producir un sistema de lead scoring accionable que permita a los SDRs y AEs saber exactamente en qué leads invertir el tiempo y en cuál orden. No un número arbitrario entre 0 y 100 — sino una puntuación compuesta con lógica transparente, umbrales de acción, y conexión directa con el win rate histórico.

## Cuándo Usar Este Comando

- Al construir o revisar el proceso de calificación de leads por primera vez
- Cuando la tasa de conversión de MQL a SQL está por debajo del 30%
- Cuando los SDRs tienen demasiados leads para trabajar y no saben por dónde empezar
- Cuando se detecta que muchos deals pierden por "mal fit" (problema de ICP en la entrada)
- Para calibrar el scoring después de acumular 50+ nuevos deals ganados

## Input Esperado

**Con datos de leads:**
```
/lead-scoring
[Lista de leads o CSV con: empresa, industria, headcount, cargo del contacto,
fuente, actividad de engagement (emails abiertos, visitas web, contenido descargado),
fecha de primer contacto, won/lost si ya está cerrado]
```

**Para diseñar el modelo desde cero:**
```
/lead-scoring
Vendemos [producto] a [segmento].
ICP definido: [descripción].
Señales de engagement disponibles: [lista de tracking que tenemos].
Datos históricos: [N] deals cerrados, win rate [X%].
```

**Para evaluar un lead específico:**
```
/lead-scoring
Lead: [Empresa / Contacto]
Industria: [X], Headcount: [X], Cargo: [X]
Engagement: [actividad observada]
Fuente: [X]
¿Debería trabajarse ahora?
```

---

## Proceso de Análisis

### Módulo 1 — Dimensión de Fit (ICP Match)

El fit mide qué tan bien encaja el prospecto con el perfil de cliente que históricamente ha comprado y retenido.

**Criterios de Fit y ponderación sugerida:**

| Criterio | Peso | Descripción |
|----------|------|-------------|
| Industria | 25% | Coincide con top-3 industrias de deals ganados |
| Tamaño de empresa (headcount) | 20% | Dentro del rango óptimo del ICP |
| Cargo del contacto | 20% | Es el DM, influencer, o champion tipo del ICP |
| Pain point declarado / inferido | 20% | Coincide con el problema que resolvemos |
| Stack tecnológico compatible | 10% | Usa herramientas complementarias (no competidoras) |
| Geografía | 5% | Dentro del mercado objetivo |

**Escala por criterio:**
- Coincidencia exacta → 100% del peso del criterio
- Coincidencia parcial → 50% del peso
- Sin coincidencia → 0%

**Fit Score (0–100)**: suma ponderada de los 6 criterios.

**Nota de calibración**: Los pesos iniciales son una hipótesis. Después de 50+ deals cerrados, recalibrar comparando el Fit Score de deals ganados vs. perdidos. Si el stack tecnológico no predice el win rate → reducir su peso.

### Módulo 2 — Dimensión de Engagement

El engagement mide la intención de compra expresada a través de comportamientos observables. Una empresa con buen fit pero sin engagement activo no es una prioridad ahora — lo será cuando active señales.

**Señales de Engagement y puntuación:**

| Señal | Puntos | Criterio |
|-------|--------|----------|
| Respuesta directa a outreach | 30 | Respondió un email o llamada sin secuencia previa |
| Visita a página de pricing | 25 | En los últimos 7 días |
| Demo solicitada de forma inbound | 25 | Request directo desde web o referencia |
| Descarga de contenido de fondo de funnel | 20 | Case study, comparativo, ROI calculator |
| Apertura de ≥3 emails en la última semana | 15 | Engagement activo con secuencia |
| Visita a página de features clave | 15 | Más de 2 visitas en 7 días |
| Asistió a un webinar/evento | 15 | En los últimos 30 días |
| Interacción en LinkedIn (comentó, compartió) | 10 | Con contenido del equipo o de la empresa |
| Descarga de contenido de tope de funnel | 10 | Blog, guías genéricas (señal débil) |
| Apertura de un email único | 5 | Señal muy débil, no actuar solo por esto |

**Engagement Score (0–100)**: Sumar puntos con cap a 100. Señales de los últimos 30 días tienen peso completo; de los últimos 31–60 días, 50%; más de 60 días, no se cuentan (el engagement caduca).

**Regla de engagement reciente**: Si el último engagement significativo fue hace más de 45 días → el lead entra en "nurturing" automático, no en secuencia activa.

### Módulo 3 — Dimensión de Timing

El timing evalúa si hay una razón externa que crea urgencia de compra en este momento. Un lead con buen fit y engagement puede no tener timing adecuado — y forzar el deal en ese momento reduce el win rate.

**Triggers de timing y puntuación:**

| Trigger | Puntos | Fuente de Detección |
|---------|--------|---------------------|
| Ronda de inversión en los últimos 6 meses | 30 | Crunchbase, LinkedIn, press |
| Contratación de VP Sales, CRO, o Head of RevOps | 30 | LinkedIn nuevo puesto |
| Contrato con competidor venciendo (si se sabe) | 25 | Conversación directa, ZoomInfo |
| Job posting de RevOps / Sales Ops abierto | 20 | LinkedIn Jobs, Glassdoor |
| Expansión de headcount >20% en 6 meses | 20 | LinkedIn headcount tracker |
| Nuevo C-level con historial en herramientas similares | 20 | LinkedIn, perfil del ejecutivo |
| Migración o evaluación de CRM/stack | 20 | Conversación, comunidades |
| Evento o deadline externo declarado | 15 | Conversación directa |
| Expansión geográfica o lanzamiento de producto | 15 | Press release, LinkedIn |

**Timing Score (0–100)**: Sumar puntos con cap a 100.

**Ausencia de timing no es descalificador**: Un lead sin triggers de timing pero con Fit > 70 y Engagement > 40 igual puede avanzar — el timing bajo solo indica que el urgency work es parte del proceso de venta.

### Módulo 4 — Score Compuesto y Umbrales de Acción

**Fórmula del Lead Score compuesto:**

```
Lead Score = (Fit × 0.45) + (Engagement × 0.35) + (Timing × 0.20)
```

**Justificación del peso**: El fit es el predictor más estable del win rate. El engagement indica intención activa. El timing es el más volátil y no siempre disponible — se pondera menos para no penalizar leads buenos donde no tenemos datos de timing.

**Umbrales de acción:**

| Tier | Score | Acción | SLA |
|------|-------|--------|-----|
| 🔥 Tier A — Prioridad Máxima | 75–100 | SDR contacta en <2 horas | Hoy |
| 🟡 Tier B — Alta Prioridad | 55–74 | SDR en secuencia esta semana | <3 días |
| 🟠 Tier C — Media Prioridad | 35–54 | Nurturing activo, revisar en 30 días | Sin urgencia |
| ⬜ Tier D — Bajo Fit | < 35 | Solo nurturing automático | Sin seguimiento manual |

**Criterio de veto** (descalifica automáticamente sin importar el score):
- Industria en lista de excluidos (win rate <10%) → Tier D automático
- Empresa demasiado pequeña para el ACV mínimo viable → Tier D automático
- Contacto sin autoridad de compra ni acceso al DM → bajar un tier

### Módulo 5 — Calibración con Datos Históricos

Para validar que el modelo predice el win rate real:

1. Aplicar retroactivamente el scoring a los últimos 50–100 deals cerrados
2. Calcular win rate por tier:

```
Win rate esperado por tier:
Tier A: ≥35%
Tier B: 20–34%
Tier C: 8–19%
Tier D: <8%
```

3. Si los win rates observados difieren significativamente → recalibrar pesos
4. Repetir la calibración cada 6 meses o cada 100 nuevos deals

---

## Output del Comando

```
## 🎯 Lead Scoring

### Resumen del Modelo
[2–3 líneas: dimensiones utilizadas, calibración disponible, uso recomendado]

### Score Compuesto por Lead (si se proporcionaron leads)
| Lead | Empresa | Fit | Engagement | Timing | Score Total | Tier | Acción |
|------|---------|-----|-----------|--------|-------------|------|--------|
| [Nombre] | [Empresa] | XX | XX | XX | XX/100 | A/B/C/D | [Acción] |

### Detalle del Top 5 (Tier A)
Para cada lead Tier A:
- **Fit**: [Razones de coincidencia con ICP]
- **Engagement**: [Señales activas observadas]
- **Timing**: [Triggers presentes]
- **Próximo paso**: [Acción concreta para el SDR]

### Configuración del Modelo
| Dimensión | Peso | Score Máximo |
|-----------|------|-------------|
| Fit (ICP) | 45% | 45 pts |
| Engagement | 35% | 35 pts |
| Timing | 20% | 20 pts |

### Distribución del Portfolio
| Tier | # Leads | % Total | Acción Recomendada |
|------|---------|---------|-------------------|
| 🔥 A | N | X% | Contacto inmediato |
| 🟡 B | N | X% | Secuencia esta semana |
| 🟠 C | N | X% | Nurturing activo |
| ⬜ D | N | X% | Solo automatizado |

### ⚡ Acciones Inmediatas
1. **[Lead / Empresa]** — Score: XX — [Razón de prioridad] — Owner: [SDR] — Deadline: Hoy
2. **[Lead / Empresa]** — Score: XX — [Razón] — Owner: [SDR] — Deadline: [fecha]

### 🚨 Alertas
- [Si hay un segmento con muchos Tier D → problema de calidad de generación de leads]
- [Si hay Tier A sin actividad en >3 días → SLA incumplido]
- [Si el modelo aún no está calibrado con datos reales → resultados son hipótesis]
```

---

## Ejemplo de Output

```
## Lead Scoring
Modelo: Fit × 0.45 + Engagement × 0.35 + Timing × 0.20
Leads evaluados: 12 | Período: semana del 3-mar-2025

### Score Compuesto por Lead
| Lead           | Empresa       | Fit | Engagement | Timing | Score | Tier | Acción              |
|----------------|---------------|-----|-----------|--------|-------|------|---------------------|
| Carla Ruiz     | Nexio HR      | 88  | 72        | 70     | 79    | 🔥 A | Contactar hoy       |
| Diego Méndez   | Orbis Fintech | 82  | 65        | 30     | 69    | 🟡 B | Secuencia esta semana|
| Laura Pons     | Stackly       | 70  | 80        | 20     | 66    | 🟡 B | Secuencia esta semana|
| Tomás Aguilar  | Kero Sales    | 55  | 90        | 60     | 72    | 🔥 A | Contactar hoy       |
| Mía Ferrer     | Velora        | 90  | 20        | 40     | 55    | 🟡 B | Secuencia esta semana|
| Pablo Ríos     | Datova        | 40  | 45        | 20     | 37    | 🟠 C | Nurturing activo    |
| Irene Castro   | Flusso        | 30  | 15        | 10     | 22    | ⬜ D | Solo automatizado   |

### Detalle del Top 2 (Tier A)

**Carla Ruiz — Nexio HR — Score: 79**
- **Fit**: Industria HR Tech (top-2 de deals ganados), headcount 90 empleados, Carla
  es Head of Sales Ops (champion tipo del ICP), pain de fragmentación de CRM declarado
- **Engagement**: Visitó pricing page hace 3 días, descargó el ROI calculator, abrió
  4 emails en la última semana
- **Timing**: Ronda Seed hace 4 meses, nuevo VP Sales incorporado hace 6 semanas
- **Próximo paso**: Llamada de 20 min para validar pain de integración — proponer demo
  específica de flujos de RevOps para SaaS Series A

**Tomás Aguilar — Kero Sales — Score: 72**
- **Fit**: Industria SaaS B2B (parcial — vertical específico no mapeado aún), headcount
  140, Tomás es Sales Ops Manager, pain presumible pero no declarado
- **Engagement**: Solicitó demo inbound hace 2 días — señal de intención muy alta
- **Timing**: Job posting de RevOps Analyst abierto → indicio de dolor activo
- **Próximo paso**: Demo preparada con casos de uso de equipos similares en tamaño;
  validar en los primeros 10 min si el pain es de reporting o de forecasting

### Distribución del Portfolio
| Tier | # Leads | % Total | Acción Recomendada        |
|------|---------|---------|---------------------------|
| 🔥 A | 2       | 17%     | Contacto en <2 horas hoy  |
| 🟡 B | 3       | 25%     | Secuencia esta semana     |
| 🟠 C | 1       | 8%      | Nurturing activo 30 días  |
| ⬜ D | 1       | 8%      | Solo automatizado         |
| Sin datos suficientes | 5 | 42% | Completar datos antes de clasificar |

### ⚡ Acciones Inmediatas
1. **Carla Ruiz / Nexio HR** — Score 79 — Visitó pricing + descargó ROI calculator
   → intención alta — Owner: Sofía (SDR) — Deadline: hoy antes de las 12hs
2. **Tomás Aguilar / Kero Sales** — Score 72 — Demo request inbound hace 48hs
   → SLA vencido — Owner: Sofía (SDR) — Deadline: llamar ahora

### 🚨 Alertas
- Tomás Aguilar solicitó una demo hace 48 horas y aún no fue contactado — SLA Tier A
  incumplido (objetivo: <2 horas). Impacto directo en win rate de inbound
- 5 de 12 leads no tienen datos suficientes para clasificar (sin industria o sin cargo
  validado en CRM) → enriquecer con Apollo o LinkedIn antes de poner en secuencia
- Mía Ferrer tiene Fit 90 pero Engagement 20 — no contactar aún; incluir en nurturing
  de contenido técnico hasta que active señales de intención
```

---

## Errores Comunes a Evitar

- **Puntuar solo por engagement** sin fit → genera trabajo para SDRs que termina en Closed-Lost por mal ICP
- **Score único sin dimensiones separadas** → un lead con Fit 90 / Engagement 0 necesita una estrategia diferente a uno con Fit 40 / Engagement 90
- **No actualizar el scoring** después de cambios de ICP → el modelo caduca con el producto y el mercado
- **Tratar Tier C como "no trabajar nunca"** → deben entrar a nurturing activo, no descartarse
- **No tener SLA por tier** → el scoring sin urgencia definida no cambia el comportamiento del equipo
- **Confiar en el score sin entender las señales** → el SDR debe saber POR QUÉ un lead es Tier A, no solo que lo es
