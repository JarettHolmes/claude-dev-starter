# Validation Scenarios Template

Create 3-6 scenarios to test guide effectiveness. Run monthly to measure success.

**Purpose**: Validate that guides actually work and provide measurable value. Without testing, you can't prove guides are helping.

---

## How to Use This Template

1. **Create 3-6 scenarios** covering:
   - 1-2 most common operations (tests Translation Guide)
   - 1-2 known capability limits (tests Capabilities Guide)
   - 1-2 common anti-patterns (tests Translation Guide)

2. **Run monthly** (1st of each month):
   - Execute each scenario
   - Record results (reference rate, time, errors)
   - Compare to baseline
   - Update guides if scenarios fail

3. **Update scenarios** as project evolves:
   - Add new scenarios for new patterns
   - Remove scenarios for deprecated patterns
   - Adjust success criteria as guides improve

---

## Scenario Template

Copy this template for each scenario:

```markdown
### Scenario N: [Scenario Name]

**Goal**: Test that [specific guide section] enables [desired outcome]

**Setup**:
1. [Precondition 1 - e.g., "Guides populated with database query pattern"]
2. [Precondition 2 - e.g., "CLAUDE.md router configured"]

**Baseline** (before guides):
- Time: [X minutes]
- Error rate: [Y%]
- Questions: [Z count]

**Test Steps**:
1. Agent encounters task: "[specific task description]"
2. CLAUDE.md router directs agent to [guide name]
3. Agent opens [guide] → finds [section/pattern]
4. Agent applies pattern: [specific action]

**Expected Behavior**:
- ✅ Agent references guide before implementation
- ✅ Agent uses documented pattern (not generic approach)
- ✅ Implementation succeeds first pass
- ✅ Time: [X seconds/minutes] (vs baseline [Y])

**Failure Indicators**:
- ❌ Agent doesn't reference guide
- ❌ Agent asks clarifying questions already answered in guide
- ❌ Agent uses wrong approach (not from guide)
- ❌ Implementation requires corrections

**Measured Metrics**:
- **Reference rate**: Did agent check guide? (yes/no)
- **Time to completion**: [actual] vs [baseline]
- **Error rate**: Corrections needed? (count)
- **Pattern usage**: Used guide pattern? (yes/no)
```

---

## Example Scenarios

### Scenario 1: Most Common Operation (Database Query)

**Goal**: Test Translation Guide enables database queries without clarifying questions

**Setup**:
1. AI_DOMAIN_TRANSLATION_GUIDE.md populated with "Database query" mapping
2. CLAUDE.md router configured to direct database tasks to guide
3. Baseline measured: 3 minutes, 2 clarifying questions

**Baseline** (before guides):
- Time: 3 minutes
- Questions: 2 ("Which ORM?", "Include relations?")
- Error rate: 50% (forgot to include relations)

**Test Steps**:
1. Agent encounters: "Fetch all active users with their profile information"
2. Router → AI_DOMAIN_TRANSLATION_GUIDE.md
3. Agent finds "Database query" → Prisma ORM mapping
4. Agent sees "Always use include for relations" in Gotcha column
5. Agent executes: `prisma.user.findMany({ where: { active: true }, include: { profile: true } })`

**Expected Behavior**:
- ✅ Agent references guide in <10 seconds
- ✅ Uses exact pattern from guide (Prisma with include)
- ✅ Completes in <60 seconds (vs 3 minutes baseline)
- ✅ No clarifying questions (vs 2 baseline)
- ✅ Includes relations (vs 50% error rate baseline)

**Failure Indicators**:
- ❌ Agent asks "Which ORM should I use?"
- ❌ Agent uses generic ORM query (not Prisma)
- ❌ Agent forgets to include relations (error)
- ❌ Takes >2 minutes (not saving time)

**Measured Metrics**:
- Reference: yes/no
- Time: [actual] vs 3 minutes baseline
- Questions: count vs 2 baseline
- Error (missing include): yes/no

**Success Criteria**:
- Reference rate: 100%
- Time reduction: ≥50% (≤90 seconds)
- Question reduction: 100% (0 questions)
- Error rate: 0% (includes relations)

---

### Scenario 2: Capability Limit (Proactive Workaround)

**Goal**: Test Capabilities Guide prevents known failure through proactive workaround

**Setup**:
1. AI_CAPABILITIES_AND_LIMITS.md documents Vision API 1568px limit
2. Workaround documented: tile_screenshot.py for tall images
3. Baseline measured: 50% failure rate on tall screenshots

**Baseline** (before guides):
- Failure rate: 50% (tall screenshots exceed limit)
- Recovery time: 15 minutes (reactive debugging)
- Workaround applied: After failure (reactive)

**Test Steps**:
1. Agent encounters: "Analyze this 3000px tall screenshot"
2. Router → AI_CAPABILITIES_AND_LIMITS.md
3. Agent finds "Vision API - Image Pixel Limit" section
4. Agent sees threshold: 1568px (shorter dimension)
5. Agent applies tile_screenshot.py BEFORE calling API
6. API call succeeds (no failure)

**Expected Behavior**:
- ✅ Agent checks limit proactively (before API call)
- ✅ Applies workaround before failure
- ✅ No reactive debugging needed
- ✅ Success rate: 100% (vs 50% baseline)
- ✅ Time saved: 15 minutes (no debugging)

**Failure Indicators**:
- ❌ Agent calls API directly (doesn't check limit)
- ❌ API fails, then agent debugs (reactive)
- ❌ Agent doesn't find workaround in guide
- ❌ Takes >5 minutes (should be quick)

**Measured Metrics**:
- Proactive check: yes/no
- Workaround used: yes/no
- Failure avoided: yes/no
- Time saved: [actual] vs 15 min reactive debugging

**Success Criteria**:
- Proactive check rate: 100%
- Failure avoidance: 100%
- Time saving: ≥80% (≤3 minutes vs 15)

---

### Scenario 3: Common Anti-Pattern (Error Prevention)

**Goal**: Test Translation Guide prevents common mistake

**Setup**:
1. AI_DOMAIN_TRANSLATION_GUIDE.md documents N+1 query anti-pattern
2. Correct approach shown: use include or DataLoader
3. Baseline measured: 60% error rate (N+1 queries)

**Baseline** (before guides):
- Error rate: 60% (N+1 queries in resolvers)
- Correction time: 10 minutes (refactor after discovering)
- Performance impact: 10x slower queries

**Test Steps**:
1. Agent encounters: "Create GraphQL resolver to fetch posts with authors"
2. Router → AI_DOMAIN_TRANSLATION_GUIDE.md
3. Agent finds anti-pattern: "N+1 queries in resolvers"
4. Agent sees ❌ wrong approach (separate queries)
5. Agent sees ✅ correct approach (include or DataLoader)
6. Agent uses correct approach from start

**Expected Behavior**:
- ✅ Agent references anti-pattern section
- ✅ Uses correct approach (include or DataLoader)
- ✅ No N+1 query created
- ✅ No correction needed (vs 60% error rate)
- ✅ Performance optimal from start

**Failure Indicators**:
- ❌ Agent creates N+1 query (anti-pattern)
- ❌ Discovers issue during testing (reactive)
- ❌ Needs to refactor (time wasted)
- ❌ Performance problem persists

**Measured Metrics**:
- Anti-pattern avoided: yes/no
- Error rate: [actual] vs 60% baseline
- Correction time: 0 vs 10 minutes baseline
- Performance: Optimal vs 10x slower

**Success Criteria**:
- Anti-pattern avoidance: 100%
- Error rate: 0% (vs 60%)
- Correction time: 0 (vs 10 min)
- Performance: Optimal (no N+1)

---

### Scenario 4: Tool Selection (Decision Support)

**Goal**: Test Translation Guide provides clear tool selection guidance

**Setup**:
1. AI_DOMAIN_TRANSLATION_GUIDE.md has Tool Selection Matrix
2. Scenario: "Need to cache API responses"
3. Baseline: 5 minutes deciding, sometimes wrong choice

**Baseline** (before guides):
- Decision time: 5 minutes
- Wrong tool choice: 30%
- Clarifying questions: 1-2

**Test Steps**:
1. Agent encounters: "Add caching for expensive API calls"
2. Router → AI_DOMAIN_TRANSLATION_GUIDE.md
3. Agent finds Tool Selection Matrix
4. Agent sees: "IF need to cache → USE Redis + apollo-cache-control → WHY fast, reduces DB load"
5. Agent implements Redis caching

**Expected Behavior**:
- ✅ Agent checks matrix before deciding
- ✅ Selects correct tool (Redis)
- ✅ Understands rationale (reduces DB load)
- ✅ Decision in <30 seconds (vs 5 min)
- ✅ No clarifying questions

**Measured Metrics**:
- Matrix consulted: yes/no
- Correct tool: yes/no
- Decision time: [actual] vs 5 min
- Questions: count vs 1-2

**Success Criteria**:
- Matrix use: 100%
- Correct tool: 100%
- Time reduction: ≥80% (≤60 seconds)
- Question reduction: 100%

---

### Scenario 5: Quick Reference Pattern (Copy-Paste)

**Goal**: Test Quick Reference patterns provide working code

**Setup**:
1. AI_DOMAIN_TRANSLATION_GUIDE.md has JWT authentication pattern
2. Pattern includes full working code
3. Baseline: 10 minutes to write auth code

**Baseline** (before guides):
- Implementation time: 10 minutes
- Errors: Missing verify logic, wrong algorithm
- Revisions: 2-3 iterations

**Test Steps**:
1. Agent encounters: "Add JWT authentication to API"
2. Router → AI_DOMAIN_TRANSLATION_GUIDE.md
3. Agent finds "JWT Authentication" quick reference
4. Agent copies pattern (RS256, verify logic, context)
5. Agent adapts for specific endpoint
6. Code works first try

**Expected Behavior**:
- ✅ Agent uses quick reference pattern
- ✅ Code is copy-paste ready (works immediately)
- ✅ Completes in <3 minutes (vs 10 min)
- ✅ No iterations needed (vs 2-3)

**Measured Metrics**:
- Pattern used: yes/no
- Time: [actual] vs 10 min
- Iterations: count vs 2-3
- Success: First pass yes/no

**Success Criteria**:
- Pattern usage: 100%
- Time reduction: ≥70% (≤3 min)
- Iteration reduction: 100% (first pass)

---

### Scenario 6: Validation Workflow (Input Checking)

**Goal**: Test anti-patterns prevent missing validation

**Setup**:
1. AI_DOMAIN_TRANSLATION_GUIDE.md documents "No validation" anti-pattern
2. Correct approach: Yup schema before business logic
3. Baseline: 40% missing validation

**Baseline** (before guides):
- Missing validation: 40%
- Security risk: High (unvalidated input)
- Discovery: During security review (late)

**Test Steps**:
1. Agent encounters: "Create mutation to update user profile"
2. Router → AI_DOMAIN_TRANSLATION_GUIDE.md
3. Agent finds anti-pattern: "No input validation"
4. Agent sees correct approach: Yup schema first
5. Agent adds validation before resolver logic

**Expected Behavior**:
- ✅ Agent adds validation (not forgotten)
- ✅ Uses documented pattern (Yup)
- ✅ Validation before business logic
- ✅ No security risk

**Measured Metrics**:
- Validation included: yes/no
- Correct pattern (Yup): yes/no
- Placement (before logic): yes/no
- Error rate: 0% vs 40%

**Success Criteria**:
- Validation inclusion: 100%
- Correct pattern: 100%
- Error rate: 0% (vs 40%)

---

## Running Validation

### Monthly (1st of Month)

**Process**:
```bash
# 1. Run validation script
bash tools/validate_ai_guides.sh

# 2. Test each scenario (record results)
# 3. Update tracking spreadsheet or markdown
# 4. Identify failures → update guides
```

**Results template**:
```markdown
## Validation Run: 2026-01-01

| Scenario | Reference | Time | Errors | Pass |
|----------|-----------|------|--------|------|
| 1. DB Query | ✅ yes | 45s | 0 | ✅ |
| 2. API Limit | ✅ yes | 2m | 0 | ✅ |
| 3. N+1 Anti-pattern | ❌ no | 12m | 1 | ❌ |

**Failures**:
- Scenario 3: Agent didn't check anti-patterns
  - **Action**: Make router condition more specific ("GraphQL resolvers")
  - **Re-test**: 2026-01-08
```

### Quarterly (Deep Review)

Analyze trends:
- Are success rates improving?
- Which scenarios consistently fail → update guides
- Which scenarios always pass → guides working
- New scenarios needed for new patterns?

### Update Guides Based on Failures

If scenario fails:
1. Identify root cause (guide unclear? router vague? pattern missing?)
2. Update relevant guide section
3. Re-run scenario to validate fix
4. Document improvement in guide changelog

---

## Customization Checklist

Before using this template:

- [ ] Replace all [CUSTOMIZE] markers with your project specifics
- [ ] Create 3-6 scenarios minimum
- [ ] Cover most common operations (2-3 scenarios)
- [ ] Cover critical capability limits (1-2 scenarios)
- [ ] Cover frequent anti-patterns (1-2 scenarios)
- [ ] Define success metrics for each scenario
- [ ] Schedule monthly testing (1st of month)
- [ ] Create results tracking system (spreadsheet or markdown)

---

## Tracking Results

### Spreadsheet Method

Create Google Sheet or Excel:

| Month | Scenario | Reference % | Time (s) | Errors | Pass |
|-------|----------|-------------|----------|--------|------|
| 2026-01 | DB Query | 100% | 45 | 0 | ✅ |
| 2026-02 | DB Query | 100% | 40 | 0 | ✅ |
| 2026-03 | DB Query | 100% | 35 | 0 | ✅ |

**Benefits**: Easy to plot trends, calculate averages

### Markdown Method

Create `VALIDATION_RESULTS.md`:

```markdown
## 2026-01-01

### Scenario 1: Database Query
- Reference: ✅ yes
- Time: 45s (baseline: 180s) - 75% improvement
- Errors: 0 (baseline: 50%)
- Pass: ✅

### Scenario 2: API Limit
- Reference: ✅ yes
- Proactive: ✅ yes
- Time saved: 13 min
- Pass: ✅

## 2026-02-01

[Next month results...]
```

**Benefits**: Version controlled, easy to review

---

## Success Metrics Summary

**1-Month Checkpoint**:
- ✅ All scenarios created and baselined
- ✅ First validation run complete
- ✅ Results tracked

**3-Month Checkpoint**:
- ✅ 80% scenarios passing consistently
- ✅ Time savings ≥30% average
- ✅ Error rates ≤50% of baseline

**6-Month Checkpoint**:
- ✅ 100% scenarios passing
- ✅ Time savings ≥50% average
- ✅ Error rates ≤20% of baseline
- ✅ System self-sustaining

---

**Remember**: Validation scenarios prove guides work. Without measurement, you can't demonstrate value or identify areas to improve.
