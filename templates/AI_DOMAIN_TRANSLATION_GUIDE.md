# AI Domain Translation Guide

**Purpose**: Quick reference for mapping generic AI knowledge to project-specific implementations

**When to use this**: Mid-task when you encounter a pattern and need immediate guidance (not comprehensive learning)

**For comprehensive workflows**: See CLAUDE.md router → domain-specific documentation

---

## When You Think... → We Actually Use...

<!-- [CUSTOMIZE] Add 15-20 concept mappings where generic AI concepts map to your project's specific implementations.
     Focus on:
     - Data structures (what AI calls "database" vs your actual storage)
     - Workflows (what AI assumes vs your actual process)
     - Tool selection (when to use X vs Y in your stack)
     - Common operations with project-specific naming

     Example format:
     | "Generic term" | Your actual implementation | ⚠️ Gotcha / Critical Note |
-->

| Generic Mental Model | Project Implementation | Gotcha / Critical Note |
|---------------------|------------------------|------------------------|
| [CUSTOMIZE: e.g., "User database"] | [CUSTOMIZE: e.g., "PostgreSQL users table"] | ⚠️ [CUSTOMIZE: e.g., "Not MongoDB - migrated 2023"] |
| [CUSTOMIZE: e.g., "API call"] | [CUSTOMIZE: e.g., "GraphQL resolver"] | ⚠️ [CUSTOMIZE: e.g., "Not REST - use Apollo client"] |
| [CUSTOMIZE: e.g., "State management"] | [CUSTOMIZE: e.g., "Zustand stores"] | ⚠️ [CUSTOMIZE: e.g., "Not Redux - simpler pattern"] |
| [CUSTOMIZE] | [CUSTOMIZE] | ⚠️ [CUSTOMIZE] |
| [CUSTOMIZE] | [CUSTOMIZE] | ⚠️ [CUSTOMIZE] |

<!-- Continue adding rows until you have 15-20 mappings that cover your most common operations -->

---

## Quick Reference Patterns

<!-- [CUSTOMIZE] Add 4-6 quick reference code patterns with copy-paste examples.
     These should be your most common operations that benefit from having exact syntax ready.

     Examples:
     - Database queries with your ORM
     - API calls with your client library
     - File operations with your project structure
     - Common transformations or validations

     Include both bash and code examples where applicable.
-->

### [CUSTOMIZE: Most Common Operation Name]

```bash
# [CUSTOMIZE: Add bash commands if applicable]
# Example: grep -r "pattern" src/components/
```

**[Language] example**:
```[language]
// [CUSTOMIZE: Add code example with exact syntax]
// Example: const data = await prisma.user.findMany({ where: { active: true } })
```

### [CUSTOMIZE: Second Common Operation]

```bash
# [CUSTOMIZE: Add relevant commands]
```

**[Language] example**:
```[language]
// [CUSTOMIZE: Add code pattern]
```

### [CUSTOMIZE: Third Common Operation]

```bash
# [CUSTOMIZE: Add relevant commands]
```

**[Language] example**:
```[language]
// [CUSTOMIZE: Add code pattern]
```

<!-- Add 3-5 more quick reference patterns -->

---

## Common Anti-Patterns

<!-- [CUSTOMIZE] Add 5-15 common anti-patterns you've observed in your project.
     Format: ❌ Anti-pattern description, Why wrong, ✅ Correct approach

     These should be mistakes that:
     - You or your team have made repeatedly
     - Cause data integrity issues
     - Break project conventions
     - Waste significant time when done wrong

     Good anti-patterns save 5+ minutes each time they're avoided.
-->

❌ **[CUSTOMIZE: Anti-pattern title]**
- **Why wrong**: [CUSTOMIZE: Explain the problem this causes]
- **Correct approach**: [CUSTOMIZE: Show the right way to do it]

❌ **[CUSTOMIZE: Second anti-pattern]**
- **Why wrong**: [CUSTOMIZE: Explain consequences]
- **Correct approach**: [CUSTOMIZE: Correct implementation]

❌ **[CUSTOMIZE: Third anti-pattern]**
- **Why wrong**: [CUSTOMIZE: Why this breaks things]
- **Correct approach**: [CUSTOMIZE: How to do it right]

<!-- Add 2-12 more anti-patterns based on your project's common mistakes -->

---

## Tool Selection Guide

<!-- [CUSTOMIZE] Add a table mapping task types to the specific tools you use.
     This helps AI choose the right tool for your stack.

     Include documentation links if you have internal docs.
-->

| Task Type | Recommended Tool | Documentation |
|-----------|------------------|---------------|
| [CUSTOMIZE: e.g., "Database migrations"] | [CUSTOMIZE: e.g., "Prisma migrate"] | [CUSTOMIZE: Link to docs] |
| [CUSTOMIZE: e.g., "API testing"] | [CUSTOMIZE: e.g., "Jest + Supertest"] | [CUSTOMIZE: Link to docs] |
| [CUSTOMIZE: e.g., "Styling"] | [CUSTOMIZE: e.g., "Tailwind classes"] | [CUSTOMIZE: Link to docs] |
| [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] |
| [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] |

<!-- Add 5-15 tool selection mappings -->

---

## [CUSTOMIZE: Project-Specific Section Name]

<!-- [CUSTOMIZE] Add 1-3 project-specific sections that don't fit above categories.

     Examples:
     - "Registry Quick Reference" (if you have registries)
     - "API Endpoints Overview" (if you have many endpoints)
     - "Deployment Environments" (if you have complex deployment)
     - "File Structure Conventions" (if you have specific folder patterns)

     Only add sections that provide genuine quick-lookup value.
-->

**[CUSTOMIZE: Add section content]**

---

## Common Workflows Quick Links

<!-- [CUSTOMIZE] Add 3-6 common workflow summaries with links to full documentation.

     Format: Brief step-by-step list + link to comprehensive workflow doc.
     These should be your most frequent multi-step operations.
-->

### [CUSTOMIZE: Workflow Name]
1. [CUSTOMIZE: Step 1]
2. [CUSTOMIZE: Step 2]
3. [CUSTOMIZE: Step 3]
4. [CUSTOMIZE: Step 4]

**See**: [CUSTOMIZE: Link to full workflow documentation]

### [CUSTOMIZE: Second Workflow]
1. [CUSTOMIZE: Step 1]
2. [CUSTOMIZE: Step 2]
3. [CUSTOMIZE: Step 3]

**See**: [CUSTOMIZE: Link to docs]

<!-- Add 1-4 more common workflows -->

---

## Decision Trees

<!-- [CUSTOMIZE] Add 2-4 decision trees for common "should I do X or Y?" questions.

     Format: ASCII tree with clear yes/no branches.
     These work best for decisions that:
     - Come up frequently
     - Have clear criteria
     - Benefit from systematic approach

     Example topics:
     - "Should I create a new component or modify existing?"
     - "Should I add this to the database or use cache?"
     - "Should I write a unit test or integration test?"
-->

### "[CUSTOMIZE: Decision question?]"

```
[CUSTOMIZE: Root question?]
├─ [CUSTOMIZE: YES case] → [CUSTOMIZE: Action]
└─ [CUSTOMIZE: NO case]
    ├─ [CUSTOMIZE: Sub-question?] → [CUSTOMIZE: Action]
    └─ [CUSTOMIZE: Sub-question?] → [CUSTOMIZE: Action]
```

### "[CUSTOMIZE: Second decision?]"

```
[CUSTOMIZE: Root question?]
├─ [CUSTOMIZE: Condition] → [CUSTOMIZE: Action]
└─ [CUSTOMIZE: Condition] → [CUSTOMIZE: Action]
```

<!-- Add 0-2 more decision trees -->

---

## Production Requirements

<!-- [CUSTOMIZE] OPTIONAL: Add if you have production-critical requirements.

     List fields, conventions, or patterns that MUST be followed for production use.
     Only include if there are genuine production blockers (not preferences).

     Delete this section if not applicable to your project.
-->

**Critical requirements for production**:

1. **[CUSTOMIZE: Requirement 1]** - [CUSTOMIZE: Why critical]
2. **[CUSTOMIZE: Requirement 2]** - [CUSTOMIZE: Why critical]
3. **[CUSTOMIZE: Requirement 3]** - [CUSTOMIZE: Why critical]

---

## Related Documentation

<!-- [CUSTOMIZE] Add links to related documentation in your project.

     Organize by type:
     - Quick References (other quick-lookup docs)
     - Comprehensive Workflows (full process documentation)
     - Technical Specifications (detailed specs)
     - Templates (starter files or examples)
-->

**Quick References** (this guide):
- ⭐ Start here for immediate pattern lookup

**Comprehensive Workflows**:
- [CUSTOMIZE: Link to workflow 1]
- [CUSTOMIZE: Link to workflow 2]
- [CUSTOMIZE: Link to workflow 3]

**Technical Specifications**:
- [CUSTOMIZE: Link to spec 1]
- [CUSTOMIZE: Link to spec 2]

**Templates**:
- [CUSTOMIZE: Link to template 1]
- [CUSTOMIZE: Link to template 2]

---

**This guide complements (not replaces) comprehensive workflows. When in doubt, read the full workflow documentation.**

---

## Change Log

<!-- [CUSTOMIZE] Track changes to this guide over time.

     Format: YYYY-MM-DD: Description
     - What was added/changed
     - Why it was added
     - Validation performed

     This helps track guide evolution and ensures updates are intentional.
-->

**YYYY-MM-DD**: Initial creation
- [CUSTOMIZE: Number] concept mappings
- [CUSTOMIZE: Number] anti-patterns
- [CUSTOMIZE: Number] tool selection scenarios
- [CUSTOMIZE: Number] quick reference patterns
- Validation: [CUSTOMIZE: What testing was performed]

---

## Customization Instructions

**First-time setup**:

1. **Concept Mappings**: Replace all [CUSTOMIZE] markers with your project's actual implementations
   - Aim for 15-20 mappings (minimum: 15)
   - Focus on operations you do daily
   - Include gotchas/warnings that save time

2. **Quick Reference Patterns**: Add 4-6 code examples with exact syntax
   - Use your actual tech stack (not generic examples)
   - Include both bash and code where relevant
   - Copy-paste ready (no placeholders in final version)

3. **Anti-Patterns**: Document 5-15 common mistakes
   - Use ❌/✅ format for clarity
   - Explain why wrong AND how to do it right
   - Focus on mistakes that cost 5+ minutes

4. **Tool Selection**: Map 5-15 task types to specific tools
   - Be specific (not "testing" but "API integration testing")
   - Include your actual tool names
   - Link to internal docs if available

5. **Optional Sections**: Add only if genuinely useful
   - Project-specific quick references
   - Production requirements
   - Decision trees for frequent decisions

6. **Related Documentation**: Link to your actual docs
   - Update all [CUSTOMIZE] links
   - Remove sections that don't apply
   - Organize by document type

7. **Validation**: Before committing
   - All [CUSTOMIZE] markers replaced
   - All code examples tested
   - All links work
   - No placeholder text remains

**Ongoing maintenance**:
- Use `/ai-guides-discover` to find new patterns
- Use `/ai-guides-assess` to prioritize updates
- Use `/ai-guides-update` to execute changes with quality control
- See: AI_GUIDES_MAINTENANCE_PLAN.md for systematic workflow

**Success metrics**:
- Time to lookup pattern: <30 seconds (vs 2-3 min in full docs)
- First-pass error rate: 40% reduction after 3 months
- Guide coverage: ≥80% of daily operations after 6 months
