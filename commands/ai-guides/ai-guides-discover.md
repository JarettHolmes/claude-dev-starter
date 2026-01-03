---
command: ai-guides-discover
description: Discover patterns, limits, and anti-patterns that may need documentation in AI guides
signature: "[SCOPE]"
arguments:
  - name: SCOPE
    description: "Discovery scope: 'conversation' (current work), 'recent' (last 7 days commits), 'workflow' (analyze specific workflow file path), or 'all' (comprehensive scan)"
    required: false
    default: "conversation"
---

Systematically discover patterns, capability limits, and anti-patterns that may warrant documentation in the AI guides system.

## Discovery Methods

### 1. Conversation Analysis (default)

Scans current conversation for:

**Patterns to document**:
- Operations repeated 2+ times (UUID lookups, event creation, registry updates)
- New implementation patterns introduced
- Workflow shortcuts or optimizations discovered
- Tool selection decisions made
- Cross-cutting concerns that apply to multiple workflows

**Capability limits encountered**:
- Tool failures or errors (Vision API, OCR, entity recognition)
- Workarounds applied (tiling, PDF splitting, fuzzy matching)
- Threshold detection (file size, image dimensions, text density)
- Performance degradation points

**Anti-patterns identified**:
- Errors corrected (duplicate UUIDs, missing EVENT_SOURCES, wrong registry)
- Mistakes prevented (checking registry before UUID generation)
- Clarifying questions asked repeatedly
- Wrong assumptions corrected

### 2. Recent Commits Scan

Analyzes last 7 days of git commits for:
- Workflow file changes (`SYSTEM/workflows/*.md`)
- Registry schema updates (`metadata/registries/*.csv` headers)
- New tools added (`SYSTEM/tools/*`)
- Command additions (`.claude/commands/*`)

### 3. Workflow File Analysis

Deep analysis of specific workflow file:
- Extract all procedural patterns
- Identify critical warnings/gotchas
- Map dependencies on other systems
- Find gaps in guide coverage

### 4. Comprehensive Scan

Combines all methods above plus:
- Recent validation scenario results
- Capability testing backlog status
- Guide staleness check (last update vs workflow changes)

## Discovery Output Format

For each discovered item, outputs:

```yaml
item_id: DISC-001
type: pattern | limit | anti_pattern
category: uuid_operations | event_creation | screenshot_processing | registry_management | other
title: "Brief description (5-10 words)"
description: "Detailed explanation of what was observed"
frequency: one_off | occasional (2x) | recurring (3+)
evidence:
  - "Conversation line 45-67: UUID lookup repeated 3 times"
  - "Commit abc123: Added fuzzy matching to prevent duplicates"
context: "Additional context about when/why this matters"
already_documented: yes | no | partial
guide_reference: "AI_DOMAIN_TRANSLATION_GUIDE.md line 42 (if documented)"
workflows_affected:
  - "newspaper-ingest.md"
  - "facebook-ingest-v2.md"
```

## Detection Criteria

**Pattern detection**:
- ✅ Operation performed 2+ times in similar way
- ✅ Explicit code/command examples provided
- ✅ Applies to multiple use cases or workflows
- ✅ Has clear "generic concept → RLA implementation" mapping

**Limit detection**:
- ✅ Tool failed or required workaround
- ✅ Threshold identified (size, dimension, count)
- ✅ Reproducible issue (not one-off edge case)
- ✅ Workaround exists or can be developed

**Anti-pattern detection**:
- ✅ Error corrected after initial implementation
- ✅ Mistake that could be prevented with documentation
- ✅ Wrong assumption about system behavior
- ✅ Can be expressed as "❌ Wrong / ✅ Correct"

## Exclusion Criteria (Don't Flag)

- ❌ One-off edge cases with no broader applicability
- ❌ Workflow-specific details already in workflow docs
- ❌ Trivial operations requiring no special knowledge
- ❌ Already comprehensively documented in guides

## Example Usage

```bash
# Analyze current conversation (default)
/ai-guides-discover

# Scan recent commits for workflow changes
/ai-guides-discover recent

# Analyze specific workflow for patterns
/ai-guides-discover "SYSTEM/workflows/newspaper-ingest.md"

# Comprehensive scan (conversation + commits + guide staleness)
/ai-guides-discover all
```

## Output Summary

After discovery, provides:

1. **Total items found**: Count by type (patterns/limits/anti-patterns)
2. **Already documented**: Count of items already in guides
3. **New discoveries**: Count requiring assessment
4. **Detailed list**: All items with IDs for assessment

**Next step**: Review discovered items → run `/ai-guides-assess [ITEM_IDS]` to evaluate materiality

## Integration with Assessment

Discovery output is designed to feed directly into assessment:
- Item IDs for selective assessment
- Pre-categorized by type
- Evidence already gathered
- Documentation status pre-checked

This command doesn't update anything - it only identifies and reports. Assessment and update are separate steps.
