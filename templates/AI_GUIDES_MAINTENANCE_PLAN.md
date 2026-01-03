# AI Guides Maintenance Plan

**Purpose**: Define operational procedures for using, updating, and maintaining the two-guide AI system.

**Created**: [CUSTOMIZE: Date]
**Status**: Living document - update as system evolves

---

## The Two-Guide System

### What We Have

**1. AI Domain Translation Guide** (`AI_DOMAIN_TRANSLATION_GUIDE.md`)
- **Purpose**: Quick reference mapping generic AI concepts → project-specific patterns
- **Content**: [CUSTOMIZE: X] concept mappings, [CUSTOMIZE: X] anti-patterns, [CUSTOMIZE: X] quick reference patterns
- **When to use**: Mid-task when you need immediate pattern guidance

**2. AI Capabilities and Limits Guide** (`AI_CAPABILITIES_AND_LIMITS.md`)
- **Purpose**: Document AI tool capability thresholds and workarounds
- **Content**: [CUSTOMIZE: Tool] limits, proactive testing protocol
- **When to use**: Before processing new data types, when encountering tool failures

### How They Work Together

```
Agent encounters task
    ↓
CLAUDE.md router directs to appropriate guide
    ↓
Guide provides quick pattern/constraint reference
    ↓
Agent follows link to comprehensive workflow if needed
    ↓
Agent completes task following documented pattern
```

**Complementary relationship**:
- **Translation Guide** = "What patterns does your project use?" (e.g., [CUSTOMIZE: example pattern])
- **Capabilities Guide** = "What constraints do AI tools have?" (e.g., [CUSTOMIZE: example limit])

---

## How Agents Use These Guides (Operational Workflow)

<!-- [CUSTOMIZE] Add 2-3 scenarios showing how agents use the guides in practice.
     Keep the same format as below, but use your project's actual patterns. -->

### Scenario 1: [CUSTOMIZE: Common Operation Name]

```
1. Agent encounters task: "[CUSTOMIZE: Task description]"
2. CLAUDE.md router: "IF task mentions X → Read AI_DOMAIN_TRANSLATION_GUIDE.md"
3. Agent opens Translation Guide → finds "[CUSTOMIZE: Pattern Name]"
4. Guide shows:
   - [CUSTOMIZE: Step 1]
   - [CUSTOMIZE: Step 2]
   - [CUSTOMIZE: Step 3]
5. Agent follows pattern → [CUSTOMIZE: outcome]
6. ✅ [CUSTOMIZE: Success result]
```

**Without guide**: [CUSTOMIZE: What goes wrong without the guide]

### Scenario 2: [CUSTOMIZE: Second Common Operation]

```
1. Agent encounters [CUSTOMIZE: situation]
2. CLAUDE.md router: "IF task involves X → Check AI_CAPABILITIES_AND_LIMITS.md"
3. Agent opens Capabilities Guide → finds "[CUSTOMIZE: Limit Name]" section
4. Guide shows:
   - [CUSTOMIZE: Limit threshold]
   - [CUSTOMIZE: Detection method]
   - [CUSTOMIZE: Workaround]
5. Agent [CUSTOMIZE: preventive action]
6. ✅ [CUSTOMIZE: Success without hitting limit]
```

**Without guide**: [CUSTOMIZE: What failure occurs]

### Scenario 3: [CUSTOMIZE: Third Operation]

```
1. [CUSTOMIZE: Initial situation]
2. [CUSTOMIZE: Router action]
3. [CUSTOMIZE: Guide lookup]
4. [CUSTOMIZE: Pattern applied]
5. ✅ [CUSTOMIZE: Success result]
```

**Without guide**: [CUSTOMIZE: Problem that would occur]

---

## Operational Maintenance Workflow (Command-Based)

**Purpose**: Systematic guide maintenance using three sequential commands

**Philosophy**: Objective, reproducible process for discovering, assessing, and updating guides (not ad-hoc)

### The Three-Command Workflow

```bash
# 1. DISCOVER patterns, limits, anti-patterns
/ai-guides-discover [scope]

# 2. ASSESS materiality with scoring framework
/ai-guides-assess [item_ids]

# 3. UPDATE guides with quality control
/ai-guides-update [item_ids]
```

**When to use**:
- **After completing work**: `/ai-guides-discover conversation` (find patterns from current session)
- **Monthly review**: `/ai-guides-discover recent` (scan last 7 days of commits)
- **Quarterly review**: `/ai-guides-discover all` (comprehensive scan)

### Discovery Phase

**Command**: `/ai-guides-discover [scope]`

**What it finds**:
- **Patterns**: Operations repeated 2+ times, explicit code examples, multi-workflow applicability
- **Capability limits**: Tool failures, workarounds applied, reproducible thresholds
- **Anti-patterns**: Errors corrected, wrong assumptions, preventable mistakes

**Discovery scopes**:
- `conversation` (default) - Analyze current work session
- `recent` - Last 7 days of commits
- `workflow` - Deep analysis of specific workflow file
- `all` - Comprehensive scan (conversation + commits + staleness check)

**Output**: List of discovered items with IDs (DISC-001, DISC-002, etc.)

**Exclusions** (won't flag):
- One-off edge cases with no broader applicability
- Workflow-specific details already in workflow docs
- Trivial operations requiring no special knowledge
- Already comprehensively documented in guides

### Assessment Phase

**Command**: `/ai-guides-assess [item_ids]`

**Materiality Scoring Framework** (40 points total):

1. **Frequency Score** (0-10 points)
   - One-off: 0 points (edge case, don't document)
   - Occasional (2x): 5 points (batch update candidate)
   - Recurring (3+): 10 points (update immediately)
   - Cross-workflow: +2 bonus

2. **Impact Score** (0-10 points)
   - Trivial (<30s saved): 2 points
   - Minor (30s-2min saved): 5 points
   - Significant (2-5min saved): 8 points
   - Critical (prevents data integrity issues): 10 points

   **Impact multipliers**:
   - Prevents [CUSTOMIZE: critical error]: ×1.5
   - Prevents [CUSTOMIZE: data issue]: ×1.5
   - Prevents [CUSTOMIZE: common failure]: ×1.2
   - Saves repetitive documentation reading: ×1.1

3. **Risk Score** (0-10 points)
   - Low (cosmetic issue): 2 points
   - Medium (inefficiency, wasted time): 5 points
   - High (data quality issue): 8 points
   - Critical (data integrity violation): 10 points

4. **Coverage Score** (-5 to +5 points)
   - Already documented: -5 points (don't duplicate)
   - Partially documented: 0 points (maybe enhance)
   - Gap in guides: +5 points (clear need)

5. **Generalizability Score** (0-5 points)
   - Workflow-specific: 0 points (belongs in workflow doc)
   - Multi-workflow: 3 points (cross-cutting concern)
   - System-wide pattern: 5 points (fundamental concept)

**Materiality Thresholds**:

| Score Range | Level | Recommendation | Action Timing |
|-------------|-------|----------------|---------------|
| **30-40+** | CRITICAL | UPDATE NOW | Immediate (today) |
| **20-29** | HIGH | UPDATE SOON | Within 1 week (batch update) |
| **10-19** | MEDIUM | CONSIDER | Next monthly review |
| **5-9** | LOW | DEFER | Quarterly review or ad-hoc |
| **<5** | NEGLIGIBLE | DON'T UPDATE | Not generalizable or already documented |

**Bypass Rules** (Skip Scoring):

**Auto-promote** (always UPDATE_NOW):
- Data integrity violations prevented
- Capability limits with validated workarounds
- Critical anti-patterns
- Workflow changes affecting guide accuracy

**Auto-reject** (always DON'T UPDATE):
- One-off edge cases (frequency = 1, no recurrence expected)
- Already comprehensively documented
- Workflow-specific minutiae
- Trivial operations (impact < 30s, no risk)

**Output**: Scored items with materiality levels and update recommendations

### Update Phase

**Command**: `/ai-guides-update [item_ids]`

**What it does**:
1. Determines target guide + section
2. Formats content per guide conventions
3. Runs quality control checklist
4. Updates guide(s) + cross-references
5. Updates change log
6. Validates updates (runs validation script)
7. Creates git commit

**Quality gates** (validates before commit):
- [ ] All code examples tested and work
- [ ] All file paths verified (point to existing files)
- [ ] All internal links validated (no broken links)
- [ ] Patterns match current workflows
- [ ] Capability limits supported by evidence
- [ ] Minimum content requirements still met
- [ ] Change log updated

**Safety features**:
- User approval for CRITICAL/HIGH items
- Conflict detection (prevents duplicates)
- Pre-update git snapshot (rollback available)
- Validation before commit (catches errors)

### Example Workflow

```bash
# Working on [CUSTOMIZE: task]...
# [CUSTOMIZE: What happened - pattern repeated, limit hit, etc.]

# 1. Discover what just happened
/ai-guides-discover conversation

# Output:
# DISC-001: [CUSTOMIZE: Pattern name] (recurring [X]x)
# DISC-002: [CUSTOMIZE: Limit name] (workaround applied)

# 2. Assess materiality
/ai-guides-assess

# Output:
# DISC-001: Score [X] ([LEVEL]) - [reason]
# DISC-002: Score [Y] ([LEVEL]) - [reason]

# 3. Update guides
/ai-guides-update CRITICAL

# Output:
# ✅ Added [pattern] to Translation Guide
# ✅ Moved [limit] to Documented Limits
# ✅ Validation passed
```

**When NOT to use this workflow**:
- Urgent fixes (update guides directly, then document process later)
- Obvious duplicates (already documented)
- External documentation (not guide-level patterns)

---

## Maintenance Triggers (When to Update Guides)

### Immediate Updates Required

**1. New Pattern Discovered** → Update Translation Guide
- **Trigger**: Workflow adds new pattern
- **Process**: Add mapping to "When You Think... → We Actually Use..." table
- **Validation**: Test pattern works as documented

**2. Capability Limit Discovered** → Update Capabilities Guide
- **Trigger**: Tool fails at specific threshold
- **Process**: Move from "Future Testing Needed" → "Documented Limits" with validation evidence
- **Validation**: Document failure threshold, workaround, and test results

**3. Anti-Pattern Identified** → Update Translation Guide
- **Trigger**: Recurring mistake
- **Process**: Add to "Common Anti-Patterns" section with ❌ wrong / ✅ correct
- **Validation**: Verify correction prevents the mistake

**4. Workflow Changes** → Update Both Guides
- **Trigger**: Major workflow modification
- **Process**: Review affected mappings, update patterns, validate links
- **Validation**: Test scenarios still work with new workflow

### Scheduled Updates

**Monthly Review** ([CUSTOMIZE: Day of month, e.g., "1st of each month"]):
1. Check if any new workflows added → extract patterns for Translation Guide
2. Check if any capability tests completed → move to "Documented Limits"
3. Review validation scenario results → update guides based on failures
4. Check internal links → validate all still point to existing files

**Quarterly Deep Review** ([CUSTOMIZE: Months, e.g., "Jan, Apr, Jul, Oct"]):
1. Measure guide effectiveness (see Success Metrics below)
2. Identify gaps from 3 months usage data
3. Reorder sections by frequency of use (most common first)
4. Prune obsolete patterns (if workflows deprecated)

---

## Update Procedures

### Procedure 1: Adding New Pattern to Translation Guide

**Trigger**: New pattern discovered in workflow or repeated agent questions

**Steps**:
1. **Document the pattern**
   ```yaml
   generic_concept: "What agents think"
   implementation: "What your project actually uses"
   gotcha: "Critical warning or note"
   ```

2. **Add to appropriate section**
   - If concept mapping → "When You Think..." table
   - If command → "Quick Reference Patterns" with code block
   - If mistake → "Common Anti-Patterns" with ❌/✅

3. **Test the pattern**
   - Run code examples to verify they work
   - Check against actual files/workflows
   - Validate any file path references

4. **Update cross-references**
   - Add link to comprehensive workflow if needed
   - Update "Tool Selection Guide" if new tool involved

5. **Validate**
   - Check markdown syntax (no errors)
   - Verify internal links work
   - Test with validation scenario if applicable

**Example commit message**:
```
docs: Add [pattern name] to Translation Guide

- Add mapping: "[concept]" → [implementation]
- Quick reference pattern for [specific use case]
- Anti-pattern: [wrong way to do it]
- Tested with [validation description]
```

### Procedure 2: Documenting New Capability Limit

**Trigger**: Tool fails at specific threshold OR proactive testing completes

**Steps**:
1. **Document the limit**
   ```yaml
   test: "What was tested"
   limit_discovered: "Threshold where tool fails"
   solution: "Workaround or fix"
   validation: "Evidence (N tests, success rate)"
   ```

2. **Move from Future Testing → Documented Limits**
   - Remove row from "Future Testing Needed" table
   - Add row to "Documented Limits" table with validation evidence

3. **Update Workaround Reference**
   - Add entry: Problem → Solution → Documentation link
   - Ensure link points to detailed workaround guide

4. **Update affected workflows**
   - Add preventive check to relevant workflow
   - Example: "Before [operation], check [condition]: `[command]`"

5. **Create tool if needed**
   - If workaround requires automation
   - Document tool with README

**Example commit message**:
```
docs: Document [tool] [limit description]

- Tested [tool] with [test conditions]
- Limit discovered: [threshold] → [failure mode]
- Workaround: [solution description]
- Updated [workflow] with preventive check
- Validation: [N] tests, [success rate]
```

### Procedure 3: Updating for Workflow Changes

**Trigger**: Major workflow modification (schema change, pattern deprecation)

**Steps**:
1. **Identify affected patterns**
   - Search Translation Guide for references to changed workflow
   - Check if capability limits reference the workflow

2. **Update mappings**
   - Correct any outdated patterns
   - Remove deprecated anti-patterns
   - Update code examples if syntax changed

3. **Validate cross-references**
   - Check all links to changed workflow still work
   - Update section/line references if file reorganized

4. **Test affected scenarios**
   - Re-run validation scenarios that use the changed pattern
   - Document any failures → fix guide → re-test

5. **Update change log**
   - Add entry to guide's update history

---

## Quality Control (Validation Checklist)

### Before Committing Guide Updates

**Content Validation**:
- [ ] All code examples tested and work
- [ ] All file paths verified (point to existing files)
- [ ] All internal links validated (no broken links)
- [ ] Minimum content requirements still met ([CUSTOMIZE: e.g., "15 mappings, 5 anti-patterns"])

**Accuracy Validation**:
- [ ] Patterns match current workflows
- [ ] Capability limits supported by evidence
- [ ] Anti-patterns actually prevent documented mistakes

**Consistency Validation**:
- [ ] Markdown syntax clean (no linting errors)
- [ ] Tables properly formatted
- [ ] Code blocks have syntax highlighting (```bash, ```python, etc.)
- [ ] Icons consistent (❌ for wrong, ✅ for correct)

**Integration Validation**:
- [ ] Router still directs to guides correctly
- [ ] Cross-references bidirectional
- [ ] Validation scenarios still pass

---

## Success Metrics (Measure Guide Effectiveness)

### Short-term Metrics (Weekly)

**Agent Behavior Tracking**:
- **Metric**: Do agents reference guides when encountering known patterns?
- **Measure**: Count references to guides in agent logs
- **Target**: ≥80% of tasks involving [CUSTOMIZE: common patterns] reference guides

**Error Reduction**:
- **Metric**: Reduction in first-pass errors for documented patterns
- **Measure**: Track corrections needed after initial implementation
- **Target**: 40% reduction in errors for guide-covered patterns
  - Before guides: ~[X%] of [operation] have errors
  - After guides: <[Y%] errors (agents check guide first)

**Time Savings**:
- **Metric**: Time to complete common operations
- **Measure**: [CUSTOMIZE: Key operations] time
- **Target**: 30% reduction in time for repetitive operations
  - Before: [X min] reading comprehensive docs
  - After: [Y sec/min] using quick reference

### Long-term Metrics (Monthly/Quarterly)

**Guide Coverage**:
- **Metric**: Percentage of workflows with patterns documented in guides
- **Measure**: Count workflows vs. patterns extracted
- **Target**: ≥80% of active workflows have key patterns in Translation Guide

**Capability Testing Progress**:
- **Metric**: Future testing backlog reduction
- **Measure**: Items moved from "Future Testing" → "Documented Limits"
- **Target**: Complete 3 capability tests per quarter
  - Current backlog: [CUSTOMIZE: X] untested items
  - Goal: Backlog → 0 within 12 months

**Validation Scenario Pass Rate**:
- **Metric**: Percentage of validation scenarios passing
- **Measure**: Test scenarios monthly, track pass/fail
- **Target**: ≥90% pass rate consistently
  - Failures indicate guide gaps → update guide → re-test

**Staleness Detection**:
- **Metric**: Guide update frequency vs. workflow change frequency
- **Measure**: Compare workflow commits to guide update commits
- **Target**: Guide updated within 1 week of major workflow change

---

## Automated Maintenance Checks

### Monthly Validation Script

**Create**: `tools/validate_ai_guides.sh`

```bash
#!/bin/bash
# Monthly validation of AI guides

echo "=== AI Guides Validation ==="

# Check 1: Minimum content requirements
echo "Checking content minimums..."
mappings=$(grep "^|" AI_DOMAIN_TRANSLATION_GUIDE.md | grep -v "Generic Mental Model" | grep -v "^|---" | wc -l)
antipatterns=$(grep "^❌" AI_DOMAIN_TRANSLATION_GUIDE.md | wc -l)

# [CUSTOMIZE: Adjust thresholds based on your minimums]
if [ "$mappings" -lt 15 ]; then
  echo "⚠️  Translation Guide has $mappings mappings (minimum: 15)"
else
  echo "✅ Translation Guide has $mappings mappings"
fi

if [ "$antipatterns" -lt 5 ]; then
  echo "⚠️  Translation Guide has $antipatterns anti-patterns (minimum: 5)"
else
  echo "✅ Translation Guide has $antipatterns anti-patterns"
fi

# Check 2: Internal link validation
echo "Checking internal links..."
broken_links=0
# [CUSTOMIZE: Adjust file paths for your project structure]
for file in AI_DOMAIN_TRANSLATION_GUIDE.md AI_CAPABILITIES_AND_LIMITS.md; do
  grep -o '\[.*\](.*\.md)' "$file" | while read link; do
    path=$(echo "$link" | sed -E 's/.*\((.*)\)/\1/')
    if [ ! -f "$path" ]; then
      echo "⚠️  Broken link in $file: $link"
      broken_links=$((broken_links + 1))
    fi
  done
done

if [ "$broken_links" -eq 0 ]; then
  echo "✅ All internal links valid"
fi

# Check 3: Future testing backlog
echo "Checking capability testing backlog..."
backlog=$(grep "Future Testing Needed" AI_CAPABILITIES_AND_LIMITS.md | wc -l)
echo "📊 $backlog capability areas awaiting testing"

# Check 4: Last update date
echo "Checking staleness..."
last_update_translation=$(git log -1 --format="%cr" AI_DOMAIN_TRANSLATION_GUIDE.md)
last_update_capabilities=$(git log -1 --format="%cr" AI_CAPABILITIES_AND_LIMITS.md)
echo "📅 Translation Guide last updated: $last_update_translation"
echo "📅 Capabilities Guide last updated: $last_update_capabilities"

echo "=== Validation Complete ==="
```

**Run monthly**: Add to calendar or CI/CD pipeline

---

## Preventing Staleness

### Strategy 1: Workflow Update Hook

**Create**: [CUSTOMIZE: Path, e.g., "workflows/.update-hook.md"]

```markdown
# Workflow Update Checklist

When modifying any workflow file:

- [ ] Check if pattern documented in AI_DOMAIN_TRANSLATION_GUIDE.md
- [ ] If yes → update guide to match new pattern
- [ ] If new pattern → add to guide
- [ ] If deprecated pattern → remove from guide
- [ ] Update internal links if file renamed/reorganized
- [ ] Run validation script: `bash tools/validate_ai_guides.sh`
```

### Strategy 2: [CUSTOMIZE: Critical System] Change Trigger

**Rule**: Any [CUSTOMIZE: critical change] → immediate guide update

**Example**:
- [CUSTOMIZE: Change type 1] → update Translation Guide mapping
- [CUSTOMIZE: Change type 2] → update pattern
- [CUSTOMIZE: Change type 3] → update anti-pattern + quick reference

### Strategy 3: Quarterly Deep Review

**Schedule**: [CUSTOMIZE: Review schedule, e.g., "1st week of Jan, Apr, Jul, Oct"]

**Process**:
1. **Read 3 months of commit history** ([CUSTOMIZE: key directories])
2. **Identify pattern changes** not reflected in guides
3. **Test all validation scenarios**
4. **Update guides** based on failures
5. **Document review** in guides' change log

---

## Change Log Template

**Add to both guides**:

```markdown
---

## Change Log

**YYYY-MM-DD**: Initial creation
- [X] concept mappings, [Y] anti-patterns (Translation Guide)
- [Z] capability areas identified (Capabilities Guide)
- [N] validation scenarios created

**YYYY-MM-DD**: [Update description]
- [What changed]
- [Why it changed]
- [Validation performed]
```

---

## Integration with Existing Systems

### Router Integration

**CLAUDE.md**:
```markdown
**IF** task involves [CUSTOMIZE: pattern type] →
→ **Read `AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**

**IF** task involves [CUSTOMIZE: tool usage] →
→ **Check `AI_CAPABILITIES_AND_LIMITS.md` FIRST**
```

### Cross-References

<!-- [CUSTOMIZE] List files that should cross-reference the guides -->
- `[CUSTOMIZE: file1]` → AI_DOMAIN_TRANSLATION_GUIDE.md
- `[CUSTOMIZE: file2]` → AI_CAPABILITIES_AND_LIMITS.md

### Validation Scenarios

**File**: [CUSTOMIZE: Path to validation scenarios file]

**[CUSTOMIZE: N] scenarios**:
1. [CUSTOMIZE: Scenario name] (translation guide)
2. [CUSTOMIZE: Scenario name] (capabilities guide)
3. [CUSTOMIZE: Scenario name] (combined guides)

**Test monthly**: Run scenarios, document results, update guides based on failures

---

## Responsibilities

### Who Maintains These Guides?

**Agents during execution**:
- When discovering new patterns → propose guide updates
- When finding guide errors → flag for correction
- When completing capability tests → document results

**Human reviewer (you)**:
- Approve guide updates (validate accuracy)
- Prioritize capability testing backlog
- Schedule quarterly deep reviews
- Monitor effectiveness metrics

**Automated systems**:
- Monthly validation script
- CI/CD checks on workflow changes

---

## Next Steps (Immediate Action Items)

### This Week
1. **Create monthly validation script** (`tools/validate_ai_guides.sh`)
2. **Add change log sections** to both guides
3. **Test one validation scenario** to establish baseline
4. **Schedule first monthly review** ([CUSTOMIZE: Date])

### This Month
1. **Complete 1 capability test** from backlog
   - Suggested: [CUSTOMIZE: HIGH priority test]
2. **Monitor agent behavior** (do they reference guides?)
3. **Document any guide gaps** discovered during actual use

### This Quarter ([CUSTOMIZE: Months])
1. **Complete 3 capability tests** ([CUSTOMIZE: List tests])
2. **Run all validation scenarios** once
3. **First quarterly deep review** (end of [CUSTOMIZE: Month])
4. **Measure effectiveness metrics**

---

## Success Criteria for This Maintenance System

**After 3 months**:
- ✅ Guides referenced in ≥80% of tasks involving documented patterns
- ✅ ≥3 capability tests completed
- ✅ All validation scenarios passing
- ✅ Zero broken internal links
- ✅ Monthly validation script running

**After 6 months**:
- ✅ 40% reduction in first-pass errors
- ✅ ≥6 capability tests completed
- ✅ Guides updated within 1 week of major workflow changes
- ✅ Measurable time savings

**After 12 months**:
- ✅ All [CUSTOMIZE: X] capability tests completed
- ✅ Guides cover ≥90% of active workflow patterns
- ✅ System self-sustaining

---

## Conclusion

**We now have**:
- Two complementary guides (patterns + constraints)
- Router integration (agents directed automatically)
- Validation scenarios (test effectiveness)

**We need to maintain**:
- Update guides when workflows change
- Complete capability testing backlog
- Measure and improve effectiveness
- Prevent staleness through scheduled reviews

**This maintenance plan provides**:
- Clear triggers for updates (when to act)
- Documented procedures (how to act)
- Quality control (validation before commit)
- Success metrics (how to measure)
- Automation (monthly validation script)

**Operational principle**: Guides are **living documents** that evolve with the system. They're only valuable if kept current.

---

**Status**: Ready for immediate use. First monthly review: [CUSTOMIZE: Date].

---

## Customization Instructions

**First-time setup**:

1. **Replace all [CUSTOMIZE] markers** throughout this document

2. **Adapt operational scenarios** (section "How Agents Use These Guides")
   - Use your project's actual patterns and limits
   - Show concrete before/after examples

3. **Adjust materiality impact multipliers** to your critical operations
   - What data integrity issues matter most?
   - What failures have highest cost?

4. **Set validation minimums** appropriate for your project
   - Translation Guide: [X] mappings minimum
   - Translation Guide: [Y] anti-patterns minimum
   - Capabilities Guide: [Z] future tests minimum

5. **Configure validation script** paths for your project structure

6. **Define maintenance schedule**:
   - Monthly review date
   - Quarterly review months
   - Add to team calendar

7. **Create validation scenarios file** with project-specific tests

8. **Link integration points** (CLAUDE.md router, cross-references)

**Success criteria**:
- All [CUSTOMIZE] markers replaced
- Validation script runs successfully
- Monthly/quarterly dates set
- At least 3 operational scenarios documented
