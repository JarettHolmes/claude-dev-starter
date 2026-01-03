---
command: ai-guides-update
description: Update AI guides with assessed patterns, limits, and anti-patterns following quality control
signature: "[ITEM_IDS]"
arguments:
  - name: ITEM_IDS
    description: "Comma-separated assessed item IDs (e.g., 'DISC-001,DISC-005') or materiality level ('CRITICAL', 'HIGH') to update all items at that level"
    required: false
    default: "CRITICAL"
---

Update AI Domain Translation Guide and/or AI Capabilities and Limits Guide with assessed items, following quality control checklist.

**Prerequisites**:
1. Run `/ai-guides-discover` to find items
2. Run `/ai-guides-assess` to evaluate materiality
3. Review assessment results to confirm items worthy of update

## Update Workflow

### Phase 1: Target Determination

For each assessed item, determines:

**Which guide(s) to update**:

| Item Type | Target Guide | Section |
|-----------|-------------|---------|
| **Pattern** (UUID lookup, event creation) | Translation Guide | "When You Think..." table OR "Quick Reference Patterns" |
| **Anti-pattern** (wrong registry, missing sources) | Translation Guide | "Common Anti-Patterns" |
| **Capability limit** (Vision API 1568px) | Capabilities Guide | "Documented Limits" (remove from "Future Testing") |
| **Tool workaround** (tiling, PDF splitting) | Capabilities Guide | "Workaround Reference" |
| **Cross-cutting** (affects both) | Both Guides | Appropriate sections in each |

**Section placement logic**:

*Translation Guide*:
- **Concept mapping** → "When You Think... → We Actually Use..." table
- **Code example** → "Quick Reference Patterns" (with syntax highlighting)
- **Mistake prevention** → "Common Anti-Patterns" (❌ wrong / ✅ correct format)
- **Tool selection** → "Tool Selection Guide"

*Capabilities Guide*:
- **Validated limit** → "Documented Limits" table (with validation evidence)
- **Future test** → "Future Testing Needed" table (if discovered but not validated)
- **Workaround** → "Workaround Reference" section

### Phase 2: Content Formatting

For each item, formats content according to guide conventions:

**Translation Guide - Concept Mapping**:
```markdown
| "Generic concept" | RLA implementation | ⚠️ Gotcha / Critical Note |
```

**Translation Guide - Quick Reference Pattern**:
```markdown
### Pattern Name (Context)

```bash
# Brief explanation
command with example
```

**Python/CSV equivalent**:
```python
# Code example with syntax highlighting
```
```

**Translation Guide - Anti-Pattern**:
```markdown
❌ **Wrong**: Description of mistake
```bash
# Example of wrong approach
```

✅ **Correct**: Description of right way
```bash
# Example of correct approach
```

**Why this matters**: Explanation of consequences
```

**Capabilities Guide - Documented Limit**:
```markdown
| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| **Test name** | Threshold description | Workaround | ✅ N tests, success rate |
```

**Capabilities Guide - Future Testing**:
```markdown
| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| **Test name** | What we suspect | How to validate | HIGH/MEDIUM/LOW |
```

### Phase 3: Quality Control Checklist

Before committing updates, validates:

**Content validation**:
- [ ] All code examples tested and work as documented
- [ ] All file paths verified (point to existing files)
- [ ] All internal links validated (no broken links)
- [ ] Syntax highlighting applied (```bash, ```python, ```yaml, etc.)
- [ ] Icons consistent (❌ for wrong, ✅ for correct, ⚠️ for warnings)

**Accuracy validation**:
- [ ] Patterns match current workflows (cross-reference source docs)
- [ ] Capability limits supported by evidence (test results, validation data)
- [ ] Anti-patterns actually prevent documented mistakes
- [ ] No conflicts with existing guide content

**Completeness validation**:
- [ ] Minimum content requirements still met (15+ mappings, 5+ anti-patterns)
- [ ] Change log updated with today's date
- [ ] Cross-references added where appropriate
- [ ] Router updated if new routing condition needed

**Integration validation**:
- [ ] Workflow files cross-reference guide (if applicable)
- [ ] Registry README links updated (if registry-related)
- [ ] Validation scenarios still pass (if affected)

### Phase 4: Guide Updates

**For Translation Guide updates**:

1. **Add concept mapping** (if applicable):
   - Insert row in "When You Think..." table
   - Alphabetize or group by category
   - Ensure unique (no duplicate concepts)

2. **Add quick reference pattern** (if applicable):
   - Add section to "Quick Reference Patterns"
   - Include code block with syntax highlighting
   - Test code example works
   - Add brief explanation of when to use

3. **Add anti-pattern** (if applicable):
   - Add to "Common Anti-Patterns" section
   - Use ❌/✅ format
   - Explain consequences of wrong approach

4. **Update Tool Selection Guide** (if new tool):
   - Add row to tool decision matrix
   - Link to tool documentation

**For Capabilities Guide updates**:

1. **Move from Future Testing → Documented Limits**:
   - Remove row from "Future Testing Needed" table
   - Add row to "Documented Limits" table
   - Include validation evidence (N tests, success rate)
   - Add detailed explanation in subsection

2. **Add new capability test** (if discovered but not validated):
   - Add row to "Future Testing Needed"
   - Include hypothesis and validation plan
   - Set priority (HIGH/MEDIUM/LOW)

3. **Update workaround reference**:
   - Add entry: Problem → Solution → Documentation link
   - Link to detailed workaround guide (if exists)

### Phase 5: Cross-References

Updates related files to maintain consistency:

**CLAUDE.md router** (if new routing condition):
```markdown
**IF** task mentions [new trigger] →
→ **Read `SYSTEM/docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**
```

**Workflow files** (if pattern extracted from workflow):
- Add note at top: "Quick reference: See AI_DOMAIN_TRANSLATION_GUIDE.md"
- Link to specific section

**Registry README** (if registry-related):
- Add link to guide section
- Note pattern in usage guidelines

### Phase 6: Change Log

Updates change log in affected guide(s):

```markdown
## Change Log

**2026-01-XX**: [Description of update]
- Added [N] concept mappings: [list]
- Documented [capability limit]: [brief description]
- Added anti-pattern: [brief description]
- Moved [N] items from Future Testing → Documented Limits
- Updated cross-references in [affected files]
```

### Phase 7: Validation

Runs automated checks:

```bash
# Run monthly validation script
bash SYSTEM/tools/maintenance/validate_ai_guides.sh

# Check for:
# - Content minimums met (15+ mappings, 5+ anti-patterns)
# - No broken internal links
# - Markdown syntax clean
# - File paths valid
```

If validation fails → fix issues → re-validate

## Update Output Format

For each item updated:

```yaml
item_id: DISC-001
status: UPDATED
guide_updated: AI_DOMAIN_TRANSLATION_GUIDE.md
section: "Quick Reference Patterns"
changes_made:
  - type: added_code_example
    content: "UUID Lookup pattern with grep command"
    line_numbers: "43-51"
  - type: updated_table
    content: "Added row to 'When You Think...' table"
    line_numbers: "14"
cross_references_updated:
  - "CLAUDE.md router (line 6)"
  - "metadata/registries/README.md (added link)"
validation:
  - code_examples_tested: PASS
  - file_paths_valid: PASS
  - internal_links_valid: PASS
  - minimum_content_met: PASS
  - change_log_updated: PASS
```

## Example Usage

```bash
# Update all CRITICAL items from last assessment
/ai-guides-update CRITICAL

# Update specific items
/ai-guides-update DISC-001,DISC-005

# Update all HIGH priority items
/ai-guides-update HIGH

# Update all assessed items (use with caution)
/ai-guides-update all
```

## Safety Checks

Before updating, confirms:

1. **User approval** for CRITICAL/HIGH items:
   ```
   About to update AI guides with 2 items:
   - DISC-001: UUID lookup pattern (Translation Guide)
   - DISC-005: Vision API limit (Capabilities Guide)

   Proceed? [Y/n]
   ```

2. **Conflict detection**:
   - Check if pattern already exists (prevent duplicates)
   - Warn if overwriting existing content

3. **Validation failure handling**:
   - If validation fails → report issues
   - Don't commit until validation passes

## Output Summary

After update, provides:

1. **Items updated**:
   ```
   ✅ DISC-001: Added UUID lookup pattern to Translation Guide
   ✅ DISC-005: Moved Vision API limit to Documented Limits
   ⚠️ DISC-007: Skipped (already documented)
   ```

2. **Files modified**:
   ```
   Modified:
   - SYSTEM/docs/AI_DOMAIN_TRANSLATION_GUIDE.md (+12 lines)
   - SYSTEM/docs/AI_CAPABILITIES_AND_LIMITS.md (+8, -3 lines)
   - CLAUDE.md (+2 lines)
   - metadata/registries/README.md (+1 line)
   ```

3. **Validation results**:
   ```
   ✅ All code examples tested and working
   ✅ All file paths valid
   ✅ All internal links valid
   ✅ Content minimums met
   ✅ Change log updated
   ```

4. **Next steps**:
   ```
   Next steps:
   1. Review changes in guides
   2. Test updated patterns in next task
   3. Monitor effectiveness over next week
   4. Schedule monthly review: February 1, 2026
   ```

## Rollback Plan

If update introduces errors:

1. **Git revert available**:
   ```bash
   git log --oneline SYSTEM/docs/AI_*.md
   git revert [commit_hash]
   ```

2. **Backup before update**:
   - Command automatically creates git commit before changes
   - Commit message: "ai-guides: Pre-update snapshot before DISC-001,DISC-005"

3. **Validation catches issues**:
   - Broken links → fix before commit
   - Invalid code → fix before commit
   - Content violations → abort update

## Integration with Discovery/Assessment

**Full workflow**:
```bash
# 1. Discover patterns in recent work
/ai-guides-discover conversation

# 2. Assess materiality
/ai-guides-assess all

# Review assessment results...

# 3. Update guides with CRITICAL items
/ai-guides-update CRITICAL

# 4. Monitor effectiveness
# (Track if patterns used in next task)
```

This command is the final step - it actually modifies the guides. Discovery finds, assessment evaluates, update executes.
