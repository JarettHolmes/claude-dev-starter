# Claude Development System Starter Kit

> **👋 New here?** Start with **[WALKTHROUGH.md](WALKTHROUGH.md)** - a 10-minute read that shows you exactly why this exists, how it works, and whether it's worth your time.

A systematic approach to AI agent instruction management for Claude Code. Package your project patterns, documented limits, and anti-patterns into quick-reference guides that agents can consult during work—preventing errors, reducing clarifying questions, and accelerating development.

## What is This?

A comprehensive starter kit combining two powerful methodologies for AI-driven development:

### 1. AI Guides System (Knowledge Layer)
Document your project's patterns, conventions, and tool limits as quick-reference guides that AI agents consult during work. Prevents repetitive questions and incorrect assumptions.

**Key features:**
- Domain translation (generic concepts → your specific patterns)
- Capability limits documentation (thresholds + workarounds)
- Systematic maintenance workflow (discover → assess → update)
- Monthly validation checks

### 2. PRP Methodology (Execution Layer)
Create context-rich specifications (Product Requirement Prompts) that enable one-pass implementation success with built-in validation loops.

**Key features:**
- 4 PRP types (PLANNING, BASE, SPEC, TASK)
- Deep agentic research phase
- Auto-integration with AI Guides patterns
- Multi-level validation loops
- Proven for complex features (auth, payments, real-time, etc.)

**How they work together:** AI Guides teach Claude your patterns once. PRPs use those patterns to build features without errors.

## Quick Start

### Automated Setup (Recommended)

1. **Copy commands to your project**
   ```bash
   cp -r commands/ /path/to/your/project/.claude/commands/
   ```

2. **Run setup command in Claude Code**
   ```
   /setup
   ```
   Claude will:
   - Create AI Guides system (docs/ directory with 4 guides)
   - Create PRP workspace (PRPs/ directory with templates)
   - Detect tech stack and populate initial patterns
   - Add router to CLAUDE.md
   - Run validation

**Time to setup**: ~10 minutes with Claude's help

### Manual Setup (Alternative)

1. **Clone this repository**
   ```bash
   git clone [URL]
   cd claude-dev-starter
   ```

2. **Customize template guides**
   - Choose a domain example: `examples/web-app/`, `api-project/`, `mobile-app/`, or `data-science/`
   - Fill in templates with your project patterns (see `SETUP_GUIDE.md`)
   - Copy to your project's `docs/` directory

3. **Add router integration to CLAUDE.md**
   - Use snippet from `examples/CLAUDE.md.snippet`

**Time to setup**: 30 minutes to 2 hours depending on customization

## What's Included

### 📚 Two Complementary Guides

**AI Domain Translation Guide** - Quick pattern lookup
- When you think "X", we actually use "Y" (concept mappings)
- Common anti-patterns (with wrong ❌ + right ✅ approaches)
- Quick reference code snippets (copy-paste ready)

**AI Capabilities & Limits Guide** - Proactive workarounds
- Documented tool limits (thresholds, failure modes)
- Tested workarounds (when to apply them)
- Future testing backlog (capability hypotheses to validate)

### ⚙️ 20 Development Commands

**4 AI Guides Commands** - Setup and systematic maintenance:
- `/setup` - Bootstrap complete system (PRP + AI Guides)
- `/ai-guides-discover` - Find patterns/limits/anti-patterns from recent work
- `/ai-guides-assess` - Score materiality with 40-point objective framework
- `/ai-guides-update` - Execute guide updates with quality control

**8 PRP Commands** - Create and execute context-rich specifications:
- `/prp-planning-create` - Rough idea → Comprehensive PRD
- `/prp-create` - Requirements → Detailed PRP
- `/prp-base-execute` - Execute BASE PRP with validation
- `/prp-spec-execute` - Execute SPEC PRP (transformations)
- `/prp-task-execute` - Execute TASK PRP (checklists)
- `/task-list-init` - Create task checklist
- `/api-contract-define` - Define API contracts
- `/read-docs` - Load project context documents

**8 Development Commands** - Productivity tools:
- `/smart-commit` - Analyze changes and create intelligent commits
- `/create-pr` - Well-structured pull requests
- `/debug-RCA` - Root cause analysis for issues
- `/update-claude-readme` - Keep documentation synchronized
- `/onboarding` - Comprehensive new developer setup
- `/prime-core` - Prime Claude with project knowledge
- `/create-prompt` - Expert prompt engineering
- `/new-dev-branch` - Create development branches

### 📋 4 Multi-Domain Examples

Realistic patterns for:
- **Web App** (React, TypeScript, Vite, Tailwind, tRPC, Prisma)
- **API Project** (GraphQL, REST, PostgreSQL, JWT)
- **Mobile App** (React Native, Expo, AsyncStorage, Navigation)
- **Data Science** (Python, Jupyter, Pandas, Scikit-learn, Plotly)

Each includes AI Guide snippets (concept mappings, anti-patterns, capability limits) and PRP examples (authentication, migrations, pipelines).

### ✅ Validation Infrastructure

- **Monthly validation script** - Health checks for guide quality
- **Validation scenarios** - Test guide effectiveness with measurable metrics
- **Success metrics framework** - Track time savings, error reduction

## Directory Structure

```
claude-dev-starter/
├── templates/              # 8 templates with [CUSTOMIZE] markers
│   ├── ai-guides/          # 4 AI Guide templates
│   │   ├── AI_DOMAIN_TRANSLATION_GUIDE.md
│   │   ├── AI_CAPABILITIES_AND_LIMITS.md
│   │   ├── AI_GUIDES_USAGE_SUMMARY.md
│   │   └── AI_GUIDES_MAINTENANCE_PLAN.md
│   ├── prp/                # 4 PRP templates
│   │   ├── prp.md (BASE)
│   │   ├── prp_planning.md
│   │   ├── prp_spec.md
│   │   └── prp_task.md
│   └── CLAUDE.md.template  # Master router template
├── commands/               # 20 Claude Code commands
│   ├── setup.md            # Bootstrap both systems
│   ├── ai-guides/          # 3 AI Guides maintenance commands
│   ├── prp/                # 8 PRP commands
│   └── development/        # 8 productivity commands
├── tools/                  # Validation script
│   └── validate_ai_guides.sh
├── examples/               # Multi-domain examples
│   ├── web-app/
│   ├── api-project/
│   ├── mobile-app/
│   ├── data-science/
│   ├── rla-documentary/    # Real-world reference
│   ├── CLAUDE.md.snippet   # Router integration
│   └── validation-scenarios-template.md
└── documentation/          # Deep dive guides
    ├── ARCHITECTURE.md     # System design
    ├── CUSTOMIZATION_GUIDE.md
    ├── SUCCESS_METRICS.md
    └── FAQ.md
```

## How to Use

### First-Time Setup

See **`SETUP_GUIDE.md`** for step-by-step instructions:
1. Choose your domain example
2. Customize templates with your patterns
3. Install commands in your project
4. Integrate router in CLAUDE.md
5. Run first validation
6. Test with a validation scenario

### Monthly Maintenance

**1st of each month** - Run three-command workflow:
```bash
# 1. Discover new patterns from recent work
/ai-guides-discover recent

# 2. Assess materiality (40-point scoring)
/ai-guides-assess DISC-001,DISC-002

# 3. Update guides (CRITICAL/HIGH items)
/ai-guides-update DISC-001
```

**Validation**:
```bash
bash tools/validate_ai_guides.sh path/to/your/guides
```

### When Guides Work

You'll know the system is working when:
- ✅ Agents stop asking questions already answered in guides
- ✅ First-pass implementation success rate increases
- ✅ Time for common operations decreases (30%+ reduction)
- ✅ Documented error types reduce (40%+ reduction in 3 months)

## Real-World Example

The **RLA Documentary** project (see `examples/rla-documentary/`) used this system for 3 months:

**Before guides:**
- UUID lookup time: 2-3 minutes
- Duplicate UUID generation: ~50% error rate
- Vision API failures: ~50% for tall screenshots

**After guides:**
- UUID lookup time: 30 seconds (90% reduction)
- Duplicate UUID rate: <10% (40% error reduction)
- Vision API failures: ~0% (proactive tiling workaround)

## Contributing

See **`CONTRIBUTING.md`** for contribution guidelines.

## Documentation

- **`SETUP_GUIDE.md`** - Step-by-step setup instructions
- **`documentation/ARCHITECTURE.md`** - System design and rationale
- **`documentation/CUSTOMIZATION_GUIDE.md`** - Domain-specific patterns
- **`documentation/SUCCESS_METRICS.md`** - How to measure impact
- **`documentation/FAQ.md`** - Common questions

## Support

- **Issues**: Use GitHub Issues for bugs or feature requests
- **Templates**: Use `.github/ISSUE_TEMPLATE/` for structured reporting

## License

MIT License - see `LICENSE` file for details.

---

**Goal**: Friend should be able to clone repo and start using the system on their own project in <30 minutes.

**Philosophy**: Guides are living documents. Systematic maintenance prevents staleness. Objective scoring prevents opinion drift. Validation ensures quality.
