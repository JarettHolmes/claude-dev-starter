# System Architecture

Deep dive into the design, rationale, and implementation of the Claude Development System.

## Overview

The Claude Development System is a **4-layer architecture** for systematic AI agent instruction management:

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: Two Complementary Guides                      │
│  ├─ Domain Translation (patterns/anti-patterns)         │
│  └─ Capabilities & Limits (tool thresholds/workarounds) │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Layer 2: Three-Command Maintenance Workflow            │
│  ├─ /ai-guides-discover (find patterns)                 │
│  ├─ /ai-guides-assess (score materiality)               │
│  └─ /ai-guides-update (execute updates)                 │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Layer 3: Router Integration (CLAUDE.md)                │
│  ├─ IF/THEN routing to guides                           │
│  ├─ Triggers on specific patterns                       │
│  └─ Post-work discovery prompts                         │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Layer 4: Validation Infrastructure                     │
│  ├─ Monthly validation script                           │
│  ├─ Validation scenarios                                │
│  └─ Success metrics tracking                            │
└─────────────────────────────────────────────────────────┘
```

## Layer 1: Two Complementary Guides

### Why Two Guides?

**The Problem**: Comprehensive documentation is too long to consult during tasks. Agents need quick lookups.

**The Solution**: Two complementary guides optimized for different lookup patterns.

### Guide 1: AI Domain Translation Guide

**Purpose**: Map human concepts to project-specific implementations

**Structure**:
```markdown
1. Concept Mappings Table
   - "When You Think" → "We Actually Use" → "Gotcha"
   - Quick pattern matching

2. Tool Selection Matrix
   - IF condition → USE tool → WHY
   - Decision tree for common choices

3. Common Anti-Patterns
   - ❌ Wrong approach + Why wrong
   - ✅ Correct approach + Why right
   - Pattern matching for error prevention

4. Quick Reference Patterns
   - Copy-paste code snippets
   - Syntax-highlighted, tested
```

**Optimization**: Scannable tables, bold keywords, code snippets

**Use case**: "I need to query the database" → scan table → find ORM pattern → apply

### Guide 2: AI Capabilities & Limits Guide

**Purpose**: Prevent reactive debugging through proactive awareness

**Structure**:
```markdown
1. Documented Limits
   - Tool/API with threshold
   - Tested workaround
   - When to apply workaround

2. Future Testing Backlog
   - Hypotheses to validate
   - Validation plan
   - Priority score

3. Workaround Reference
   - Script/tool name
   - When to use
   - Link to implementation
```

**Optimization**: Searchable tool names, clear thresholds, actionable workarounds

**Use case**: "I need to process an image" → check limits → see 1568px threshold → apply tiling workaround proactively

### Cognitive Load Management

**Why split guides?**

1. **Different mental models**: Pattern lookup vs. capability checking
2. **Different update triggers**: New patterns vs. discovered limits
3. **Different scanning patterns**: Table scan vs. tool name search
4. **Different urgency**: Anti-patterns prevent errors (HIGH), limits prevent failures (CRITICAL)

**Alternative considered**: Single guide
- **Rejected**: Too long, hard to scan, mixing concerns

## Layer 2: Three-Command Maintenance Workflow

### The Staleness Problem

**Challenge**: Guides become outdated as projects evolve

**Traditional approach**: Manual updates when you "remember"
- **Result**: 80% of guides are stale within 3 months

**Our approach**: Systematic discovery → assessment → update

### Command 1: `/ai-guides-discover`

**Purpose**: Find patterns, limits, anti-patterns from recent work

**Scopes**:
- `conversation` - Analyze current conversation
- `recent` - Last 7 days of git commits
- `workflow` - Specific workflow file
- `all` - Comprehensive codebase scan

**Output**: Discovery items with IDs (DISC-001, DISC-002...)

**Algorithm**:
1. Scan context (conversation/commits/files)
2. Identify patterns (repeated code, common tasks)
3. Identify limits (error messages, workarounds applied)
4. Identify anti-patterns (corrections, refactors)
5. Generate structured discovery report

**Example output**:
```
DISC-001: Database Query Pattern
  - Observed: prisma.user.findMany() used 5 times
  - Current guide: No mapping for "find all users"
  - Recommendation: Add to concept mappings

DISC-002: API Timeout Limit
  - Observed: fetch() timeout after 30 seconds
  - Current guide: No documented limit
  - Recommendation: Add to Capabilities Guide with retry workaround
```

### Command 2: `/ai-guides-assess`

**Purpose**: Score materiality with objective 40-point framework

**Input**: Discovery item IDs or materiality level

**Scoring dimensions** (10 points each):
1. **Impact**: How much time does this save/prevent?
2. **Frequency**: How often is this encountered?
3. **Clarity**: How obvious is the correct approach?
4. **Testability**: How easily can this be validated?

**Scoring scale**:
- 0-10: LOW (defer, backlog)
- 11-20: MEDIUM (schedule, next quarter)
- 21-30: HIGH (schedule, this month)
- 31-40: CRITICAL (update immediately)

**Output**: Prioritized recommendations

**Example**:
```
DISC-001: Database Query Pattern
  Impact: 7/10 (saves 2 min per query, 10x/day = 20 min/day)
  Frequency: 9/10 (used daily)
  Clarity: 4/10 (not obvious which ORM method)
  Testability: 8/10 (easy to test)
  TOTAL: 28/40 → HIGH (update this month)

DISC-002: API Timeout Limit
  Impact: 10/10 (prevents production failures)
  Frequency: 6/10 (weekly occurrence)
  Clarity: 2/10 (very non-obvious)
  Testability: 7/10 (can reproduce)
  TOTAL: 25/40 → HIGH (update this month)
```

**Why objective scoring?**
- Prevents opinion drift ("I think this is important")
- Enables prioritization (limited time → highest impact first)
- Provides audit trail (why was this updated?)

### Command 3: `/ai-guides-update`

**Purpose**: Execute guide updates with quality control

**Input**: Discovery item IDs

**Safety measures**:
1. **User approval** - Show proposed changes before applying
2. **Validation** - Run validation script after update
3. **Git snapshots** - Commit before/after for rollback
4. **Link checking** - Verify internal references still work

**Algorithm**:
1. Load discovery item details
2. Determine target guide section
3. Generate proposed update (markdown diff)
4. Show to user for approval
5. Apply changes
6. Run validation script
7. Commit with structured message
8. Report success/failure

**Example flow**:
```
User: /ai-guides-update DISC-001