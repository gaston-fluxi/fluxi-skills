# Fluxi Skills — RevOps Intelligence

[![GitHub Stars](https://img.shields.io/github/stars/gaston-fluxi/fluxi-skills?style=flat-square&color=335FFA)](https://github.com/gaston-fluxi/fluxi-skills/stargazers)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-5DE1E6.svg?style=flat-square)](https://github.com/gaston-fluxi/fluxi-skills/blob/main/LICENSE)

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
git clone https://github.com/gaston-fluxi/fluxi-skills.git

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

## Cómo generar dist/

Los archivos en `dist/` ya están incluidos en el repositorio y listos para usar. Si modificás los skills en `source/` y necesitás regenerar:

1. Asegurate de tener `bash` instalado (macOS/Linux: nativo; Windows: Git Bash o WSL)
2. Dale permisos de ejecución al script si es necesario:
   ```bash
   chmod +x build.sh
   ```
3. Ejecutá desde la raíz del repositorio:
   ```bash
   ./build.sh
   ```
4. El script copia los archivos de `source/skills/` a cada uno de los cinco directorios en `dist/`:
   - `dist/claude-code/.claude/skills/`
   - `dist/cursor/.cursor/skills/`
   - `dist/gemini/.gemini/skills/`
   - `dist/codex/.codex/skills/`
   - `dist/agents/.agents/skills/`

**Troubleshooting:**
- `Permission denied` → ejecutá `chmod +x build.sh` primero
- El script no modifica nada fuera de `dist/` — es seguro correrlo múltiples veces

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
│           ├── SKILL.md              # Contexto general de RevOps
│           └── commands/
│               ├── pipeline-health.md
│               ├── forecast.md
│               ├── funnel-diagnosis.md
│               ├── churn-risk.md
│               ├── icp-market.md
│               ├── lead-scoring.md
│               └── deal-review.md
└── dist/
    ├── claude-code/.claude/skills/   # Estructura plana (un dir por skill)
    │   ├── revops-intelligence/SKILL.md
    │   ├── pipeline-health/SKILL.md
    │   ├── forecast/SKILL.md
    │   └── ...
    ├── cursor/.cursor/skills/revops-intelligence/
    ├── gemini/.gemini/skills/revops-intelligence/
    ├── codex/.codex/skills/revops-intelligence/
    └── agents/.agents/skills/revops-intelligence/
```

> **Nota sobre Claude Code**: Claude Code requiere que cada skill invocable sea su propio directorio con `SKILL.md`. El `build.sh` genera automáticamente esta estructura plana para `dist/claude-code/`. Los demás providers mantienen la estructura original.

---

## Contribuir

Los skills se mantienen con criterio RevOps real: benchmarks actualizados, frameworks validados en campo, sin contenido de relleno.

Para proponer mejoras:
1. Fork del repositorio
2. Editar en `source/skills/`
3. Ejecutar `./build.sh` para regenerar `dist/`
4. Pull request con descripción del cambio y justificación

**Checklist para PRs:**
- [ ] El framework sigue benchmarks RevOps estándar (con fuente)
- [ ] Incluye al menos un ejemplo de output con datos ficticios realistas
- [ ] No rompe compatibilidad con ninguno de los 5 agentes
- [ ] Los cálculos y fórmulas están verificados

---

## Fuentes y Benchmarks

Los benchmarks B2B SaaS incluidos en los skills están basados en:

- **HubSpot State of Sales** (2024–2025)
- **Salesforce State of Sales Report** (2024)
- **SaaS benchmarks de Benchmarkit / RevOps Squared** (2024)
- **Pipeline velocity y coverage ratio**: basado en distribución de deals en empresas SaaS con ACV €10K–€100K

Los benchmarks varían por industria, ACV y modelo de venta — se presentan como referencia, no como verdad absoluta. Si ves datos desactualizados, abrí un PR con la fuente actualizada.

Revisión programada: anual o cuando hay un cambio significativo en los benchmarks de la industria.

---

## Licencia

Apache 2.0 — ver [LICENSE](LICENSE) para el texto completo.

Libre para uso comercial, modificación y distribución.

---

Hecho con criterio RevOps. [fluxilabs.com](https://fluxilabs.com) · [LinkedIn](https://www.linkedin.com/company/fluxilabs/)
