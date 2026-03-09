---
name: icp-market
description: >
  Define el Perfil de Cliente Ideal (ICP) a partir de deals cerrados y estima el
  tamaño de mercado (TAM/SAM/SOM). Genera un scorecard ICP con señales de
  priorización y criterios de calificación accionables.
user-invokable: true
---

# /icp-market — ICP & Market Sizing

## Propósito

Definir con precisión el Perfil de Cliente Ideal basándose en datos de deals ganados, identificar triggers de compra, y estimar el tamaño de mercado alcanzable para los próximos 12 meses.

## Cuándo Usar Este Comando

- Al iniciar o revisar la estrategia de go-to-market
- Cuando el win rate está cayendo (posible drift del ICP)
- Antes de entrar a un nuevo segmento o vertical
- Para calificar si un prospecto merece inversión de tiempo del equipo
- Cuando el equipo debate si "ese tipo de empresa" es un cliente objetivo

## Input Esperado

**Con datos de deals:**
```
/icp-market
[Lista o CSV de deals cerrados: empresa, industria, tamaño, ARR, ciclo de venta días, won/lost]
```

**Sin datos (análisis cualitativo):**
```
/icp-market
Vendemos [producto/servicio] a [segmento].
Ticket: [precio]. Ciclo: [tiempo]. Win rate estimado: [%].
Mejores clientes actuales: [describe 2–3].
Clientes problemáticos: [describe].
```

**Para un prospecto específico:**
```
/icp-market
¿Es [Empresa X] un buen fit para nosotros?
[Pegar información de la empresa]
```

---

## Proceso de Análisis

### Paso 1 — Análisis de Deals Ganados

Extraer y comparar patrones de los últimos 20–50 deals *ganados* (no de todos los deals):

**Firmographics:**
- Industria y vertical específico — no "SaaS" sino "B2B SaaS de HR Tech para medianas empresas"
- Headcount en rango acotado (ej: 50–200 empleados, no "50–500")
- ARR/Revenue estimado del cliente o stage de funding
- Geografía y mercado (país, idioma, regulación relevante)

**Buyer Profile:**
- Cargo del economic buyer (quien firma y libera el presupuesto)
- Cargo del champion (quien impulsa internamente y tiene pain directo)
- Cargo del evaluador técnico o influencer
- Número de stakeholders en el proceso → average de deals ganados

**Deal Characteristics:**
- ACV/ARR promedio y rango
- Sales cycle promedio en días — desde primer contacto hasta firma
- Win rate segmentado (no win rate global — por industria, tamaño, fuente)
- LTV estimado: ACV × años promedio de retención
- Fuente del deal: outbound, inbound, referral, partner → win rate por fuente

### Paso 2 — Identificar Diferenciadores

Comparar deals ganados vs. deals perdidos para encontrar qué predice el éxito:
- ¿Qué tenían en común los deals ganados que los perdidos no tenían?
- ¿Cuál era el pain específico declarado en los deals ganados?
- ¿Había algún trigger de compra recurrente (nuevo líder, funding, dolor urgente)?

### Paso 3 — Scorecard ICP Fit (para calificación)

Construir matriz de criterios ponderados usable para calificar prospectos nuevos:

| Criterio | Peso | Indicador |
|----------|------|-----------|
| Industria en top-3 de deals ganados | 25% | Sí/No/Parcial |
| Tamaño en rango óptimo | 20% | Sí/No/Parcial |
| Contacto es DM o tiene acceso directo | 20% | Sí/No/Parcial |
| Pain point declarado coincide con el que resolvemos | 20% | Sí/No/Parcial |
| Stack tecnológico compatible | 10% | Sí/No |
| Geografía objetivo | 5% | Sí/No |

Score total (0–100) → Tier A (80+), B (60–79), C (40–59), D (<40)

### Paso 4 — ICP Primario y Secundario

**ICP Primario**: Segmento con win rate ≥40%, ciclo ≤ promedio general, LTV ≥ promedio. Concentrar 70% del esfuerzo de prospecting.

**ICP Secundario**: Segmento viable con mayor fricción o menor LTV. Trabajar oportunísticamente, no proactivamente.

**Segmentos a Excluir**: Win rate <15% O ciclo >2.5x el promedio → el costo de oportunidad supera el potencial de revenue.

### Paso 5 — Market Sizing

**TAM (Total Addressable Market)**
```
TAM = # total de empresas que podrían necesitar la solución
    × ACV promedio del mercado (no solo el nuestro)
```
Fuentes: Apollo.io, LinkedIn Sales Navigator, Crunchbase, reportes de Gartner/Forrester, DataIQ.

**SAM (Serviceable Addressable Market)**
```
SAM = TAM filtrado por:
  - Geographies donde operamos actualmente
  - Idioma y go-to-market local
  - Canales de distribución disponibles
  - Segmentos que podemos atender con el equipo actual
```

**SOM (Serviceable Obtainable Market — 12 meses)**
```
SOM = (Capacidad del equipo en deals/mes × Win Rate × ACV) × 12
```
O alternativamente:
```
SOM = SAM × tasa de penetración realista (histórica en segmentos similares)
```

### Paso 6 — Señales de Priorización (Buying Triggers)

Identificar eventos que aumentan la propensión de compra inmediata:

| Trigger | Por qué importa |
|---------|----------------|
| Contratación de VP Sales / Head of RevOps / CRO | Pain de RevOps → presupuesto y autoridad |
| Ronda de inversión (últimos 18 meses) | Presupuesto disponible + presión de crecimiento |
| Migración o evaluación de nuevo CRM | Stack change → momento de entrada |
| Job postings de RevOps / Sales Enablement | Pain declarado públicamente |
| Expansión de headcount >20% YoY | Crecimiento genera caos operacional |
| Contrato con competidor venciendo | Ventana de oportunidad conocida |
| Nuevo C-level con historial de usar herramientas similares | Champion potencial ya convertido |

---

## Output del Comando

```
## 🎯 Análisis ICP + Market Sizing
**Fecha**: [fecha]
**Basado en**: [N deals ganados / análisis cualitativo]

### Resumen Ejecutivo
[2–3 líneas: quién es el cliente ideal, qué lo hace ideal, y cuál es la oportunidad de mercado inmediata]

### ICP Primario
| Criterio | Descripción |
|----------|-------------|
| Industria | [ej: B2B SaaS · HR Tech y Fintech] |
| Tamaño | [ej: 50–200 empleados] |
| Stage | [ej: Series A–B] |
| Buyer (DM) | [ej: VP Sales o Head of Revenue] |
| Champion | [ej: Sales Operations Manager] |
| ACV promedio | [ej: €15–25K ARR] |
| Sales cycle | [ej: 21–35 días] |
| Win rate | [ej: 43%] |
| LTV estimado | [ej: €48K / 3.2 años] |
| Fuente top | [ej: Outbound (win rate 38%) > Referral (55%) > Inbound (22%)] |

### ICP Secundario
[Tabla similar — segmento viable pero con mayor fricción]

### Segmentos a Evitar
[Lista de segmentos con win rate bajo o ciclo excesivo — con dato]

### 📐 Market Sizing
| Métrica | Estimación | Metodología |
|---------|-----------|-------------|
| TAM | [€Xm / X.XXX empresas] | [Cómo se calculó] |
| SAM | [€Xm / X.XXX empresas] | [Filtros aplicados] |
| SOM 12m | [€Xm / XXX empresas] | [Capacidad × win rate] |

### Scorecard de Calificación
Para usar en qualification calls y en el CRM:
- ✅ [Criterio obligatorio — sin esto, no avanzar]
- ✅ [Criterio obligatorio]
- ⚠️ [Criterio importante — validar en discovery]
- 💡 [Nice-to-have — señal de deal de alta calidad]

### ⚡ Señales de Priorización
Top triggers de compra a monitorear:
1. [Trigger más relevante con dato]
2. [Trigger]
3. [Trigger]

### 🚨 Alertas
- [Si hay drift entre el ICP definido y los deals que actualmente están en pipeline]
- [Si el SOM es insuficiente para los objetivos de crecimiento]
- [Si el win rate varía >20% entre segmentos aparentemente similares]
```

---

## Errores Comunes a Evitar

- **Definir el ICP por intuición** en lugar de datos de deals ganados
- **ICP demasiado amplio** para "no perder oportunidades" → termina significando "todos"
- **No actualizar el ICP** después de cada 50 nuevos deals — el mercado y el producto cambian
- **Confundir TAM con oportunidad real** — el SOM ajustado por capacidad es lo que importa
- **Ignorar la fuente de los deals** — el ICP puede variar significativamente entre outbound e inbound
- **Definir el ICP en base a los clientes actuales** sin considerar qué clientes se quieren en el futuro
