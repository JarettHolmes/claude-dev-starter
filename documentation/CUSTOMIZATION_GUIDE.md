# Customization Guide

Practical, example-heavy guide for adapting the Claude Development System to your specific project.

## First-Time Setup Checklist

Follow this checklist to populate your guides for the first time.

### ☑ 1. Populate Domain Translation Guide

**Time**: 1-2 hours for initial population

**File**: `AI_DOMAIN_TRANSLATION_GUIDE.md`

#### Step 1.1: Fill Concept Mappings Table

**Goal**: 15+ mappings (minimum for validation)

**How to identify mappings**:
1. Review your project's README or onboarding docs
2. List common operations (database queries, API calls, state management, routing)
3. For each operation, document the specific tool/pattern you use

**Template row**:
```markdown
| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| [Generic concept] | [Your specific implementation] | [Common mistake or important detail] |
```

**Examples by domain**:

**Web App**:
```markdown
| "Database query" | Prisma ORM with TypeScript types | Always use `include` for relations, not separate queries |
| "State management" | Zustand stores in src/stores/ | Don't use Redux, context, or component state for global data |
| "API call" | tRPC procedures with type safety | Never use fetch() for internal APIs |
| "Form validation" | Zod schemas in src/schemas/ | Define schema first, derive TypeScript types |
```

**API Project**:
```markdown
| "GraphQL resolver" | Apollo Server resolvers in src/resolvers/ | Use dataloaders to prevent N+1 queries |
| "Authentication" | JWT tokens with RS256 signing | Never use HS256, keys in environment variables only |
| "Database migration" | Prisma Migrate in migrations/ | Always create migration before schema changes |
```

**Mobile App**:
```markdown
| "Navigation" | React Navigation v6 stack navigator | Don't use expo-router, we use stack |
| "Local storage" | AsyncStorage with @react-native-async-storage | Never use localStorage (doesn't exist in RN) |
| "API call" | Axios with request interceptors | Use interceptors for auth token injection |
```

**Data Science**:
```markdown
| "Load dataset" | pandas.read_csv() with dtype specification | Always specify dtypes to prevent inference errors |
| "Train model" | scikit-learn pipeline with cross-validation | Never train without pipeline (data leakage risk) |
| "Visualize" | Plotly Express in notebooks/visuals/ | Don't use matplotlib, we standardize on Plotly |
```

#### Step 1.2: Add Tool Selection Matrix

**Goal**: 3-5 decision trees for common "which tool?" questions

**Format**:
```markdown
| IF (Condition) | USE (Tool/Approach) | WHY (Reasoning) |
|----------------|---------------------|-----------------|
| Need to [X] | Use [Tool Y] | Because [reason] |
```

**Example (Web App)**:
```markdown
| Need to persist data client-side | localStorage for <5KB, IndexedDB for >5KB | IndexedDB async, better performance |
| Need to style component | Tailwind utility classes | Consistency, design system tokens |
| Need to fetch external API | React Query with axios | Handles caching, retries, loading states |
```

#### Step 1.3: Document Common Anti-Patterns

**Goal**: 5+ anti-patterns (minimum for validation)

**How to identify**:
1. Review recent PRs for patterns you corrected
2. Think about common mistakes new developers make
3. List patterns you repeatedly tell agents NOT to do

**Format**:
```markdown
❌ **[Anti-pattern name]**
- **Why wrong**: [Explanation]
- **Correct approach**: [What to do instead]
- **Example**: [Code snippet]

✅ **Correct Pattern**
[Code snippet showing right way]
```

**Example (API Project)**:
```markdown
❌ **Direct database queries in resolvers**
- **Why wrong**: Creates N+1 query problem, no caching
- **Correct approach**: Use DataLoader for batch loading
- **Example**:
```javascript
// Wrong
const posts = await Promise.all(
  userIds.map(id => db.post.findMany({ where: { userId: id } }))
)

// Right
const posts = await postLoader.loadMany(userIds)
```

✅ **Use DataLoaders**
- Create in context
- Batch similar queries
- Automatic caching per request
```

#### Step 1.4: Add Quick Reference Patterns

**Goal**: 3-5 copy-paste code snippets for most common operations

**Format**:
```markdown
### [Operation Name]
```[language]
[Code snippet]
```

**Explanation**: [When to use this]
```

**Example (Data Science)**:
```markdown
### Load CSV with Type Safety
```python
import pandas as pd

df = pd.read_csv('data.csv', dtype={
    'id': 'int64',
    'name': 'string',
    'created_at': 'string'  # Parse dates separately
})
df['created_at'] = pd.to_datetime(df['created_at'])
```

**When**: Loading any CSV file into pandas

**Why**: Prevents type inference errors, ensures consistency
```

---

### ☑ 2. Set Up Capabilities Guide

**Time**: 30 minutes for initial setup, grows over time

**File**: `AI_CAPABILITIES_AND_LIMITS.md`

#### Step 2.1: Add Known Limits

**Start with 0-3 limits** - only if you've already encountered them

**Format**:
```markdown
### [Tool/API Name]

- **Issue**: [What fails]
- **Threshold**: [Exact limit if known, or "N/A"]
- **Workaround**: [How to avoid the failure]
- **Tested**: [Date], [number of tests], [reproducibility %]
- **Workaround Reference**: [Link to script/tool if exists]
```

**Example (Web App - Vite build)**:
```markdown
### Vite Build (Dev Server)

- **Issue**: Hot module replacement (HMR) fails with circular dependencies
- **Threshold**: Any circular import chain
- **Workaround**: Refactor to remove circular deps, use lazy loading
- **Tested**: 2024-11, 8 instances, 100% reproducible
- **Workaround Reference**: Run `npx madge --circular src/` to detect
```

**Example (Data Science - Pandas)**:
```markdown
### Pandas Memory Usage

- **Issue**: read_csv() fails with MemoryError on large files
- **Threshold**: ~50% of available RAM
- **Workaround**: Use `chunksize` parameter to read in batches
- **Tested**: 2024-10, 3 datasets (2GB, 5GB, 10GB), 100% reproducible
- **Workaround Reference**: `scripts/chunked_csv_reader.py`
```

**Don't have any limits yet?** That's okay! Leave this section minimal and add as you discover limits.

#### Step 2.2: Create Future Testing Backlog

**Goal**: 5-10 hypotheses to validate over the next 6-12 months

**Format**:
```markdown
| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| [What to test] | [Suspected limit] | [How to test] | HIGH/MEDIUM/LOW |
```

**How to create hypotheses**:
1. Think about tools you use frequently
2. What might fail at scale?
3. What edge cases haven't you tested?
4. What workarounds do you use "just in case"?

**Example (API Project)**:
```markdown
| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| GraphQL query depth | May have depth limit >10 levels | Create nested query, increase depth until failure | MEDIUM |
| Database connection pool | May exhaust at >100 concurrent connections | Load test with varying concurrency | HIGH |
| JWT token size | May exceed header size limit >8KB | Create token with large claims, test | LOW |
```

**Priority guidance**:
- **HIGH**: Affects production, likely to encounter soon
- **MEDIUM**: Affects development, will encounter eventually
- **LOW**: Edge case, rarely encountered

**Complete 3 tests per quarter** to work through backlog

---

### ☑ 3. Create Validation Scenarios

**Time**: 30 minutes for initial 3 scenarios

**File**: Copy `examples/validation-scenarios-template.md` to your project

**Goal**: 3-6 scenarios testing guide effectiveness

**Template**:
```markdown
### Scenario [N]: [Name]

**Goal**: Test that [guide section] enables [outcome]

**Test Steps**:
1. Agent encounters: "[task description]"
2. Router directs to [guide name]
3. Agent finds [pattern/limit]
4. Agent applies [action]

**Expected Behavior**:
- ✅ Agent references guide
- ✅ Uses documented pattern
- ✅ Succeeds first pass
- ✅ Time: [X] (vs baseline [Y])

**Measured Metrics**:
- Reference rate: yes/no
- Time: [actual] vs [baseline]
- Error rate: count
```

**Recommended scenarios**:
1. **Most common operation** (tests Translation Guide)
2. **Known capability limit** (tests Capabilities Guide)
3. **Common anti-pattern** (tests Translation Guide)

**Example (Web App)**:
```markdown
### Scenario 1: Database Query

**Goal**: Test Translation Guide enables correct ORM usage

**Test**: "Fetch all active users with their posts"

**Expected**:
1. Agent reads router → Translation Guide
2. Agent finds "Database query" → Prisma ORM mapping
3. Agent uses `findMany()` with `include` option
4. Query works first try

**Baseline**: Without guide, agent uses generic ORM query (missing `include`)

**Success criteria**:
- Uses Prisma (not raw SQL)
- Includes relations (not N+1 queries)
- Completes in <60 seconds
```

---

### ☑ 4. Integrate Router

**Time**: 10 minutes

**File**: `CLAUDE.md` in your project root

**Location**: Very top of file (before other instructions)

**Simple router** (recommended for most projects):
```markdown
# AGENT ROUTER

**IF** task involves [CUSTOMIZE: your patterns] →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**

**IF** task involves [CUSTOMIZE: tool operations] →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST**

**AFTER completing significant work** →
→ **Consider running**: `/ai-guides-discover conversation`
```

**Customization examples by domain**:

**Web App**:
```markdown
**IF** task involves database queries, API calls, state management, styling, or routing →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**

**IF** task involves image processing, large datasets, or external API timeouts →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST**
```

**API Project**:
```markdown
**IF** task involves GraphQL resolvers, database queries, or authentication →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**

**IF** task involves connection pools, query performance, or JWT tokens →
→ **Check `docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST**
```

**Tips**:
- Be specific with triggers (not "code", but "database queries")
- List 3-5 common patterns in each condition
- Adjust file paths if guides not in `docs/`

---

### ☑ 5. Configure Validation Script

**Time**: 5 minutes

**File**: `tools/validate_ai_guides.sh`

**Environment variables** (optional):
```bash
export GUIDES_DIR=/path/to/your/docs  # Default: current directory
export MIN_MAPPINGS=15                 # Default: 15
export MIN_ANTIPATTERNS=5              # Default: 5
export CLAUDE_MD=/path/to/CLAUDE.md    # Default: CLAUDE.md in current dir
```

**Adjust thresholds** based on project complexity:
- **Small project**: `MIN_MAPPINGS=10`, `MIN_ANTIPATTERNS=3`
- **Medium project**: Defaults (15 mappings, 5 anti-patterns)
- **Large project**: `MIN_MAPPINGS=25`, `MIN_ANTIPATTERNS=10`

**Test run**:
```bash
bash tools/validate_ai_guides.sh /path/to/your/docs
```

---

## Domain-Specific Pattern Examples

### Web Application (React + TypeScript)

**Technology stack**:
- Frontend: React 18, TypeScript, Vite
- Styling: Tailwind CSS
- State: Zustand
- API: tRPC
- Database: Prisma + PostgreSQL
- Auth: NextAuth.js

**Concept mappings** (10 essential):
1. Database query → Prisma ORM
2. State management → Zustand stores
3. API call → tRPC procedures
4. Component → React .tsx files in src/components/
5. Styling → Tailwind utility classes
6. Form validation → Zod schemas
7. Routing → React Router v6
8. Authentication → NextAuth with JWT
9. Environment vars → import.meta.env
10. Build output → dist/ folder

**Anti-patterns** (5 common):
1. ❌ Using fetch() for internal APIs (use tRPC)
2. ❌ Inline Tailwind without design tokens (use tailwind.config.js)
3. ❌ Component state for global data (use Zustand)
4. ❌ Separate queries for relations (use Prisma include)
5. ❌ Manual form validation (use Zod schemas)

**Quick reference**:
- Database query with relations
- tRPC procedure call from client
- Zustand store creation

**Capability limits**:
- Vite HMR fails with circular dependencies
- TypeScript inference on 3+ nested generics

---

### API Project (GraphQL + PostgreSQL)

**Technology stack**:
- API: Apollo Server, GraphQL
- Database: PostgreSQL with Prisma
- Auth: JWT with RS256
- Validation: Yup schemas

**Concept mappings** (10 essential):
1. GraphQL resolver → Apollo resolvers in src/resolvers/
2. Database query → Prisma client
3. Authentication → JWT middleware
4. Authorization → Context + role checking
5. Validation → Yup schemas in src/validation/
6. Error handling → Custom GraphQL errors
7. Testing → Jest with apollo-server-testing
8. Migration → Prisma Migrate
9. N+1 prevention → DataLoader
10. Subscription → Apollo subscription

**Anti-patterns** (5 common):
1. ❌ Direct DB queries in resolvers (use DataLoader)
2. ❌ HS256 JWT signing (use RS256)
3. ❌ Inline validation (use Yup schemas)
4. ❌ Hardcoded secrets (use environment variables)
5. ❌ Missing error codes (use structured errors)

---

### Mobile App (React Native + Expo)

**Technology stack**:
- Framework: React Native, Expo
- Navigation: React Navigation v6
- Storage: AsyncStorage
- State: Zustand
- API: Axios

**Concept mappings** (10 essential):
1. Navigation → React Navigation stack
2. Local storage → AsyncStorage
3. API call → Axios with interceptors
4. Styling → StyleSheet.create()
5. Image handling → Expo Image
6. Push notifications → Expo Notifications
7. Camera → Expo Camera
8. Location → Expo Location
9. State management → Zustand
10. Build → EAS Build

**Anti-patterns** (5 common):
1. ❌ Using localStorage (doesn't exist, use AsyncStorage)
2. ❌ Expo Router (we use React Navigation)
3. ❌ fetch() without timeout (use Axios)
4. ❌ Inline styles (use StyleSheet)
5. ❌ Direct camera access (use Expo Camera)

---

### Data Science (Python + Jupyter)

**Technology stack**:
- Language: Python 3.10+
- Notebooks: Jupyter
- Data: Pandas, NumPy
- ML: Scikit-learn
- Visualization: Plotly

**Concept mappings** (10 essential):
1. Load dataset → pandas.read_csv() with dtype
2. Train model → sklearn pipeline
3. Visualize → Plotly Express
4. Feature engineering → Pipeline transformers
5. Model evaluation → cross_val_score()
6. Save model → joblib.dump()
7. Data cleaning → pandas methods
8. Missing data → SimpleImputer
9. Scaling → StandardScaler in pipeline
10. Categorical encoding → OneHotEncoder

**Anti-patterns** (5 common):
1. ❌ Training without pipeline (data leakage)
2. ❌ matplotlib for viz (use Plotly)
3. ❌ Manual train/test split (use cross-validation)
4. ❌ Ignoring dtypes on CSV load
5. ❌ Fitting on full dataset (use train set only)

---

## Monthly Maintenance Routine

**Schedule**: 1st of each month

**Time**: 30-60 minutes

### Step 1: Run Validation Script

```bash
cd /path/to/project
bash tools/validate_ai_guides.sh docs/
```

**Review output**:
- Content minimums met?
- Links valid?
- [CUSTOMIZE] markers remaining?
- Staleness warnings?

### Step 2: Run Discovery

```bash
# In Claude Code
/ai-guides-discover recent
```

**Review discovery items**: What patterns appeared in last 30 days?

### Step 3: Assess Materiality

```bash
/ai-guides-assess all
```

**Identify CRITICAL and HIGH items**: Update these immediately

### Step 4: Update Guides

```bash
/ai-guides-update [critical-item-ids]
```

**Update CRITICAL items first**, then HIGH if time permits

### Step 5: Complete 1 Capability Test

Pick one item from Future Testing Backlog:

1. Design test
2. Run test
3. Document results
4. Move to Documented Limits if confirmed

**Goal**: 3 tests per quarter, 12 per year

---

## Quarterly Deep Review

**Schedule**: Every 3 months (March, June, September, December)

**Time**: 2-3 hours

### Review Validation Scenarios

**Run all scenarios**:
1. Record results (pass/fail, time, errors)
2. Compare to baseline
3. Update scenarios if project changed
4. Add new scenarios for new patterns

### Analyze Trends

**Questions to ask**:
- Are success rates improving?
- Which scenarios consistently fail? (update guides)
- Which scenarios always pass? (guides working)
- New scenarios needed for new features?

### Update Examples

**Review Quick Reference Patterns**:
- Are code snippets still current?
- New patterns to add?
- Old patterns to remove/update?

### Assess Coverage

**Calculate coverage**:
- % of active workflows documented
- % of common operations in guide
- % of capability backlog completed

**Goal**: ≥80% coverage by month 6

---

## Questions?

See `FAQ.md` for common customization questions.
