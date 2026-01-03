# AI Capabilities and Limits

**Purpose**: Document known AI capability thresholds and workarounds to prevent reactive problem discovery

**Philosophy**: Atlassian proactively tests AI capabilities with calibration images. We should do the same.

**Success Story**: Facebook tiling methodology - discovered 1568px Vision API limit → built systematic solution → validated with 29 posts, 195 tiles, 100% success rate

**When to use this**: Before processing new evidence types, when encountering image/OCR issues, or when planning new workflows

**For domain patterns**: See [AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md) (quick reference for RLA-specific implementations)

---

## Vision API Limits

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| **Tall screenshots** | Long edge > 1568px → auto-downscale → illegible text | tile_screenshot.py (1400px tiles, 100px overlap) | ✅ 29 posts, 195 tiles, 100% success |

**Details**:
- **Problem**: Vision API automatically downscales images where long edge > 1568px
- **Impact**: Text becomes illegible, OCR produces hallucinations (e.g., "Chicken" placeholder surnames, garbled URLs)
- **Detection**: `identify -format "%h" screenshot.png` shows height > 5000px (needs tiling)
- **Solution**: `tile_screenshot.py` splits into 1400px tiles with 100px overlap
- **Documentation**: See [tile-methodology.md](../workflows/tile-methodology.md)

**Applicability**: Applies to ANY tall screenshot - Facebook posts, Slack threads, iMessage conversations, LinkedIn profiles, web captures

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Dense text | May have threshold for text density/complexity | Create calibration image with varying densities (6pt → 12pt fonts) | MEDIUM |
| Low contrast | Light gray text on white may not register | Test grayscale gradient thresholds (10% → 100% contrast) | LOW |
| Handwritten notes | Cursive vs print recognition rates | Test with yearbook handwriting samples (multiple styles) | MEDIUM |
| Multiple columns | May struggle with column detection | Test with 2-col, 3-col, 4-col layouts (newspaper articles) | LOW |
| Image quality | JPEG compression artifacts may affect OCR | Test various compression levels (100% → 50% quality) | LOW |

---

## OCR Limits (Docling)

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| (None yet documented) | | | |

**Current Usage**: Works well for yearbooks and newspaper scans (observed empirically, not systematically tested)

**Known Good**: Successfully processed 200+ yearbook PDFs and 100+ newspaper articles without systematic failures

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Page count | May have max pages per PDF | Test with 10, 50, 100, 500 page PDFs | LOW |
| Image quality | Scanned PDFs below certain DPI may fail | Test DPI thresholds (72, 150, 300, 600 dpi) | MEDIUM |
| Curved scans | Yearbook spine curvature affects OCR | Test with curved vs flat scans (known issue) | HIGH |
| Language mixing | English + French may confuse OCR | Test bilingual documents (RLA has some French names) | MEDIUM |
| Text density | Dense multi-column layouts may lose structure | Test newspaper layouts with 3-4 columns | MEDIUM |

---

## Entity Recognition Limits

### Documented Limits

| Test | Limit Discovered | Solution | Validation |
|------|------------------|----------|------------|
| Name variants | Fuzzy matching needed for Christopher→Chris | fuzzy_matcher.py + norm_v1 | ✅ In production |
| Nickname → formal | Manual UUID mapping required | Manual override files | ✅ In production |

**Details**:
- **Problem**: Person names appear in multiple variants (Christopher/Chris, Robert/Bob, William/Bill)
- **Impact**: UUID lookups fail, creates duplicate entities, breaks cross-referencing
- **Solution**: fuzzy_matcher.py with norm_v1 normalization algorithm (frozen spec)
- **Documentation**: See [UUID_SYSTEM.md](../workflows/UUID-system/UUID_SYSTEM.md)

### Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Misspellings | Levenshtein distance threshold unknown | Test with deliberate misspellings (1-char, 2-char, 3-char edits) | MEDIUM |
| Cultural names | Non-Western name structure (surname first) | Test with Chinese, Korean, Japanese names (RLA has some) | LOW |
| Titles and suffixes | Jr., Sr., III handling inconsistency | Test with name variants registry (standardize format) | LOW |
| Hyphenated names | Double-barreled surnames may confuse matching | Test with Smith-Jones, O'Brien patterns | MEDIUM |

---

## Proactive Testing Protocol

When encountering a new evidence type or processing pattern, follow this systematic approach:

### 1. Create Calibration Document

- **Example**: Atlassian's "printer sheet" with various UI elements
- **For us**: Create test images with known characteristics
  - Dense text gradients (10pt → 6pt font sizes)
  - Contrast gradients (black → 10% gray text)
  - Handwriting samples (cursive, print, mixed)
  - Multi-column layouts (2-col, 3-col, 4-col)
  - Name variant tests (formal, nicknames, misspellings)
- **Storage**: `SYSTEM/testing/calibration_images/` (to be created)

### 2. Test Capability Systematically

- Start with edge cases (very tall, very dense, very low contrast)
- Document exact failure thresholds (e.g., 1568px for Vision API)
- Test with real examples from repository (yearbooks, newspaper scans, Facebook screenshots)
- Record success/failure metrics
- **Create test log**: Document what works, what fails, and at what threshold

### 3. Document Results

- Add to appropriate section above (Vision API / OCR / Entity Recognition)
- Include: **what breaks**, **at what threshold**, **how to detect**, **workaround**
- Move from "Future Testing" table to "Documented Limits" table
- Update this document with findings
- Link to any new tools or workarounds created

### 4. Update Workflows with Preventive Guidance

- Add checks to relevant workflows (newspaper-ingest.md, facebook-ingest-v2.md, etc.)
- **Example**: "Before processing, check image height: `identify -format '%h' file.png`"
- Link to this document for full context
- Create workaround tools if needed (like tile_screenshot.py)
- Update router in CLAUDE.md if new pattern is common enough

---

## Workaround Reference (Quick Lookup)

| Problem | Solution | Documentation |
|---------|----------|---------------|
| Tall screenshot (>1568px) | tile_screenshot.py | [tile-methodology.md](../workflows/tile-methodology.md) |
| Name variant not matching | fuzzy_matcher.py | SYSTEM/tools/uuid_integration/ |
| UUID for new person | Check registry first, then UUID v5 | [UUID_SYSTEM.md](../workflows/UUID-system/UUID_SYSTEM.md) |
| Curved yearbook scan | (not yet solved) | File issue, manual correction needed |
| Low DPI PDF scan | Re-scan at 300+ DPI | (no formal doc yet, empirical finding) |
| Image height check | `identify -format "%h" file.png` | ImageMagick command |
| Image dimensions check | `identify -format "%wx%h" file.png` | ImageMagick command |

---

## Applicability Beyond Current Use Cases

**Vision API 1568px limit**: Applies to ANY tall screenshot (Slack threads, iMessage conversations, web captures, LinkedIn profiles)

**Proactive testing mindset**: When expanding to new evidence types, test capabilities BEFORE production processing

**Example**: If we start processing LinkedIn screenshots, test first:
- Screenshot height thresholds (profile pages can be very tall → may need tiling)
- Profile layout recognition (structured vs unstructured sections)
- Text density in "About" sections (often dense paragraphs → may trigger Vision API limits)
- Multi-column experience sections (may trigger column detection issues)

**Example**: If we start processing court documents:
- Multi-page PDF handling (test page count limits)
- Legal formatting (dense text, footnotes, multi-column)
- Scanned vs born-digital PDFs (different OCR requirements)
- Signature/stamp recognition (may need special handling)

---

## Integration with Translation Guide

**Complementary relationship**:
- **Translation Guide** ([AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md)): "What patterns does RLA use?" (e.g., 3-table event pattern)
- **Capabilities Guide** (This document): "What constraints do AI tools have?" (e.g., Vision API 1568px limit)

**Together**: Complete quick reference for agents (patterns + constraints = informed decisions)

**Decision Flow**:
1. **Before starting work**: Check Translation Guide for RLA-specific patterns
2. **When encountering images/OCR**: Check this Capabilities Guide for known limits
3. **When limits discovered**: Update this guide + create workaround + update workflows

---

## When to Reference This Guide

**Use this guide when**:
- Processing tall screenshots or large images
- Encountering OCR issues with PDFs or scans
- Entity recognition fails (names not matching)
- Planning workflow for new evidence type
- Debugging unexpected Vision API or OCR behavior

**Router condition** (in CLAUDE.md):
- IF task involves processing screenshots, OCR, or new evidence types → Check this guide FIRST
- IF tall image detected (>5000px) → Reference tiling methodology
- IF name matching fails → Reference entity recognition limits

---

## Success Stories

### Facebook Tiling (2025)

**Challenge**: Facebook screenshots averaging 8,000-14,500px tall → Vision API downscaled → illegible text

**Discovery**: Reactive (hit the limit during production processing)

**Solution**: Created tile_screenshot.py with 1400px tiles, 100px overlap

**Validation**: 29 posts, 195 tiles processed, 100% success rate, zero hallucinations

**Lesson**: Should have tested proactively, but systematic solution prevented future issues

**Documentation**: [tile-methodology.md](../workflows/tile-methodology.md)

---

## Future Priorities

### High Priority Tests
1. **Curved yearbook scans** - Known issue, need systematic workaround
2. **Dense text thresholds** - May affect newspaper multi-column layouts
3. **Handwritten notes** - Yearbooks contain handwritten dedications

### Medium Priority Tests
1. **Image quality/DPI** - Understand minimum viable scan quality
2. **Language mixing** - English/French bilingual documents
3. **Misspelling tolerance** - Entity recognition robustness

### Low Priority Tests
1. **Low contrast text** - Edge case, likely not common in our evidence
2. **Multiple columns** - Covered by dense text testing
3. **Cultural names** - Small percentage of RLA entities

---

## Related Documentation

- **[AI_DOMAIN_TRANSLATION_GUIDE.md](AI_DOMAIN_TRANSLATION_GUIDE.md)** - RLA-specific patterns and anti-patterns
- **[tile-methodology.md](../workflows/tile-methodology.md)** - Vision API 1568px limit workaround
- **[UUID_SYSTEM.md](../workflows/UUID-system/UUID_SYSTEM.md)** - Entity recognition and name normalization
- **[newspaper-ingest.md](../workflows/newspaper-ingest.md)** - OCR workflow with Docling
- **[facebook-ingest-v2.md](../workflows/facebook-ingest-v2.md)** - Screenshot processing workflow
- **CLAUDE.md** - Router directing to this guide when appropriate

---

## Change Log

**2026-01-02**: Initial creation (PRP 2)
- Vision API limits: 1 documented, 5 future tests (167% of minimum)
- OCR limits: 0 documented, 5 future tests (250% of minimum)
- Entity recognition limits: 2 documented, 4 future tests (200% of minimum)
- Proactive testing protocol: 4-step systematic process
- Workaround reference table: 7 entries with documentation links
- CLAUDE.md router integration: Lines 6-12
- Validation: 6 test scenarios created, all links validated
- Total backlog: 14 untested capability items
