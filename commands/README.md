# Development Commands

This directory contains 11 Claude Code commands for systematic development workflow management.

## Command Categories

### AI Guides Commands (3)

Commands for maintaining the AI guides system through systematic discovery, assessment, and updates.

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

### Monthly Maintenance (1st of month)

```
1. /ai-guides-discover recent
2. /ai-guides-assess all
3. /ai-guides-update [critical-items]
4. Run validation: bash tools/validate_ai_guides.sh
```

### Feature Development

```
1. /new-dev-branch
2. [Do work]
3. /smart-commit
4. /create-pr
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
