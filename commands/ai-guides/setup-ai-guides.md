---
command: setup-ai-guides
description: Bootstrap the AI guides system for your project with interactive setup
signature: "[MODE]"
arguments:
  - name: MODE
    description: "Setup mode: 'interactive' (guided questions), 'auto' (analyze codebase), or 'minimal' (basic templates only)"
    required: false
    default: "interactive"
---

Bootstrap the complete AI guides system for your project. This command helps you set up domain translation guides, capabilities documentation, and the maintenance workflow tailored to your project.

## What This Command Does

**Interactive Mode** (default):
1. Asks about your project (tech stack, domain, preferences)
2. Analyzes existing codebase to identify patterns
3. Selects best-matching domain example
4. Populates templates with your project's patterns
5. Creates directory structure
6. Adds router integration to CLAUDE.md
7. Runs first validation check

**Auto Mode**:
1. Scans codebase to detect tech stack automatically
2. Identifies common patterns in your code
3. Populates templates based on findings
4. Sets up with minimal user input

**Minimal Mode**:
1. Creates basic directory structure
2. Copies blank templates
3. User fills in manually later

## Setup Process

### Step 1: Project Analysis

Ask the user:
- **Project type**: New project or existing codebase?
- **Domain**: Web app, API, mobile app, data science, or other?
- **Tech stack**: What technologies do you use? (frameworks, databases, state management, etc.)
- **Guides location**: Where should guides live? (default: `docs/`)

If existing project, scan for:
- Package files (`package.json`, `requirements.txt`, `Cargo.toml`, `go.mod`, etc.)
- Framework indicators (React, Next.js, Django, Flask, Express, etc.)
- Database usage (Prisma, SQLAlchemy, TypeORM, etc.)
- API patterns (tRPC, GraphQL, REST)
- State management (Redux, Zustand, Pinia, etc.)
- Testing setup (Jest, pytest, etc.)

### Step 2: Domain Example Selection

Match project to closest domain example:
- **web-app**: React, Vue, Svelte, Next.js, Angular frontends
- **api-project**: Express, FastAPI, Django, Rails backends
- **mobile-app**: React Native, Flutter, Swift, Kotlin
- **data-science**: Python notebooks, R, data pipelines

If multiple matches, ask user to choose.

Show user the example:
```
Found best match: web-app (React + TypeScript)

Example includes patterns for:
- Database queries (Prisma ORM)
- API calls (tRPC procedures)
- State management (Zustand)
- Form validation (Zod schemas)

Use this as starting point? (y/n)
```

### Step 3: Pattern Discovery

Scan the codebase for actual patterns:

**Database Patterns**:
- Search for: `prisma.`, `db.query`, `session.execute`, `mongoose.`, etc.
- Extract common query patterns
- Identify ORM usage
- Example finding: "Uses Prisma with TypeScript types, common pattern: `findMany({ include: ... })`"

**API Patterns**:
- Search for: `fetch(`, `axios.`, `trpc.`, API route files
- Identify REST vs GraphQL vs tRPC
- Extract endpoint patterns
- Example finding: "Uses tRPC procedures in `src/server/api/`, type-safe client calls"

**State Management**:
- Search for: `useState`, `create(`, `createStore`, `Pinia`, `Redux`
- Identify state solution
- Example finding: "Uses Zustand stores in `src/stores/`, pattern: `useAuthStore((state) => ...)`"

**File Structure**:
- Identify common directories: `src/components/`, `pages/`, `api/`, `utils/`
- Map file naming conventions
- Example finding: "Components in `src/components/` with `.tsx` extension"

**Common Errors Found**:
- Look in git history for reverted commits
- Check for common fix patterns
- Example finding: "5 commits fixing N+1 query issues → document 'always use include'"

### Step 4: Template Population

Create customized guides:

#### AI_DOMAIN_TRANSLATION_GUIDE.md

Populate concept mappings table:
```markdown
| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "Database query" | [DETECTED: Prisma ORM with TypeScript types] | [PATTERN: Always use `include` for relations to avoid N+1] |
| "API call" | [DETECTED: tRPC procedures in src/server/api/] | [PATTERN: Type-safe, no fetch() needed for internal APIs] |
| "State management" | [DETECTED: Zustand stores in src/stores/] | [CONVENTION: Global state in stores, component state for UI only] |
```

Add quick reference patterns based on actual code:
```markdown
### Database Query (Prisma)
[ACTUAL CODE FROM PROJECT - show common pattern found in codebase]
```

Document anti-patterns if found:
```markdown
❌ **[FOUND IN COMMITS]: Using fetch() for internal APIs**
- **Why wrong**: No type safety, tRPC provides end-to-end types
- **Correct approach**: Use tRPC procedures
- **Evidence**: Commit abc123f fixed this in UserProfile.tsx
```

#### AI_CAPABILITIES_AND_LIMITS.md

Start with empty/minimal content:
```markdown
# AI Capabilities & Limits Guide

**Purpose**: Document AI tool limitations discovered during development and proven workarounds.

## Documented Limits

*No limits documented yet. Run `/ai-guides-discover` after encountering tool issues.*

## Future Testing Backlog

| Test ID | Hypothesis | Validation Plan | Priority |
|---------|-----------|-----------------|----------|
| TEST-001 | Large file processing may have limits | Test with varying file sizes | MEDIUM |
```

### Step 5: Directory Setup

Create directory structure:
```bash
# Create guides directory
mkdir -p [USER_SPECIFIED_PATH]/

# Copy populated templates
# AI_DOMAIN_TRANSLATION_GUIDE.md
# AI_CAPABILITIES_AND_LIMITS.md
# AI_GUIDES_USAGE_SUMMARY.md
# AI_GUIDES_MAINTENANCE_PLAN.md
```

### Step 6: Router Integration

Add to CLAUDE.md (create if doesn't exist):

```markdown
# AGENT ROUTER

**IF** task involves [DETECTED_PATTERNS: database queries, API calls, state management] →
→ **Read `[GUIDES_PATH]/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference)

**IF** task involves image processing, API timeouts, or new libraries →
→ **Check `[GUIDES_PATH]/AI_CAPABILITIES_AND_LIMITS.md` FIRST** (limits and workarounds)

**AFTER completing significant work** →
→ **Consider running**: `/ai-guides-discover conversation`
→ **Then**: `/ai-guides-assess` to score materiality
→ **Purpose**: Prevent guide staleness, capture patterns while fresh
```

If CLAUDE.md already exists, ask before modifying:
```
Found existing CLAUDE.md. Add router integration at the top? (y/n)
If no, I'll create a separate AI_GUIDES_ROUTER.md you can merge manually.
```

### Step 7: Commands Setup

Check if commands directory exists:
```bash
ls .claude/commands/
```

If yes, ask:
```
Found existing .claude/commands/ directory.
Copy AI guides commands (discover, assess, update)? (y/n)
```

If no:
```
Create .claude/commands/ and install all commands? (y/n/skip)
Options:
  y - Install all 11 commands (ai-guides + development)
  n - Install only ai-guides commands (3 commands)
  skip - Skip command installation
```

### Step 8: Validation

Run initial validation:
```bash
# Check if validation script exists
ls tools/validate_ai_guides.sh

# If not, copy from starter kit
# If yes, run it
bash tools/validate_ai_guides.sh [GUIDES_PATH]
```

Show validation results and next steps.

## Setup Summary Output

After completion, show summary:

```
✅ AI Guides System Setup Complete!

📁 Location: docs/
📊 Guides Created:
  - AI_DOMAIN_TRANSLATION_GUIDE.md (15 concept mappings, 3 anti-patterns)
  - AI_CAPABILITIES_AND_LIMITS.md (empty - populate as you discover limits)
  - AI_GUIDES_USAGE_SUMMARY.md
  - AI_GUIDES_MAINTENANCE_PLAN.md

🔗 Router: Added to CLAUDE.md (lines 1-15)

⚙️  Commands: Installed 3 AI guides commands to .claude/commands/ai-guides/
  - /ai-guides-discover
  - /ai-guides-assess
  - /ai-guides-update

🎯 Tech Stack Detected:
  - React 18.2 with TypeScript
  - Prisma ORM (PostgreSQL)
  - tRPC for API layer
  - Zustand for state management
  - Tailwind CSS for styling

📋 Validation Results:
  ⚠️  Translation Guide: 15 mappings (minimum: 15) ✅
  ⚠️  Translation Guide: 3 anti-patterns (minimum: 5) - Add 2 more
  ✅  All internal links valid

🚀 Next Steps:

1. Review the generated guides in docs/
2. Add 2 more anti-patterns from your experience
3. Test the system:
   - Ask me: "Add a database query to fetch all active users"
   - I should reference the guide and use your Prisma pattern

4. Monthly maintenance (set reminder for 1st of month):
   /ai-guides-discover recent
   /ai-guides-assess [discovered-items]
   /ai-guides-update [critical-items]

5. After completing work, run:
   /ai-guides-discover conversation

📚 Learn More:
  - Setup details: docs/AI_GUIDES_USAGE_SUMMARY.md
  - Maintenance workflow: docs/AI_GUIDES_MAINTENANCE_PLAN.md
  - Validation: bash tools/validate_ai_guides.sh docs/

---

Try it now! Ask me to implement something using your tech stack and watch me reference the guides.
```

## Error Handling

**No tech stack detected**:
```
⚠️  Couldn't auto-detect tech stack.
This might be a new project or use technologies I don't recognize.

Would you like to:
1. Manually specify your tech stack
2. Use minimal templates (fill in later)
3. Pick a domain example to customize

Your choice (1/2/3):
```

**Guides already exist**:
```
⚠️  Found existing AI guides in docs/

Would you like to:
1. Update existing guides (merge new patterns)
2. Create new guides in different location
3. Abort setup

Your choice (1/2/3):
```

**Permission issues**:
```
❌ Cannot write to docs/ directory.

Try:
1. Check directory permissions
2. Specify different location
3. Run with appropriate permissions
```

## Usage Examples

### Example 1: New React Project
```bash
# User runs
/setup-ai-guides

# Claude asks
"Is this a new project or existing codebase?"
User: "New React project with Vite, Prisma, and tRPC"

# Claude sets up
- Uses web-app example as base
- Populates templates with React/Prisma/tRPC patterns
- Creates docs/ directory
- Adds router to CLAUDE.md
- Shows 15 pre-populated concept mappings ready to use
```

### Example 2: Existing Python Project
```bash
# User runs
/setup-ai-guides auto

# Claude scans
- Detects: Flask, SQLAlchemy, pytest
- Finds common patterns in src/
- Uses api-project example but adapts for Python

# Claude populates
- Database patterns: SQLAlchemy ORM usage
- API patterns: Flask route decorators
- Testing patterns: pytest fixtures
- Shows actual code from project as examples
```

### Example 3: Minimal Setup
```bash
# User runs
/setup-ai-guides minimal

# Claude creates
- Empty template files
- Basic directory structure
- Router snippet
- Shows "Fill these in as you go" message
```

## Integration with Existing Commands

After setup, the discovery/assess/update workflow is ready:

```bash
# Discover patterns from recent work
/ai-guides-discover conversation

# Assess materiality
/ai-guides-assess DISC-001,DISC-002

# Update guides
/ai-guides-update DISC-001
```

## Success Criteria

Setup is successful when:
1. ✅ Guides directory created with 4 files
2. ✅ At least 10 concept mappings populated (or templates ready for new project)
3. ✅ Router added to CLAUDE.md
4. ✅ Validation runs without errors
5. ✅ User understands next steps
6. ✅ Test query successfully references guide

---

**This command is designed to be run ONCE per project. After initial setup, use `/ai-guides-discover`, `/ai-guides-assess`, and `/ai-guides-update` for ongoing maintenance.**
