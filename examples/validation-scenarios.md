# Validation Scenarios: PRP + AI Guides Integration

## Scenario 1: New User Setup

**Objective**: Verify complete system setup in a fresh project

**Steps**:
1. Clone repo to clean directory
2. Run `/setup`
3. Verify the following are created:
   - `docs/` directory with 4 AI guide files
   - `PRPs/in-progress/` directory
   - `PRPs/completed/` directory
   - `PRPs/in-progress/.templates/` with 4 PRP templates
   - `workspace/ai_docs/` directory
   - `.claude/commands/` has 20 commands total:
     - 4 AI Guides commands (setup, discover, assess, update)
     - 8 PRP commands
     - 8 Development commands
   - `CLAUDE.md` has routing for both systems
   - `PRPs/README.md` exists

**Expected Output**:
```
✅ Created 4 AI guide files in docs/
✅ Created PRP workspace with 4 templates
✅ Populated 15 concept mappings from your code
✅ Added router to CLAUDE.md
✅ Installed 20 commands
✅ Validation passed
```

**Success Criteria**:
- All directories created
- All templates present
- Router properly integrated in CLAUDE.md
- Validation script passes

---

## Scenario 2: First Feature (using both systems)

**Objective**: Verify AI Guides and PRP work together for a complete feature workflow

**Steps**:
1. Check AI guides (should have minimal patterns from setup)
2. Create `PRPs/in-progress/INITIAL.md` with a simple feature:
   ```markdown
   Feature: User profile page
   - Display user info
   - Edit profile form
   - Save changes to database
   ```
3. Run `/prp-create PRPs/in-progress/INITIAL.md`
4. Verify generated PRP includes:
   - Patterns from AI_DOMAIN_TRANSLATION_GUIDE.md
   - Database query patterns
   - API layer patterns
   - Known gotchas from guides
5. Execute the PRP with `/prp-base-execute`
6. After completion, run `/ai-guides-discover conversation`
7. Verify discovered patterns include:
   - New profile-specific patterns
   - Form validation approach
   - Database update pattern
8. Run `/ai-guides-assess all`
9. Update guide with HIGH/CRITICAL items: `/ai-guides-update [ids]`
10. Create second feature (similar complexity)
11. Verify new PRP auto-includes yesterday's documented patterns

**Expected Integration Points**:
- PRP "All Needed Context" section references AI Guides
- Discovered patterns are relevant (not noise)
- Second PRP is faster to execute (patterns already documented)

**Success Criteria**:
- First feature implements correctly
- Patterns discovered after first feature
- Second feature reuses first feature's patterns
- Measurable time improvement on second feature

---

## Scenario 3: Existing Project Integration

**Objective**: Verify safe integration into project with existing CLAUDE.md

**Steps**:
1. Create test project with existing `CLAUDE.md`:
   ```markdown
   # Existing CLAUDE.md

   Important project rules:
   - Always use TypeScript
   - Never commit secrets

   [Existing content...]
   ```
2. Run `/setup` in this project
3. Verify:
   - Backup created: `CLAUDE.md.backup-[timestamp]`
   - Diff shown before applying changes
   - User prompted for approval
   - Router inserted without breaking existing rules
   - Existing content preserved
   - New routing added at appropriate location

**Expected Behavior**:
```
Found existing CLAUDE.md
Creating backup: CLAUDE.md.backup-20260102

Proposed changes:
+++ AGENT ROUTER (EXECUTE FIRST)
+++ [Router content...]
+++
+++ [Existing content preserved]

Apply changes? (yes/no)
```

**Success Criteria**:
- Backup created successfully
- Existing rules not modified
- Router properly integrated
- User approval required before changes
- Can revert using backup if needed

---

## Scenario 4: Monthly Maintenance Workflow

**Objective**: Verify regular maintenance workflow works end-to-end

**Steps**:
1. Complete 3-5 features over a "month" (simulate work)
2. Run `/ai-guides-discover recent` (scan last 7 days)
3. Verify discoveries include recent patterns
4. Run `/ai-guides-assess all`
5. Verify scoring is reasonable (HIGH items are truly high-impact)
6. Run `/ai-guides-update [critical-ids]`
7. Verify guides updated correctly
8. Run validation script: `bash tools/validate_ai_guides.sh`
9. Verify both AI Guides and PRP workspace checked
10. Archive completed PRPs: `mv PRPs/in-progress/[done].md PRPs/completed/`

**Expected Output from Validation**:
```
=== AI Guides Validation Report ===
...
📊 Content Minimums
✅ Translation Guide: 23 mappings (minimum: 15)
✅ Translation Guide: 8 anti-patterns (minimum: 5)

📁 PRP Workspace
✅ PRP workspace structure exists
✅ All 4 PRP templates present
✅ PRPs/README.md exists
📊 Active PRPs: 2
📊 Completed PRPs: 3
```

**Success Criteria**:
- Discovery finds relevant patterns
- Assessment scores make sense
- Updates applied correctly
- Validation script passes
- PRP archive organized

---

## Scenario 5: Performance Validation

**Objective**: Measure time savings from using both systems

**Setup**:
- Feature A: Implement without AI Guides (baseline)
- Feature B: Implement with AI Guides, no PRP
- Feature C: Implement with AI Guides + PRP

**Measurements**:
1. **Clarifying questions asked**:
   - Feature A: ~8-12 questions
   - Feature B: ~3-5 questions (60% reduction)
   - Feature C: ~0-2 questions (80%+ reduction)

2. **Time to first working implementation**:
   - Feature A: 90 minutes (with rework)
   - Feature B: 60 minutes (40% faster)
   - Feature C: 50 minutes (45% faster)

3. **Implementation accuracy (first pass)**:
   - Feature A: 60% correct
   - Feature B: 80% correct
   - Feature C: 90% correct

**Success Criteria**:
- AI Guides alone: 40%+ time savings
- AI Guides + PRP: 50%+ time savings
- PRP prevents common errors documented in guides
- Each iteration of feature type gets faster

---

## Scenario 6: Error Recovery

**Objective**: Verify rollback and recovery procedures work

**Test Cases**:

### 6a: Broken Link in Guide
1. Accidentally add broken link to AI_DOMAIN_TRANSLATION_GUIDE.md
2. Run validation script
3. Verify warning appears
4. Fix link
5. Rerun validation
6. Verify passes

### 6b: Corrupted PRP Template
1. Delete one PRP template
2. Run validation script
3. Verify warning: "Expected 4 PRP templates, found 3"
4. Restore from git or copy from examples/
5. Rerun validation
6. Verify passes

### 6c: Bad Router Integration
1. Corrupt CLAUDE.md router section
2. Try to run `/prp-create`
3. Verify graceful error message
4. Restore from backup or git
5. Verify system works again

**Success Criteria**:
- All errors detected by validation
- Clear guidance on how to fix
- Recovery procedures work
- No data loss

---

## Success Metrics Summary

Across all scenarios, track:

### Setup Metrics:
- [ ] `/setup` completes in <10 minutes
- [ ] All 20 commands installed correctly
- [ ] Validation passes after setup
- [ ] CLAUDE.md router works

### Usage Metrics:
- [ ] Clarifying questions reduced 60%+
- [ ] First-pass accuracy improved 40%+
- [ ] Time per feature reduced 30%+
- [ ] Pattern reuse increases over time

### Maintenance Metrics:
- [ ] Monthly validation takes <5 minutes
- [ ] Discovery finds relevant patterns (>80% signal)
- [ ] Assessment scores align with actual impact
- [ ] Updates complete without breaking guides

### Integration Metrics:
- [ ] PRP auto-pulls AI Guide patterns
- [ ] Discovered patterns appear in next PRP
- [ ] No manual copy-paste between systems
- [ ] Validation checks both systems

---

**Last Updated**: 2026-01-02
**Version**: 1.0 (PRP + AI Guides Integration)
