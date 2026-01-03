---
command: ai-guides-assess
description: Assess materiality of discovered items and determine if guide updates warranted
signature: "[ITEM_IDS]"
arguments:
  - name: ITEM_IDS
    description: "Comma-separated discovery item IDs (e.g., 'DISC-001,DISC-003') or 'all' to assess all discovered items from last discovery run"
    required: false
    default: "all"
---

Evaluate discovered patterns, limits, and anti-patterns to determine if they meet materiality threshold for documentation.

**Prerequisites**: Run `/ai-guides-discover` first to generate items for assessment

## Assessment Framework

### Materiality Dimensions

For each discovered item, evaluates:

#### 1. **Frequency Score** (0-10 points)
- **One-off**: 0 points (edge case, don't document)
- **Occasional (2x)**: 5 points (batch update candidate)
- **Recurring (3+)**: 10 points (update immediately)
- **Cross-workflow**: +2 bonus (affects multiple workflows)

#### 2. **Impact Score** (0-10 points)
- **Trivial** (<30s saved): 2 points
- **Minor** (30s-2min saved): 5 points
- **Significant** (2-5min saved): 8 points
- **Critical** (prevents data integrity issues): 10 points

Impact multipliers:
- **Prevents duplicate UUIDs**: ×1.5
- **Prevents broken evidence chains**: ×1.5
- **Prevents OCR hallucinations**: ×1.2
- **Saves repetitive documentation reading**: ×1.1

#### 3. **Risk Score** (0-10 points)
- **Low** (cosmetic issue): 2 points
- **Medium** (inefficiency, wasted time): 5 points
- **High** (data quality issue): 8 points
- **Critical** (data integrity violation): 10 points

#### 4. **Coverage Score** (-5 to +5 points)
- **Already documented**: -5 points (don't duplicate)
- **Partially documented**: 0 points (maybe enhance)
- **Gap in guides**: +5 points (clear need)

#### 5. **Generalizability Score** (0-5 points)
- **Workflow-specific**: 0 points (belongs in workflow doc)
- **Multi-workflow**: 3 points (cross-cutting concern)
- **System-wide pattern**: 5 points (fundamental concept)

### Materiality Thresholds

**Total Score Calculation**: Frequency + Impact + Risk + Coverage + Generalizability

**Materiality Levels**:

| Score Range | Level | Recommendation | Action Timing |
|-------------|-------|----------------|---------------|
| **30-40+** | CRITICAL | UPDATE NOW | Immediate (today) |
| **20-29** | HIGH | UPDATE SOON | Within 1 week (batch update) |
| **10-19** | MEDIUM | CONSIDER | Next monthly review |
| **5-9** | LOW | DEFER | Quarterly review or ad-hoc |
| **<5** | NEGLIGIBLE | DON'T UPDATE | Workflow-specific, already documented, or not generalizable |

## Assessment Output Format

For each assessed item:

```yaml
item_id: DISC-001
title: "UUID lookup pattern"
assessment:
  frequency_score: 10 (recurring 3+)
  impact_score: 12 (8 base × 1.5 duplicate prevention)
  risk_score: 10 (critical - prevents duplicate UUIDs)
  coverage_score: 5 (gap - not in guides)
  generalizability_score: 5 (system-wide)
  total_score: 42
  materiality_level: CRITICAL
  recommendation: UPDATE_NOW
  reasoning: |
    - Recurring operation (performed 3+ times in recent work)
    - Prevents critical data integrity issue (duplicate UUIDs)
    - Clear gap in guides (no quick reference pattern exists)
    - System-wide pattern (affects all entity processing)
    - High time savings (2-3 min → 30s with quick reference)
suggested_updates:
  target_guide: AI_DOMAIN_TRANSLATION_GUIDE.md
  section: "Quick Reference Patterns"
  update_type: add_code_example
  content_preview: |
    ### UUID Lookup (Most Common Operation)
    ```bash
    grep -i "lastname.*firstname" metadata/registries/MASTER_UUID_REGISTRY.csv
    ```
```

## Special Rules

### Auto-Promote (Bypass Assessment)

Certain items automatically qualify for UPDATE_NOW:

- **Data integrity violations prevented** (duplicate UUIDs, missing EVENT_SOURCES)
- **Capability limits with validated workarounds** (tiling methodology)
- **Critical anti-patterns** (wrong registry used, CSV quoting violations)
- **Workflow changes affecting guide accuracy** (schema changes, deprecated patterns)

### Auto-Reject (Don't Document)

Certain items automatically rejected:

- **One-off edge cases** (frequency = 1, no recurrence expected)
- **Already comprehensively documented** (coverage = fully documented)
- **Workflow-specific minutiae** (generalizability = 0, belongs in workflow doc)
- **Trivial operations** (impact < 30s, no risk)

## Batch Assessment Workflow

When assessing multiple items:

1. **Group by type**: Patterns, limits, anti-patterns
2. **Sort by score**: Highest materiality first
3. **Identify clusters**: Related items that should be documented together
4. **Batch recommendations**:
   - CRITICAL batch (update immediately)
   - HIGH batch (update this week)
   - MEDIUM/LOW batch (defer to monthly review)

## Example Usage

```bash
# Assess all discovered items from last discovery
/ai-guides-assess

# Assess specific items
/ai-guides-assess DISC-001,DISC-003,DISC-007

# Assess only patterns (filter by type)
/ai-guides-assess pattern

# Assess only critical items (filter by frequency)
/ai-guides-assess recurring
```

## Output Summary

After assessment, provides:

1. **Distribution by level**:
   - CRITICAL: 2 items (update now)
   - HIGH: 5 items (batch update this week)
   - MEDIUM: 3 items (defer to monthly review)
   - LOW: 1 item (quarterly review)
   - NEGLIGIBLE: 4 items (don't update)

2. **Recommended actions**:
   ```
   UPDATE NOW (2 items):
   - DISC-001: UUID lookup pattern (score: 42)
   - DISC-005: Vision API 1568px limit (score: 38)

   BATCH UPDATE (5 items):
   - DISC-002: Event creation 3-table pattern (score: 28)
   - DISC-004: CSV quoting anti-pattern (score: 25)
   ...
   ```

3. **Next step guidance**:
   - If CRITICAL items exist → run `/ai-guides-update DISC-001,DISC-005` immediately
   - If HIGH items exist → schedule batch update this week
   - If only MEDIUM/LOW → defer to scheduled maintenance

## Integration with Update Command

Assessment output designed to feed directly into update:
- Item IDs for selective update
- Target guide pre-determined
- Section placement suggested
- Content preview ready for validation

## Materiality Reasoning Examples

### Example 1: UUID Lookup Pattern

**Scores**:
- Frequency: 10 (performed 5 times)
- Impact: 12 (8 base × 1.5 duplicate prevention)
- Risk: 10 (critical integrity issue)
- Coverage: 5 (gap)
- Generalizability: 5 (system-wide)
- **Total: 42 (CRITICAL)**

**Reasoning**: Repeated operation preventing critical data issue, clear gap in guides, saves significant time (2-3 min → 30s).

### Example 2: Minor Optimization

**Scores**:
- Frequency: 5 (2 times)
- Impact: 2 (<30s saved)
- Risk: 2 (cosmetic)
- Coverage: 0 (partially documented)
- Generalizability: 0 (workflow-specific)
- **Total: 9 (LOW)**

**Reasoning**: Infrequent, low impact, already partially documented, too specific.

### Example 3: Capability Limit Discovered

**Scores**:
- Frequency: 5 (occasional)
- Impact: 10 (prevents wasted work)
- Risk: 8 (quality issue)
- Coverage: 5 (gap)
- Generalizability: 5 (system-wide)
- **Total: 33 (CRITICAL)**

**Reasoning**: Prevents OCR failures, validated workaround exists, applies to all screenshot processing.

## Quality Gates

Before recommending UPDATE:

- [ ] Evidence is clear and reproducible
- [ ] Pattern/limit is generalizable (not edge case)
- [ ] Update would prevent future errors or save time
- [ ] Not already comprehensively documented
- [ ] Fits within guide's scope (quick reference, not comprehensive)

Assessment doesn't update anything - it only evaluates and recommends. Update is a separate step.
