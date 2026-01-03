# Setup Guide

Complete instructions for setting up the Claude Development System on your project.

**Choose your approach:**
- **Quick Start (Recommended)**: ~10 minutes with automated setup
- **Manual Setup (Advanced)**: 30 minutes to 2 hours for full customization

## Prerequisites

Before starting, ensure you have:
- **Claude Code** installed ([installation guide](https://docs.anthropic.com/claude-code))
- **Git** (for version control and validation staleness checks)
- **Bash** (for running validation script)
- Your project's codebase accessible

---

## Quick Start (Automated Setup)

**Time estimate**: ~10 minutes

This is the recommended approach. Claude Code analyzes your project and sets everything up automatically.

### Step 1: Install Commands

```bash
# Copy commands to your project
cp -r commands/ /path/to/your/project/.claude/commands/

# Restart Claude Code to load commands
```

### Step 2: Run Automated Setup

Open Claude Code in your project and run:

```
/setup-ai-guides
```

Claude will:
1. **Analyze your codebase**
   - Detect tech stack (frameworks, databases, tools)
   - Find actual patterns in your code
   - Identify common operations

2. **Populate templates**
   - Fill in concept mappings with your patterns
   - Add detected tech stack to CLAUDE.md
   - Create routing rules based on your project

3. **Set up structure**
   - Create `docs/` directory with 4 guide files
   - Add router integration to CLAUDE.md
   - Run validation

4. **Show summary**
   ```
   ✅ AI Guides System Setup Complete!

   📁 Location: docs/
   📊 Guides Created: 4 files
   🔗 Router: Added to CLAUDE.md
   🎯 Tech Stack Detected: React, Prisma, tRPC...

   🚀 Next Steps: Review guides and test the system
   ```

### Step 3: Review and Test

1. **Review generated guides** in `docs/`
2. **Test the system**:
   ```
   Ask Claude: "Add a database query to fetch all active users"
   Claude should reference your guide and use your detected patterns
   ```
3. **Customize** if needed (add more anti-patterns, refine mappings)

**Done!** Your system is ready to use.

---

## Manual Setup (Advanced)

**Time estimate**: 30 minutes to 2 hours

Use this approach if you want full control over every detail, or if you're setting up for a new project without existing code.

### Step 1: Clone Repository

```bash
git clone [URL]
cd claude-dev-starter
```

### Step 2: Choose Your Domain Example

Select the example that best matches your project:

| Example | Best For | Key Technologies |
|---------|----------|------------------|
| **web-app/** | Frontend applications | React, TypeScript, Vite, Tailwind, tRPC |
| **api-project/** | Backend services | GraphQL, REST, PostgreSQL, JWT |
| **mobile-app/** | Mobile applications | React Native, Expo, AsyncStorage |
| **data-science/** | Data/ML projects | Python, Jupyter, Pandas, Scikit-learn |

**Browse examples**:
```bash
ls examples/
cat examples/web-app/README.md  # Read context for each domain
```

**Not sure?** Start with the closest match. You can mix patterns from multiple examples.

### Step 3: Customize Templates

Templates are in `templates/` with `[CUSTOMIZE]` markers showing what to fill in.

#### 3.1: AI Domain Translation Guide

**File**: `templates/AI_DOMAIN_TRANSLATION_GUIDE.md`

**What to customize**:

1. **Concept Mappings Table** - Fill "When You Think..." → "We Actually Use" mappings

   **Example from web-app**:
   ```markdown
   | When You Think | We Actually Use | Gotcha |
   |----------------|----------------|--------|
   | "Database query" | Prisma ORM with TypeScript types | Always use `include` for relations |
   | "API call" | tRPC procedures | Type-safe, no fetch() needed |
   ```

   **Copy from your chosen example**:
   ```bash
   # View example snippets
   cat examples/web-app/AI_DOMAIN_TRANSLATION.snippet.md
   ```

2. **Quick Reference Patterns** - Add 3-5 copy-paste code snippets

   ```markdown
   ### Database Query
   ```typescript
   const users = await prisma.user.findMany({
     where: { active: true }
   })
   ```
   ```

3. **Common Anti-Patterns** - Document mistakes you've seen

   ```markdown
   ❌ **Using fetch() for internal API calls**
   - **Why wrong**: tRPC provides type safety
   - **Correct approach**: Use tRPC procedures
   ```

**Goal**: 15+ concept mappings, 5+ anti-patterns (validation script checks)

#### 3.2: AI Capabilities & Limits Guide

**File**: `templates/AI_CAPABILITIES_AND_LIMITS.md`

**What to customize**:

1. **Documented Limits** - Add any AI tool limits you've discovered

   **Example**:
   ```markdown
   ### Build Tool (Vite)
   - **Issue**: Error messages truncated in terminal
   - **Threshold**: N/A (always happens)
   - **Workaround**: Check vite.config.ts when build fails
   - **Tested**: 2024-12, 15 builds, 100% reproducible
   ```

2. **Future Testing Backlog** - Hypotheses to validate

   ```markdown
   | Test | Hypothesis | Validation Plan | Priority |
   |------|-----------|-----------------|----------|
   | Bundle size | May have threshold | Test with varying component counts | MEDIUM |
   ```

**Start simple**: Add 1-2 documented limits if you have them. Backlog grows over time.

#### 3.3: AI Guides Usage Summary & Maintenance Plan

**Files**:
- `templates/AI_GUIDES_USAGE_SUMMARY.md` - How system works (minimal customization)
- `templates/AI_GUIDES_MAINTENANCE_PLAN.md` - When/how to update (minimal customization)

**Customization**:
- Update file paths if guides aren't in `docs/`
- Adjust validation schedule if not monthly

**Most users**: Use these as-is, they're already generic.

### Step 4: Copy Guides to Your Project

```bash
# Create guides directory in your project
mkdir -p /path/to/your/project/docs

# Copy customized templates
cp templates/AI_DOMAIN_TRANSLATION_GUIDE.md /path/to/your/project/docs/
cp templates/AI_CAPABILITIES_AND_LIMITS.md /path/to/your/project/docs/
cp templates/AI_GUIDES_USAGE_SUMMARY.md /path/to/your/project/docs/
cp templates/AI_GUIDES_MAINTENANCE_PLAN.md /path/to/your/project/docs/
```

**Note**: You can put guides anywhere. Common locations:
- `docs/` (recommended)
- `SYSTEM/docs/` (if you have a system directory)
- `.claude/guides/` (co-located with commands)

### Step 5: Install Commands

```bash
# Copy commands to your project
cp -r commands/ /path/to/your/project/.claude/commands/

# Verify commands copied
ls /path/to/your/project/.claude/commands/ai-guides/
ls /path/to/your/project/.claude/commands/development/
```

**Commands are project-agnostic** - no customization needed.

**Restart Claude Code** if it's running to load new commands.

**Test a command**:
```
/prime-core
```

### Step 6: Router Integration

Add routing logic to your `CLAUDE.md` file so agents know when to use guides.

**Copy snippet**:
```bash
cat examples/CLAUDE.md.snippet
```

**Add to CLAUDE.md** (at the very top, before other instructions):

```markdown
# AGENT ROUTER

**IF** task involves database queries, API calls, or state management →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference)

**IF** task involves image processing, API timeouts, or new libraries →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST** (limits and workarounds)

**AFTER completing significant work** →
→ **Consider running**: `/ai-guides-discover conversation`
→ **Then**: `/ai-guides-assess` to score materiality
→ **Purpose**: Prevent guide staleness, capture patterns while fresh
```

**Customize triggers**: Replace "database queries, API calls..." with your project's common patterns.

**Path adjustment**: Change `docs/` if you put guides elsewhere.

### Step 7: First Validation Run

Run validation script to check guide quality:

```bash
bash tools/validate_ai_guides.sh /path/to/your/project/docs
```

**Expected output**:
```
=== AI Guides Validation Report ===

📊 Content Minimums
-------------------
⚠️  Translation Guide: 8 mappings (minimum: 15)
⚠️  Translation Guide: 3 anti-patterns (minimum: 5)

🔗 Internal Links
-----------------
✅ All internal links valid

🧪 Capability Testing Backlog
------------------------------
📊 Future testing sections: 2
📊 Total backlog items: 5

⚠️  CUSTOMIZATION WARNINGS
--------------------------
Found [CUSTOMIZE] markers in:
  - AI_DOMAIN_TRANSLATION_GUIDE.md (3 markers)
```

**What to do**:
- ⚠️ Warnings are normal initially
- Fill in more mappings/anti-patterns to meet minimums
- Replace any remaining `[CUSTOMIZE]` markers
- Re-run validation until warnings clear

### Step 8: Test with Validation Scenario

Create a test scenario to verify guides work:

**Copy template**:
```bash
cp examples/validation-scenarios-template.md /path/to/your/project/docs/
```

**Create simple test**:
```markdown
### Scenario 1: Database Query Test

**Test**: Ask Claude to "fetch all active users from the database"

**Expected**:
1. Agent reads router → directed to Translation Guide
2. Agent finds "Database query" mapping
3. Agent uses your ORM pattern (not generic approach)
4. Implementation works first try

**Success**: Agent references guide and uses documented pattern
```

**Run the test**:
1. Open Claude Code in your project
2. Ask: "Fetch all active users from the database"
3. Watch for guide reference in agent's response
4. Verify correct pattern used

**If agent doesn't reference guide**:
- Router condition may be too vague
- Guide mapping may not be clear enough
- Try more specific router trigger

## Troubleshooting

### Commands Not Found

**Issue**: `/ai-guides-discover` shows "command not found"

**Solutions**:
1. Check commands copied to correct location:
   ```bash
   ls .claude/commands/ai-guides/
   ```
2. Restart Claude Code to reload commands
3. Verify `.claude/` directory has correct structure

### Validation Script Fails

**Issue**: `bash tools/validate_ai_guides.sh` returns errors

**Solutions**:

**Error**: "Translation Guide not found"
```bash
# Set guides directory
bash tools/validate_ai_guides.sh /path/to/your/docs
# Or use environment variable
export GUIDES_DIR=/path/to/your/docs
bash tools/validate_ai_guides.sh
```

**Error**: "Not a git repository"
- Normal if guides directory isn't in git repo
- Staleness check will be skipped (not critical)

### Broken Links

**Issue**: Validation reports broken links

**Solutions**:
1. Check relative paths in markdown files
2. Common issue: Guide references workflow files that don't exist
3. Update or remove broken links

### Agent Doesn't Use Guides

**Issue**: Agent doesn't reference guides when expected

**Solutions**:
1. **Router too generic**: Make conditions more specific
   - Bad: "IF task involves code"
   - Good: "IF task involves database queries, API calls, or form validation"

2. **Guide mapping unclear**: Add more detail to "We Actually Use" column
   - Bad: "Use the ORM"
   - Good: "Prisma ORM with `findMany()` and `include` for relations"

3. **Missing pattern**: Add the pattern agent needed to guide

## Next Steps

After setup is complete:

### 1. Schedule Monthly Validation

**Recommended**: 1st of each month

**Add to calendar**:
```bash
# Run validation
bash tools/validate_ai_guides.sh path/to/guides

# Run three-command workflow
/ai-guides-discover recent
/ai-guides-assess [item-ids]
/ai-guides-update [critical-items]
```

**Or automate with cron**:
```bash
# Add to crontab
0 9 1 * * cd /path/to/project && bash tools/validate_ai_guides.sh
```

### 2. Complete 1 Capability Test This Month

Pick one item from "Future Testing Backlog" and validate it:

1. Create hypothesis (e.g., "Vision API fails on images >2000px")
2. Design test (upload varying size images)
3. Run test, document results
4. Move to "Documented Limits" if confirmed
5. Add workaround if needed

**Goal**: Complete 3 tests per quarter, 12 per year

### 3. Use `/ai-guides-discover` After Completing Work

**Recommended triggers**:
- After solving a tricky bug
- After implementing a new feature
- After discovering a tool limit
- After pair programming session

**Command**:
```
/ai-guides-discover conversation
```

**Review output** → assess materiality → update guides for CRITICAL/HIGH items

### 4. Evolve Your Examples

As your project grows:
- Add new concept mappings
- Document new anti-patterns
- Update code snippets
- Add new quick reference patterns

**Guides are living documents** - they should grow with your project.

## Success Metrics

Track these to measure system effectiveness:

**Month 1**:
- ✅ Validation script running monthly
- ✅ At least 1 capability test completed
- ✅ Agents referencing guides ≥80% of relevant tasks

**Month 3**:
- ✅ 40% reduction in documented error types
- ✅ 3 capability tests completed
- ✅ All validation scenarios passing
- ✅ Measurable time savings (30% for repetitive operations)

**Month 6**:
- ✅ Guides cover ≥80% of active workflow patterns
- ✅ 6 capability tests completed
- ✅ System self-sustaining (minimal manual intervention)

See `documentation/SUCCESS_METRICS.md` for detailed measurement framework.

## Questions?

- **FAQ**: See `documentation/FAQ.md`
- **Architecture**: See `documentation/ARCHITECTURE.md`
- **Customization**: See `documentation/CUSTOMIZATION_GUIDE.md`
- **Issues**: Open GitHub issue with bug/feature request template

---

**You're done!** Your guides are set up and ready to use. Remember: guides are living documents—update them as your project evolves.
