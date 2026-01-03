# Frequently Asked Questions

Common questions about setting up, using, and maintaining the Claude Development System.

## Setup & Installation

### Q: How long does setup take?

**A**: <30 minutes for basic setup (copy commands, customize 1-2 patterns, add router). 2-3 hours to fully customize guides with 15+ mappings, 5+ anti-patterns, and validation scenarios.

**Breakdown**:
- Copy commands: 2 minutes
- Choose domain example: 5 minutes
- Customize Translation Guide (minimal): 20 minutes
- Add router to CLAUDE.md: 5 minutes
- Run validation: 2 minutes
- **Total**: ~30 minutes

For comprehensive setup:
- Customize Translation Guide (15+ mappings): 60 minutes
- Add anti-patterns (5+): 30 minutes
- Set up Capabilities Guide: 30 minutes
- Create validation scenarios: 30 minutes
- **Total**: 2.5-3 hours

### Q: What if my project doesn't use [specific tool from examples]?

**A**: Examples are starting points, not requirements. Mix and match patterns from multiple examples or create your own.

**Process**:
1. Start with closest domain example
2. Replace tools with your stack
3. Keep the format and structure
4. Focus on YOUR patterns, not example patterns

**Example**: Your web app uses Redux instead of Zustand?
```markdown
| "State management" | Redux store in src/store/ with RTK slices | Use createSlice(), never hand-write reducers |
```

The principle is the same ("map generic concept to your specific tool"), just different tools.

### Q: Can I use this without Claude Code?

**A**: Partially. The guides themselves are universal markdown files that work with any AI coding assistant. The commands are Claude Code-specific and won't work in other tools.

**What works universally**:
- ✅ Guide templates (any AI can read markdown)
- ✅ Router concept (adapt to your tool's instruction system)
- ✅ Validation script (bash, runs anywhere)
- ✅ Success metrics framework

**What's Claude Code-specific**:
- ❌ Commands (use `.claude/commands/` format)
- ❌ Discovery/assess/update workflow (requires commands)

**Alternative approach** for other tools:
- Use guides without commands
- Manual discovery (review your work, add patterns)
- Manual validation (run script monthly)
- Still get 80% of value

### Q: Do I need all 4 guide files?

**A**: No. Start with the 2 core guides:

**Essential (start here)**:
1. **AI_DOMAIN_TRANSLATION_GUIDE.md** - Concept mappings and anti-patterns
2. **AI_CAPABILITIES_AND_LIMITS.md** - Tool limits and workarounds

**Optional (add later)**:
3. **AI_GUIDES_USAGE_SUMMARY.md** - How the system works (useful for teams)
4. **AI_GUIDES_MAINTENANCE_PLAN.md** - When/how to update (useful for systematic maintenance)

Most solo developers only need #1 and #2. Add #3 and #4 when onboarding others.

---

## Using the Guides

### Q: When should agents use guides vs. comprehensive workflows?

**A**: Different purposes:

**Guides** (quick lookup, <1 minute):
- Mid-task pattern lookup ("which ORM method?")
- Quick anti-pattern check ("is this approach correct?")
- Capability limit check ("will this fail at scale?")

**Workflows** (complete understanding, 5-15 minutes):
- New feature implementation (need full context)
- Complex multi-step processes
- Unfamiliar domain (learning mode)

**Analogy**: Guides are like a cookbook's quick reference card. Workflows are like the full recipe with explanations.

**Router integration ensures agents use right resource**:
```markdown
**IF** quick lookup (known pattern) → Use guide
**IF** complex task (new feature) → Read full workflow
```

### Q: How do I know if guides are working?

**A**: Watch for these indicators:

**Positive signs** (guides working):
- ✅ Agent references guide before asking questions
- ✅ Agent quotes specific pattern from guide
- ✅ Reduced clarifying questions (fewer "which ORM?", "where does this file go?")
- ✅ First-pass success rate increases
- ✅ Time for common operations decreases

**Example of working guide**:
```
User: "Fetch all active users from the database"

Agent: "I'll check the Translation Guide... I see we use Prisma ORM with findMany(). Let me query active users with included relations..."

[Works first try, no questions]
```

**Negative signs** (guides not working):
- ❌ Agent doesn't reference guide
- ❌ Agent asks questions answered in guide
- ❌ Agent uses generic patterns (not your documented patterns)
- ❌ Time/error metrics unchanged

**If guides aren't working**:
1. Check router conditions (too vague?)
2. Check pattern clarity (too generic?)
3. Check coverage (missing this pattern?)

### Q: What if a pattern changes?

**A**: Update guide immediately, test, commit.

**Process**:
1. **Identify change**: New tool, deprecated pattern, better approach
2. **Update guide**: Mark old pattern as deprecated, add new pattern
3. **Test**: Run validation scenarios to ensure new pattern works
4. **Commit**: Git commit with clear message
5. **Announce**: Tell team (if applicable)

**Example update**:
```markdown
| "State management" | ~~Redux~~ **DEPRECATED** - Use Zustand stores in src/stores/ | Migration guide: docs/migrations/redux-to-zustand.md |
```

**Timeline**:
- Pattern deprecated → Update guide within 1 week
- Pattern actively used → Update immediately

---

## Maintenance

### Q: How often should I run validation?

**A**: Monthly minimum (1st of month), plus after major workflow changes.

**Recommended schedule**:

**Monthly** (1st of month):
```bash
bash tools/validate_ai_guides.sh
/ai-guides-discover recent
/ai-guides-assess all
/ai-guides-update [critical-items]
```

**Ad-hoc triggers**:
- After major refactor
- After adding new tool/framework
- After team feedback
- When validation scenario fails

**Automation option**:
```bash
# Add to crontab for monthly reminder
0 9 1 * * cd /path/to/project && bash tools/validate_ai_guides.sh && echo "Run AI guides maintenance today!"
```

### Q: When should I update guides?

**A**: Two modes: immediate (reactive) and scheduled (proactive).

**Immediate updates** (do now):
- New pattern discovered during work
- Tool limit hit for first time
- Anti-pattern repeatedly encountered
- Validation scenario fails
- Error rate spikes for known operation

**Scheduled updates** (do monthly):
- Review discovery items
- Assess materiality
- Update CRITICAL and HIGH items
- Complete 1 capability test
- Review validation scenarios

**Don't update for**:
- One-off edge cases
- Experimental patterns (wait for confirmation)
- Patterns used <3 times (not established yet)

### Q: Can I skip the capabilities guide?

**A**: Not recommended, but you can start minimal.

**Why you need it**:
- Prevents reactive debugging (saves hours)
- Catches failures before production
- Documents workarounds for team
- Proactive testing saves time long-term

**Minimal approach** (if you insist):
1. Start with empty "Documented Limits" section
2. Add limits as you discover them
3. Create "Future Testing" backlog over time

**Better approach**:
1. Spend 30 minutes thinking about potential limits
2. Create 5-10 test hypotheses
3. Complete 1 test per month
4. Prevent issues before they happen

**ROI**: One prevented production issue pays for entire testing backlog.

### Q: What's the priority order for capability testing?

**A**: HIGH → MEDIUM → LOW based on impact and likelihood.

**Priority framework**:

**HIGH** (complete first):
- Affects production systems
- Likely to encounter in next 1-3 months
- No known workaround
- High impact if failure occurs

**MEDIUM** (complete second):
- Affects development workflow
- Will encounter eventually (3-6 months)
- Workaround exists but untested
- Medium impact

**LOW** (complete last):
- Edge cases
- Unlikely to encounter
- Low impact
- Already have workaround

**Recommended pace**: 3 tests per quarter
- Month 1: 1 HIGH
- Month 2: 1 HIGH or MEDIUM
- Month 3: 1 MEDIUM or complete backlog item

---

## Troubleshooting

### Q: Validation script reports broken links

**A**: Fix relative paths in markdown files.

**Common causes**:

**1. Incorrect relative path**:
```markdown
# Wrong (too many ../)
[Workflow](../../../workflows/feature.md)

# Right (correct relative path)
[Workflow](../../workflows/feature.md)
```

**2. File moved or renamed**:
- Search for old filename in all .md files
- Update all references
- Re-run validation

**3. Link to non-existent workflow**:
- Remove link OR
- Create placeholder workflow

**Debug approach**:
```bash
# Find all markdown links
grep -r "](.*\.md)" docs/

# Test each link manually
# Fix or remove broken links
```

### Q: Commands not showing in Claude Code

**A**: Check installation path and restart.

**Checklist**:

1. **Verify commands copied**:
```bash
ls .claude/commands/ai-guides/
ls .claude/commands/development/
```

2. **Check directory structure**:
```
.claude/
└── commands/
    ├── ai-guides/
    │   ├── ai-guides-discover.md
    │   ├── ai-guides-assess.md
    │   └── ai-guides-update.md
    └── development/
        └── [8 command files]
```

3. **Restart Claude Code**:
- Close all Claude Code instances
- Reopen project
- Commands should load

4. **Check command format**:
- Files must be .md
- Must have YAML frontmatter
- Must have `name:` field

### Q: [CUSTOMIZE] markers still in guides

**A**: Find and replace them with your project-specific content.

**How to find remaining markers**:
```bash
grep -r "\[CUSTOMIZE" docs/
```

**Example replacements**:

**Before**:
```markdown
| "Database query" | [CUSTOMIZE: your ORM] | [CUSTOMIZE: important detail] |
```

**After**:
```markdown
| "Database query" | Prisma ORM with findMany() | Always use include for relations |
```

**Validation catches these**:
```
⚠️  CUSTOMIZATION WARNINGS
--------------------------
Found [CUSTOMIZE] markers in:
  - AI_DOMAIN_TRANSLATION_GUIDE.md (3 markers)
```

**Fix all markers before considering guides "ready"**.

### Q: Agent doesn't use guides even with router

**A**: Router conditions likely too vague or pattern not clear enough.

**Debug steps**:

**1. Check router specificity**:

**Too vague** (agent doesn't match):
```markdown
**IF** task involves code →
→ **Read guide**
```

**Too specific** (agent matches too narrowly):
```markdown
**IF** task involves querying users table with active status →
→ **Read guide**
```

**Just right**:
```markdown
**IF** task involves database queries, API calls, or state management →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**
```

**2. Check pattern clarity**:

**Too generic**:
```markdown
| "Database query" | Use the ORM | Be careful |
```

**Too specific**:
```markdown
| "Database query for user with ID 123" | prisma.user.findUnique({ where: { id: 123 } }) | ... |
```

**Just right**:
```markdown
| "Database query" | Prisma ORM with findMany() for lists, findUnique() for single records | Always include relations to avoid N+1 queries |
```

**3. Test explicitly**:
Ask agent: "Before you implement, check if the Translation Guide has a pattern for this task."

If agent finds pattern → router issue
If agent doesn't find pattern → pattern missing or unclear

---

## Advanced Usage

### Q: How do I add a new guide?

**A**: Extend the system with domain-specific guides.

**Process**:

1. **Identify need**: Specialized domain (e.g., "Security Patterns", "Performance Optimization")

2. **Create guide file**:
```markdown
# AI [Domain] Guide

## Quick Reference
[Patterns specific to this domain]

## When to Use This Guide
[Conditions for consulting]
```

3. **Update router**:
```markdown
**IF** task involves [domain-specific triggers] →
→ **Read `docs/AI_[DOMAIN]_GUIDE.md` FIRST**
```

4. **Update validation script** (if needed):
- Add content checks
- Add link validation

5. **Create validation scenario**:
- Test guide effectiveness
- Measure impact

**Example domains**:
- Security patterns (auth, authorization, data sanitization)
- Performance patterns (caching, lazy loading, optimization)
- Testing patterns (unit, integration, e2e)
- Deployment patterns (CI/CD, infrastructure, monitoring)

### Q: Can I customize the materiality scoring?

**A**: Yes, adjust the 40-point framework for your project.

**Default framework** (10 points each):
1. Impact (time saved/prevented)
2. Frequency (how often encountered)
3. Clarity (obviousness of correct approach)
4. Testability (validation ease)

**Customization options**:

**Adjust weights**:
```
Impact: 15 points (prioritize high-impact changes)
Frequency: 10 points
Clarity: 10 points
Testability: 5 points
Total: 40 points
```

**Add dimensions**:
```
Impact: 8 points
Frequency: 8 points
Clarity: 8 points
Testability: 8 points
Team alignment: 8 points (does team agree?)
Total: 40 points
```

**Change thresholds**:
```
0-8: LOW (defer)
9-16: MEDIUM (next quarter)
17-24: HIGH (this month)
25-40: CRITICAL (immediate)
```

**Document changes** in AI_GUIDES_MAINTENANCE_PLAN.md

### Q: How do I integrate with CI/CD?

**A**: Run validation script in your pipeline.

**GitHub Actions example**:
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

      - name: Check for [CUSTOMIZE] markers
        run: |
          if grep -r "\[CUSTOMIZE" docs/; then
            echo "Found [CUSTOMIZE] markers in guides"
            exit 1
          fi
```

**GitLab CI example**:
```yaml
# .gitlab-ci.yml
validate-guides:
  stage: test
  script:
    - bash tools/validate_ai_guides.sh docs/
  only:
    - schedules  # Run on schedule
    - changes:   # Or when guides change
        - docs/AI_*.md
```

**Benefits**:
- Catch broken links before merge
- Enforce content minimums
- Prevent [CUSTOMIZE] markers in production
- Monthly automated reminders

---

## Multi-Project & Team Usage

### Q: Can I share guides across multiple projects?

**A**: Yes, with a shared template repository.

**Approach**:

1. **Create guides-templates repo** (private):
```
claude-guides-templates/
├── web-app/
│   ├── AI_DOMAIN_TRANSLATION_GUIDE.md
│   └── AI_CAPABILITIES_AND_LIMITS.md
├── api-project/
└── mobile-app/
```

2. **Customize per project**:
```bash
# In new project
cp ~/guides-templates/web-app/* docs/
# Customize for project specifics
```

3. **Sync improvements back**:
- When you improve a pattern in Project A
- Copy improvement to templates repo
- All future projects benefit

**Team coordination**:
- Templates repo is source of truth
- Project-specific guides can diverge
- Share learnings in team meetings

### Q: How do I onboard team members to the guides?

**A**: Include in onboarding checklist.

**Onboarding steps**:

1. **Introduction** (15 min):
- Show AI_GUIDES_USAGE_SUMMARY.md
- Explain router concept
- Demo one guide lookup

2. **First task** (30 min):
- Assign task covered by guide
- Watch them use guide (or not)
- Provide feedback

3. **Feedback session** (15 min):
- Ask what was clear/unclear
- Update guide based on feedback
- Add them to maintenance rotation

**Onboarding checklist**:
```markdown
- [ ] Read AI_GUIDES_USAGE_SUMMARY.md
- [ ] Review 3 concept mappings from Translation Guide
- [ ] Review 1 documented limit from Capabilities Guide
- [ ] Complete 1 validation scenario
- [ ] Update 1 pattern (contribute to guide)
```

---

**More questions?** Open an issue with the "question" label on GitHub.
