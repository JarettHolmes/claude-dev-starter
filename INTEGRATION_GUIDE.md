# PRP + AI Guides Integration Guide

## Two Systems, One Goal

This starter kit combines two complementary methodologies:

| System | Purpose | When to Use |
|--------|---------|-------------|
| **AI Guides** | Document existing patterns | After work is done, to capture learnings |
| **PRP** | Create detailed specifications | Before building, to plan implementation |

**Key Insight**: AI Guides teach Claude your patterns once. PRPs use those patterns for error-free implementation.

---

## System 1: AI Guides (Knowledge Layer)

**Purpose:** Maintain living documentation that prevents AI agents from asking repetitive questions.

**Three-Phase Workflow:**
1. **Discover** (`/ai-guides-discover`) - Find patterns/limits after completing work
2. **Assess** (`/ai-guides-assess`) - Score materiality (0-40 points)
3. **Update** (`/ai-guides-update`) - Add HIGH/CRITICAL items to guides

**Two Guide Types:**
1. **Domain Translation** - "When you think X, we use Y" mappings
2. **Capabilities & Limits** - Tool limits, thresholds, workarounds

**Example Usage:**
```bash
# After implementing auth feature
/ai-guides-discover conversation
  → Found: JWT pattern, OAuth gotcha, session storage approach

/ai-guides-assess all
  → DISC-001: 32/40 (HIGH) - JWT validation pattern
  → DISC-002: 38/40 (CRITICAL) - OAuth scope gotcha

/ai-guides-update DISC-002
  → Added to AI_DOMAIN_TRANSLATION_GUIDE.md
```

**Output:** `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` updated with patterns

---

## System 2: PRP (Execution Layer)

**Purpose:** Create context-rich specifications that enable one-pass implementation success.

**Four PRP Types:**

| Type | Purpose | Time | Use Case |
|------|---------|------|----------|
| **PLANNING** | Rough idea → Comprehensive PRD | 30-60 min | Complex features needing research |
| **BASE** | Requirements → Implementation | 1-2 hours | Standard feature development |
| **SPEC** | Transform existing code | 2-5 hours | Migrations, refactors, upgrades |
| **TASK** | Break down complex work | Variable | Multi-phase features |

**Standard Workflow:**
```bash
# 1. Create rough outline
cat > PRPs/in-progress/INITIAL.md <<EOF
Feature: User authentication with JWT
- Login/logout
- Token refresh
- Protected routes
EOF

# 2. Generate detailed PRP (auto-pulls AI Guide patterns)
/prp-create PRPs/in-progress/INITIAL.md
  → Generates: auth-feature.md (12 pages)
  → Includes: Your project's JWT patterns from AI guides
  → Includes: Database query patterns (Prisma)
  → Includes: Known gotchas

# 3. Review and enhance PRP
vim PRPs/in-progress/auth-feature.md

# 4. Execute with validation loops
/prp-base-execute PRPs/in-progress/auth-feature.md
  → Implements feature
  → Runs validation at each step
  → Self-corrects errors

# 5. Archive on completion
mv PRPs/in-progress/auth-feature.md PRPs/completed/
```

**Output:** Working feature + completed PRP in `PRPs/completed/`

---

## How They Work Together

### Integration Point 1: PRP Creation Auto-References AI Guides

When you run `/prp-create`, it:
1. Reads `docs/AI_DOMAIN_TRANSLATION_GUIDE.md`
2. Extracts relevant patterns for your feature
3. Includes them in "All Needed Context" section
4. References known gotchas

**Example:**
```yaml
# In generated PRP:
All Needed Context:
  project_patterns:
    - Database queries: Prisma ORM (from AI_DOMAIN_TRANSLATION_GUIDE.md)
      Gotcha: Always use `include` for relations
      Example: prisma.user.findMany({ include: { profile: true } })

    - API calls: tRPC procedures (from AI_DOMAIN_TRANSLATION_GUIDE.md)
      Gotcha: Type-safe, no fetch() for internal APIs
```

### Integration Point 2: AI Guides Capture PRP Learnings

After executing a PRP:
1. Run `/ai-guides-discover conversation`
2. System finds new patterns from implementation
3. Run `/ai-guides-assess` to score
4. Run `/ai-guides-update` to document
5. Future PRPs auto-include these patterns

**Feedback Loop:**
```
PRP discovers pattern → AI Guides documents → Next PRP references → Faster implementation
```

### Integration Point 3: Validation Commands Shared

PRPs reference validation commands from AI guides:
- Database migrations use documented Prisma commands
- API testing use documented curl patterns
- Frontend testing uses documented test patterns

---

## Complete Workflow Examples

### Example 1: New Feature (Social Login)

**Day 1: Build**
```bash
# Create rough requirements
cat > PRPs/in-progress/social-login-INITIAL.md <<EOF
Add Google OAuth login
- OAuth flow
- Token storage
- Profile sync
EOF

# Generate detailed PRP
/prp-create PRPs/in-progress/social-login-INITIAL.md
  → Auto-includes: Database patterns (Prisma User model)
  → Auto-includes: API patterns (tRPC procedures)
  → Auto-includes: Known OAuth gotchas (if documented)

# Execute
/prp-base-execute social-login.md
  → Feature completed in 90 minutes
```

**Day 2: Document**
```bash
# Discover new patterns
/ai-guides-discover conversation
  → DISC-001: OAuth scope handling pattern
  → DISC-002: Google token refresh approach
  → DISC-003: Profile sync edge case

# Assess
/ai-guides-assess all
  → DISC-001: 36/40 (CRITICAL)
  → DISC-002: 28/40 (HIGH)
  → DISC-003: 18/40 (MEDIUM)

# Update guide with critical items
/ai-guides-update DISC-001,DISC-002
  → docs/AI_DOMAIN_TRANSLATION_GUIDE.md updated
```

**Day 3: Next Feature (Facebook Login)**
```bash
# Create PRP for Facebook login
/prp-create PRPs/in-progress/facebook-login-INITIAL.md
  → Auto-includes: OAuth patterns documented yesterday
  → Auto-includes: Token refresh approach
  → Faster implementation with yesterday's learnings
```

### Example 2: Database Migration (SQLite → PostgreSQL)

**Step 1: Create SPEC PRP**
```bash
# SPEC PRPs for transformations
cat > PRPs/in-progress/postgres-migration-SPEC.md <<EOF
Transform: SQLite → PostgreSQL
Current: app.db (SQLite)
Desired: PostgreSQL with Prisma
Constraints: Zero downtime, preserve data
EOF

/prp-create PRPs/in-progress/postgres-migration-SPEC.md
  → Generates transformation spec
  → Includes: Database patterns from AI guides
  → Includes: Migration validation commands
```

**Step 2: Execute Migration**
```bash
/prp-spec-execute postgres-migration-SPEC.md
  → Systematic transformation
  → Validates each step
  → Rollback on failure
```

**Step 3: Document Migration Pattern**
```bash
/ai-guides-discover conversation
  → Documents: Migration pattern
  → Documents: PostgreSQL-specific gotchas
  → Future migrations reference this
```

---

## Decision Tree: Which System When?

```
New Task Arrives
    │
    ├─ Documenting/Looking up existing pattern?
    │  └─> Use AI Guides
    │      - Check AI_DOMAIN_TRANSLATION_GUIDE.md
    │      - Quick reference lookup
    │      - Time: <1 minute
    │
    ├─ Building new feature (complex, multi-file)?
    │  └─> Use PRP
    │      - Create PRP with /prp-create
    │      - Auto-includes AI Guide patterns
    │      - Execute with /prp-base-execute
    │      - Time: 1-3 hours total
    │      - After: Document learnings with AI Guides
    │
    ├─ Transforming existing code?
    │  └─> Use SPEC PRP
    │      - Database migrations
    │      - Framework upgrades
    │      - Large refactors
    │
    ├─ Simple, obvious implementation?
    │  └─> Implement directly
    │      - No PRP needed
    │      - After: Run /ai-guides-discover
    │
    └─ Just completed significant work?
       └─> Update AI Guides
           - /ai-guides-discover conversation
           - Capture patterns while fresh
           - Time: 10-15 minutes
```

---

## Monthly Maintenance

**1st of Month Ritual** (30 minutes):

```bash
# 1. Discover patterns from recent work
/ai-guides-discover recent  # Last 7 days of commits

# 2. Assess all findings
/ai-guides-assess all

# 3. Update CRITICAL items
/ai-guides-update [critical-ids]

# 4. Run validation
bash tools/validate_ai_guides.sh docs/

# 5. Archive completed PRPs
mv PRPs/in-progress/*.md PRPs/completed/  # If done

# 6. Clean up workspace
rm -rf workspace/ai_docs/*  # Remove stale docs
```

---

## Success Metrics

### AI Guides Success:
- ✅ Questions asked before starting work (↓ should decrease 60%+)
- ✅ First-pass implementation success (↑ should increase 40%+)
- ✅ Time for common operations (↓ should decrease 30%+)
- ✅ Guide staleness (monthly validation passing)

### PRP Success:
- ✅ One-pass implementation success rate (target: 80%+)
- ✅ Clarifying questions during execution (↓ should be minimal)
- ✅ Validation failures (↓ caught early with built-in loops)
- ✅ Implementation time vs manual (comparable or faster)

### Combined Success:
- ✅ Pattern reuse across features
- ✅ Faster second/third implementations (patterns documented)
- ✅ Reduced rework from missed requirements
- ✅ Comprehensive validation coverage

---

## Troubleshooting

**Q: PRP doesn't include AI Guide patterns**
A: Ensure guides exist in `docs/` before running `/prp-create`. Run `/setup` if needed.

**Q: AI Guides feel stale**
A: Run `/ai-guides-discover recent` monthly. Set calendar reminder for 1st of month.

**Q: Too many PRPs in progress**
A: Archive completed ones to `PRPs/completed/`. Keep max 3-5 active PRPs.

**Q: Which system should I use?**
A: See decision tree above. General rule: PRP for building, AI Guides for documenting.

---

## Quick Reference

**Setup:** `/setup` (one-time, 10 minutes)

**Daily:**
- Build features: `/prp-create` → `/prp-base-execute`
- Look up patterns: Check `docs/AI_DOMAIN_TRANSLATION_GUIDE.md`

**After significant work:**
- Document: `/ai-guides-discover conversation`

**Monthly:**
- Maintain: `/ai-guides-discover recent` → assess → update
- Validate: `bash tools/validate_ai_guides.sh docs/`

**Learn more:**
- AI Guides: `docs/AI_GUIDES_USAGE_SUMMARY.md`
- PRP: `PRPs/README.md`
- Commands: `.claude/commands/`
