---
name: deal-review
description: >
  Revisión estructurada de deal individual: validación de MEDDPICC, riesgos
  específicos por stakeholder, próximos pasos críticos y probabilidad de cierre
  ajustada. Para pipeline reviews con managers o autoevaluación del AE.
user-invocable: true
---

# /deal-review — Deal Review Estructurado

## Propósito

Producir una revisión honesta y estructurada de un deal específico que vaya más allá de "va bien" o "está avanzando". Identificar exactamente qué falta para cerrar, qué riesgo específico puede hacer caer el deal, y cuáles son los próximos pasos concretos en las próximas 72 horas. La revisión aplica el framework MEDDPICC como estructura base.

## Cuándo Usar Este Comando

- En la pipeline review semanal con el manager para cada deal >50% del ACV promedio
- Cuando un deal lleva más de 1.5x el sales cycle promedio sin avanzar
- Antes de enviar una propuesta económica
- Cuando el rep dice "va a cerrar" pero el manager quiere validar la evidencia
- Después de una reunión clave (discovery, demo, QBR con cliente) para capturar insights
- Cuando un deal que parecía seguro empieza a mostrar señales de riesgo

## Input Esperado

```
/deal-review
Empresa: [Nombre]
Etapa actual: [Discovery / Proposal / Negotiation / Verbal Commit]
Valor del deal: €[X]
Fecha de cierre estimada: [fecha]
Rep asignado: [nombre]

MEDDPICC:
- Metrics: [qué métricas de éxito tiene el cliente definidas]
- Economic Buyer: [nombre, cargo, ¿tuvimos conversación directa?]
- Decision Criteria: [criterios de evaluación del cliente]
- Decision Process: [pasos del proceso de compra interno del cliente]
- Paper Process: [proceso legal/procurement, tiempo estimado]
- Identify Pain: [pain declarado explícitamente por el cliente]
- Champion: [nombre, cargo, nivel de compromiso]
- Competition: [competidores activos en este deal]

Última actividad: [fecha y qué pasó]
Próximo paso agendado: [sí/no, qué, cuándo]
```

---

## Proceso de Análisis

### Módulo 1 — Validación MEDDPICC

Para cada elemento del framework, evaluar si está **Confirmado** (evidencia directa), **Asumido** (no validado), o **Desconocido** (no hay información).

**M — Metrics (Métricas de Éxito)**
- ¿El cliente ha definido cómo va a medir el éxito de esta compra?
- ¿Hay ROI o KPIs específicos que justifican el gasto?
- ¿El AE puede articular el impacto en números del cliente?

**Señal de riesgo**: Si las métricas de éxito son vagas o genéricas ("mejorar la eficiencia"), el deal no tiene un caso de negocio sólido → alta probabilidad de "no decision".

---

**E — Economic Buyer (Decisor Económico)**
- ¿Se ha tenido una conversación directa con quien firma el contrato?
- ¿El economic buyer está involucrado en el proceso o solo el champion?
- ¿El economic buyer tiene presupuesto asignado o necesita aprobación adicional?

**Señal de riesgo crítica**: Deal sin contacto directo con el economic buyer = deal sin cierre probable. La aprobación del champion NO garantiza el deal. Si el AE no ha hablado con el EB, esta es la tarea #1.

---

**D — Decision Criteria (Criterios de Decisión)**
- ¿Cuáles son los criterios formales o informales de evaluación del cliente?
- ¿Cómo se ponderan estos criterios? ¿Qué es lo más importante para ellos?
- ¿Estamos posicionados favorablemente en los criterios que más importan?

**Señal de riesgo**: Si no conocemos los criterios de decisión, estamos a ciegas. Hay que preguntar directamente: "¿Cómo van a tomar esta decisión? ¿Qué factores son los más importantes para ustedes?"

---

**D — Decision Process (Proceso de Decisión)**
- ¿Cuántas personas intervienen en la decisión final?
- ¿Hay un comité de evaluación o es una decisión unilateral?
- ¿Cuáles son los pasos internos antes de firmar? (Demo técnica, aprobación de security, etc.)
- ¿El timeline del cliente coincide con el forecast del AE?

**Señal de riesgo**: Si el timeline del cliente es más largo que la fecha de cierre del rep → ajustar el forecast o crear urgencia real.

---

**P — Paper Process (Proceso Legal y Procurement)**
- ¿Hay un proceso de procurement formal? (Legal, InfoSec, Finanzas)
- ¿Cuánto tarda históricamente el proceso de contratación en esta empresa?
- ¿Ya se ha enviado el borrador de contrato? ¿Hay redlines?

**Señal de riesgo**: En enterprise, el paper process puede tomar 3–6 semanas. Si no está contemplado, el deal "cerrado" puede moverse al próximo trimestre.

---

**I — Identify Pain (Dolor Identificado)**
- ¿El cliente ha articulado el dolor en sus propias palabras? (no el AE interpretando)
- ¿Cuál es el costo del status quo para el cliente? (costo de NO hacer nada)
- ¿El dolor está conectado a una prioridad estratégica del negocio?

**Señal de riesgo**: Si el pain es del champion pero no del economic buyer → el EB puede no aprobar el gasto. El pain debe resonar en el nivel donde se aprueba el presupuesto.

---

**C — Champion (Campeón Interno)**
- ¿Quién es el champion y cuánta influencia real tiene en la organización?
- ¿El champion ha hecho algo concreto para avanzar el deal internamente? (facilitó reunión con EB, compartió internamente, defendió el proyecto)
- ¿El champion tiene algo a ganar personalmente con esta compra?

**Señal de riesgo crítica**: Un "champion" que solo asiste a reuniones pero no hace nada internamente no es un champion real — es un contacto amable. Un champion de verdad toma riesgo interno por el deal.

---

**C — Competition (Competencia)**
- ¿Hay competidores activos en el deal? ¿Cuáles?
- ¿El cliente está evaluando alternativas en paralelo?
- ¿Cómo se posiciona nuestra solución vs. el competidor principal?
- ¿Hay riesgo de "build vs. buy" o "status quo como competidor"?

**Señal de riesgo**: Competidor no identificado = riesgo oculto. Preguntar directamente: "¿Están evaluando otras alternativas? ¿Qué estaban considerando antes de contactarnos?"

### Módulo 2 — Score de Completitud MEDDPICC

Para cada elemento: Confirmado = 2 pts, Asumido = 1 pt, Desconocido = 0 pts

```
Score MEDDPICC = Suma de los 7 elementos (máx. 14 pts)
```

| Score | Interpretación | Forecast |
|-------|---------------|---------|
| 12–14 pts | Deal bien calificado | Forecast confiable |
| 8–11 pts | Deal parcialmente calificado | Forecast con riesgo, validar gaps |
| 4–7 pts | Deal poco calificado | No commitear — calificar primero |
| 0–3 pts | Deal sin calificar | Sacar del forecast activo |

### Módulo 3 — Análisis de Riesgos por Stakeholder

Para cada stakeholder identificado en el deal, evaluar:

**Mapa de poder:**
| Stakeholder | Rol | Posición | Acceso | Riesgo |
|------------|-----|---------|--------|--------|
| [Nombre] | Economic Buyer | [Champion/Neutral/Blocker] | [Directo/Indirecto/Sin acceso] | [Alto/Medio/Bajo] |

**Riesgos específicos por stakeholder:**
- **Champion ausente o débil**: ¿Tiene mandato y voluntad de pelear por el deal?
- **Blocker no identificado**: ¿Hay alguien que puede bloquear el deal desde seguridad, legal, o finanzas?
- **EB no involucrado**: ¿El economic buyer sabe que este deal existe y está activo?
- **Stakeholder que cambió de rol**: ¿Algún contacto clave salió de la empresa o cambió de puesto?

### Módulo 4 — Ajuste de Probabilidad

Calcular la probabilidad real de cierre a partir de la evidencia disponible:

**Probabilidad base por etapa:**
- Negotiation: 75%
- Proposal enviada: 50%
- Qualified / Demo: 30%
- Discovery: 15%

**Ajustes al alza (+):**
- Champion activo con acceso directo al EB: +10%
- Fecha de inicio requerida del cliente confirmada: +10%
- Competidor principal eliminado del proceso: +8%
- Métricas de ROI acordadas con el cliente: +8%
- Contrato en revisión legal: +12%

**Ajustes a la baja (-):**
- EB nunca contactado directamente: -20%
- Competidor fuerte no trabajado: -15%
- Pain solo expresado por champion (no EB): -10%
- Sin next step agendado post-última reunión: -10%
- Deal estancado >2x el promedio histórico de la etapa: -15%
- Renovación de presupuesto pendiente: -10%

```
Probabilidad ajustada = Probabilidad base + Σ ajustes al alza − Σ ajustes a la baja
```

### Módulo 5 — Plan de Acción

Para cada gap identificado en MEDDPICC, definir la acción específica:

| Gap | Acción Concreta | Owner | Deadline |
|-----|----------------|-------|----------|
| EB no contactado | Pedir intro al champion para reunión ejecutiva | AE + Champion | Esta semana |
| Decision criteria no validados | Enviar email al champion con resumen de nuestra propuesta de valor y pedir confirmación | AE | 48 horas |
| Competidor no trabajado | Solicitar reunión de competitive positioning con champion | AE | 3 días |

---

## Output del Comando

```
## 🔍 Deal Review — [Empresa]
**Etapa**: [Etapa] | **Valor**: €X | **Cierre estimado**: [fecha] | **Rep**: [Nombre]

### Resumen Ejecutivo
[2–3 líneas: estado real del deal, riesgo principal, acción más urgente]

### Validación MEDDPICC
| Elemento | Estado | Evidencia | Riesgo |
|----------|--------|-----------|--------|
| Metrics | ✅/⚠️/❌ | [Qué sabemos] | [Riesgo si falta] |
| Economic Buyer | ✅/⚠️/❌ | [Último contacto] | — |
| Decision Criteria | ✅/⚠️/❌ | [Criterios conocidos] | — |
| Decision Process | ✅/⚠️/❌ | [Pasos del proceso] | — |
| Paper Process | ✅/⚠️/❌ | [Estado legal/procurement] | — |
| Identify Pain | ✅/⚠️/❌ | [Pain declarado] | — |
| Champion | ✅/⚠️/❌ | [Nivel de compromiso] | — |
| Competition | ✅/⚠️/❌ | [Competidores activos] | — |

**Score MEDDPICC**: XX/14 — [Interpretación]

### Probabilidad Ajustada
| Factor | Probabilidad |
|--------|-------------|
| Base (por etapa) | X% |
| Ajustes al alza | +X% |
| Ajustes a la baja | -X% |
| **Probabilidad ajustada** | **X%** |

[Si la probabilidad ajustada difiere >15% de la etapa base → explicar por qué]

### Mapa de Stakeholders
| Stakeholder | Rol | Posición | Acceso | Riesgo |
|------------|-----|---------|--------|--------|
| [Nombre, Cargo] | EB/Champion/Evaluador | Favorable/Neutral/Blocker | Directo/Indirecto | Alto/Medio/Bajo |

### ⚡ Próximos Pasos Críticos (próximas 72 horas)
1. **[Acción]** — [Por qué es crítica ahora] — Owner: [AE/Manager] — Deadline: [fecha/hora]
2. **[Acción]** — [Razón] — Owner: [Rol] — Deadline: [fecha]
3. **[Acción]** — [Razón] — Owner: [Rol] — Deadline: [fecha]

### 🚨 Alertas del Deal
- [Riesgo crítico que puede hacer caer el deal]
- [Elemento MEDDPICC sin resolver que bloquea el avance]
- [Si la fecha de cierre estimada no es realista — con justificación]

### Recomendación de Forecast
[Mantener en forecast / Mover a "Upside" / Sacar del forecast activo]
[Justificación basada en evidencia, no en la opinión del rep]
```

---

## Errores Comunes a Evitar

- **Asumir que el champion es el economic buyer** → son roles diferentes con motivaciones distintas; confundirlos es la causa más frecuente de deals perdidos en la última milla
- **Actualizar la etapa sin actualizar el MEDDPICC** → mover un deal de Discovery a Proposal sin validar los elementos críticos infla el forecast artificialmente
- **No definir "próximos pasos" con fecha y owner** → "quedamos en hablar la próxima semana" no es un next step — es una conversación sin compromiso
- **Confirmar el pain con el champion en lugar del EB** → el champion puede tener el pain pero no el presupuesto ni la prioridad para resolverlo
- **Ignorar el paper process** → en deals enterprise, el proceso legal puede ser tan largo como el ciclo de venta completo — no contemplarlo genera slippage garantizado
- **Usar la revisión para justificar el deal en lugar de evaluarlo** → el manager debe hacer preguntas incómodas, el rep debe responder con evidencia, no con optimismo
