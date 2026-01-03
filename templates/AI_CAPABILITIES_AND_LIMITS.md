# AI Capabilities and Limits

**Purpose**: Document known AI capability thresholds and workarounds to prevent reactive problem discovery

**Philosophy**: Test AI capabilities proactively with calibration data before hitting limits in production

**Success Story**: [CUSTOMIZE: Add your first successful workaround here after discovery]

**When to use this**: Before processing new data types, when encountering tool issues, or when planning new workflows

**For domain patterns**: See [AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md) (quick reference for project-specific implementations)

---

## [CUSTOMIZE: AI Tool/Service Name] Limits

<!-- [CUSTOMIZE] Create sections for each AI tool or service you use in your project.

     Examples:
     - Vision API Limits (if processing images)
     - LLM Context Limits (if using GPT/Claude for processing)
     - OCR Limits (if using Docling, Tesseract, etc.)
     - Speech-to-Text Limits (if transcribing audio)
     - Entity Recognition Limits (if extracting names/places)

     For each tool, create two tables:
     1. Documented Limits (problems you've encountered and solved)
     2. Future Testing Needed (hypothesis tests to run proactively)
-->

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| [CUSTOMIZE: e.g., "Large images"] | [CUSTOMIZE: e.g., "Max 10MB → API rejects"] | [CUSTOMIZE: e.g., "Resize to 5MB max"] | [CUSTOMIZE: e.g., "✅ 50 images tested"] |

**Details**:
- **Problem**: [CUSTOMIZE: Describe what breaks]
- **Impact**: [CUSTOMIZE: What happens when limit is hit]
- **Detection**: [CUSTOMIZE: How to detect before processing]
- **Solution**: [CUSTOMIZE: How to work around the limit]
- **Documentation**: [CUSTOMIZE: Link to detailed workflow if exists]

**Applicability**: [CUSTOMIZE: When else this limit might apply]

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| [CUSTOMIZE: Test name] | [CUSTOMIZE: What you think might break] | [CUSTOMIZE: How to test systematically] | [CUSTOMIZE: HIGH/MEDIUM/LOW] |
| [CUSTOMIZE: Test name] | [CUSTOMIZE: Hypothesis] | [CUSTOMIZE: Validation approach] | [CUSTOMIZE: Priority] |

---

## [CUSTOMIZE: Second Tool/Service] Limits

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| (None yet documented) | | | |

**Current Usage**: [CUSTOMIZE: Describe empirical observations without systematic testing]

**Known Good**: [CUSTOMIZE: What has worked well so far]

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| [CUSTOMIZE: Test] | [CUSTOMIZE: Hypothesis] | [CUSTOMIZE: Plan] | [CUSTOMIZE: Priority] |
| [CUSTOMIZE: Test] | [CUSTOMIZE: Hypothesis] | [CUSTOMIZE: Plan] | [CUSTOMIZE: Priority] |

---

## [CUSTOMIZE: Third Tool/Service] Limits

<!-- Add 1-5 tool sections based on your project's AI/ML usage -->

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] |

**Details**:
- **Problem**: [CUSTOMIZE]
- **Impact**: [CUSTOMIZE]
- **Solution**: [CUSTOMIZE]
- **Documentation**: [CUSTOMIZE]

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] | [CUSTOMIZE] |

---

## Proactive Testing Protocol

<!-- This section provides a systematic approach to capability testing.
     You can keep this mostly as-is, just customize the examples to your domain. -->

When encountering a new data type or processing pattern, follow this systematic approach:

### 1. Create Calibration Document

- **Example**: Create test data with known characteristics
- **For your project**: [CUSTOMIZE: What kinds of test data to create]
  - [CUSTOMIZE: e.g., "Images at different resolutions (100px → 10000px)"]
  - [CUSTOMIZE: e.g., "Documents with varying complexity (simple → dense)"]
  - [CUSTOMIZE: e.g., "Audio files at different quality levels (8kHz → 48kHz)"]
  - [CUSTOMIZE: e.g., "Text with edge cases (special characters, multiple languages)"]
- **Storage**: [CUSTOMIZE: Where to store test files, e.g., "test/calibration_data/"]

### 2. Test Capability Systematically

- Start with edge cases (very large, very complex, very low quality)
- Document exact failure thresholds (e.g., "fails at 10MB", "struggles with 300 DPI")
- Test with real examples from your project
- Record success/failure metrics
- **Create test log**: Document what works, what fails, and at what threshold

### 3. Document Results

- Add to appropriate section above
- Include: **what breaks**, **at what threshold**, **how to detect**, **workaround**
- Move from "Future Testing" table to "Documented Limits" table
- Update this document with findings
- Link to any new tools or workarounds created

### 4. Update Workflows with Preventive Guidance

- Add checks to relevant workflows
- **Example**: [CUSTOMIZE: e.g., "Before processing, check file size: `ls -lh file`"]
- Link to this document for full context
- Create workaround tools if needed
- Update router in CLAUDE.md if new pattern is common enough

---

## Workaround Reference (Quick Lookup)

<!-- [CUSTOMIZE] Add a quick reference table for all known workarounds.
     This should be a "cheat sheet" for common problems and their solutions. -->

| Problem | Solution | Documentation |
|---------|----------|---------------|
| [CUSTOMIZE: e.g., "File too large"] | [CUSTOMIZE: e.g., "split_file.sh script"] | [CUSTOMIZE: Link to docs] |
| [CUSTOMIZE: e.g., "Text not recognized"] | [CUSTOMIZE: e.g., "Increase image quality"] | [CUSTOMIZE: Link to docs] |
| [CUSTOMIZE: e.g., "API timeout"] | [CUSTOMIZE: e.g., "Batch processing script"] | [CUSTOMIZE: Link to docs] |

---

## Applicability Beyond Current Use Cases

<!-- [CUSTOMIZE] Describe how these limits might apply to future work.
     This helps prevent similar issues when expanding to new data types. -->

**[CUSTOMIZE: Limit name]**: Applies to [CUSTOMIZE: broader set of use cases]

**Proactive testing mindset**: When expanding to new data types, test capabilities BEFORE production processing

**Example**: [CUSTOMIZE: If you start processing X, test first:]
- [CUSTOMIZE: Specific characteristic 1]
- [CUSTOMIZE: Specific characteristic 2]
- [CUSTOMIZE: Specific characteristic 3]
- [CUSTOMIZE: Specific characteristic 4]

---

## Integration with Translation Guide

<!-- Keep this section mostly as-is - explains relationship between the two guides -->

**Complementary relationship**:
- **Translation Guide** ([AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md)): "What patterns does your project use?" (e.g., API structure, data models)
- **Capabilities Guide** (This document): "What constraints do AI tools have?" (e.g., file size limits, timeout thresholds)

**Together**: Complete quick reference for agents (patterns + constraints = informed decisions)

**Decision Flow**:
1. **Before starting work**: Check Translation Guide for project-specific patterns
2. **When encountering AI tools**: Check this Capabilities Guide for known limits
3. **When limits discovered**: Update this guide + create workaround + update workflows

---

## When to Reference This Guide

**Use this guide when**:
- [CUSTOMIZE: e.g., "Processing large files or datasets"]
- [CUSTOMIZE: e.g., "Using Vision API or OCR"]
- [CUSTOMIZE: e.g., "Entity extraction fails"]
- [CUSTOMIZE: e.g., "Planning workflow for new data type"]
- [CUSTOMIZE: e.g., "Debugging unexpected API behavior"]

**Router condition** (in CLAUDE.md):
- IF [CUSTOMIZE: specific task] → Check this guide FIRST
- IF [CUSTOMIZE: specific condition] → Reference [specific section]
- IF [CUSTOMIZE: specific failure] → Reference [specific workaround]

---

## Success Stories

<!-- [CUSTOMIZE] Document your successful workarounds here.
     This provides context and motivation for the proactive testing approach. -->

### [CUSTOMIZE: Workaround Name] (YYYY)

**Challenge**: [CUSTOMIZE: What problem were you facing?]

**Discovery**: [CUSTOMIZE: How did you discover the limit? Reactive or proactive?]

**Solution**: [CUSTOMIZE: What workaround did you create?]

**Validation**: [CUSTOMIZE: How did you validate the solution?]

**Lesson**: [CUSTOMIZE: What would you do differently next time?]

**Documentation**: [CUSTOMIZE: Link to detailed docs]

---

## Future Priorities

<!-- [CUSTOMIZE] Maintain a prioritized backlog of capability tests to run.
     This helps ensure systematic testing over time. -->

### High Priority Tests
1. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why high priority]
2. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why high priority]

### Medium Priority Tests
1. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why medium priority]
2. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why medium priority]

### Low Priority Tests
1. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why low priority]
2. [CUSTOMIZE: Test name] - [CUSTOMIZE: Why low priority]

---

## Related Documentation

<!-- [CUSTOMIZE] Link to related documentation in your project -->

- **[AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md)** - Project-specific patterns
- [CUSTOMIZE: Link to relevant workflow documentation]
- [CUSTOMIZE: Link to tool documentation]
- [CUSTOMIZE: Link to CLAUDE.md router]

---

## Change Log

<!-- [CUSTOMIZE] Track changes to this guide over time -->

**YYYY-MM-DD**: Initial creation
- [CUSTOMIZE: Tool 1] limits: X documented, Y future tests
- [CUSTOMIZE: Tool 2] limits: X documented, Y future tests
- [CUSTOMIZE: Tool 3] limits: X documented, Y future tests
- Proactive testing protocol: 4-step systematic process
- Workaround reference table: X entries with documentation links
- CLAUDE.md router integration: [CUSTOMIZE: Where integrated]
- Validation: [CUSTOMIZE: What validation performed]
- Total backlog: [CUSTOMIZE: Number] untested capability items

---

## Customization Instructions

**First-time setup**:

1. **Identify AI/ML Tools**: List all AI services your project uses
   - Vision APIs, OCR, LLMs, speech-to-text, entity recognition, etc.
   - Create a section for each major tool

2. **Document Known Issues**: If you've hit limits before, document them
   - Move to "Documented Limits" table
   - Include problem, solution, validation
   - Link to any workaround scripts or tools

3. **Create Testing Backlog**: Hypothesize potential limits
   - Add to "Future Testing Needed" tables
   - Prioritize by impact (HIGH/MEDIUM/LOW)
   - Aim for 3-5 tests per tool

4. **Set Up Calibration Data**: Create test files for systematic testing
   - Store in designated directory
   - Document characteristics (sizes, formats, edge cases)
   - Use for validation of workarounds

5. **Link Documentation**: Connect to related guides
   - Update Translation Guide reference
   - Link to workflow docs that reference limits
   - Add router integration in CLAUDE.md

6. **Validation**: Before committing
   - All [CUSTOMIZE] markers replaced
   - At least 1 documented limit (or mark as "None yet documented")
   - At least 3 future tests per tool
   - All links work

**Ongoing maintenance**:
- When you hit a limit → Document it immediately (move from Future to Documented)
- When you create a workaround → Add to Workaround Reference table
- Monthly → Review Future Testing backlog, prioritize next tests
- Quarterly → Run HIGH priority tests systematically

**Success metrics**:
- Reactive discoveries → Proactive discoveries (shift from hitting limits to testing first)
- Workaround count: Track how many limits you've systematically solved
- Test coverage: What % of hypothesized limits have been validated
