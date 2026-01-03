# AI Guides System - Quick Start

**Created**: [CUSTOMIZE: Date]
**For**: Understanding how to use and maintain the two-guide AI system

---

## What You Now Have

### Two Complementary Guides

**1. AI Domain Translation Guide** (`AI_DOMAIN_TRANSLATION_GUIDE.md`)
- **What it does**: Maps generic AI knowledge → project-specific patterns
- **Example**: [CUSTOMIZE: e.g., "How do I query the database?" → `prisma.user.findMany({ where: { ... } })`]
- **Contains**: [CUSTOMIZE: X] concept mappings, [CUSTOMIZE: X] anti-patterns, [CUSTOMIZE: X] copy-paste code examples
- **When agents use it**: [CUSTOMIZE: e.g., "Database queries, API calls, state management operations"]

**2. AI Capabilities and Limits Guide** (`AI_CAPABILITIES_AND_LIMITS.md`)
- **What it does**: Documents AI tool capability thresholds and workarounds
- **Example**: [CUSTOMIZE: e.g., "Image processor fails on files > 10MB → resize to 5MB max"]
- **Contains**: [CUSTOMIZE: X] documented limits, [CUSTOMIZE: X] future tests, proactive testing protocol
- **When agents use it**: [CUSTOMIZE: e.g., "Processing images, API calls with timeouts, large file operations"]

### Automatic Routing

**CLAUDE.md router** automatically directs agents to the right guide:

```
[CUSTOMIZE: Add your router conditions]
Task involves X → Read Translation Guide FIRST
Task involves Y → Check Capabilities Guide FIRST
```

**Result**: Agents get quick pattern reference before diving into comprehensive workflows.

---

## How This Works in Practice

<!-- [CUSTOMIZE] Add 2-3 examples showing before/after with the guides.
     These should be real scenarios from your project that demonstrate:
     - Time savings
     - Error reduction
     - Proactive problem prevention
-->

### Example 1: [CUSTOMIZE: Common Operation Name]

**Old way** (before guides):
1. [CUSTOMIZE: Step where agent wastes time]
2. [CUSTOMIZE: Step where error commonly occurs]
3. [CUSTOMIZE: Step requiring reactive fix]
4. [CUSTOMIZE: Result - incomplete or incorrect]

**New way** (with guides):
1. CLAUDE.md router: "Read [Guide Name]"
2. Agent finds "[Pattern Name]" in [time]
3. Quick reference shows: [key insight]
4. Agent completes task correctly first pass ✅

**Time saved**: [X minutes] → [Y seconds] ([Z%] reduction)
**Error rate**: ~[X%] errors → <[Y%] errors ([Z%] error reduction)

### Example 2: [CUSTOMIZE: Second Common Operation]

**Old way**:
1. [CUSTOMIZE: Problem step]
2. [CUSTOMIZE: Error occurs]
3. [CUSTOMIZE: Debugging/fixing]
4. [CUSTOMIZE: Rework needed]

**New way**:
1. CLAUDE.md router: "Check [Guide Name]"
2. Agent finds "[Pattern/Limit]" in workaround table
3. [CUSTOMIZE: Preventive action]
4. [CUSTOMIZE: Success first pass] ✅

**Time saved**: [X minutes] reactive debugging → [Y minutes] proactive check
**Success rate**: ~[X%] failures → ~[Y%] failures

---

## How to Maintain These Guides

### When to Update

**Immediate updates required**:
1. **New pattern discovered** → Add to Translation Guide
   - Example: [CUSTOMIZE: e.g., "New way to handle authentication"]
   - Update: Add mapping to "When You Think..." table

2. **Capability limit discovered** → Update Capabilities Guide
   - Example: [CUSTOMIZE: e.g., "API times out after 30 seconds"]
   - Update: Move from "Future Testing" → "Documented Limits"

3. **Anti-pattern identified** → Add to Translation Guide
   - Example: [CUSTOMIZE: e.g., "Team keeps using wrong API endpoint"]
   - Update: Add ❌ wrong / ✅ correct to anti-patterns

4. **Workflow changes** → Update both guides
   - Example: [CUSTOMIZE: e.g., "Database schema updated"]
   - Update: Modify affected mappings, validate links

### Scheduled Maintenance

**Monthly** (1st of each month):
```bash
# Run validation script
bash tools/validate_ai_guides.sh

# Review output:
# - Content minimums met? (15+ mappings, 5+ anti-patterns)
# - Any broken links?
# - Capability testing backlog status
# - Staleness check (when last updated vs. workflows)
```

**Quarterly** ([CUSTOMIZE: Months, e.g., "Jan, Apr, Jul, Oct"]):
1. Read 3 months of commit history
2. Test all validation scenarios
3. Complete 3 capability tests from backlog
4. Update guides based on actual usage

### How to Update a Guide

<!-- [CUSTOMIZE] Adapt this example to your project's workflow -->

**Example: Adding new pattern**

```bash
# 1. Document the pattern
Pattern: [CUSTOMIZE: e.g., "Database connection pooling"]
Implementation: [CUSTOMIZE: e.g., "Use prisma.$connect() at startup"]
Gotcha: [CUSTOMIZE: e.g., "Don't create new connections per request"]

# 2. Add to Translation Guide
[CUSTOMIZE: Your editor command]
# Add row to "When You Think..." table

# 3. Add quick reference code example
# (if applicable - copy-paste ready command)

# 4. Test the pattern
[CUSTOMIZE: Test command]
# Verify it works as documented

# 5. Update change log
**YYYY-MM-DD**: Added [pattern name]
- [Description of what was added]
- Code example added to Quick Reference Patterns
- Tested with [validation description]

# 6. Commit
git add AI_DOMAIN_TRANSLATION_GUIDE.md
git commit -m "docs: Add [pattern name] to Translation Guide"
```

**Complete procedure**: See `AI_GUIDES_MAINTENANCE_PLAN.md`

---

## Measuring Success

### Short-term (Weekly)

**Watch for**:
- Do agents reference guides when encountering patterns?
- Reduction in repeated clarifications?
- Faster completions of common operations?

**Target**: ≥80% of [CUSTOMIZE: common tasks] reference guides

### Long-term (Quarterly)

**Metrics**:
1. **Error reduction**: [CUSTOMIZE: X%] reduction in first-pass errors
   - Before: ~[X%] of [operation] fail/incomplete
   - After: <[Y%] fail (agents check guide first)

2. **Time savings**: [CUSTOMIZE: X%] reduction for repetitive operations
   - [Operation 1]: [X min] → [Y sec]
   - [Operation 2]: [X min] → [Y min]

3. **Capability testing progress**: [X]-item backlog → 0 within 12 months
   - Complete 3 tests per quarter
   - Document results → update Capabilities Guide

4. **Coverage**: ≥80% of active workflows have patterns in Translation Guide

---

## What to Do Right Now

### This Week

1. **Run validation script** (establishes baseline)
   ```bash
   bash tools/validate_ai_guides.sh
   ```

2. **Test one scenario** (validate guides work)
   - [CUSTOMIZE: Path to validation scenarios]
   - Run [Scenario name]
   - Document result

3. **Monitor agent behavior**
   - Do agents reference guides when they should?
   - Any confusion or gaps discovered?

### This Month

1. **Complete 1 capability test** from backlog
   - Suggested: [CUSTOMIZE: HIGH priority test]
   - Document results → update Capabilities Guide

2. **Track guide usage**
   - Count how often guides referenced
   - Note which sections most useful

3. **First monthly review** ([CUSTOMIZE: Date])
   - Run validation script
   - Check for staleness
   - Update if workflows changed

### This Quarter ([CUSTOMIZE: Months])

1. **Complete 3 capability tests**
   - [CUSTOMIZE: Test 1]
   - [CUSTOMIZE: Test 2]
   - [CUSTOMIZE: Test 3]

2. **Run all validation scenarios** once

3. **First quarterly deep review** (end of [CUSTOMIZE: Month])
   - Read 3 months commits
   - Identify missing patterns
   - Measure effectiveness metrics

4. **Achieve targets**
   - ≥80% task coverage (agents reference guides)
   - ≥3 capability tests completed
   - All validation scenarios passing

---

## Files You Need to Know

### Core Guides
- `AI_DOMAIN_TRANSLATION_GUIDE.md` - Translation guide
- `AI_CAPABILITIES_AND_LIMITS.md` - Capabilities guide

### Maintenance
- `AI_GUIDES_MAINTENANCE_PLAN.md` - Complete maintenance procedures
- `tools/validate_ai_guides.sh` - Monthly validation script
- [CUSTOMIZE: Path to validation scenarios]

### Integration
- `CLAUDE.md` - Router directing to guides
- [CUSTOMIZE: Other integration points]

---

## Common Questions

**Q: When should agents use guides vs. comprehensive workflows?**

A: **Guides** = Quick pattern lookup mid-task ("How do I do X?")
   **Workflows** = Complete learning and edge cases ("Understand entire system")

   Guides complement workflows, don't replace them.

**Q: How do I know if guides are working?**

A: Watch for:
- Agents reference guides before asking clarifying questions
- Fewer first-pass errors
- Faster completion of repetitive tasks

Run validation scenarios monthly to measure objectively.

**Q: What if a pattern changes?**

A: Update the guide immediately:
1. Modify affected mapping/pattern
2. Test change works
3. Update change log
4. Commit with clear message

**Q: What's the priority order for capability testing?**

A: **HIGH priority** (affects current production):
- [CUSTOMIZE: Current production issue]
- [CUSTOMIZE: Known problem without systematic solution]

**MEDIUM priority** (likely to encounter soon):
- [CUSTOMIZE: Anticipated issue]
- [CUSTOMIZE: Pattern seen occasionally]

**LOW priority** (edge cases):
- [CUSTOMIZE: Rare edge case]
- [CUSTOMIZE: Theoretical concern]

Complete 3 HIGH/MEDIUM tests per quarter.

---

## Success Indicators

**After 1 month**:
- ✅ Validation script running monthly
- ✅ At least 1 capability test completed
- ✅ Agents referencing guides (observed in logs)

**After 3 months**:
- ✅ [CUSTOMIZE: X%] reduction in documented error types
- ✅ 3 capability tests completed (backlog reduced)
- ✅ All validation scenarios passing
- ✅ Measurable time savings on repetitive tasks

**After 6 months**:
- ✅ Guides cover ≥80% of active workflow patterns
- ✅ [CUSTOMIZE: X] capability tests completed ([Y%] backlog reduction)
- ✅ System self-sustaining (minimal manual intervention)

**After 12 months**:
- ✅ All [CUSTOMIZE: X] capability tests completed (backlog → 0)
- ✅ Guides fully integrated into agent workflows
- ✅ Documented impact: time saved, errors prevented

---

## Key Principle

**Guides are living documents that evolve with the system.**

They're only valuable if kept current. Monthly validation + quarterly reviews prevent staleness.

When workflows change → guides must change.
When patterns discovered → guides must document.
When limits found → guides must warn.

**The system works if it's maintained. Maintenance is not optional.**

---

**Next action**: Run `bash tools/validate_ai_guides.sh` to establish baseline.

---

## Customization Instructions

**First-time setup**:

1. **Replace all [CUSTOMIZE] markers** with your project's actual information

2. **Add concrete examples** showing before/after with guides
   - Must be real scenarios from your project
   - Include time savings and error reduction metrics

3. **Define your routing conditions** in CLAUDE.md
   - What tasks trigger Translation Guide?
   - What tasks trigger Capabilities Guide?

4. **Set up validation**
   - Create validation scenarios file
   - Run baseline validation
   - Document current state

5. **Plan maintenance schedule**
   - Set monthly review date
   - Set quarterly review months
   - Add to calendar

6. **Link all files**
   - Update all file paths for your project
   - Ensure all cross-references work
   - Test links before committing

**Success criteria**:
- All [CUSTOMIZE] markers replaced
- At least 2 concrete before/after examples
- Validation script runs successfully
- All file paths correct for your project structure
