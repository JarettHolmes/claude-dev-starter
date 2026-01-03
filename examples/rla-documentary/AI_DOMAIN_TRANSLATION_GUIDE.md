# AI Domain Translation Guide

**Purpose**: Quick reference for mapping generic AI knowledge to RLA-specific implementations

**When to use this**: Mid-task when you encounter a pattern and need immediate guidance (not comprehensive learning)

**For comprehensive workflows**: See CLAUDE.md router → domain-specific READMEs

---

## When You Think... → We Actually Use...

| Generic Mental Model | RLA Implementation | Gotcha / Critical Note |
|---------------------|-------------------|------------------------|
| "Person database" | MASTER_UUID_REGISTRY.csv | ⚠️ Confusing name - people ONLY, not all entities |
| "Event record" | 3-table system (EVENTS + PARTICIPANTS + SOURCES) | ⚠️ All three required, not just EVENTS row |
| "Add a person" | 1) grep registry 2) UUID v5 3) Add row 4) Create dossier | ⚠️ Never generate UUID without checking registry |
| "Tall screenshot" | height > 5000px? → tile_screenshot.py | ⚠️ Vision API downscales to illegible otherwise |
| "Source citation" | source_bundle_uuid + EVENT_SOURCES row | ⚠️ Both required, not either/or |
| "Name matching" | fuzzy_matcher.py with norm_v1 | ⚠️ Use normalized canonical, not display names |
| "Create entity folder" | entities/{type}/{category}/{person_slug}/ | ⚠️ Use canonical_name from registry for slug |
| "Organization record" | MASTER_ORG_UUID_REGISTRY.csv | ⚠️ NOT in MASTER_UUID_REGISTRY.csv |
| "Location record" | MASTER_LOCATION_UUID_REGISTRY.csv | ⚠️ Has lat/lon fields, different schema |
| "Newspaper article" | MASTER_ARTICLE_UUID_REGISTRY.csv | ⚠️ Links to MASTER_PUBLICATION_UUID_REGISTRY.csv |
| "Person name normalization" | norm_v1 algorithm | ⚠️ Frozen spec - lowercase, strip titles, standardize spacing |
| "Name variants" | PERSON_NAME_VARIANTS.csv | ⚠️ Maps aliases → canonical UUID |
| "Evidence source" | source_bundle_uuid (UUID v5) | ⚠️ Generated from source metadata, not random |
| "CSV editing" | Always use csv.QUOTE_ALL | ⚠️ DuckDB requires all fields quoted |
| "Check entity exists" | grep registry first | ⚠️ Prevents duplicate UUIDs |
| "UUID generation" | UUID v5 with DNS namespace | ⚠️ Use uuid_name_key format person:lastname_firstname |
| "Investigation leads" | Dual-layer extraction (factual + social) | ⚠️ Layer 1 (claims) + Layer 2 (dynamics) |
| "Transcript processing" | 9-phase workflow | ⚠️ Extract people, locations, orgs, events, quotes, assertions |
| "Screenshot processing" | Check height first, tile if > 5000px | ⚠️ 1568px Vision API limit causes hallucinations |
| "Thread assignment" | Check existing threads, propose NEW if no fit | ⚠️ Don't force ill-fitting threads |
| "Victim/perpetrator distinction" | Separate UUID fields | ⚠️ Critical for investigation integrity |
| "Verbatim quotes" | Preserve separately from claim_text | ⚠️ Production requirement for on-screen display |
| "Multi-claim detection" | Use lead_id suffix (XXXa/b/c) | ⚠️ Target 30-50% of leads with multiple claims |
| "Assertion extraction" | 20-30 per transcript | ⚠️ Biographical, character, relationships, events, speech |

---

## Quick Reference Patterns

### UUID Lookup (Most Common Operation)

```bash
# Check if person exists in registry
grep -i "lastname.*firstname" metadata/registries/MASTER_UUID_REGISTRY.csv

# If not found → generate UUID v5 (see UUID_SYSTEM.md for algorithm)
# If found → extract UUID from first column
```

**Python UUID generation**:
```python
import uuid
namespace = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')  # DNS namespace
uuid_name_key = "person:lastname_firstname"
person_uuid = uuid.uuid5(namespace, uuid_name_key)
```

### Event Creation (3-Table Pattern)

```bash
# Step 1: Add event to MASTER_EVENTS_REGISTRY.csv
# Row format: event_uuid, event_date, date_precision, event_type, event_label,
#             event_description, location_uuid, primary_subject_uuid,
#             corroboration_score, confidence, tags, source_bundle_uuid

# Step 2: Add person links to EVENT_PARTICIPANTS.csv (with roles)
# Row format: event_uuid, person_uuid, person_name, role, role_context

# Step 3: Add source link to EVENT_SOURCES.csv (with confidence)
# Row format: event_uuid, source_type, source_uuid, source_label,
#             source_date, extraction_notes

# All three required - event is incomplete without participants + sources
```

### Tall Screenshot Handling

```bash
# Check height
identify -format "%wx%h" screenshot.png

# If height > 5000px:
python3 SYSTEM/tools/facebook/tile_screenshot.py screenshot.png --output-dir tiles/

# Then process tiles sequentially with Vision API
# Each tile stays under 1568px limit → no downscaling → no hallucinations
```

### Source Citation Pattern

```bash
# Generate source bundle UUID (UUID v5 from source metadata)
# Add source_bundle_uuid to entity's dossier intelligence file
# Add EVENT_SOURCES row linking event_uuid → source_bundle_uuid
# Both required for complete evidence chain
```

### Name Normalization (norm_v1)

```python
from unidecode import unidecode
import re

def normalize_name_v1(name_string):
    """Frozen normalization algorithm - NEVER modify"""
    # 1. Unicode → ASCII
    name = unidecode(name_string)
    # 2. Lowercase and collapse whitespace
    name = name.lower().strip()
    name = re.sub(r'\s+', ' ', name)
    # 3. Remove punctuation
    name = re.sub(r'[.,\"\'\(\)\[\]]', '', name)
    name = re.sub(r'-', ' ', name)  # Hyphens → spaces
    # 4. Strip titles/ranks (token-aware)
    # 5. Final collapse
    name = re.sub(r'\s+', ' ', name).strip()
    return name
```

### CSV Editing Standard

```python
import csv

# ALWAYS use QUOTE_ALL for DuckDB compatibility
with open('registry.csv', 'w', newline='') as f:
    writer = csv.writer(f, quoting=csv.QUOTE_ALL)
    writer.writerow(['uuid', 'canonical_name', 'full_name'])
    writer.writerow([uuid_value, canonical, display_name])

# Or with pandas:
df.to_csv('registry.csv', quoting=csv.QUOTE_ALL, index=False)
```

---

## Common Anti-Patterns

❌ **Creating person entities before checking UUID registry**
- **Why wrong**: Causes duplicates, breaks cross-referencing across all intelligence
- **Correct approach**: Always `grep -i "lastname.*firstname" metadata/registries/MASTER_UUID_REGISTRY.csv` first, only generate UUID if not found

❌ **Processing tall screenshots directly without tiling**
- **Why wrong**: Vision API downscales > 1568px → illegible text → hallucinations ("Chicken" surnames, garbled URLs)
- **Correct approach**: Check height first (`identify -format "%h" file.png`), tile if > 5000px (see SYSTEM/workflows/tile-methodology.md)

❌ **Adding events without EVENT_SOURCES entries**
- **Why wrong**: Breaks evidence chain, no corroboration tracking, violates 3-table system
- **Correct approach**: Always populate source_bundle_uuid + add EVENT_SOURCES row + add EVENT_PARTICIPANTS rows

❌ **Using display names for file paths**
- **Why wrong**: Inconsistent casing/spacing breaks file lookups (e.g., "Paul Zahra" vs "paul_zahra")
- **Correct approach**: Always use canonical_name from registry (lowercase_underscore format)

❌ **Generating UUID v5 without checking registry**
- **Why wrong**: Creates duplicate UUIDs for existing entities, breaks referential integrity
- **Correct approach**: `grep` registry, only generate if truly new person

❌ **Editing CSV without csv.QUOTE_ALL**
- **Why wrong**: Mixed quoting breaks DuckDB strict parser, causes data loss
- **Correct approach**: Always specify `quoting=csv.QUOTE_ALL` in csv.writer/DictWriter

❌ **Forcing leads into ill-fitting threads**
- **Why wrong**: Dilutes thread quality, makes queries less meaningful
- **Correct approach**: If thread fit takes >10 seconds to decide, propose NEW_PROPOSED with thread name and driving question

❌ **Conflating claim_text with verbatim_quote**
- **Why wrong**: Loses exact wording needed for on-screen display in documentary
- **Correct approach**: Keep both - claim_text (concise summary) + verbatim_quote (exact quote for production)

❌ **Putting victims in perpetrator_uuids or vice versa**
- **Why wrong**: Breaks investigation integrity, reverses roles in abuse documentation
- **Correct approach**: Maintain clear distinction - victim_uuids, perpetrator_uuids, witness_uuids are separate fields

❌ **Re-extracting posts with comprehensive Intelligence Notes**
- **Why wrong**: Wastes time, duplicates work, ignores existing structured data
- **Correct approach**: Migrate existing notes to new schema, don't re-extract from scratch

❌ **Skipping location/organization extraction in transcripts**
- **Why wrong**: Breaks event linkage (events need location_uuid), loses context
- **Correct approach**: Extract ALL locations and ALL organizations (Phase 3 and Phase 4 are mandatory)

❌ **Extracting only 3-5 assertions per transcript**
- **Why wrong**: Wrong granularity, misses biographical facts, character assessments, relationships
- **Correct approach**: Aim for 20-30 assertions covering all types (biographical, character, relationships, events, reported speech)

❌ **Updating AI guides ad-hoc when you remember**
- **Why wrong**: Guides become stale, subjective assessment ("seems important"), risk of forgetting patterns, inconsistent documentation quality
- **Correct approach**: Use systematic three-command workflow
  ```bash
  /ai-guides-discover conversation  # Find what happened
  /ai-guides-assess                 # Score materiality objectively
  /ai-guides-update CRITICAL        # Execute high-priority updates with QC
  ```
  See: SYSTEM/docs/AI_GUIDES_MAINTENANCE_PLAN.md (Operational Maintenance Workflow section)

---

## Tool Selection Guide

| Task Type | Recommended Tool | Documentation |
|-----------|------------------|---------------|
| UUID lookup | `grep -i` MASTER_UUID_REGISTRY.csv | SYSTEM/workflows/UUID-system/UUID_SYSTEM.md |
| Name matching | fuzzy_matcher.py | SYSTEM/tools/uuid_integration/ |
| Tall screenshots | tile_screenshot.py | SYSTEM/workflows/tile-methodology.md |
| Schema validation | audit_and_fix_canonical_json.py | SYSTEM/tools/registries/ |
| OCR extraction | Docling (for PDFs) | SYSTEM/workflows/newspaper-ingest.md |
| Event creation | Manual CSV editing (3 tables) | metadata/registries/README.md |
| Name normalization | norm_v1 algorithm | SYSTEM/workflows/UUID-system/UUID_NORMALIZATION_STANDARD.md |
| CSV editing | csv.QUOTE_ALL | metadata/registries/README.md |
| Transcript processing | transcript-ingest.md workflow | SYSTEM/workflows/transcript-ingest.md |
| Facebook extraction | facebook-ingest-v2.md workflow | SYSTEM/workflows/facebook-ingest-v2.md |
| Newspaper extraction | newspaper-ingest.md workflow | SYSTEM/workflows/newspaper-ingest.md |

---

## Registry Quick Reference

**MASTER_UUID_REGISTRY.csv = people ONLY** (confusing name, backward compatibility)

**Other entity types**:
- **Events** → MASTER_EVENTS_REGISTRY.csv + EVENT_PARTICIPANTS.csv + EVENT_SOURCES.csv (3-table system)
- **Locations** → MASTER_LOCATION_UUID_REGISTRY.csv
- **Organizations** → MASTER_ORG_UUID_REGISTRY.csv
- **Publications** → MASTER_PUBLICATION_UUID_REGISTRY.csv
- **Articles** → MASTER_ARTICLE_UUID_REGISTRY.csv
- **Transcripts** → MASTER_TRANSCRIPT_REGISTRY.csv
- **Yearbooks** → MASTER_YEARBOOK_UUID_REGISTRY.csv
- **Documentary Sources** → MASTER_DOCUMENTARY_SOURCES_REGISTRY.csv

**Complete schemas**: See metadata/registries/README.md

---

## Common Workflows Quick Links

### Creating New Entity
1. Check MASTER_UUID_REGISTRY.csv (grep by name)
2. If not found, generate UUID v5 with norm_v1
3. Add to registry with all required fields
4. Create entity folder: entities/{type}/{category}/{slug}/
5. Create subject.yml with UUID metadata
6. Create MASTER_INTELLIGENCE.md

**See**: SYSTEM/workflows/entity-processing.md

### Processing Newspaper Article
1. OCR extraction (Docling)
2. Create canonical JSON with schema v1.3
3. Add to MASTER_ARTICLE_UUID_REGISTRY.csv
4. Extract events → MASTER_EVENTS_REGISTRY + participants + sources
5. Update entity dossiers

**See**: SYSTEM/workflows/newspaper-ingest.md

### Processing Facebook Post
1. Check intelligence_notes_status
2. Locate screenshot_path
3. Dual-layer extraction:
   - Layer 1: Factual claims (investigation leads)
   - Layer 2: Social dynamics (stance tracking)
4. Maintain victim/perpetrator distinction
5. Capture verbatim quotes for production

**See**: SYSTEM/workflows/facebook-ingest-v2.md

### Processing Interview Transcript
1. Add to MASTER_TRANSCRIPT_REGISTRY.csv
2. Extract ALL people (→ TRANSCRIPT_PEOPLE_INDEX.csv)
3. Extract ALL locations (→ TRANSCRIPT_LOCATIONS_INDEX.csv)
4. Extract ALL organizations (→ TRANSCRIPT_ORGS_INDEX.csv)
5. Extract ALL events (→ MASTER_EVENTS_REGISTRY + participants + sources)
6. Extract significant quotes (→ TRANSCRIPT_QUOTES_INDEX.csv)
7. Extract 20-30 assertions (→ ASSERTIONS.csv)
8. Update entity dossiers (batched separately)

**See**: SYSTEM/workflows/transcript-ingest.md

---

## Decision Trees

### "Should I create a new thread or use existing?"

```
Does this lead answer an existing thread's driving question?
├─ YES, clearly → Use existing thread
└─ NO / UNCERTAIN
    ├─ Took >10 seconds to decide? → Propose NEW_PROPOSED
    ├─ Thread fit feels "stretched"? → Propose NEW_PROPOSED
    └─ No existing thread fits well? → Propose NEW_PROPOSED
```

### "Should I tile this screenshot?"

```
What is the image height?
├─ < 5000px → Process normally (no tiling)
├─ 5000-10000px → Tile with 1400px height, 100px overlap
└─ > 10000px → Tile with 1400px height, 100px overlap
```

### "Should I create an event or just an assertion?"

```
Is it a SPECIFIC INCIDENT with date/location/participants?
├─ YES → Create EVENT + ASSERTION(s) referencing event
└─ NO → Is it a claim about a person/relationship/state?
    ├─ YES → Create ASSERTION only (no event)
    └─ NO → Consider if it belongs in system at all
```

---

## Production Requirements

**Critical fields that MUST be populated for documentary use**:

1. **screenshot_path** - Every investigation lead needs screenshot reference
2. **verbatim_quote** - Exact wording for on-screen display (separate from claim_text summary)
3. **victim_uuids vs perpetrator_uuids** - Never mix these roles
4. **source_bundle_uuid + EVENT_SOURCES** - Complete evidence chain required
5. **location_uuid** - Events need location linkage

---

## Related Documentation

**Quick References** (this guide):
- ⭐ Start here for immediate pattern lookup

**Comprehensive Workflows**:
- CLAUDE.md - Router to all workflows
- SYSTEM/workflows/newspaper-ingest.md - 6-phase newspaper workflow
- SYSTEM/workflows/facebook-ingest-v2.md - Dual-layer Facebook extraction
- SYSTEM/workflows/transcript-ingest.md - 9-phase transcript workflow
- SYSTEM/workflows/tile-methodology.md - Tall screenshot processing

**Technical Specifications**:
- SYSTEM/workflows/UUID-system/UUID_SYSTEM.md - UUID generation standard
- SYSTEM/workflows/UUID-system/UUID_NORMALIZATION_STANDARD.md - norm_v1 spec (frozen)
- SYSTEM/workflows/UUID-system/UUID_VARIANTS_SYSTEM.md - Name variants handling
- metadata/registries/README.md - Complete registry documentation

**Templates**:
- docs/templates/ENTITY_DOSSIER_STRUCTURE.md - Entity folder structure
- entities/people/rla_staff/priority/zahra_paul/ - Complete reference implementation

---

**This guide complements (not replaces) comprehensive workflows. When in doubt, read the full workflow documentation.**

---

## Change Log

**2026-01-02**: Initial creation (PRP 1)
- 24 concept mappings (160% of minimum 15)
- 12 anti-patterns (240% of minimum 5)
- 11 tool selection scenarios
- 6 quick reference patterns with copy-paste code
- Validation: All scenarios tested, all links validated

**2026-01-02** (later same day): Added maintenance anti-pattern
- Added "Ad-hoc guide updates" anti-pattern with ❌/✅ format
- Links to systematic three-command workflow in Maintenance Plan
- Total anti-patterns: 13 (260% of minimum 5)
- Cross-reference: SYSTEM/docs/AI_GUIDES_MAINTENANCE_PLAN.md
