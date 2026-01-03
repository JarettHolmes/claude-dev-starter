# Tools

## validate_ai_guides.sh

Monthly validation script for AI guides system health checks.

### Purpose

Automatically validates that your AI guides meet quality standards:
- Content minimums (15+ mappings, 5+ anti-patterns)
- Internal link integrity
- Testing backlog visibility
- Staleness detection (if git repo)
- Router integration
- Customization completeness

### Usage

```bash
# From project root (guides in current directory)
bash tools/validate_ai_guides.sh

# Specify guides directory
bash tools/validate_ai_guides.sh path/to/guides

# Or use environment variable
GUIDES_DIR=path/to/guides bash tools/validate_ai_guides.sh
```

### Configuration

#### Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `GUIDES_DIR` | Current directory | Directory containing AI guides |
| `MIN_MAPPINGS` | 15 | Minimum concept mappings required |
| `MIN_ANTIPATTERNS` | 5 | Minimum anti-patterns required |
| `CLAUDE_MD` | `CLAUDE.md` in current dir | Path to CLAUDE.md for router check |

#### Example Configuration

```bash
# Set environment variables
export GUIDES_DIR=/path/to/my/docs
export MIN_MAPPINGS=20
export MIN_ANTIPATTERNS=10

# Run validation
bash tools/validate_ai_guides.sh
```

**Or inline**:
```bash
GUIDES_DIR=/path/to/docs MIN_MAPPINGS=20 bash tools/validate_ai_guides.sh
```

### Checks Performed

#### 1. Content Minimums

Ensures guides meet minimum content requirements:

**Translation Guide**:
- ✅ Concept mappings ≥ MIN_MAPPINGS (default: 15)
- ✅ Anti-patterns ≥ MIN_ANTIPATTERNS (default: 5)

**Example output**:
```
📊 Content Minimums
-------------------
✅ Translation Guide: 24 mappings (minimum: 15)
✅ Translation Guide: 12 anti-patterns (minimum: 5)
```

**Failure example**:
```
📊 Content Minimums
-------------------
⚠️  Translation Guide: 8 mappings (minimum: 15)
⚠️  Translation Guide: 3 anti-patterns (minimum: 5)

ACTION: Add more concept mappings and anti-patterns
```

#### 2. Internal Links

Validates all markdown links within guides:

**Checks**:
- File exists at link target
- Relative paths correct
- No broken cross-references

**Example output**:
```
🔗 Internal Links
-----------------
✅ All internal links valid
```

**Failure example**:
```
🔗 Internal Links
-----------------
❌ Broken link in AI_DOMAIN_TRANSLATION_GUIDE.md:
   → workflows/database-query.md (file not found)

ACTION: Fix or remove broken link
```

#### 3. Testing Backlog

Reports capability testing progress:

**Counts**:
- Future testing sections
- Total backlog items
- High/medium/low priority breakdown

**Example output**:
```
🧪 Capability Testing Backlog
------------------------------
📊 Future testing sections: 3
📊 Total backlog items: 14
  - HIGH priority: 4
  - MEDIUM priority: 7
  - LOW priority: 3

RECOMMENDATION: Complete 3 tests per quarter
```

#### 4. Staleness Detection

Shows last update dates (requires git repository):

**Example output**:
```
📅 Guide Staleness (Last Modified)
-----------------------------------
AI_DOMAIN_TRANSLATION_GUIDE.md: 2 days ago ✅
AI_CAPABILITIES_AND_LIMITS.md: 15 days ago ✅
AI_GUIDES_USAGE_SUMMARY.md: 45 days ago ⚠️

⚠️  STALENESS WARNING
--------------------
AI_GUIDES_USAGE_SUMMARY.md: 45 days since update
  → Consider review if project changed

RECOMMENDATION: Update guides monthly
```

**Not a git repo**:
```
📅 Guide Staleness
------------------
Not a git repository - staleness check skipped
```

#### 5. Router Integration

Checks CLAUDE.md references to guides:

**Validates**:
- CLAUDE.md exists
- Contains references to both guides
- File paths in router match actual guide locations

**Example output**:
```
🔀 Router Integration
---------------------
✅ CLAUDE.md found
✅ References AI_DOMAIN_TRANSLATION_GUIDE.md
✅ References AI_CAPABILITIES_AND_LIMITS.md
```

**Failure example**:
```
🔀 Router Integration
---------------------
✅ CLAUDE.md found
❌ No reference to AI_DOMAIN_TRANSLATION_GUIDE.md
⚠️  No reference to AI_CAPABILITIES_AND_LIMITS.md

ACTION: Add router integration (see examples/CLAUDE.md.snippet)
```

#### 6. Customization Status

Warns about remaining `[CUSTOMIZE]` markers:

**Example output**:
```
🛠️  Customization Status
------------------------
✅ No [CUSTOMIZE] markers found
```

**Warning example**:
```
🛠️  Customization Status
------------------------
⚠️  Found [CUSTOMIZE] markers in:
  - AI_DOMAIN_TRANSLATION_GUIDE.md (3 markers)
    Lines: 45, 67, 89

ACTION: Replace [CUSTOMIZE] markers with project-specific content
```

### Complete Output Example

```
=== AI Guides Validation Report ===
Date: 2026-01-02
Guides Directory: /Users/ritual/Projects/Development/my-project/docs

📊 Content Minimums
-------------------
✅ Translation Guide: 24 mappings (minimum: 15)
✅ Translation Guide: 12 anti-patterns (minimum: 5)

🔗 Internal Links
-----------------
✅ All internal links valid

🧪 Capability Testing Backlog
------------------------------
📊 Future testing sections: 3
📊 Total backlog items: 14
  - HIGH priority: 4
  - MEDIUM priority: 7
  - LOW priority: 3

📅 Guide Staleness (Last Modified)
-----------------------------------
AI_DOMAIN_TRANSLATION_GUIDE.md: 2 days ago ✅
AI_CAPABILITIES_AND_LIMITS.md: 15 days ago ✅
AI_GUIDES_USAGE_SUMMARY.md: 45 days ago ⚠️
AI_GUIDES_MAINTENANCE_PLAN.md: 30 days ago ✅

🔀 Router Integration
---------------------
✅ CLAUDE.md found
✅ References AI_DOMAIN_TRANSLATION_GUIDE.md
✅ References AI_CAPABILITIES_AND_LIMITS.md

🛠️  Customization Status
------------------------
✅ No [CUSTOMIZE] markers found

=== Summary ===
Content: 24 mappings, 12 anti-patterns
Links: 0 broken
Testing backlog: 14 items (complete 3 per quarter)
Customization: Complete ✅
Router: Integrated ✅

✅ All checks passed
```

### Scheduling

#### Monthly Validation

**Recommended**: 1st of each month

**Manual reminder**:
```bash
# Add to calendar
# Or add reminder in project management tool
```

**Cron job**:
```bash
# Add to crontab (runs 9am on 1st of month)
0 9 1 * * cd /path/to/project && bash tools/validate_ai_guides.sh
```

**Cron with email notification**:
```bash
0 9 1 * * cd /path/to/project && bash tools/validate_ai_guides.sh | mail -s "AI Guides Validation" you@example.com
```

#### CI/CD Integration

**GitHub Actions**:
```yaml
# .github/workflows/validate-guides.yml
name: Validate AI Guides

on:
  schedule:
    - cron: '0 9 1 * *'  # 9am on 1st of month
  push:
    paths:
      - 'docs/AI_*.md'   # When guides change

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Run validation
        run: bash tools/validate_ai_guides.sh docs/

      - name: Check exit code
        run: |
          if [ $? -ne 0 ]; then
            echo "Validation failed"
            exit 1
          fi
```

**GitLab CI**:
```yaml
# .gitlab-ci.yml
validate-guides:
  stage: test
  script:
    - bash tools/validate_ai_guides.sh docs/
  only:
    - schedules      # Scheduled pipelines
    - changes:       # When guides change
        - docs/AI_*.md
```

**Benefits of CI/CD integration**:
- Automated monthly reminders
- Catch broken links before merge
- Enforce content minimums
- Prevent [CUSTOMIZE] markers in production
- Team visibility into guide health

### Troubleshooting

#### Issue: "Translation Guide not found"

**Cause**: Script can't find `AI_DOMAIN_TRANSLATION_GUIDE.md`

**Solutions**:

1. **Set GUIDES_DIR**:
```bash
bash tools/validate_ai_guides.sh /correct/path/to/docs
```

2. **Or use environment variable**:
```bash
export GUIDES_DIR=/path/to/docs
bash tools/validate_ai_guides.sh
```

3. **Check file exists**:
```bash
ls /path/to/docs/AI_DOMAIN_TRANSLATION_GUIDE.md
```

#### Issue: "Broken links reported"

**Cause**: Markdown links point to non-existent files

**Solutions**:

1. **Find broken links**:
```bash
# Search for markdown links
grep -n "](.*\.md)" docs/AI_DOMAIN_TRANSLATION_GUIDE.md
```

2. **Fix relative paths**:
```markdown
# Check path is correct
[Workflow](../../workflows/feature.md)  # Verify ../../ is right
```

3. **Remove or update links**:
- If file was removed, remove link
- If file was moved, update path
- If file doesn't exist, create or remove reference

#### Issue: "Not a git repository"

**Cause**: Guides directory not in git repo

**Impact**: Staleness check skipped (not critical)

**Solutions**:

1. **Accept**: If guides not in git, staleness check won't work (not critical)

2. **Or initialize git**:
```bash
cd /path/to/guides
git init
```

3. **Or move guides to git repo**:
```bash
mv /path/to/guides /path/to/git/repo/docs
```

#### Issue: "Min mappings not met"

**Cause**: Guide has fewer than MIN_MAPPINGS (default: 15)

**Solutions**:

1. **Add more mappings** (recommended):
   - Review recent work for patterns
   - Add 5-10 common operations
   - Re-run validation

2. **Adjust threshold** (if project is small):
```bash
export MIN_MAPPINGS=10
bash tools/validate_ai_guides.sh
```

#### Issue: "Min anti-patterns not met"

**Cause**: Guide has fewer than MIN_ANTIPATTERNS (default: 5)

**Solutions**:

1. **Add anti-patterns** (recommended):
   - Review recent PR corrections
   - Document common mistakes
   - Add 3-5 anti-patterns

2. **Adjust threshold**:
```bash
export MIN_ANTIPATTERNS=3
bash tools/validate_ai_guides.sh
```

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All checks passed ✅ |
| 1 | Validation failures (broken links, missing minimums, etc.) |

**Use in scripts**:
```bash
if bash tools/validate_ai_guides.sh; then
  echo "Validation passed"
else
  echo "Validation failed - review output"
  exit 1
fi
```

### Customizing Thresholds

**Adjust based on project size**:

**Small project** (<10k LOC):
```bash
export MIN_MAPPINGS=10
export MIN_ANTIPATTERNS=3
```

**Medium project** (10-100k LOC):
```bash
# Use defaults
MIN_MAPPINGS=15
MIN_ANTIPATTERNS=5
```

**Large project** (>100k LOC):
```bash
export MIN_MAPPINGS=25
export MIN_ANTIPATTERNS=10
```

### Best Practices

1. **Run monthly** - 1st of each month minimum
2. **Run before commits** - When guides change
3. **Review output** - Don't just check pass/fail, read findings
4. **Act on warnings** - ⚠️ warnings indicate areas to improve
5. **Track progress** - Save validation reports, compare over time
6. **Update guides** - Use validation to trigger maintenance

### Integration with AI Guides Workflow

**Monthly routine**:
```bash
# 1. Run validation
bash tools/validate_ai_guides.sh

# 2. If issues, fix before proceeding
# (add mappings, fix links, etc.)

# 3. Then run discovery
/ai-guides-discover recent

# 4. Assess and update
/ai-guides-assess all
/ai-guides-update [critical-items]

# 5. Re-run validation
bash tools/validate_ai_guides.sh

# 6. Commit if changes made
git add docs/
git commit -m "docs: Monthly AI guides maintenance"
```

---

**The validation script is your quality gate. Run it monthly to keep guides healthy.**
