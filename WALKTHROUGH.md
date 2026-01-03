# Why You Need This (And How It Works)

**If you're reading this, you're probably tired of answering the same questions from Claude over and over.**

This walkthrough will show you exactly what problem this solves, how it works, and whether it's worth your 30 minutes to set up.

**TL;DR**: After setup, Claude stops asking questions it should already know the answer to, implements patterns correctly the first time, and saves you ~90% of the time on common operations.

---

## The Problem You Already Have

You're using Claude Code. Right now, one of these is happening:

**Scenario A**: Claude asks you 5 questions before doing anything
- "What state management do you use?"
- "Where should I put this file?"
- "What's your testing setup?"
- "Which database ORM?"
- "What's your styling approach?"

**Scenario B**: Claude guesses wrong
- Uses `fetch()` when you have a typed API client
- Puts files in wrong directories
- Uses patterns you've explicitly moved away from
- You spend 10 minutes fixing what should've been right the first time

**You've probably done this**: Typed the same answer 50 times. "We use Prisma for database, not raw SQL." "State goes in Zustand stores." "We use tRPC, not REST."

Sound familiar? Yeah. **That's what this fixes.**

---

## The Solution (Show, Don't Tell)

Let me show you what goes in your guide. This is an actual example from the web-app template:

### Concept Mappings

| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "Database query" | Prisma ORM with TypeScript types | Always use `include` for relations to avoid N+1 queries |
| "State management" | Zustand stores in src/stores/ | Don't use Redux, context, or component state for global data |
| "API call" | tRPC procedures with automatic type safety | Never use fetch() for internal APIs - tRPC provides end-to-end types |
| "Component" | React component in src/components/ with .tsx extension | Use functional components with hooks, no class components |
| "Styling" | Tailwind utility classes, no CSS modules | Use design tokens from tailwind.config.js for consistency |
| "Form validation" | Zod schemas in src/schemas/ | Define schema first, derive TypeScript types with z.infer |
| "Authentication" | NextAuth.js with JWT strategy | Session stored in httpOnly cookie, never localStorage |

See that table? **That's the magic.**

Now when you tell Claude "add a database query," it reads that table and goes:
- ✅ "Oh, they use Prisma"
- ✅ "With TypeScript types"
- ✅ "And I need to use `include` to avoid N+1 queries"

**Zero questions asked. First implementation is correct.**

### Common Anti-Patterns

The guide also teaches Claude your team's hard-won lessons:

❌ **Using fetch() for internal API calls**
- **Why wrong**: No type safety, manual error handling, no caching
- **Correct approach**: Use tRPC procedures for end-to-end type safety
- **Example**:
```typescript
// Wrong
const response = await fetch('/api/users')
const data = await response.json()  // No type safety

// Right
const data = await trpc.users.getAll.query()  // Fully typed
```

✅ **Correct Pattern**: Always use tRPC for internal APIs, only use fetch() for external APIs

---

❌ **Using component state for global data**
- **Why wrong**: Prop drilling, re-renders, hard to share between components
- **Correct approach**: Use Zustand for global state
- **Example**:
```typescript
// Wrong - prop drilling hell
function App() {
  const [user, setUser] = useState(null)
  return <Dashboard user={user} setUser={setUser} />
}

// Right - global store
const user = useAuthStore((state) => state.user)
```

✅ **Correct Pattern**: Global state in Zustand, component state for UI-only (modals, forms)

---

See those ❌ and ✅ markers? **That's Claude learning your team's lessons.**

Every time you've told someone "don't use fetch for internal APIs, we have tRPC" - that goes in here **once**. Now Claude never makes that mistake again.

---

## Here's Why This Actually Works

Let me show you the proof. This system was used on a real documentary project for 3 months:

**Before the guides existed:**
- UUID lookup time: **2-3 minutes each** (Claude searching through files)
- Error rate: **50%** duplicate UUIDs generated
- Vision API: **50% failure rate** on tall screenshots

**After adding guides:**
- UUID lookup time: **30 seconds** (reads the guide, finds the pattern)
- Error rate: **<10%** duplicates (90% reduction)
- Vision API: **~0% failures** (guide says "tall screenshot = use tiling workaround")

**That's 90% time savings on common operations. 40% error reduction.**

The RLA project has:
- 2,940 person entities (all UUID-based)
- 7 master registries
- Complex newspaper/Facebook/transcript ingestion workflows

Before guides: Claude kept generating duplicate UUIDs (50% error rate) because the pattern was complex.

After adding to guide: "UUID lookup process: Check registry first, never generate if exists" → Error rate dropped to <10%.

**The complete RLA guides are included** in `examples/rla-documentary/` so you can see what "fully populated" looks like.

---

## What You Actually Get

When you clone this repo, you get:

### 1. Templates with Fill-in-the-Blanks

Not empty files. Real templates with `[CUSTOMIZE]` markers showing exactly what to fill in:

```markdown
| "Database query" | [CUSTOMIZE: Your ORM + key patterns] | [CUSTOMIZE: Common gotchas] |
```

Open the template, see the marker, type your answer. That's it.

### 2. Four Working Examples

- **web-app/** - React/TypeScript/Vite/Tailwind/tRPC/Prisma
- **api-project/** - GraphQL/REST/PostgreSQL/JWT
- **mobile-app/** - React Native/Expo/AsyncStorage/Navigation
- **data-science/** - Python/Jupyter/Pandas/Scikit-learn/Plotly

Pick the one closest to your stack, copy the patterns. Don't start from scratch.

### 3. Commands That Maintain the Guides

**This is the killer feature**: Most documentation goes stale. This system actively prevents that.

Three commands that keep guides fresh:

**Every month** (1st of the month), run:
```bash
/ai-guides-discover recent
```

Claude looks at your last week of commits and says:
```
Found 3 new patterns:
- DISC-001: You're now using Zod for validation (5 files)
- DISC-002: Moved API calls to src/api/ (was src/services/)
- DISC-003: Started using React Query for caching

Should I assess these for adding to guides?
```

Then you run:
```bash
/ai-guides-assess DISC-001,DISC-002
```

Claude scores them objectively (40-point framework):
```
DISC-001: CRITICAL (38/40 points) - Affects 80% of forms
DISC-002: HIGH (28/40 points) - New standard location
```

Then you run:
```bash
/ai-guides-update DISC-001
```

Claude updates the guide with the new pattern. **Takes 5 minutes per month to keep guides current.**

### 4. Validation Script

Monthly health check:
```bash
bash tools/validate_ai_guides.sh
```

Tells you:
- ✅ Links all work
- ✅ Guide has enough content (minimum 15 patterns)
- ⚠️ Last updated 3 months ago (needs refresh)
- ⚠️ Testing backlog: 14 items (should test 3 per quarter)

Prevents guide rot. Keeps quality high.

---

## The 30-Minute Setup (What You Actually Do)

Here's the actual work:

**Step 1** (2 min): Clone repo
```bash
git clone [URL]
cd claude-dev-system-starter
```

**Step 2** (5 min): Pick your example
- Building a React app? Look at `examples/web-app/`
- Python/data science? Look at `examples/data-science/`
- GraphQL API? Look at `examples/api-project/`
- React Native? Look at `examples/mobile-app/`

**Step 3** (15 min): Fill in the template
- Open `templates/AI_DOMAIN_TRANSLATION_GUIDE.md`
- See `[CUSTOMIZE: Your ORM]` → type "Prisma" or "SQLAlchemy" or whatever you use
- Copy-paste patterns from the example
- Add 2-3 anti-patterns your team already knows about

**Step 4** (5 min): Copy commands to your project
```bash
cp -r commands/ /path/to/your/project/.claude/commands/
```

**Step 5** (3 min): Add router to your CLAUDE.md
```markdown
**IF** task involves database/API/state →
→ **Read `docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST**
```

**Done.** 30 minutes total.

---

## Here's What Happens Next

Next time you ask Claude to "add a database query":

### Without Guides (Old Way):
```
Claude: "What database are you using?"
You: "PostgreSQL with Prisma"
Claude: "Where should the query go?"
You: "In src/db/queries/"
Claude: "Should I use raw SQL or ORM?"
You: "Prisma ORM"
Claude: *writes code*
You: "No, you need to use `include` for relations"
Claude: *fixes code*

Total time: 5 minutes, 4 back-and-forths
```

### With Guides (New Way):
```
Claude: *reads guide* "Database query" → Prisma → use `include`
Claude: *writes correct code first try*

Total time: 30 seconds, zero questions
```

**That's the value proposition: 10x faster, zero questions, correct first time.**

---

## One More Thing - The Commands Are Gold

Even if you don't use the guides, the 11 commands are worth cloning:

```bash
/smart-commit     # Analyzes git diff, writes intelligent commit message
/create-pr        # Generates PR with summary from commits
/debug-RCA        # Root cause analysis for bugs
/onboarding       # New dev setup guide
/prime-core       # Load project knowledge into context
/create-prompt    # Expert prompt engineering
/new-dev-branch   # Create development branches
```

These work **without the guides**. They're just good productivity tools.

But when you **combine** them with guides? That's when it gets powerful:
- `/smart-commit` knows your commit style from guides
- `/debug-RCA` checks documented limits when debugging
- `/onboarding` references guides for team patterns

---

## Bottom Line: Should You Use This?

### Use This If:
- ✅ You find yourself answering the same Claude questions repeatedly
- ✅ Claude guesses wrong about your project patterns
- ✅ You have team conventions that aren't obvious from the code
- ✅ You've discovered AI tool limits the hard way (and want to document them)
- ✅ You want first-pass implementations to be correct

### Skip This If:
- ❌ You're on a brand new project with no established patterns yet
- ❌ Your entire team is just you (though even solo devs benefit)
- ❌ You change tech stack every month

---

## What You Do Right Now

### The Minimum Viable Test

Want to see if this is worth it? Here's the 12-minute test:

1. Clone repo (2 min)
2. Look at the example closest to your stack (5 min)
3. Copy ONE pattern you use daily to the template (5 min)
4. Ask Claude to do that thing

**If Claude references the guide and does it correctly first try** → you just found your answer.

**If it doesn't help** → you spent 12 minutes learning it's not for you.

**My bet**: You'll see the value in the first task, then spend the next 2 hours filling in more patterns because you'll realize how much time this saves.

---

## Next Steps

### Option 1: Quick Test (12 minutes)
Follow the test above. See if it works for you.

### Option 2: Full Setup (30 minutes)
Read **SETUP_GUIDE.md** for complete step-by-step instructions.

### Option 3: Learn More First
- **README.md** - Feature list and directory structure
- **documentation/ARCHITECTURE.md** - How the system works
- **documentation/FAQ.md** - Common questions
- **examples/web-app/README.md** - See example in detail

---

## The Test: Does Claude Ask Questions?

Next time you ask Claude "add a database query," count how many questions it asks.

- **More than zero?** You need this.
- **Zero questions, correct implementation?** You already have this solved somehow.

Most projects fall into the first category.

**Ready to try it?** Start with **SETUP_GUIDE.md** →
