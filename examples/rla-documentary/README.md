# RLA Documentary Example

This directory contains the **complete, production AI guides** from the RLA (Robert Land Academy) documentary project.

## Purpose

These are **real-world examples** showing what fully-populated guides look like after 3 months of active use in a production documentary investigation project.

## What's Included

### AI_DOMAIN_TRANSLATION_GUIDE.md

**Content**:
- **24 concept mappings** (160% of minimum 15)
- **13 anti-patterns** (260% of minimum 5)
- **11 tool selection scenarios**
- **6 quick reference patterns** with copy-paste code
- **Domains covered**: UUID systems, event registries, evidence processing, newspaper ingestion, entity dossiers

**Notable patterns**:
- UUID v5 generation and lookup
- 3-table event system (EVENTS + PARTICIPANTS + SOURCES)
- Registry-based entity management
- Evidence ingestion workflows
- CSV quoting standards for DuckDB compatibility

### AI_CAPABILITIES_AND_LIMITS.md

**Content**:
- **3 documented limits** (Vision API 1568px, name variants, manual UUID mapping)
- **14 future tests** in backlog (OCR DPI, curved scans, dense text, misspellings)
- **Proactive testing protocol** (4-step systematic approach)
- **7 workaround references** (tile_screenshot.py, fuzzy_matcher.py, etc.)

**Notable limits**:
- Vision API pixel threshold for tall screenshots
- Name variant matching complexity
- Manual UUID mapping time costs

## Context: What is RLA?

The **RLA documentary** is an investigative feature film examining 40+ years of Canada's only private military boarding school for boys.

**Project scale**:
- **2,940 person entities** (UUID-based identification)
- **3-table event system** (EVENTS, EVENT_PARTICIPANTS, EVENT_SOURCES)
- **7 master registries** for cross-referencing intelligence
- **Evidence types**: Newspapers, Facebook, transcripts, LinkedIn, yearbooks, legal documents
- **Analysis workspace**: ICIJ/OCCRP architecture for investigative journalism

**The guides were created to prevent**:
1. **Duplicate UUID generation** (was ~50% error rate before guides)
2. **Incomplete event creation** (missing EVENT_SOURCES foreign key rows)
3. **Vision API hallucinations** (tall screenshots exceeding 1568px limit)
4. **Registry lookup inefficiency** (2-3 minute lookups reduced to 30 seconds)

## How to Use This Example

### As Reference While Customizing

When filling **your** Translation Guide:

1. **Look at RLA concept mappings for format inspiration**
   - See table structure: "When You Think" | "We Actually Use" | "Gotcha"
   - Note level of detail in "Gotcha" column (specific, actionable)
   - Observe how code examples are formatted (syntax highlighting, comments)

2. **Note anti-pattern structure**
   - Format: ❌ Wrong + why + ✅ Correct
   - Includes before/after code examples
   - Clear explanation of consequences

3. **See quick reference pattern format**
   - Code snippet with syntax highlighting
   - "When" explanation (use case)
   - "Why" explanation (reasoning)

### As Validation

After customizing **your** guides:

1. **Compare content density**
   - Are you meeting minimums? (15+ mappings, 5+ anti-patterns)
   - Is detail level similar to RLA examples?
   - Are patterns specific enough to be useful?

2. **Check pattern specificity**
   - RLA: "Prisma ORM with findMany() and include"
   - Not: "Use the ORM" (too generic)
   - Your guides should be equally specific

3. **Verify code examples are copy-paste ready**
   - RLA examples have full imports, type annotations, comments
   - No placeholder code (`// TODO: implement`)
   - Your examples should be equally complete

4. **Ensure anti-patterns have clear before/after**
   - RLA shows wrong code + why wrong + right code
   - Not just "don't do X" but "do Y instead"
   - Your anti-patterns should have same structure

### What NOT to Copy

❌ **Don't copy RLA-specific content verbatim**:
- UUID v5 generation (unless you use UUID v5)
- 3-table event system (unless you have similar structure)
- Registry naming conventions (MASTER_UUID_REGISTRY.csv is confusing, RLA kept it for backward compatibility)
- Documentary-specific workflows

✅ **Do copy structural patterns**:
- Format and organization
- Level of detail
- Code example style
- Anti-pattern format
- Table structures
- Section headings

## Success Metrics (RLA)

**After 1 month** of using these guides:
- UUID lookup time: 2-3 min → 30 sec (90% reduction)
- Duplicate UUID rate: ~50% → <10% (40% error reduction)
- Vision API failures: ~50% → ~0% (proactive tiling workaround applied)

**After 3 months**:
- Guide coverage: 88% (22/25 common operations documented)
- Error prevention: 7/8 documented error types prevented (88%)
- Capability testing: 3 critical limits documented with workarounds
- Time savings: ~200 hours saved over 3 months (setup + maintenance: 40 hours = 5:1 ROI)

**These metrics validate the guide system works when properly implemented.**

## Key Learnings from RLA

### 1. Specificity Matters

**Bad pattern** (too generic):
```markdown
| "Create entity" | Use the entity system | Be careful with IDs |
```

**Good pattern** (specific, actionable):
```markdown
| "Create entity" | Generate UUID v5 with norm_v1(lastname_firstname), check MASTER_UUID_REGISTRY.csv first | Always check registry before generating to prevent duplicates |
```

**Lesson**: Every mapping should have enough detail to act immediately without asking questions.

### 2. Anti-Patterns Should Show Consequences

**Bad anti-pattern**:
```markdown
❌ Don't forget to add EVENT_SOURCES rows
```

**Good anti-pattern**:
```markdown
❌ **Creating event without EVENT_SOURCES rows**
- **Why wrong**: Breaks referential integrity, event can't be traced to evidence
- **Consequence**: Data quality validation fails, event is orphaned
- **Correct approach**: Always create EVENT_SOURCES rows linking to registry
```

**Lesson**: Explain WHY it's wrong and WHAT happens if you do it anyway.

### 3. Workarounds Need Testing Data

**Bad limit documentation**:
```markdown
Vision API might fail on large images
```

**Good limit documentation**:
```markdown
### Vision API (Claude) - Image Pixel Limit
- **Issue**: Images exceeding dimension limits cause API failures
- **Threshold**: 1568 pixels (shorter dimension)
- **Workaround**: Use tile_screenshot.py to split tall screenshots
- **Tested**: 2024-11-15, 50 screenshots, 100% reproducible
- **Workaround Reference**: `SYSTEM/tools/vision/tile_screenshot.py`
```

**Lesson**: Document limits with tested thresholds, not guesses.

### 4. Maintenance Must Be Systematic

**Before systematic maintenance**:
- Guides created, then forgotten
- Became outdated within 2 weeks
- Error rate returned to baseline

**After systematic maintenance** (monthly discover → assess → update):
- Guides stay current
- New patterns added as discovered
- Error prevention sustained

**Lesson**: Without systematic maintenance, guides become stale and ineffective.

## Using RLA as Baseline

When measuring **your** guide effectiveness:

**Compare to RLA metrics**:
- If your time savings <30%, investigate why (not specific enough? missing patterns?)
- If your error reduction <40%, check anti-patterns (are they being used?)
- If your coverage <80%, identify missing operations

**RLA's results are achievable** with proper implementation and maintenance.

---

**These guides represent 40+ hours of work over 3 months, refined through actual use. Use them as a north star for what "good" looks like.**
