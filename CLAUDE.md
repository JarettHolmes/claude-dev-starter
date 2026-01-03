# AGENT ROUTER (EXECUTE FIRST)

Follow this router before any action. Do not explore outside the relevant README.

**IF** task involves commands, slash commands, or command development →
→ **Open `commands/README.md`** and follow it
→ Work in: `commands/ai-guides/`, `commands/development/`
→ Key files: Command `.md` files with YAML frontmatter

**IF** task involves templates, guide templates, or customization markers →
→ **Open `templates/` directory**
→ Work in: `templates/`
→ Reference: `examples/` for populated examples

**IF** task involves domain examples (web-app, api-project, mobile-app, data-science) →
→ **Open `examples/{domain}/README.md`**
→ Work in: `examples/`
→ Purpose: Reference implementations for users

**IF** task involves documentation, setup guides, or user-facing docs →
→ **Check `documentation/` directory first**
→ Reference: `README.md`, `WALKTHROUGH.md`, `SETUP_GUIDE.md`, `CONTRIBUTING.md`
→ Work in: Root docs or `documentation/`

**IF** task involves validation, testing, or quality checks →
→ **Read `tools/validate_ai_guides.sh`**
→ Work in: `tools/`
→ Purpose: Health checks for guide quality

**IF** general/exploratory task →
→ Continue reading this file

**ALWAYS respect repo rules**:
- No hardcoded repository URLs (use [URL] placeholder)
- Keep examples realistic but generic
- All [CUSTOMIZE] markers must have inline instructions
- Command descriptions must be concise (3-5 words)
- Follow existing formatting conventions

---

# CLAUDE.md

Agent instructions for working in the Claude Development System Starter Kit repository.

## Project Mission

Provide a systematic approach to AI agent instruction management for Claude Code. Enable developers to create quick-reference guides documenting project patterns, limitations, and anti-patterns that AI agents can consult during work—preventing errors, reducing clarifying questions, and accelerating development.

**Target Users**: Developers using Claude Code who want to teach Claude their project's patterns once instead of answering the same questions repeatedly.

---

## Critical Standards

### Documentation Quality

**All user-facing documentation must**:
- Be clear and concise
- Include examples
- Use consistent formatting
- Be testable (if contains code)
- Follow markdown best practices

**WALKTHROUGH.md philosophy**: Show, don't tell. Real examples, real value props, minimal fluff.

### Template Standards

**All templates must**:
- Use `[CUSTOMIZE: description]` markers with inline instructions
- Show examples in comments
- Be copy-paste ready (no TODOs)
- Follow domain-specific conventions

### Command Standards

**All commands must**:
- Have YAML frontmatter (command, description, signature, arguments)
- Concise description (3-5 words)
- Clear argument descriptions
- Detailed usage instructions in body
- Examples showing actual usage

### Repository Rules

- Never commit with hardcoded repository URLs (use `[URL]` or `git@github.com:YOUR_USERNAME/...`)
- Keep examples domain-specific but technology-agnostic where possible
- All code examples must be tested and working
- Follow conventional commits format (feat:, fix:, docs:, chore:)

---

## Repository Structure

```
claude-dev-starter/
├── templates/              # Guide templates with [CUSTOMIZE] markers
│   ├── AI_DOMAIN_TRANSLATION_GUIDE.md
│   ├── AI_CAPABILITIES_AND_LIMITS.md
│   ├── AI_GUIDES_USAGE_SUMMARY.md
│   ├── AI_GUIDES_MAINTENANCE_PLAN.md
│   └── CLAUDE.md.template  # Master router + context template
│
├── commands/               # Claude Code commands
│   ├── ai-guides/          # Setup and maintenance commands
│   │   ├── setup-ai-guides.md       # Bootstrap entire system
│   │   ├── ai-guides-discover.md    # Find patterns
│   │   ├── ai-guides-assess.md      # Score materiality
│   │   └── ai-guides-update.md      # Update guides
│   └── development/        # Productivity commands
│
├── tools/                  # Validation and utilities
│   └── validate_ai_guides.sh
│
├── examples/               # Domain-specific examples
│   ├── web-app/            # React/TypeScript/Prisma/tRPC
│   ├── api-project/        # GraphQL/REST/PostgreSQL
│   ├── mobile-app/         # React Native/Expo
│   ├── data-science/       # Python/Jupyter/Pandas
│   ├── rla-documentary/    # Real-world reference
│   ├── CLAUDE.md.snippet   # Router integration example
│   └── validation-scenarios-template.md
│
├── documentation/          # Deep dive guides
│   ├── ARCHITECTURE.md
│   ├── CUSTOMIZATION_GUIDE.md
│   ├── SUCCESS_METRICS.md
│   └── FAQ.md
│
├── .github/                # GitHub templates
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
│
├── README.md               # Project overview
├── WALKTHROUGH.md          # Why you need this (value prop)
├── SETUP_GUIDE.md          # Step-by-step setup
├── CONTRIBUTING.md         # Contribution guidelines
├── CHANGELOG.md            # Version history
└── CLAUDE.md               # This file (agent instructions)
```

---

## Architecture Principles

**Templates = Fill-in-the-Blanks**:
- Not empty files - real content with [CUSTOMIZE] markers
- Inline instructions show what to fill in
- Examples in comments demonstrate patterns

**Examples = Working References**:
- Domain-specific but realistic
- Show actual patterns, not toy code
- Complete enough to copy and adapt
- Cover common use cases

**Commands = Autonomous Workflows**:
- Self-contained instructions
- Clear steps and validation
- Error handling
- Examples of expected output

**Documentation = Show Value First**:
- WALKTHROUGH.md hooks users (10 min read)
- README.md gives overview
- SETUP_GUIDE.md provides step-by-step
- documentation/ for deep dives

---

## Standard Workflows

**Adding a New Domain Example**:
1. Create `examples/{domain}/` directory
2. Populate AI_DOMAIN_TRANSLATION.snippet.md with patterns
3. Add README.md explaining the domain
4. Add validation scenario
5. Update main README.md to list new example
6. Test with validation script

**Adding a New Command**:
1. Create `commands/{category}/{command-name}.md`
2. Add YAML frontmatter (command, description, signature, arguments)
3. Write detailed instructions with examples
4. Test command works in Claude Code
5. Update `commands/README.md` to document it
6. Update main README.md command count

**Updating Documentation**:
1. Identify what changed (commands, examples, templates)
2. Update relevant docs (README, WALKTHROUGH, SETUP_GUIDE)
3. Update CHANGELOG.md
4. Check all internal links still work
5. Update "Last Modified" dates where applicable

**Adding Real-World Example**:
1. Get permission from project owner
2. Anonymize if needed
3. Extract actual patterns to example directory
4. Document results (before/after metrics)
5. Add to examples/ with README explaining context

---

## Command System

**Available Commands**:
```bash
# AI Guides Commands (in user projects)
/setup-ai-guides [mode]        # Bootstrap system (run once)
/ai-guides-discover [scope]    # Find patterns from recent work
/ai-guides-assess [item_ids]   # Score materiality
/ai-guides-update [item_ids]   # Update guides
```

**Command Development**:
- Commands are markdown files with YAML frontmatter
- Stored in `commands/{category}/`
- Use clear, imperative descriptions
- Include examples of usage and output

---

## Critical Documents

### For Users (External)
- `README.md` - Project overview, quick start
- `WALKTHROUGH.md` - Value proposition, real examples
- `SETUP_GUIDE.md` - Step-by-step instructions
- `CONTRIBUTING.md` - How to contribute
- `templates/` - What users customize
- `examples/` - Reference implementations

### For Developers (Internal)
- `CLAUDE.md` - This file (agent instructions)
- `commands/README.md` - Command library
- `documentation/ARCHITECTURE.md` - System design
- `documentation/CUSTOMIZATION_GUIDE.md` - Domain-specific patterns
- `documentation/FAQ.md` - Common questions

### Reference Implementation
- `examples/rla-documentary/` - Real-world usage with metrics

---

## Design Philosophy

**Problem**: AI agents either (1) ask too many clarifying questions, or (2) guess wrong about project conventions.

**Solution**: Quick-reference guides + systematic maintenance workflow.

**Key Insight**: Documentation goes stale. This system actively prevents staleness through:
1. Discovery workflow (find new patterns)
2. Assessment framework (objective 40-point scoring)
3. Update workflow (quality-controlled changes)
4. Validation (monthly health checks)

**Not Another Documentation System**: This is designed specifically for AI agent consumption. Concise, scannable, pattern-focused. Humans read README.md, agents consult guides.

---

**When working on this repository**:
1. Check router at top of this file for correct README
2. Follow existing formatting conventions
3. Test all code examples
4. Keep user experience front-of-mind
5. Show value through real examples, not theoretical benefits

**Target outcome**: User clones repo, runs `/setup-ai-guides`, and sees immediate value in first task.
