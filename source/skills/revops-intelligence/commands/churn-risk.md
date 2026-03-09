---
name: churn-risk
description: >
  Identifica cuentas en riesgo de churn con health scores, señales de alerta
  temprana y playbooks de retención priorizados por nivel de riesgo y valor
  de la cuenta.
user-invocable: true
---

# /churn-risk — Churn Risk Assessment

## Propósito

Identificar cuentas en riesgo de no renovar antes de que sea demasiado tarde para actuar. La detección temprana es la diferencia entre retener una cuenta y perderla. Este comando produce un análisis de riesgo accionable, no una lista de cuentas para "hacer seguimiento".

## Cuándo Usar Este Comando

- Al inicio de cada trimestre para revisar el portafolio completo de cuentas
- Cuando se acercan renovaciones de contratos importantes (90–180 días)
- Después de un cambio organizacional en una cuenta clave (nuevo CTO, CEO, o decisor)
- Cuando el equipo de CS reporta señales de problema en una cuenta
- Antes de una reunión de QBR (Quarterly Business Review) con el cliente

## Input Esperado

**Con datos de cuentas:**
```
/churn-risk
[Lista de cuentas con: nombre, ARR, fecha de renovación, NPS/CSAT, logins últimos 30 días vs. promedio, tickets abiertos, último contacto]
```

**Para una cuenta específica:**
```
/churn-risk
Cuenta: [Empresa]
ARR: €[X]
Renovación: [fecha]
Señales observadas: [describe]
Historial: [contexto relevante]
```

**Análisis cualitativo del portafolio:**
```
/churn-risk
Portafolio: [N] cuentas, ARR total €[X]
Cuentas con preocupaciones: [describe las 3–5 más relevantes]
NPS promedio: [X]
```

---

## Proceso de Análisis

### Módulo 1 — Health Score por Cuenta (0–100)

Calcular un health score para cada cuenta basado en señales objetivas:

**Dimensión 1: Uso del Producto (30 pts)**
| Señal | Puntos |
|-------|--------|
| Uso estable o creciente vs. mes anterior | 30 |
| Uso caído 10–20% | 20 |
| Uso caído 20–40% | 10 |
| Uso caído >40% | 0 |

**Dimensión 2: Engagement con el Equipo (20 pts)**
| Señal | Puntos |
|-------|--------|
| Responde emails en <24hs, asiste a QBRs | 20 |
| Responde con demora, asiste a QBRs | 14 |
| Responde con demora, no asiste a QBRs | 7 |
| No responde, comunicación cortada | 0 |

**Dimensión 3: Adopción de Features Clave (20 pts)**
| Señal | Puntos |
|-------|--------|
| Usa >70% de las features del plan | 20 |
| Usa 40–70% | 14 |
| Usa 20–40% | 8 |
| Usa <20% | 0 |

**Dimensión 4: Satisfacción — NPS/CSAT (15 pts)**
| Score | Puntos |
|-------|--------|
| NPS ≥ 8 / CSAT ≥ 8 | 15 |
| NPS 6–7 / CSAT 6–7 | 8 |
| NPS < 6 / CSAT < 6 | 0 |
| Sin datos recientes (<90 días) | 5 |

**Dimensión 5: Expansión / Upsell (15 pts)**
| Señal | Puntos |
|-------|--------|
| Expandió en los últimos 6 meses | 15 |
| Sin expansión pero tampoco reducción | 8 |
| Solicitud de reducción de plan | 0 |

**Health Score Total: suma de las 5 dimensiones (0–100)**

### Módulo 2 — Señales de Alerta Temprana

Independientemente del health score, estas señales activan alerta inmediata:

| Señal | Nivel | Acción requerida |
|-------|-------|-----------------|
| Uso caído >40% en 30 días | 🔴 Crítico | Executive outreach en <48hs |
| Champion/DM renunció o cambió de rol | 🔴 Crítico | Mapeo de stakeholders urgente |
| Mención de evaluación de competidor | 🔴 Crítico | Competitive response inmediato |
| Ticket de soporte crítico sin resolver >7 días | 🔴 Crítico | Escalación interna |
| NPS < 5 en la última medición | 🔴 Crítico | Save plan activado |
| Solicitud de reducción de contrato | 🟡 Alto | Conversación de valor urgente |
| Sin login del usuario principal >14 días | 🟡 Alto | Check-in de CSM |
| Renovación en <90 días sin conversación | 🟡 Alto | Agendar QBR urgente |
| NPS entre 5–6 | 🟡 Alto | Plan de mejora de satisfacción |
| 0 interacciones con contenido de producto en 60 días | 🟠 Medio | Nurturing y enablement |

### Módulo 3 — Segmentación de Riesgo

Combinar health score + señales de alerta para clasificar cada cuenta:

| Segmento | Health Score | Criterio Adicional | % Prob. Churn |
|----------|-------------|-------------------|---------------|
| 🔴 Alto Riesgo | < 40 | O señal crítica activa | 60–80% |
| 🟡 Riesgo Medio | 40–65 | O 2+ señales de alto riesgo | 25–50% |
| 🟢 Bajo Riesgo | > 65 | Sin señales de alerta | 5–15% |

### Módulo 4 — Priorización por ARR en Riesgo

```
ARR en riesgo = ARR de la cuenta × Probabilidad de churn del segmento
```

Ordenar las acciones de retención por ARR en riesgo, no solo por health score. Una cuenta con health score 35 y ARR €5K puede tener menos prioridad que una con health score 45 y ARR €80K.

### Módulo 5 — Playbooks de Retención

**Playbook 🔴 Alto Riesgo:**
1. Executive sponsor outreach en <48hs (CEO/VP llamando al equivalente del cliente)
2. QBR urgente: mostrar valor generado, roadmap de mejoras, plan de éxito personalizado
3. Identificar y cultivar un nuevo champion si el anterior se fue
4. Involucrar al producto si hay gaps de funcionalidad como causa raíz
5. Offer de retención si corresponde (descuento, features adicionales, SLA mejorado)

**Playbook 🟡 Riesgo Medio:**
1. CSM proactive outreach en <7 días
2. Value review: casos de uso activos, ROI logrado, benchmarks vs. industria
3. Evaluar si hay un sponsor ejecutivo en el lado del cliente — si no hay, cultivarlo
4. Plan de aceleración de adopción de features no utilizadas

**Playbook 🟢 Bajo Riesgo:**
1. Mantener cadencia estándar de QBRs
2. Identificar oportunidades de expansión (upsell/cross-sell)
3. Pedir caso de estudio o referencia si el NPS es ≥8

---

## Output del Comando

```
## ⚠️ Churn Risk Assessment
**Fecha**: [fecha]
**Portafolio analizado**: [N] cuentas / ARR total: €X

### Resumen Ejecutivo
[Estado del portafolio en 2–3 líneas: ARR en riesgo total, cuentas críticas, acción más urgente]

### Overview del Portafolio
| Segmento | # Cuentas | ARR | % del Total | ARR en Riesgo |
|----------|-----------|-----|-------------|--------------|
| 🔴 Alto Riesgo | N | €X | X% | €X |
| 🟡 Riesgo Medio | N | €X | X% | €X |
| 🟢 Bajo Riesgo | N | €X | X% | €X |
| **Total** | **N** | **€X** | **100%** | **€X** |

### 🔴 Cuentas de Alto Riesgo (acción inmediata)
| Cuenta | ARR | Renov. | Health Score | Señal Principal | Próxima Acción | Owner |
|--------|-----|--------|-------------|----------------|---------------|-------|
| [Empresa] | €X | [fecha] | XX/100 | [Señal] | [Acción] | [CSM] |

### 🟡 Cuentas de Riesgo Medio (acción esta semana)
| Cuenta | ARR | Renov. | Health Score | Señal Principal | Próxima Acción |
|--------|-----|--------|-------------|----------------|---------------|
| [Empresa] | €X | [fecha] | XX/100 | [Señal] | [Acción] |

### Health Scores por Dimensión (cuentas en riesgo)
| Cuenta | Uso | Engagement | Adopción | Satisfac. | Expansión | Total |
|--------|-----|-----------|---------|----------|----------|-------|
| [Empresa] | XX | XX | XX | XX | XX | XX/100 |

### ⚡ Acciones Priorizadas (por ARR en riesgo)
1. **[Cuenta] — €X ARR** — [Acción] — Owner: [CSM/Manager] — Deadline: [fecha]
2. **[Cuenta] — €X ARR** — [Acción] — Owner: [CSM/Manager] — Deadline: [fecha]

### 🚨 Alertas Críticas
- [Cuenta con señal de churn en <30 días a renovación]
- [Cuenta donde el champion principal ya no está en la empresa]
- [Tendencia sistémica si múltiples cuentas muestran el mismo problema]
```

---

## Ejemplo de Output

```
## Churn Risk Assessment
Fecha: marzo 2025
Portafolio analizado: 34 cuentas / ARR total: €1.12M

### Resumen Ejecutivo
€218K de ARR en riesgo alto o crítico. Dos cuentas representan el 71% de ese riesgo:
Lúmina (€92K, champion que renunció + uso caído 52%) y Nortek (€63K, NPS 3, evaluando
competidor). Acción urgente: executive outreach a ambas antes del viernes.

### Overview del Portafolio
| Segmento       | # Cuentas | ARR     | % Total | ARR en Riesgo |
|----------------|-----------|---------|---------|---------------|
| 🔴 Alto Riesgo | 4         | €218K   | 19%     | €152K         |
| 🟡 Riesgo Medio| 9         | €340K   | 30%     | €102K         |
| 🟢 Bajo Riesgo | 21        | €562K   | 51%     | €28K          |
| **Total**      | **34**    | **€1.12M** | **100%** | **€282K**  |

### 🔴 Cuentas de Alto Riesgo (acción inmediata)
| Cuenta  | ARR   | Renov.  | Health | Señal Principal                        | Próxima Acción                         | Owner  |
|---------|-------|---------|--------|----------------------------------------|----------------------------------------|--------|
| Lúmina  | €92K  | Jun-25  | 28/100 | Champion (VP Ops) renunció hace 15 días| Executive call esta semana + mapeo de stakeholders | Ana G. |
| Nortek  | €63K  | Abr-25  | 31/100 | NPS 3 + mencionó evaluación de Gainsight | Competitive response + QBR urgente   | Mateo R.|
| Finsur  | €38K  | May-25  | 37/100 | Uso caído 41% en 45 días               | Check-in de CSM + audit de adopción    | Ana G. |
| Cobrex  | €25K  | May-25  | 34/100 | Sin login del decisor en 22 días       | Email directo del CEO                  | Mateo R.|

### Health Scores por Dimensión (cuentas en riesgo)
| Cuenta  | Uso | Engagement | Adopción | Satisfac. | Expansión | Total  |
|---------|-----|-----------|---------|----------|----------|--------|
| Lúmina  | 0   | 7          | 14       | 0         | 7         | 28/100 |
| Nortek  | 10  | 14         | 8        | 0         | 0         | 31/100 |
| Finsur  | 0   | 14         | 14       | 8         | 0         | 37/100 |

### ⚡ Acciones Priorizadas (por ARR en riesgo)
1. **Lúmina — €92K ARR** — Executive call CEO→CEO + mapa de nuevos stakeholders
   Owner: Ana G. + CRO — Deadline: viernes 14-mar
2. **Nortek — €63K ARR** — Competitive response deck + QBR de valor con nuevo DM
   Owner: Mateo R. — Deadline: lunes 17-mar
3. **Finsur — €38K ARR** — Auditoría de adopción + sesión de re-onboarding
   Owner: Ana G. — Deadline: semana del 17-mar

### 🚨 Alertas Críticas
- Lúmina renueva en <90 días y el champion salió: riesgo de churn sin interlocutor claro
- Nortek renovación en 45 días con NPS 3 → ventana de acción muy estrecha
- 3 de 4 cuentas en riesgo alto tienen el mismo problema: caída de adopción de features
  de integración → revisar si hay un problema de producto o de onboarding sistemático
```

---

## Errores Comunes a Evitar

- **Medir solo el NPS** sin datos de uso → el NPS puede ser positivo en cuentas que están buscando alternativas
- **Esperar a la renovación** para tener la conversación difícil → a 30 días de la renovación es muy tarde
- **No priorizar por ARR** → dedicar el mismo esfuerzo a una cuenta de €2K y una de €80K
- **No identificar el nuevo champion** después de un stakeholder change → la cuenta queda "huérfana"
- **Hacer la conversación de retención con descuentos** como primera opción → resolver el problema de valor primero
