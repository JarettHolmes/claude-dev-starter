# CLAUDE.md Architecture Guide

Complete guide to understanding and implementing the CLAUDE.md master router + AI guides integration pattern.

## Table of Contents

- [What is CLAUDE.md?](#what-is-claudemd)
- [The Router-First Architecture](#the-router-first-architecture)
- [AI Guides Integration](#ai-guides-integration)
- [Real-World Examples](#real-world-examples)
- [Implementation Guide](#implementation-guide)
- [Best Practices](#best-practices)

---

## What is CLAUDE.md?

**CLAUDE.md** is the master instruction file for AI agents working in your repository. It serves two critical functions:

1. **Router** - Directs agents to domain-specific knowledge based on task keywords
2. **Project Context** - Provides essential background (mission, standards, architecture)

Think of it as a **combination of**:
- A smart router (IF doing X → read Y)
- A project README for agents
- An integration point for specialized guides

### Why CLAUDE.md?

Without CLAUDE.md, agents must either:
- Ask clarifying questions repeatedly
- Read your entire README/documentation every time
- Guess about where to find information

With CLAUDE.md, agents:
- Know exactly where to find specialized knowledge
- Get routed to the right README for the task
- Access quick-reference patterns from AI guides
- Understand project context without reading 50 pages

---

## The Router-First Architecture

### Structure

```markdown
# AGENT ROUTER (EXECUTE FIRST)  <-- Always first, always named this

[Routing rules based on task keywords]

---

# CLAUDE.md  <-- Project context comes after

## Project Mission
## Critical Standards
## Repository Structure
## Architecture Principles
## Standard Workflows
## Command System
## Critical Documents
```

### Why Router First?

**The router must execute BEFORE any action**. This ensures:
1. Agents consult specialized knowledge for their specific task
2. Domain-specific context is loaded before implementation
3. Quick-reference patterns are checked before writing code
4. Existing conventions are followed automatically

### Router Pattern

```markdown
**IF** task mentions [keywords] →
→ **Read/Open `path/to/README.md`** (explanation)
→ Then [optional next step]
→ Work in: [relevant directories]
```

**Example**:
```markdown
**IF** task involves database queries, ORM operations, migrations →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference)
→ Then read domain-specific DB docs if needed
→ Work in: src/db/, src/models/, prisma/
```

### Routing Specificity Levels

**Order matters**. Route from most specific to most general:

```markdown
# AGENT ROUTER (EXECUTE FIRST)

**IF** [MOST SPECIFIC] task mentions exact feature/module →
→ Read that module's README

**IF** [CROSS-CUTTING] task involves patterns (database/API/state) →
→ Read AI_DOMAIN_TRANSLATION_GUIDE.md

**IF** [DOMAIN-SPECIFIC] task mentions broad domain (frontend/backend) →
→ Read domain README

**IF** [GENERAL] exploratory/unclear task →
→ Continue reading this file
```

This ensures agents get the most relevant context first.

---

## AI Guides Integration

The AI guides system integrates into the router as **cross-cutting pattern knowledge**.

### Integration Points

**1. Domain Translation Guide** - For implementation patterns

```markdown
**IF** task involves [detected: database queries, API calls, form validation] →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference)
→ Then read domain-specific documentation if needed
```

**Keywords to use**:
- Database operations → "database queries, ORM operations, migrations"
- API operations → "API calls, endpoints, routes, HTTP requests"
- Frontend → "components, UI, styling, forms, validation"
- State → "state management, stores, context, global data"

**2. Capabilities & Limits Guide** - For known constraints

```markdown
**IF** task involves [detected: image processing, API timeouts, file uploads] →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST** (thresholds + workarounds)
→ Then proceed with appropriate workaround
```

**Keywords to use**:
- Vision/OCR → "image processing, screenshots, OCR, vision tasks"
- Performance → "large files, timeouts, rate limits, slow operations"
- External APIs → "API timeouts, third-party services, external calls"

**3. Guides System Usage** - For guide maintenance

```markdown
**IF** user asks about AI guides system, maintaining guides, or how to use guides →
→ **Read `docs/AI_GUIDES_USAGE_SUMMARY.md` FIRST** (how system works)
→ **For maintenance**: `docs/AI_GUIDES_MAINTENANCE_PLAN.md`
→ **Three-command workflow**:
  - `/ai-guides-discover [scope]` - Find patterns
  - `/ai-guides-assess [item_ids]` - Score materiality
  - `/ai-guides-update [item_ids]` - Update guides
```

**4. Post-Work Discovery** - Systematic maintenance

```markdown
**AFTER completing significant work** →
→ **Consider running**: `/ai-guides-discover conversation`
→ **Purpose**: Prevent guide staleness, capture patterns while fresh
→ **Don't run if**: One-off task, already documented, trivial operation
```

### Where AI Guides Fit

AI guides provide **cross-cutting pattern knowledge** that applies across domains:

```
CLAUDE.md (master router)
    ├── Domain-specific routing
    │   ├── Frontend → front-end/README.md
    │   ├── Backend → backend/README.md
    │   └── Infrastructure → infra/README.md
    │
    ├── Cross-cutting patterns ⭐ AI GUIDES LIVE HERE
    │   ├── Database patterns → AI_DOMAIN_TRANSLATION_GUIDE.md
    │   ├── API patterns → AI_DOMAIN_TRANSLATION_GUIDE.md
    │   ├── Tool limits → AI_CAPABILITIES_AND_LIMITS.md
    │   └── Workarounds → AI_CAPABILITIES_AND_LIMITS.md
    │
    └── General context
        └── Continue reading this file
```

**Key insight**: Domain READMEs are exhaustive (all about frontend). AI guides are selective (just the patterns that matter).

---

## Real-World Examples

### Example 1: Web Application CLAUDE.md

```markdown
# AGENT ROUTER (EXECUTE FIRST)

**IF** task involves database queries, ORM operations, migrations →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference - Prisma patterns)
→ Then read `backend/database/README.md` if needed
→ Work in: src/db/, prisma/

**IF** task involves API endpoints, routes, tRPC procedures →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference - tRPC patterns)
→ Then read `backend/api/README.md` if needed
→ Work in: src/server/api/

**IF** task involves React components, UI, styling, forms →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference - component patterns)
→ Then read `frontend/README.md` if needed
→ Work in: src/components/, src/pages/

**IF** task involves image uploads, large files, or API timeouts →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST** (known limits + workarounds)
→ Apply documented workaround before proceeding

**IF** task mentions authentication, sessions, users →
→ **Open `backend/auth/README.md`** and follow it
→ Work in: src/auth/, src/middleware/

**IF** general/exploratory task →
→ Continue reading this file

**AFTER completing significant work** →
→ **Consider running**: `/ai-guides-discover conversation`

---

# CLAUDE.md

Agent instructions for working in [Project Name].

## Project Mission

Full-stack web application for [purpose]. Built with React, TypeScript, Prisma, and tRPC.

[Continue with project context...]
```

### Example 2: Documentary Project CLAUDE.md

See `examples/CLAUDE-example-documentary-project.md` for a comprehensive anonymized example from a real documentary project with:
- 530 lines of detailed routing
- Integration with investigation workflows
- Registry system routing
- Evidence ingestion pipelines
- Processing commands integration
- AI guides for UUID operations and tool limits

**Key takeaways from real-world usage**:
1. Router can be extremely detailed (100+ routing rules)
2. Domain-specific routing comes first, AI guides provide cross-cutting patterns
3. Commands integrate naturally into routing logic
4. "AFTER completing work" reminder drives systematic maintenance

---

## Implementation Guide

### Option 1: Automated Setup (Recommended)

Use `/setup-ai-guides` command:

```bash
# In your project with Claude Code
/setup-ai-guides
```

Claude will:
1. Detect your tech stack
2. Find patterns in your code
3. Create CLAUDE.md with:
   - Router with detected keywords
   - AI guides integration
   - Project context from README
4. Populate AI guides with your patterns

**Pros**:
- Fast (10 minutes)
- Accurate (based on actual code)
- Integrated (AI guides + CLAUDE.md together)

**Cons**:
- Less control over exact wording
- May miss domain-specific nuances

### Option 2: Manual Setup

Use the template:

```bash
# Copy template
cp templates/CLAUDE.md.template /path/to/your/project/CLAUDE.md

# Customize
# - Replace [CUSTOMIZE] markers
# - Add domain-specific routing
# - Populate project context
```

**Pros**:
- Full control
- Can add domain expertise
- Custom routing logic

**Cons**:
- Time-consuming (30+ minutes)
- Easy to miss patterns
- Must maintain manually

### Option 3: Hybrid Approach

1. Run `/setup-ai-guides` for initial setup
2. Review generated CLAUDE.md
3. Add domain-specific routing manually
4. Refine keywords and paths

**Pros**:
- Best of both worlds
- Fast initial setup
- Refined with expertise

**Recommended** for production projects.

---

## Best Practices

### 1. Router Keyword Selection

**Good keywords** (specific, task-based):
```markdown
**IF** task involves database queries, ORM operations, migrations →
```

**Bad keywords** (too vague):
```markdown
**IF** task involves data →  # Too broad!
```

**Guidelines**:
- Include synonyms (database queries, DB operations, SQL)
- Use task-based language (what user would say)
- Cover variations (database query, querying database, DB queries)
- Be specific enough to route correctly

### 2. Routing Order

**Correct order** (specific → general):
```markdown
1. **IF** task mentions exact feature module
2. **IF** task involves implementation patterns (AI guides)
3. **IF** task mentions broad domain
4. **IF** general/exploratory
```

**Incorrect order** (agents may stop too early):
```markdown
1. **IF** general task  # Too early!
2. **IF** specific module  # Never reached
```

### 3. AI Guides Integration

**Do**:
- Integrate into router flow (not separate section)
- Use "FIRST" to indicate priority (read guide FIRST)
- Include "Then [next step]" for additional context
- Add "Work in:" to show relevant directories

**Don't**:
- Make AI guides optional ("you might want to check...")
- Bury them at the end of routing rules
- Duplicate patterns in both CLAUDE.md and guides (reference, don't repeat)

### 4. Updating CLAUDE.md

**When existing CLAUDE.md exists**:
1. Parse to find "AGENT ROUTER" section
2. Check if AI guides routing already present
3. Insert AI guides rules after domain routing, before general
4. **Show diff before applying**
5. **Create backup**: `CLAUDE.md.backup-YYYYMMDD-HHMMSS`
6. Validate no content lost

**The `/setup-ai-guides` command does this automatically**.

### 5. Router vs. Guides

**CLAUDE.md Router**: Where to find knowledge
```markdown
**IF** database task → Read AI_DOMAIN_TRANSLATION_GUIDE.md
```

**AI Domain Translation Guide**: The actual knowledge
```markdown
| "Database query" | Prisma with include for relations | Watch for N+1 queries |
```

**Never duplicate**. Router points to guides, guides contain patterns.

### 6. Keep It Updated

**Monthly maintenance** (1st of month):
```bash
/ai-guides-discover recent
/ai-guides-assess all
/ai-guides-update [critical-items]
```

Update CLAUDE.md router if:
- New domain added (new module/feature area)
- Keywords change (team terminology evolves)
- Structure changes (directories reorganized)

---

## Common Patterns

### Pattern 1: Multi-Domain Project

```markdown
# AGENT ROUTER (EXECUTE FIRST)

**IF** task involves [cross-cutting patterns] →
→ **Read AI guides FIRST**

**IF** task mentions frontend [keywords] →
→ **Open `frontend/README.md`**

**IF** task mentions backend [keywords] →
→ **Open `backend/README.md`**

**IF** task mentions infrastructure [keywords] →
→ **Open `infra/README.md`**
```

### Pattern 2: Monorepo

```markdown
# AGENT ROUTER (EXECUTE FIRST)

**IF** task mentions package [package-name] →
→ **Open `packages/[package-name]/README.md`**

**IF** task involves [cross-cutting patterns] →
→ **Read AI guides FIRST**

**IF** general task →
→ Continue reading
```

### Pattern 3: Microservices

```markdown
# AGENT ROUTER (EXECUTE FIRST)

**IF** task mentions service [service-name] →
→ **Open `services/[service-name]/README.md`**

**IF** task involves shared patterns (API, database, auth) →
→ **Read AI guides FIRST**

**IF** task mentions deployment, infrastructure →
→ **Open `deployment/README.md`**
```

---

## Troubleshooting

### Agent Not Reading Guides

**Symptom**: Agent asks questions already answered in guides

**Diagnosis**:
1. Check if router keywords match task description
2. Verify "FIRST" is included in routing rule
3. Ensure guides path is correct

**Fix**:
- Broaden keywords (add synonyms)
- Make routing rule more prominent
- Test with actual user phrasing

### Router Rules Conflict

**Symptom**: Agent gets confused by multiple matching rules

**Diagnosis**:
- Multiple rules match same keywords
- Order is wrong (general before specific)

**Fix**:
- Reorder rules (specific → general)
- Make keywords more specific
- Add "Then continue if needed" to allow fallthrough

### CLAUDE.md Too Long

**Symptom**: CLAUDE.md is 1000+ lines

**Diagnosis**:
- Duplicating content from guides/READMEs
- Too much detail in routing rules

**Fix**:
- Router should REFERENCE, not REPEAT
- Move detailed content to domain READMEs
- Keep routing rules concise (1-3 lines each)

---

## Template Reference

See `templates/CLAUDE.md.template` for complete template with [CUSTOMIZE] markers.

See `CLAUDE.md` (this repository) for reference implementation.

See `examples/CLAUDE-example-documentary-project.md` for real-world production example.

---

## Summary

**CLAUDE.md = Master Router + Project Context**

1. **Router FIRST** - Directs to specialized knowledge
2. **AI Guides** - Provide cross-cutting patterns
3. **Domain READMEs** - Exhaustive domain documentation
4. **Project Context** - Mission, standards, architecture

**Integration Pattern**:
```
User task → CLAUDE.md router → AI guides (quick patterns) → Domain README (deep dive) → Implementation
```

**Maintenance**:
- Update router when structure changes
- Update AI guides monthly (discover/assess/update workflow)
- Keep CLAUDE.md concise (reference, don't repeat)

**Goal**: Agent finds the right knowledge for the task in <30 seconds.
