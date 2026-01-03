# Command Library

This starter kit includes 20 commands organized in 3 categories.

## Command Categories

### AI Guides Commands (4)

Commands for setting up and maintaining the AI guides system through systematic discovery, assessment, and updates.

#### `/setup [mode]`

**Purpose**: Bootstrap complete system (PRP + AI Guides) for your project with interactive setup

**When to use**:
- **First time setup** - When adding AI guides to your project
- New project initialization
- Existing project that needs guides

**Modes**:
- `interactive` (default) - Guided questions and codebase analysis
- `auto` - Automatic tech stack detection and setup
- `minimal` - Basic templates only, manual customization

**What it does**:
1. Creates AI Guides system (docs/ directory with 4 guides)
2. Creates PRP workspace (PRPs/ directory with templates)
3. Detects tech stack and populates initial patterns
4. Adds router integration to CLAUDE.md
5. Installs all commands (AI Guides + PRP + Development)
6. Runs validation check

**Example**:
```
/setup

# Claude asks about your project
"Is this a new project or existing codebase?"
"What's your tech stack? (detected: React, Prisma, tRPC)"
"Where should guides and PRPs live? (default: docs/ and PRPs/)"

# Claude sets up everything
✅ Created 4 AI guide files in docs/
✅ Created PRP workspace with 4 templates
✅ Populated 15 concept mappings from your code
✅ Added router to CLAUDE.md
✅ Installed 20 commands
✅ Validation passed

# Both systems ready to use!
```

**Run this ONCE per project.** After setup, use the maintenance commands below.

---

#### `/ai-guides-discover [scope]`

**Purpose**: Find patterns, limits, and anti-patterns from recent work

**When to use**:
- After completing significant work
- Monthly review (1st of month)
- After discovering a bug or workaround
- After pair programming sessions

**Scopes**:
- `conversation` (default) - Analyze current conversation
- `recent` - Last 7 days of git commits
- `workflow` - Specific workflow file path
- `all` - Comprehensive codebase scan

**Output**: Discovery items with IDs (DISC-001, DISC-002, etc.)

**Example**:
```
/ai-guides-discover recent

Output:
DISC-001: Database Query Pattern
  - Observed: prisma.findMany() used 5 times
  - Recommendation: Add to concept mappings

DISC-002: API Timeout Limit
  - Observed: fetch() timeout at 30s
  - Recommendation: Document limit with retry workaround
```

---

#### `/ai-guides-assess [item_ids]`

**Purpose**: Score materiality with objective 40-point framework

**When to use**:
- After discovery (assess which items to update)
- To prioritize updates when time is limited
- Before monthly update cycle

**Input options**:
- Specific IDs: `DISC-001,DISC-002`
- Materiality level: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
- `all` - Assess all discovered items

**Output**: Prioritized recommendations with scores

**Scoring dimensions** (10 points each):
1. Impact - Time saved or prevented
2. Frequency - How often encountered
3. Clarity - Obviousness of correct approach
4. Testability - Validation ease

**Example**:
```
/ai-guides-assess DISC-001,DISC-002

Output:
DISC-001: Database Query Pattern
  Impact: 7/10 (saves 20 min/day)
  Frequency: 9/10 (daily)
  Clarity: 4/10 (not obvious)
  Testability: 8/10 (easy to test)
  TOTAL: 28/40 → HIGH (update this month)

DISC-002: API Timeout
  Impact: 10/10 (prevents failures)
  Frequency: 6/10 (weekly)
  Clarity: 2/10 (very non-obvious)
  Testability: 7/10 (reproducible)
  TOTAL: 25/40 → HIGH (update this month)
```

---

#### `/ai-guides-update [item_ids]`

**Purpose**: Execute guide updates with quality control

**When to use**:
- After assessment (update CRITICAL and HIGH items)
- When validation scenarios fail
- When error rate spikes for known pattern

**Input**: Discovery item IDs (e.g., `DISC-001`)

**Safety features**:
- User approval before changes
- Validation script runs after update
- Git snapshots for rollback
- Link checking

**Example**:
```
/ai-guides-update DISC-001

Output:
Proposed changes:
  File: docs/AI_DOMAIN_TRANSLATION_GUIDE.md
  Section: Concept Mappings
  Change: Add "Database query" → "Prisma findMany()"

Approve? (yes/no)
> yes

✅ Updated guide
✅ Validation passed
✅ Git commit created
```

---

### PRP Commands (8)

Commands for creating and executing context-rich Product Requirement Prompts with built-in validation.

#### `/prp-planning-create [idea]`

**Purpose**: Transform rough idea into comprehensive PRD through agentic research

**When to use**: Complex features needing thorough research and planning

**Features**:
- Deep codebase analysis
- API/library documentation research
- Competitive analysis
- Risk assessment
- Comprehensive requirements doc

---

#### `/prp-create [INITIAL.md]`

**Purpose**: Generate detailed PRP from requirements file (auto-pulls AI Guide patterns)

**When to use**: After creating INITIAL.md with feature requirements

**Features**:
- Auto-references AI Guides patterns
- Creates comprehensive "All Needed Context" section
- Includes validation loops
- Generates implementation blueprint

**Example**:
```
/prp-create PRPs/in-progress/auth-feature-INITIAL.md

# Generates detailed PRP with:
✅ Your project's database patterns (from AI Guides)
✅ API patterns (from AI Guides)
✅ Known gotchas and workarounds
✅ Validation criteria
✅ Implementation steps
```

---

#### `/prp-base-execute [prp-file]`

**Purpose**: Execute BASE PRP with multi-level validation loops

**When to use**: Standard feature implementation from PRP

**Features**:
- Step-by-step implementation
- Validation at each step
- Self-correction on errors
- Progress tracking

---

#### `/prp-spec-execute [spec-file]`

**Purpose**: Execute SPEC PRP for transformations (migrations, refactors)

**When to use**: Database migrations, framework upgrades, large refactors

**Features**:
- Systematic transformation
- Rollback on failure
- Data preservation checks
- Migration validation

---

#### `/prp-task-execute [task-file]`

**Purpose**: Execute TASK PRP with checklist-based workflow

**When to use**: Multi-phase features, complex deployments

---

#### `/task-list-init [description]`

**Purpose**: Create task checklist for breaking down complex work

**When to use**: Starting multi-step features or projects

---

#### `/api-contract-define [feature]`

**Purpose**: Define API contracts before implementation

**When to use**: API-first development, frontend-backend coordination

---

#### `/read-docs`

**Purpose**: Load project context documents into agent memory

**When to use**: Start of session, after context loss, before major work

**Features**:
- Loads AI Guides
- Loads relevant PRPs
- Loads architecture docs
- Sets full project context

---

### Development Commands (8)

General productivity tools for development workflow.

#### `/smart-commit`

**Purpose**: Analyze changes and create intelligent git commit

**When to use**: Before committing code

**Features**:
- Analyzes git diff
- Generates semantic commit message
- Follows conventional commits format
- References related issues

**Related**: Integrates with guides for commit message patterns

---

#### `/create-pr`

**Purpose**: Create well-structured pull request with proper description

**When to use**: After commits, before merging

**Features**:
- Generates PR title and description
- Lists changes with context
- Includes testing notes
- Links to related issues

**Related**: Links to `/smart-commit` for commit history

---

#### `/debug-RCA`

**Purpose**: Systematic root cause analysis for debugging

**When to use**: When investigating issues or bugs

**Features**:
- Structured problem investigation
- Root cause identification
- Solution exploration
- Documentation of findings

**Related**: Documents findings for capability testing in guides

---

#### `/update-claude-readme`

**Purpose**: Keep CLAUDE.md documentation synchronized with changes

**When to use**: After completing significant work

**Features**:
- Analyzes recent changes
- Updates router if needed
- Syncs with guide references
- Maintains documentation consistency

**Related**: Updates guide references in CLAUDE.md

---

#### `/onboarding`

**Purpose**: Comprehensive analysis for new developer onboarding

**When to use**: When team members join the project

**Features**:
- Project overview generation
- Key files identification
- Setup instructions
- Common patterns summary

**Related**: References guides in onboarding flow

---

#### `/prime-core`

**Purpose**: Prime Claude Code with core project knowledge

**When to use**: At start of session, after context loss

**Features**:
- Loads key project files
- Summarizes architecture
- References guides
- Sets context for work

**Related**: Loads guide references into agent context

---

#### `/create-prompt`

**Purpose**: Expert prompt engineering assistance

**When to use**: Creating new prompts or commands

**Features**:
- Structured prompt design
- XML formatting
- Depth optimization
- Pattern reuse

**Related**: Uses patterns from guides for prompt structure

---

#### `/new-dev-branch`

**Purpose**: Create development branches with consistent naming

**When to use**: Starting new features or fixes

**Features**:
- Branch naming conventions
- Branch from correct base
- Initial commit setup
- Worktree support

**Related**: Standard branching workflow

---

## Installation

Copy commands to your project:

```bash
cp -r commands/ /path/to/your/project/.claude/commands/
```

**Restart Claude Code** to load new commands.

## Usage

Access commands with `/` prefix in Claude Code:

```
/ai-guides-discover conversation
/ai-guides-assess all
/ai-guides-update DISC-001
/smart-commit
/create-pr
```

**Tab completion**: Type `/ai-` and press tab to see available commands.

## Customization

Commands are **project-agnostic** and work as-is. No customization needed.

If you need to modify:
1. Edit command `.md` files
2. Follow YAML frontmatter format
3. Test with `/[command-name]`
4. Restart Claude Code if changes don't apply

## Typical Workflow

### Initial Setup (One Time)

```
1. /setup
2. Review generated guides and PRP templates
3. Test with a sample task
4. Customize as needed
```

### Monthly Maintenance (1st of month)

```
1. /ai-guides-discover recent
2. /ai-guides-assess all
3. /ai-guides-update [critical-items]
4. Run validation: bash tools/validate_ai_guides.sh
```

### Feature Development (with PRP)

```
1. Create PRPs/in-progress/INITIAL.md with requirements
2. /prp-create PRPs/in-progress/INITIAL.md
3. Review generated PRP
4. /prp-base-execute [prp-file]
5. /ai-guides-discover conversation  # Document learnings
6. /smart-commit
7. /create-pr
```

### Simple Feature Development (no PRP)

```
1. /new-dev-branch
2. [Do work]
3. /smart-commit
4. /create-pr
5. /ai-guides-discover conversation  # If pattern worth documenting
```

### After Discovering Pattern

```
1. [Complete work]
2. /ai-guides-discover conversation
3. /ai-guides-assess [discovered-item]
4. /ai-guides-update [if HIGH/CRITICAL]
```

### Debugging

```
1. /debug-RCA
2. [Investigate and fix]
3. /ai-guides-discover conversation  # Document if new pattern
```

## Command Dependencies

```
/ai-guides-discover
       ↓
/ai-guides-assess
       ↓
/ai-guides-update
```

**Run in sequence**: Discovery → Assessment → Update

## Troubleshooting

**Commands not showing**:
1. Check installation path (`.claude/commands/`)
2. Restart Claude Code
3. Verify file format (`.md` with YAML frontmatter)

**Command errors**:
1. Check command syntax
2. Verify required parameters
3. Check Claude Code version compatibility

**Need help?**
- Check command file for detailed instructions
- Open issue on GitHub
- See FAQ.md for common questions

---

**All commands are maintained and ready to use. No modifications required for basic usage.**
