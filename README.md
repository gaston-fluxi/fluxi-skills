# Fluxi Skills — RevOps Intelligence

Skills de Revenue Operations para agentes de IA. Instala en Claude Code, Cursor, Gemini CLI, Codex CLI o VS Code Copilot/Kiro y obtén un analista de RevOps disponible en cualquier momento.

---

## ¿Qué es esto?

Una colección de skills estructurados para que cualquier asistente de IA pueda ejecutar análisis de Revenue Operations de nivel senior: pipeline health, forecasting, diagnóstico de funnel, churn risk, ICP scoring y revisión estructurada de deals.

Cada skill incluye:
- Frameworks analíticos completos con benchmarks B2B SaaS
- Fórmulas de cálculo (coverage ratio, pipeline velocity, health scores, win rate ajustado)
- Formatos de output listos para compartir con directores o el board
- Guías de causa raíz por etapa problemática
- Errores comunes a evitar

## Skills disponibles

### `revops-intelligence`

| Comando | Descripción |
|---------|-------------|
| `/pipeline-health` | Diagnóstico completo del pipeline: cobertura, velocity, deals estancados y alertas por rep |
| `/forecast` | Pronóstico de revenue con tres escenarios (peor/base/mejor), ajustado por win rate real |
| `/funnel-diagnosis` | Tasas de conversión por etapa, time-in-stage, bottleneck y causa raíz |
| `/churn-risk` | Health scores por cuenta, señales de alerta temprana y playbooks de retención |
| `/icp-market` | Perfil de cliente ideal desde deals cerrados, TAM/SAM/SOM y scorecard de calificación |
| `/lead-scoring` | Modelo multicritério (Fit + Engagement + Timing) con umbrales de acción por tier |
| `/deal-review` | Revisión MEDDPICC de deal individual, probabilidad ajustada y próximos pasos críticos |

---

## Instalación

### Claude Code

```bash
# Clonar el repositorio
git clone https://github.com/fluxilabs/fluxi-skills.git

# Copiar al directorio de skills de Claude
cp -r dist/claude-code/.claude ~/.claude
```

O agregar directamente al proyecto:

```bash
cp -r dist/claude-code/.claude /ruta/a/tu/proyecto/.claude
```

### Cursor

```bash
cp -r dist/cursor/.cursor /ruta/a/tu/proyecto/.cursor
```

### Gemini CLI

```bash
cp -r dist/gemini/.gemini ~/.gemini
```

### Codex CLI

```bash
cp -r dist/codex/.codex ~/.codex
```

### VS Code Copilot / Kiro

```bash
cp -r dist/agents/.agents /ruta/a/tu/proyecto/.agents
```

---

## Uso

Una vez instalado, invocar cualquier comando en el chat del agente:

```
/pipeline-health
Pipeline total: €2.4M. Objetivo del trimestre: €800K.
Tenemos 47 deals activos. Los más grandes son Empresa A (€180K, Negotiation)
y Empresa B (€95K, Proposal). Preocupación: varios deals llevan >30 días sin actividad.
```

```
/forecast
Objetivo Q2: €650.000
Días restantes: 38
Pipeline por etapa:
- Verbal Commit: €120.000 (2 deals)
- Negotiation: €310.000 (5 deals)
- Proposal: €480.000 (9 deals)
- Discovery: €220.000 (14 deals)
Revenue cerrado: €87.000
Win rate histórico 90 días: 22%
Slippage rate: 18%
```

```
/deal-review
Empresa: Acme Corp
Etapa: Negotiation
Valor: €85.000
Champion: María López (VP Operations) — muy activa
Economic Buyer: CEO — nunca tuvimos reunión directa
Competidor: HubSpot en evaluación paralela
Próxima reunión: viernes con el champion
```

---

## Estructura del repositorio

```
fluxi-skills/
├── README.md
├── LICENSE
├── build.sh                          # Genera dist/ desde source/
├── source/
│   └── skills/
│       └── revops-intelligence/
│           ├── SKILL.md              # Definición del skill y contexto RevOps
│           └── commands/
│               ├── pipeline-health.md
│               ├── forecast.md
│               ├── funnel-diagnosis.md
│               ├── churn-risk.md
│               ├── icp-market.md
│               ├── lead-scoring.md
│               └── deal-review.md
└── dist/
    ├── claude-code/.claude/skills/revops-intelligence/
    ├── cursor/.cursor/skills/revops-intelligence/
    ├── gemini/.gemini/skills/revops-intelligence/
    ├── codex/.codex/skills/revops-intelligence/
    └── agents/.agents/skills/revops-intelligence/
```

---

## Contribuir

Los skills se mantienen con criterio RevOps real: benchmarks actualizados, frameworks validados en campo, sin contenido de relleno.

Para proponer mejoras:
1. Fork del repositorio
2. Editar en `source/skills/`
3. Ejecutar `./build.sh` para regenerar `dist/`
4. Pull request con descripción del cambio y justificación

---

## Licencia

Apache 2.0 — ver [LICENSE](LICENSE) para el texto completo.

Libre para uso comercial, modificación y distribución.

---

Hecho con criterio RevOps. [fluxilabs.com](https://fluxilabs.com)
