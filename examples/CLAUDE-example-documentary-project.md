# AGENT ROUTER (EXECUTE FIRST)

Follow this router before any action. Do not explore outside the relevant README.

**IF** task involves UUID lookup, registry operations, or creating entities →
→ **Read `SYSTEM/docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference for project patterns)
→ Then read domain-specific workflow if needed
→ Work in: `metadata/registries/`, `entities/**`

**IF** task involves processing tall screenshots, OCR, or new evidence types →
→ **Check `SYSTEM/docs/AI_CAPABILITIES_AND_LIMITS.md` FIRST** (capability thresholds + workarounds)
→ Then proceed with appropriate workaround
→ Work in: `collections/**`, `investigations/**`

**IF** user asks about AI guides system, maintaining guides, or how to use translation/capabilities guides →
→ **Read `SYSTEM/docs/AI_GUIDES_USAGE_SUMMARY.md` FIRST** (quick start - how system works)
→ **For maintenance**: `SYSTEM/docs/AI_GUIDES_MAINTENANCE_PLAN.md` (when/how to update guides)
→ **Three-command workflow** (systematic maintenance):
  - `/ai-guides-discover [scope]` - Find patterns/limits/anti-patterns after completing work
  - `/ai-guides-assess [item_ids]` - Score materiality with objective framework (40 points)
  - `/ai-guides-update [item_ids]` - Execute updates with quality control
  - See: AI_GUIDES_MAINTENANCE_PLAN.md → "Operational Maintenance Workflow" section
→ **For validation**: Run `bash SYSTEM/tools/maintenance/validate_ai_guides.sh` (monthly health check)
→ **The two guides**:
  - `SYSTEM/docs/AI_DOMAIN_TRANSLATION_GUIDE.md` - Quick pattern lookup (UUID, events, registries)
  - `SYSTEM/docs/AI_CAPABILITIES_AND_LIMITS.md` - Tool limits and workarounds (Vision API, OCR)
→ **Test scenarios**: `PRPs/in-progress/ai-systems-validation-scenarios.md` (validation scenarios)
→ **Implementation history**: `PRPs/in-progress/ai-domain-translation-guide.md`
→ **Key insight**: Guides are living documents - update when workflows change (monthly validation required)

**IF** task mentions sources/evidence/people/orgs/analysis/quotes/selections →
→ **Open `investigations/README.md`** and follow it
→ Work in: `collections/**`, `entities/**`, `investigations/**`

**IF** task mentions decks/scripts/outlines/shoots/production/edits →
→ **Open `production/README.md`** and follow it
→ Work in: `production/**`
→ Note: Operations (budgets/schedules/contracts) in `production/ops/` (private)

**IF** task mentions web app, dashboard, deployment, screening, or viewer portal →
→ **Read `front-end/viewer-portal/README.md` FIRST** - comprehensive tech stack and architecture
→ Work in: `front-end/viewer-portal/`
→ **Live Sites**:
  - `https://app.example.com` - Internal portal (auth protected)
  - `https://public.example.com` - External viewers (email gate)
→ **Stack**: React 18 + TypeScript + Vite + Tailwind + Cloudflare Pages
→ **Video**: Cloudflare Stream + Video.js v10 (`@videojs/react`) with 1080p enforcement
→ **Database**: Cloudflare D1 (viewer access logging)
→ **Auth**: Cloudflare Access for internal, email gate for external viewers
→ **Deployment**: Push to `main` (auto-deploys) or `./deploy.sh`
→ **Key files**: `App.tsx` (routing), `pages/ViewingRoom.tsx` (email gate + video), `data.ts` (content)
→ **PRPs**: `portal-PRPs/in-progress/` for pending feature work

**IF** task mentions video editing software integration, timeline operations, or media import →
→ **Read `SYSTEM/tools/video-editor/README.md`** for complete integration guide
→ **MCP tools for exploration**: Tools to read state/information (mcp__video-editor__*)
→ **Python scripts for actions**: More reliable for taking actions (SYSTEM/tools/video-editor/scripts/)
→ **API documentation**: Check scripting-reference/ to determine capabilities
→ Timeline organization: Multiple timelines, organized bin structure, automated tools
→ Connection: Local video editor instance via MCP server (must be running)

**IF** task mentions message archive analysis, investigation leads, threads, or master indices →
→ **Read `entities/people/subjects/subject_001/interviews/messages/README.md`** for complete system overview
→ **Master indices**: `.../messages/master_indices/` (aggregated data across all periods)
  - `MESSAGES_LEADS_MASTER.csv` - Investigation leads with threading
  - `MESSAGES_THREADS_MASTER.csv` - Investigation threads (T001-T028+)
  - `MESSAGES_PATTERNS_MASTER.csv` - Pattern tracking from research
  - `MESSAGES_PEOPLE_UUID_INDEX.csv` - Person-to-UUID mappings
  - `MESSAGES_SOURCE_CHAINS_MASTER.csv` - Evidence chains to raw messages
→ Work in: `.../messages/master_indices/` for aggregated queries, `.../messages/processed/{period}/` for period data

**IF** task mentions retrieving exact message text for display →
→ **Read `entities/people/subjects/subject_001/interviews/messages/documentation/TEXT_REFERENCING_GUIDE.md`**
→ Work in: `entities/people/subjects/subject_001/interviews/messages/processed/{period}/`
→ Retrieval: investigation_leads.csv → source_chains.csv → {period}_COMPLETE.csv (exact text)

**IF** task mentions interview selects, transcript selects, or interview review status →
→ **Command**: `/project:transcript-selects {subject} {next|filename}` to process transcripts
→ **Processing Queue**:
  1. `subject_001`: **COMPLETE** (37/37 transcripts, 288 selects) - `entities/people/subjects/subject_001/interviews/`
  2. `subject_002`: **IN PROGRESS** (0/59 transcripts) - `entities/people/subjects/subject_002/interviews/`
→ Each subject has: `PROCESSING_STATUS.md` (tracking), `{NAME}_SELECTS.csv` (output)
→ Use `next` to auto-detect next unreviewed transcript across all subjects

**IF** task mentions audio transcription status, audio inventory, or which recordings need transcribing →
→ **Read `production/media/audio/recordings/TRANSCRIPTION_STATUS.md`** for complete status report
→ **Files**: `TRANSCRIPTION_TODO.csv` (prioritized list), `AUDIO_INVENTORY.csv` (all files)
→ Work in: `production/media/audio/recordings/`
→ Transcripts stored in: `entities/people/{person}/interviews/{type}/` (phone, video, online_meeting)
→ Status: Example - 199/297 audio files transcribed (67%), 98 files pending
→ **Registry**: `metadata/registries/MASTER_TRANSCRIPT_REGISTRY.csv`
→ **Backfill tool**: `SYSTEM/tools/registries/backfill_transcript_registry.py` (auto-register new transcripts)

**IF** task mentions video meeting transcription status or which meetings need transcribing →
→ **Read `production/media/MEETING_TRANSCRIPTION_STATUS.md`** for complete status report
→ **Media Manifest**: `production/media/Project_Media_Manifest.csv` (filter by type, check "Transcribed" column)
→ **Registry**: `metadata/registries/MASTER_TRANSCRIPT_REGISTRY.csv` (filter interview_type = "online_meeting")
→ **Source files**: Subtitle tracks directory (SRT subtitle files)
→ **Video files**: Video recordings directory (MP4 recordings)
→ Status: Example - 15/26 meetings transcribed (57.7%), 11 pending
→ Transcripts stored in: `entities/people/{person}/interviews/online_meeting/`
→ **Transcription tool**: `SYSTEM/tools/transcription/transcriber.py` (with speaker diarization)

**IF** task mentions transcribing audio files, speech-to-text, or vocabulary boost →
→ **Read `SYSTEM/tools/transcription/QUICKSTART.md`** for quick start guide
→ **Read `SYSTEM/tools/transcription/README.md`** for complete documentation
→ **Tool**: `SYSTEM/tools/transcription/transcriber.py` (with custom vocabulary)
→ **Vocabulary**: Custom terms max (people, orgs, locations, core terms) - auto-generated from registries
→ **Features**: Speaker diarization, word boost, multi-format output (JSON/TXT/MD)
→ **Usage**: `python SYSTEM/tools/transcription/transcriber.py audio.m4a`

**IF** task mentions entity dossiers/profiles/intelligence →
→ **Read `docs/templates/ENTITY_DOSSIER_STRUCTURE.md`** for complete template
→ Work in: `entities/people/{category}/{person_slug}/`
→ Reference: `entities/people/staff/priority/person_001/` (complete example)

**IF** task mentions ingesting documents, social posts, transcripts, or profiles →
→ **Read `SYSTEM/workflows/document-ingest.md`** for document ingestion workflow
→ **Read `investigations/project_master/analyses/documents/batches/README.md`** for batch processing
→ **Read `SYSTEM/workflows/social-ingest-v2.md`** for social media ingestion (dual-layer extraction)
→ **Read `SYSTEM/workflows/tile-methodology.md`** for processing oversized screenshots (Vision API limits)
→ **Read `SYSTEM/workflows/transcript-ingest.md`** for transcript ingestion workflow
→ **Read `SYSTEM/workflows/profile-ingest.md`** for profile ingestion workflow
→ These are the authoritative processes for adding new evidence

**IF** task mentions social media posts/extraction/processing →
→ **⭐ PRIMARY COMMAND: `/social-process-next [batch_size]`** - Automated post-by-post processing
  - Finds next unprocessed post automatically
  - Guides through complete extraction workflow
  - Updates registry automatically with processing status
  - Progress tracking: X/total posts complete
  - **Helper script**: `SYSTEM/tools/social/process_post.py` (CSV operations + alias registry management)
    - **Alias functions**: `check-alias`, `add-alias`, `update-alias-count`, `list-unmatched`
  - **Command file**: `.claude/commands/project/social-process-next.md` (complete instructions)
→ **⭐ WORKFLOW REFERENCE: `SYSTEM/workflows/social-ingest-v2.md`** (canonical v2 dual-layer extraction)
  - Phase 1: Pre-processing setup (load threads, UUIDs, check alias registry FIRST, actor registry, content)
  - Phase 2: Layer 1 - Factual claims extraction (multi-claim detection, thread assignment)
  - Phase 3: Layer 2 - Social dynamics (stance tracking, interactions)
  - Phase 4: Source chains construction (traceability to exact text)
  - Phase 5: Entity profile updates (credibility tracking)
  - Phase 6: Validation (UUID verification 100%, coverage 100%)
  - Phase 7: Output files (append to staging CSVs, update registry)
→ **Status tracking**: `investigations/.../social_posts/v2_extraction/staging/EXTRACTION_STATUS.md`
→ **Active workspace**: `investigations/.../social_posts/v2_extraction/staging/`
  - `SOCIAL_INVESTIGATION_LEADS.csv` - Investigation leads
  - `SOCIAL_SOURCE_CHAINS.csv` - Traceability to exact text
  - `SOCIAL_PROFILE_DATA.csv` - Profile metadata
  - `SOCIAL_ACTOR_STANCES.csv` - Social dynamics tracking
  - `SOCIAL_POSTS_REGISTRY.csv` - Processing status
  - `SOCIAL_ACTOR_ALIASES.csv` - **PRIMARY ALIAS REGISTRY**: Display names → person UUIDs
    - Check this FIRST before master UUID registry for any name
    - Tracks appearance counts (prioritizes high-frequency actors)
→ **Progress**: X/total posts processed, Y remaining
→ **Critical registries** (always verify against these):
  - `metadata/registries/MASTER_UUID_REGISTRY.csv` - Person UUIDs - grep for EVERY person
  - `entities/.../messages/master_indices/MESSAGES_THREADS_MASTER.csv` - Thread IDs
  - `SOCIAL_ACTOR_ALIASES.csv` - **Check names FIRST** before master registry

**IF** task mentions messaging platform analysis/channels/workspace/processing data →
→ **Read `investigations/project_master/analyses/messaging/README.md`** for processing workflow
→ **Threads registry**: `investigations/project_master/analyses/messaging/THREADS_MASTER.csv`
→ **Commands**:
  - `/messaging-week-process` - Process one week of messages
  - `/messaging-week-validate` - Validate processing quality
  - `/messaging-month-canonical` - Create month canonical after all weeks
→ **Processing Status**: Messages across multiple weeks processed
→ Work in: `investigations/project_master/analyses/messaging/processed/`
→ Source data: `collections/messaging/` (raw export, user mapping)

**IF** task mentions corporate governance, board members, or corporate officers →
→ **Read `SYSTEM/workflows/corporate-intelligence-integration.md`** for corporate entity updates
→ Work in: `metadata/indices/corporate/`, `entities/.../dossier/corporate/`, `investigations/.../corporate/`

**IF** task mentions processing entities or UUID integration →
→ **Read `SYSTEM/workflows/entity-processing.md`** for entity workflows
→ **Read `SYSTEM/workflows/uuid-integration.md`** for UUID integration workflow (7 steps)
→ **Read `SYSTEM/workflows/UUID-system/UUID_SYSTEM.md`** for UUID generation/specification
→ These cover entity processing, UUID matching, and UUID generation standards

**IF** task mentions registries, UUIDs, or working with master data →
→ **⚠️ MANDATORY: Read `metadata/registries/README.md` FIRST** (registry authority, schemas, usage, maintenance)
→ **This is required reading** for any registry-related work - contains current counts, schemas, validation
→ Work in: `metadata/registries/` (master registries + event system)

**IF** general/exploratory task →
→ Continue reading this file

**AFTER completing significant work** (UUID lookups, event creation, processing, registry updates) →
→ **Consider running**: `/ai-guides-discover conversation` to find patterns worth documenting
→ **Then**: `/ai-guides-assess` to score materiality (CRITICAL items = update immediately)
→ **Purpose**: Prevent guide staleness, capture patterns while fresh, systematic maintenance
→ **Don't run if**: One-off task, already documented, trivial operation (<30s impact)

**ALWAYS respect repo rules**:
- No camera masters in Git
- No new OCR (existing OCR in `investigations/project_master/analyses/[source_type]/ocr/`)
- No source datasets under `production/**`
- Minimize tokens: read only the README relevant to the task, then local directory tree
- **CSV QUOTING STANDARD**: All registry CSVs MUST use `csv.QUOTE_ALL` for database compatibility
  - When writing CSVs: Always specify `quoting=csv.QUOTE_ALL` in csv.writer/DictWriter
  - When using pandas: Use `.to_csv(..., quoting=csv.QUOTE_ALL)`
  - Mixed quoting breaks strict parsers

---

# CLAUDE.md

Agent instructions for working in the documentary project evidence repository.

## Project Mission

Master evidence and narrative development repository for a documentary project - an investigative feature film. Intelligence system tracks person entities (UUID-based), archival documents, court/coroner documents, media articles, events registry, assertions, social media intelligence, profiles, corporate governance, and interview transcripts. **See `STATUS.md`** for complete completion status and frozen datasets.

---

## Critical Standards

### UUID System

**Critical Standard**: All person records use **UUID v5** (RFC 4122) as primary identifier for cross-referencing across all intelligence sources.

**Complete Specification**: `SYSTEM/workflows/UUID-system/` (3 technical docs)
- `UUID_SYSTEM.md` - Complete UUID generation standard, usage guide, subject.yml requirements
- `UUID_NORMALIZATION_STANDARD.md` - Normalization algorithm specification (frozen)
- `UUID_VARIANTS_SYSTEM.md` - Name variants table schema and management

**UUID Authority**: `metadata/registries/` - Master registries + event system

⚠️ **For registry work**: **Read `metadata/registries/README.md` FIRST** (mandatory prerequisite)
- Complete registry list, schemas, current counts
- Usage guidelines, validation, maintenance
- Foreign key relationships, integration points

**subject.yml Requirement** - All person entities MUST include:
```yaml
uuid: "xxxxxxxx-xxxx-5xxx-xxxx-xxxxxxxxxxxx"
uuid_source: "registry_name"
uuid_name_key: "person:lastname_firstname"
canonical_name: "lastname_firstname"
```

**When creating entities**:
1. Read `metadata/registries/README.md` for usage guidelines
2. Check appropriate registry
3. If not found, generate UUID v5 (see `UUID_SYSTEM.md`)
4. Add UUID fields to entity metadata
5. Update appropriate registry

### Repository Rules

- No camera masters in Git
- No new OCR (existing OCR in designated directories)
- No source datasets under `production/**`
- Minimize tokens: read only the README relevant to the task
- **CSV QUOTING**: All registry CSVs MUST use `csv.QUOTE_ALL` for database compatibility

---

## Repository Structure (ICIJ/OCCRP Architecture)

```
project/
├── collections/          # IMMUTABLE SOURCES (raw files only)
│   ├── legal_court/, legal_coroner/
│   ├── media/documents/
│   ├── social_media/
│   └── official/         # Archives, corporate, email, handbooks
│
├── entities/             # CANONICAL DOSSIERS
│   └── people/{person_slug}/
│       ├── README.md, subject.yml
│       ├── interviews/   # If interview subject
│       └── dossier/      # Intelligence folder
│           ├── MASTER_INTELLIGENCE.md  ⭐ Canonical truth
│           ├── BIOGRAPHICAL_TIMELINE.csv
│           ├── documents/, social/, profiles/, corporate/, interviews/
│
├── investigations/       # DERIVED DATA & ANALYSIS
│   └── project_master/analyses/  # Mirrors collections/ (1:1 traceability)
│       ├── legal_court/, legal_coroner/
│       ├── media/documents/{ocr,quotes}
│       └── patterns/, themes/, selections/, story/
│
├── metadata/             # STRUCTURED REFERENCE DATA (ICIJ/OCCRP)
│   ├── registries/       # ⭐ UUID AUTHORITIES (master registries)
│   ├── indices/          # Cross-reference tables (articles↔entities)
│   ├── corporate/        # Corporate records metadata
│   └── assertions/       # Claims tracking
│
├── production/           # CREATIVE DELIVERABLES
│   └── {development,shoots,footage,transcripts,ops}/
│
└── SYSTEM/               # TECHNICAL INFRASTRUCTURE
    ├── docs/             # System maps, setup guides, context
    ├── tools/            # Processing scripts
    ├── workflows/        # ⭐ Complete workflow documentation
    └── readmodels/       # Pre-built queries
```

**⚠️ For registry details**: See `metadata/registries/README.md`

---

## Architecture Principles

**`collections/**` = Immutable Sources**
- Raw files as received/downloaded (PDFs, JSON, images)
- No OCR, no analysis outputs

**`investigations/**` = Reproducible Analysis**
- OCR extraction (versioned: attempts, canonical, superseded)
- Thematic analysis, pattern identification
- **Mirrors `collections/` structure for 1:1 traceability**

**`metadata/**` = Structured Reference Data (ICIJ/OCCRP)**
- **Registries**: UUID authorities (person, org, publication IDs)
- **Indices**: Cross-reference tables (entity-to-article links)
- **Corporate**: Corporate records metadata
- **Assertions**: Claims tracking

**Data Flow Examples**:
- OCR: `collections/{source}.pdf → investigations/.../ocr/ → canonical.md`
- Documents: `collections/documents/ → ocr/ → metadata/indices/ → entities/.../dossier/documents/`

---

## Standard Workflows

**Ingesting New Evidence**:
- **Documents**: `SYSTEM/workflows/document-ingest.md` (multi-phase workflow)
- **Social Posts**: `/social-process-next` command (automated) OR `SYSTEM/workflows/social-ingest-v2.md` (manual reference)
- **Interview Transcripts**: `SYSTEM/workflows/transcript-ingest.md` (multi-phase workflow)
- **Profiles**: `SYSTEM/workflows/profile-ingest.md` (multi-phase workflow)
- **Corporate Intelligence**: `SYSTEM/workflows/corporate-intelligence-integration.md` (entity updates)

**Entity Processing**:
- **Complete Guide**: `SYSTEM/workflows/entity-processing.md`
- **UUID Integration**: `SYSTEM/workflows/uuid-integration.md` (7-step process)

---

## Command System

**How Commands Work**:
- Commands in `.claude/commands/` (markdown files with YAML frontmatter)
- Access via `/` prefix (e.g., `/document-profile-generate "Person Name"`)
- **ALWAYS use commands when available** - don't recreate functionality

**Essential Commands**:
```bash
/social-process-next [batch_size]          # Process next unprocessed social post(s)
/document-profile-generate "{Name}"        # Generate document profile
/master-intelligence-update "{Subject}"    # Consolidate all intelligence
/transcript-process [path]                 # Full analysis pipeline
/messaging-week-process "{month}" {week}   # Process messaging week
/messaging-week-validate {week_path}       # Validate week processing
```

**Full Command Library**: `.claude/commands/project/` and `.claude/commands/project/README.md`

---

## Critical Documents

### Master Context Files
- `README.md` - Project overview (human onboarding)
- `CLAUDE.md` - This file (agent instructions)
- `docs/templates/ENTITY_DOSSIER_STRUCTURE.md` - ⭐ Standard template for all entities

### Router READMEs
- `investigations/README.md` - Analysis workspace router
- `production/README.md` - Creative production router

### Reference Implementation
- `entities/people/staff/priority/person_001/` - ⭐ Complete template (use for structure reference)

---

**This is an investigative documentary repository**. Every piece of data matters. Track everything, verify everything, maintain evidence chain.

**When in doubt**:
1. Check router at top of this file for correct README
2. Read `MASTER_INTELLIGENCE.md` for person context
3. Check if command exists (`.claude/commands/`)
4. Reference template entity structure
5. Read project context documentation for ethics and principles
