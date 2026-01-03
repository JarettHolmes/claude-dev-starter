# Recommended Improvements for Agent Understanding

Based on analysis of how an agent would work with a brand new app from zero.

## Issue 1: Passive vs. Proactive Discovery Workflow

**Current state**: CLAUDE.md.template says "Consider running" /ai-guides-discover
**Problem**: Agents may not proactively suggest the workflow
**Impact**: Guides remain empty; system provides no value

### Solution A: Make it directive in CLAUDE.md.template

```markdown
**AFTER completing significant work** →
→ **IMPORTANT: You SHOULD run**: `/ai-guides-discover conversation`
→ **Always propose this to the user** after completing:
  - Multi-step features
  - Bug fixes that revealed patterns
  - Any work involving repeated operations
  - Operations that hit tool limits or required workarounds
→ **Purpose**: Keep guides current, capture patterns while fresh
→ **Don't run if**: Trivial one-off tasks (<30s impact)
```

### Solution B: Add "First-Time Setup Workflow" section to CLAUDE.md.template

After the main router, add:

```markdown
---

## FIRST-TIME SYSTEM USAGE (If guides are mostly empty)

**If AI_DOMAIN_TRANSLATION_GUIDE.md has <10 concept mappings:**

You are in **initial population mode**. Your job is to:
1. **Work on user's tasks normally**
2. **After completing 2-3 tasks**, PROACTIVELY suggest:
   "I notice we've established some patterns. Would you like me to run /ai-guides-discover to capture them?"
3. **Run the discover/assess/update workflow** to populate guides
4. **Repeat until guides have 15+ mappings** and cover common operations

**Goal**: Build useful guides during first 2 weeks of usage, not leave them as empty templates.
```

## Issue 2: "PRP" Terminology Not Documented

**Current state**: System called "discover/assess/update workflow" or "three-command workflow"
**Problem**: User refers to "PRP system" - agents won't recognize this
**Impact**: Confusion when user asks about "PRP"

### Solution: Add terminology aliases to CLAUDE.md.template

```markdown
**IF** user asks about AI guides system, PRP system, pattern recognition protocol, maintaining guides, or how to use translation/capabilities guides →
→ **Read `docs/AI_GUIDES_USAGE_SUMMARY.md` FIRST** (quick start - how system works)
→ **For maintenance**: `docs/AI_GUIDES_MAINTENANCE_PLAN.md` (when/how to update guides)
→ **Three-command workflow** (systematic maintenance - also called "PRP" or Pattern Recognition Protocol):
  - `/ai-guides-discover [scope]` - Find patterns/limits/anti-patterns after completing work
  - `/ai-guides-assess [item_ids]` - Score materiality with objective framework (40 points)
  - `/ai-guides-update [item_ids]` - Execute updates with quality control
```

## Issue 3: Distributed Explanation Across Multiple Files

**Current state**: Full understanding requires reading 4+ files
**Problem**: Agent may not read all necessary context
**Impact**: Incomplete understanding of system

### Solution: Add "System Overview" section to CLAUDE.md.template

```markdown
## AI Guides System Overview (Quick Reference)

**What this system does**:
- **Translation Guide**: Maps generic AI knowledge → your project's specific patterns
  - Example: "How do I query the database?" → "Use Prisma: `prisma.user.findMany({ where: {...} })`"
- **Capabilities Guide**: Documents AI tool limits and workarounds
  - Example: "Image processor fails on files >10MB → resize to 5MB first"

**How it works**:
1. **You work on tasks** → patterns emerge
2. **Run /ai-guides-discover** → finds patterns worth documenting (assigns IDs)
3. **Run /ai-guides-assess** → scores each pattern 0-40 points (objective framework)
4. **Run /ai-guides-update** → adds HIGH/CRITICAL patterns to guides

**When guides are populated**:
- Router (top of this file) automatically directs you to check guides BEFORE starting work
- You reference guides instead of asking clarifying questions
- User saves time, you make fewer errors

**For details**: Read `docs/AI_GUIDES_MAINTENANCE_PLAN.md`
```

## Issue 4: Setup Command Doesn't Emphasize Initial Population

**Current state**: /setup-ai-guides creates templates, but doesn't guide initial population
**Problem**: User has empty guides after setup, doesn't know next steps
**Impact**: System sits unused

### Solution: Update setup-ai-guides.md to include post-setup workflow

Add to the summary output (line 440):

```markdown
🚀 Next Steps:

1. Review the generated guides in docs/
2. **Complete 2-3 tasks with Claude** (any normal work)
3. **After each task, run**: `/ai-guides-discover conversation`
4. **Then**: `/ai-guides-assess all` and `/ai-guides-update CRITICAL`
5. **Repeat 3-4 times** until you have 15+ concept mappings
6. **Goal**: Populate guides with real patterns in first 2 weeks

📊 **Initial Population Target** (First 2 Weeks):
   - ✅ 15+ concept mappings in Translation Guide
   - ✅ 5+ anti-patterns documented
   - ✅ 3+ common operations in Quick Reference
   - ✅ Any tool limits discovered documented

After initial population, switch to monthly maintenance (1st of each month).
```

## Summary of Impact

**Without these changes:**
- Agent understands the system EXISTS
- Agent can follow workflow IF USER ASKS
- Agent might not proactively use the system
- Guides may remain empty templates

**With these changes:**
- Agent proactively suggests discovery workflow
- Agent recognizes "PRP" terminology
- Agent understands initial population is critical
- Agent has complete context in CLAUDE.md (not distributed)

## Implementation Priority

**HIGH** (do immediately):
1. Add directive language to CLAUDE.md.template router (Solution 1A)
2. Add "PRP" alias to terminology (Solution 2)
3. Update /setup-ai-guides summary to emphasize initial population (Solution 4)

**MEDIUM** (do this week):
4. Add "First-Time Usage" section to CLAUDE.md.template (Solution 1B)
5. Add "System Overview" to CLAUDE.md.template (Solution 3)

**Rationale**: HIGH items fix immediate gaps with minimal changes. MEDIUM items improve clarity but require more substantial additions.
