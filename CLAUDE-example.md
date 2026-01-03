# AGENT ROUTER (EXECUTE FIRST)

Follow this router before any action. Do not explore outside the relevant README.

**IF** task involves UUID lookup, registry operations, or creating entities →
→ **Read `SYSTEM/docs/AI_DOMAIN_TRANSLATION_GUIDE.md` FIRST** (quick reference for RLA patterns)
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
→ **Test scenarios**: `PRPs/in-progress/ai-systems-validation-scenarios.md` (6 validation scenarios)
→ **Implementation history**: `PRPs/in-progress/ai-domain-translation-guide.md` + `ai-capabilities-integration.md`
→ **Key insight**: Guides are living documents - update when workflows change (monthly validation required)

**IF** task mentions sources/evidence/people/orgs/analysis/quotes/selections →
→ **Open `investigations/README.md`** and follow it
→ Work in: `collections/**`, `entities/**`, `investigations/**`

**IF** task mentions decks/scripts/outlines/shoots/production/edits →
→ **Open `production/README.md`** and follow it
→ Work in: `production/**`
→ Note: Operations (budgets/schedules/contracts) in `production/ops/` (private)

**IF** task mentions Producer Hub, web app, dashboard, Cloudflare, deployment, screening, mobile, or the marchontheacademy site →
→ **Read `front-end/rla-producer-hub/README.md` FIRST** - comprehensive tech stack and architecture
→ Work in: `front-end/rla-producer-hub/`
→ **Live Sites**:
  - `https://marchontheacademy.com` - Producer hub (Cloudflare Access auth)
  - `https://watch.marchontheacademy.com` - External viewers (email gate → D1 logged)
→ **Stack**: React 18 + TypeScript + Vite + Tailwind + Cloudflare Pages
→ **Video**: Cloudflare Stream + Video.js v10 (`@videojs/react`) with 1080p enforcement
→ **Database**: Cloudflare D1 (viewer access logging)
→ **Auth**: Cloudflare Access for producers, email gate for external viewers (no passwords in code)
→ **Deployment**: Push to `main` (auto-deploys) or `./deploy.sh`
→ **Key files**: `App.tsx` (routing), `pages/ScreeningRoom.tsx` (email gate + video), `data.ts` (content)
→ **PRPs**: `producer-hub-PRPs/in-progress/` for pending feature work

**IF** task mentions DaVinci Resolve, timeline operations, video editing, or media import →
→ **Read `SYSTEM/tools/davinci/README.md`** for complete DaVinci integration guide
→ **MCP tools for exploration**: 14 tools to read state/information (mcp__davinci-resolve__*)
→ **Python scripts for actions**: More reliable for taking actions (SYSTEM/tools/davinci/scripts/)
→ **API documentation**: Check scripting-reference/ to determine capabilities and implementation
→ Timeline organization: 208 timelines, 11-category bin structure, automated movement tools
→ Connection: Local DaVinci Resolve instance via MCP server (must be running)

**IF** task mentions iMessage investigation leads, threads, deaths, patterns, or master indices →
→ **Read `entities/people/rla_alumni/longfield_ian/interviews/imessage/README.md`** for complete system overview
→ **Master indices**: `.../imessage/master_indices/` (aggregated data across all months)
  - `IMESSAGE_LEADS_MASTER.csv` - 1000+ investigation leads with threading
  - `IMESSAGE_THREADS_MASTER.csv` - 28 investigation threads (T001-T028)
  - `IMESSAGE_DEATHS_MASTER.csv` - Mortality tracking from iMessage research
  - `IMESSAGE_PEOPLE_UUID_INDEX.csv` - Person-to-UUID mappings
  - `IMESSAGE_SOURCE_CHAINS_MASTER.csv` - Evidence chains to raw messages
→ Work in: `.../imessage/master_indices/` for aggregated queries, `.../imessage/processed/{month}/` for monthly data

**IF** task mentions retrieving exact iMessage text for on-screen display →
→ **Read `entities/people/rla_alumni/longfield_ian/interviews/imessage/documentation/TEXT_REFERENCING_GUIDE.md`** for complete retrieval workflows
→ Work in: `entities/people/rla_alumni/longfield_ian/interviews/imessage/processed/{month}/`
→ Retrieval: investigation_leads.csv → source_chains.csv → {month}_PASS3_COMPLETE.csv (exact text)

**IF** task mentions documentary selects, transcript selects, or interview review status →
→ **Command**: `/documentary:transcript-selects {subject} {next|filename}` to process transcripts
→ **Processing Queue**:
  1. `holmes_evan`: **COMPLETE** (37/37 transcripts, 288 selects) - `entities/people/rla_alumni/holmes_evan/interviews/`
  2. `merrick_peter`: **IN PROGRESS** (0/59 transcripts) - `entities/people/rla_alumni/merrick_peter/interviews/`
→ Each subject has: `PROCESSING_STATUS.md` (tracking), `{NAME}_SELECTS.csv` (output)
→ Use `next` to auto-detect next unreviewed transcript across all subjects

**IF** task mentions phone call transcription status, audio inventory, or which calls need transcribing →
→ **Read `production/media/audio/phone_calls/TRANSCRIPTION_STATUS.md`** for complete status report
→ **Files**: `TRANSCRIPTION_TODO.csv` (prioritized list), `AUDIO_INVENTORY.csv` (all files), `analyze_transcription_status.py` (regenerate analysis)
→ Work in: `production/media/audio/phone_calls/`
→ Transcripts stored in: `entities/people/{person}/interviews/{type}/` (phone, video, google_meet)
→ Status: 199/297 audio files transcribed (67%), 98 files pending (~37.5 hours)
→ **Registry**: `metadata/registries/MASTER_TRANSCRIPT_REGISTRY.csv` (162 transcripts: 149 phone, 12 Google Meet, 1 video)
→ **Backfill tool**: `SYSTEM/tools/registries/backfill_transcript_registry.py` (auto-register new transcripts)

**IF** task mentions Google Meet transcription status, video meetings, or which Google Meets need transcribing →
→ **Read `production/media/GOOGLE_MEET_TRANSCRIPTION_STATUS.md`** for complete status report
→ **Media Manifest**: `production/media/RLA_Media_Manifest_Enriched.csv` (filter Card_ID starting with "GM", check "Transcribed" column)
→ **Registry**: `metadata/registries/MASTER_TRANSCRIPT_REGISTRY.csv` (filter interview_type = "google_meet")
→ **Source files**: `/Volumes/RLA_MASTER_WORK/SUBTITLE TRACKS/` (SRT subtitle files)
→ **Video files**: `/Users/ritual/Projects/Development/rla-transcripts/media/video_meetings/raw/` (MP4 recordings)
→ Status: 15/26 Google Meets transcribed (57.7%), 11 pending
→ Transcripts stored in: `entities/people/{person}/interviews/google_meet/`
→ **Transcription tool**: `SYSTEM/tools/transcription/rla_transcriber.py` (AssemblyAI with speaker diarization)
→ **Migration tool**: `SYSTEM/tools/transcripts/migrate_google_meet_transcripts.py` (convert .docx → .md)

**IF** task mentions transcribing audio files, AssemblyAI, or RLA vocabulary boost →
→ **Read `SYSTEM/tools/transcription/QUICKSTART.md`** for quick start guide (ready to use!)
→ **Read `SYSTEM/tools/transcription/README.md`** for complete documentation
→ **Tool**: `SYSTEM/tools/transcription/rla_transcriber.py` (AssemblyAI with 1,000 RLA terms)
→ **Vocabulary**: 1,000 terms max (725 people, 231 orgs, 18 locations, 27 core) - auto-generated from registries
→ **Features**: Speaker diarization, word boost, multi-format output (JSON/TXT/MD)
→ **Status**: ✅ API key configured, ready to transcribe 98 pending files (~37.5 hours, ~$9.38)
→ **Usage**: `python SYSTEM/tools/transcription/rla_transcriber.py audio.m4a`

**IF** task mentions entity dossiers/profiles/intelligence →
→ **Read `docs/templates/ENTITY_DOSSIER_STRUCTURE.md`** for complete template
→ Work in: `entities/people/{category}/{person_slug}/`
→ Reference: `entities/people/rla_staff/priority/zahra_paul/` (complete example)

**IF** task mentions ingesting newspapers, Facebook posts, transcripts, or LinkedIn →
→ **Read `SYSTEM/workflows/newspaper-ingest.md`** for newspaper ingestion (canonical workflow)
→ **Read `investigations/rla_master/analyses/media/newspapers/batches/README.md`** for batch processing (batches 42+, current workspace)
→ **Read `investigations/rla_master/analyses/incidents/rla-genesis/GENESIS_WORKFLOW_DOCUMENTATION.md`** for historical reference (batches 10-41, archived)
→ **Read `SYSTEM/workflows/facebook-ingest-v2.md`** for Facebook ingestion (dual-layer extraction workflow)
→ **Read `SYSTEM/workflows/tile-methodology.md`** for processing oversized screenshots (Vision API 1568px limit)
→ **Read `SYSTEM/workflows/transcript-ingest.md`** for transcript ingestion (canonical workflow)
→ **Read `SYSTEM/workflows/linkedin-ingest.md`** for LinkedIn profile ingestion (canonical workflow)
→ These are the authoritative processes for adding new evidence of these types

**IF** task mentions Facebook posts/extraction/processing →
→ **⭐ PRIMARY COMMAND: `/facebook-process-next [batch_size]`** - Automated post-by-post processing
  - Finds next unprocessed post automatically (comprehensive → partial → none priority)
  - Guides through complete 7-phase v2 extraction workflow
  - Updates registry automatically with processing status
  - Progress tracking: X/1,605 posts complete
  - **Helper script**: `SYSTEM/tools/facebook/process_facebook_post.py` (mechanical CSV operations + alias registry management)
    - **Alias functions**: `check-alias`, `add-alias`, `update-alias-count`, `list-unmatched` - manage Facebook name → UUID mappings
  - **Command file**: `.claude/commands/documentary/facebook-process-next.md` (complete instructions)
→ **⭐ WORKFLOW REFERENCE: `SYSTEM/workflows/facebook-ingest-v2.md`** (canonical v2 dual-layer extraction)
  - Phase 1: Pre-processing setup (load threads, UUIDs, **check alias registry FIRST**, actor registry, post content)
  - Phase 2: Layer 1 - Factual claims extraction (multi-claim detection, thread assignment)
  - Phase 3: Layer 2 - Social dynamics (stance tracking, interactions)
  - Phase 4: Source chains construction (traceability to exact text)
  - Phase 5: Witness profile updates (testimony credibility tracking)
  - Phase 6: Validation (UUID verification 100%, screenshot coverage 100%)
  - Phase 7: Output files (append to staging CSVs, update registry)
→ **Status tracking**: `investigations/.../facebook_posts/v2_extraction/staging/EXTRACTION_STATUS.md`
→ **Active workspace**: `investigations/.../facebook_posts/v2_extraction/staging/`
  - `FACEBOOK_INVESTIGATION_LEADS.csv` - Investigation leads (like iMessage/Slack)
  - `FACEBOOK_SOURCE_CHAINS.csv` - Traceability to exact text
  - `FACEBOOK_WITNESS_PROFILES.csv` - Witness metadata
  - `FACEBOOK_ACTOR_STANCES.csv` - Social dynamics tracking
  - `FACEBOOK_POSTS_REGISTRY.csv` - Processing status (1,605 posts)
  - `FACEBOOK_ACTOR_ALIASES.csv` - **PRIMARY ALIAS REGISTRY**: Facebook display names → person UUIDs (170 actors: 31 matched, 139 pending)
    - Check this FIRST before master UUID registry for any Facebook name
    - Tracks appearance counts (prioritizes high-frequency actors for matching)
    - 45 current actors + 125 legacy imports from old extraction
→ **Progress (Jan 2026)**: 8/1,605 posts processed (0.5%), 1,597 remaining
  - Next unprocessed: Post ID 10163405764979175 (Philip Poon, 2025-03-17, status: comprehensive)
  - Priority: Migrate existing comprehensive notes first (don't re-extract)
→ **Critical registries** (always verify against these):
  - `metadata/registries/MASTER_UUID_REGISTRY.csv` - Person UUIDs (3,259 people) - grep for EVERY person
  - `entities/.../imessage/master_indices/IMESSAGE_THREADS_MASTER.csv` - Thread IDs (T001-T048+)
  - `FACEBOOK_ACTOR_ALIASES.csv` - **Check Facebook names FIRST** before master registry (avoids re-research, builds institutional knowledge)
→ **⚠️ OLD EXTRACTION ARCHIVED**: `metadata/indices/facebook_ARCHIVED_2025-01-02/`
  - DO NOT USE - historical reference only
  - 11,469 person mentions from previous methodology
  - v2 outputs will eventually replace this in `metadata/indices/facebook/`

**IF** task mentions Slack messages/channels/workspace/processing Slack data →
→ **Read `investigations/rla_master/analyses/slack/README.md`** for processing workflow and status
→ **Threads registry**: `investigations/rla_master/analyses/slack/SLACK_THREADS_MASTER.csv` (separate from iMessage)
→ **Commands**:
  - `/slack-week-process` - Process one week of messages
  - `/slack-week-validate` - Validate processing quality
  - `/slack-month-canonical` - Create month canonical after all weeks
→ **Processing Status (Dec 2025)**: 3,618 messages across 47 weeks; Dec 2024 + Jan-Feb 2025 processing underway
→ Work in: `investigations/rla_master/analyses/slack/all-rla-alumni-2025/processed/`
→ Source data: `collections/slack/` (raw export, user mapping)

**IF** task mentions corporate governance, board members, or corporate officers →
→ **Read `SYSTEM/workflows/corporate-intelligence-integration.md`** for corporate entity updates
→ Work in: `metadata/indices/corporate/`, `entities/.../dossier/corporate/`, `investigations/.../corporate/`

**IF** task mentions processing entities or UUID integration →
→ **Read `SYSTEM/workflows/entity-processing.md`** for entity workflows (staff, alumni, evidence)
→ **Read `SYSTEM/workflows/uuid-integration.md`** for UUID integration workflow (7 steps)
→ **Read `SYSTEM/workflows/UUID-system/UUID_SYSTEM.md`** for UUID generation/specification
→ These cover entity processing, UUID matching, and UUID generation standards

**IF** task mentions registries, UUIDs, or working with master data →
→ **⚠️ MANDATORY: Read `metadata/registries/README.md` FIRST** (registry authority, schemas, usage, maintenance)
→ **This is required reading** for any registry-related work - contains current counts, schemas, validation guidelines
→ Work in: `metadata/registries/` (7 master registries + 3-table event system)

**IF** general/exploratory task →
→ Continue reading this file

**AFTER completing significant work** (UUID lookups, event creation, screenshot processing, registry updates) →
→ **Consider running**: `/ai-guides-discover conversation` to find patterns worth documenting
→ **Then**: `/ai-guides-assess` to score materiality (CRITICAL items = update immediately)
→ **Purpose**: Prevent guide staleness, capture patterns while fresh, systematic maintenance
→ **Don't run if**: One-off task, already documented, trivial operation (<30s impact)

**ALWAYS respect repo rules**:
- No camera masters in Git
- No new OCR (existing OCR in `investigations/rla_master/analyses/[source_type]/ocr/` - use Docling)
- No source datasets under `production/**`
- Minimize tokens: read only the README relevant to the task, then local directory tree
- **CSV QUOTING STANDARD**: All registry CSVs MUST use `csv.QUOTE_ALL` for DuckDB compatibility
  - When writing CSVs: Always specify `quoting=csv.QUOTE_ALL` in csv.writer/DictWriter
  - When using pandas: Use `.to_csv(..., quoting=csv.QUOTE_ALL)`
  - Mixed quoting breaks DuckDB strict parser
  - See: `SYSTEM/tools/registries/repair_csv_quoting_comprehensive.py` for reference

---

# CLAUDE.md

Agent instructions for working in the RLA documentary evidence repository.

## Project Mission

Master evidence and narrative development repository for the Robert Land Academy documentary - an investigative feature film examining 40+ years of Canada's only private military boarding school for boys. Intelligence system tracks 2,940 person entities (UUID-based), 40+ years of yearbooks, court/coroner documents, newspaper articles, events registry (2,206 events), assertions, Facebook intelligence, LinkedIn profiles, corporate governance, mortality analysis, and interview transcripts. **See `STATUS.md`** for complete completion status and frozen datasets.

---

## Critical Standards

### UUID System (October-November 2025)

**Critical Standard**: All person records use **UUID v5** (RFC 4122) as primary identifier for cross-referencing across all intelligence sources.

**Complete Specification**: `SYSTEM/workflows/UUID-system/` (3 technical docs)
- `UUID_SYSTEM.md` - Complete UUID generation standard, usage guide, subject.yml requirements
- `UUID_NORMALIZATION_STANDARD.md` - norm_v1 algorithm specification (frozen)
- `UUID_VARIANTS_SYSTEM.md` - Name variants table schema and management

**UUID Authority**: `metadata/registries/` - 7 master registries + 3-table event system

⚠️ **For registry work**: **Read `metadata/registries/README.md` FIRST** (mandatory prerequisite)
- Complete registry list, schemas, current counts
- Usage guidelines, validation, maintenance
- Foreign key relationships, integration points

**subject.yml Requirement** - All person entities MUST include:
```yaml
uuid: "xxxxxxxx-xxxx-5xxx-xxxx-xxxxxxxxxxxx"
uuid_source: "staff_roster"  # OR "corporate_generated" | "newly_generated"
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
- No new OCR (existing OCR in `investigations/rla_master/analyses/[source_type]/ocr/` - use Docling)
- No source datasets under `production/**`
- Minimize tokens: read only the README relevant to the task
- **CSV QUOTING**: All registry CSVs MUST use `csv.QUOTE_ALL` for DuckDB compatibility

---

## Git Worktree Setup (January 2026)

**Purpose**: Enable parallel work on different evidence types without branch switching or file conflicts.

### Active Worktrees

This repository uses **git worktrees** for specialized parallel workflows:

| Worktree | Location | Branch | Size | Purpose |
|----------|----------|--------|------|---------|
| **Main** | `rla-story-dev/` | `main` | 27GB | Primary repository (complete) |
| **Slack** | `rla-story-dev-slack/` | `feature/slack-processing-2026` | 1.3GB | Slack message processing |
| **iMessage** | `rla-story-dev-imessage/` | `feature/imessage-processing-2026` | 2.2GB | iMessage analysis |
| **Facebook** | `rla-story-dev-facebook/` | `feature/facebook-processing-2026` | 6.3GB | Facebook post processing |
| **Producer** | `rla-story-dev-producer/` | `feature/producer-hub-2026` | 2.1GB | Producer Hub web app |

### Worktree Contents (Optimized)

Each worktree contains **only** files needed for its specific purpose:

**All worktrees include:**
- `metadata/registries/` - UUID authorities (required by all workflows)
- `SYSTEM/workflows/`, `SYSTEM/docs/`, `SYSTEM/tools/registries/` - Core documentation and tools
- Root config files (CLAUDE.md, README.md, STATUS.md)

**Slack worktree** includes:
- `collections/slack/` - Raw Slack export
- `investigations/rla_master/analyses/slack/` - Processed analysis
- Slack-specific tools

**iMessage worktree** includes:
- `entities/people/rla_alumni/longfield_ian/interviews/imessage/` - Complete iMessage data (1.9GB)
- iMessage-specific tools

**Facebook worktree** includes:
- `collections/social_media/facebook/` - All Facebook screenshots (5.1GB)
- `investigations/rla_master/analyses/social_media/facebook/` - Analysis
- `SYSTEM/tools/facebook/` - Processing scripts

**Producer worktree** includes:
- `front-end/rla-producer-hub/` - Web application (1.8GB)
- Minimal documentary files for reference

### Using Worktrees

```bash
# List all worktrees
git worktree list

# Switch to specific worktree
cd /Users/ritual/Projects/Development/rla-story-dev-slack     # Slack work
cd /Users/ritual/Projects/Development/rla-story-dev-imessage  # iMessage work
cd /Users/ritual/Projects/Development/rla-story-dev-facebook  # Facebook work
cd /Users/ritual/Projects/Development/rla-story-dev-producer  # Producer Hub work
cd /Users/ritual/Projects/Development/rla-story-dev           # Main repo

# Each worktree can be opened in separate terminal/IDE windows simultaneously
```

### Worktree Best Practices

1. **Work in the appropriate worktree** - Don't cross-contaminate evidence types
2. **Commit frequently** - Each worktree is independent
3. **Merge to main** - When feature work is complete, merge branch to main
4. **Main repo stays complete** - All worktrees are derived from main, which contains all files

### ⚠️ CRITICAL: Worktree Git Workflow

**When committing in a worktree:**
- ✅ **DO commit**: Your actual work files (CSVs, markdown, scripts you modified)
- ❌ **DO NOT commit**: Deletions of newspapers, yearbooks, genesis incidents, etc.
- ❌ **DO NOT stage**: Large file deletions from space optimization

**Space optimization commits that MUST NOT merge to main:**
- Facebook branch: `8fa0b721` - "Optimize Facebook worktree - remove newspaper files"
- Producer branch: `ff9bf899` - "Resolve CSS breaking issues" (includes optimization)
- Slack branch: Any commits deleting newspapers/yearbooks
- iMessage branch: Any commits deleting newspapers/yearbooks

**When committing new work in a worktree:**
```bash
# ✅ CORRECT - Only stage your actual work files
git add investigations/rla_master/analyses/slack/processed/week_5/
git add SYSTEM/tools/slack/new_script.py
git commit -m "feat: Process Slack week 5"

# ❌ WRONG - Never stage deletions of large files
git add -A  # This would stage newspaper deletions!
```

**When merging worktree branches to main:**
- Use `git cherry-pick` to select only real work commits
- **NEVER merge space optimization commits** to main
- Verify `git diff main..branch` doesn't show newspaper/yearbook deletions
- If in doubt, cherry-pick individual commits instead of merging

**Why this matters:**
- Main repo must retain ALL files (complete 27GB)
- Worktrees are intentionally smaller (space-optimized)
- Merging optimization commits would delete 641 newspaper files from main
- This would break the entire documentary evidence system

### Space Optimization

Each worktree is **optimized** (large unused files removed):
- **Total savings**: ~96GB freed across 4 worktrees
- **Before**: 4 worktrees × 27GB = 108GB
- **After**: 1.3GB + 2.2GB + 6.3GB + 2.1GB = ~12GB

Removed from worktrees (based on relevance):
- Facebook screenshots (5.1GB) - Only in Facebook worktree
- Front-end (1.8GB) - Only in Producer worktree
- iMessage attachments (1.6GB) - Only in iMessage worktree
- Genesis incidents (1.3GB) - Removed from all worktrees
- Yearbooks (1.1GB) - Removed from all worktrees
- Newspapers (1.1GB) - Removed from all worktrees

**Note**: Main repo (`rla-story-dev/`) retains complete files. Worktrees are workspace-optimized copies.

---

## Repository Structure (ICIJ/OCCRP Architecture)

```
rla-story-dev/
├── collections/          # IMMUTABLE SOURCES (raw files only)
│   ├── legal_court/, legal_coroner/
│   ├── media/newspapers/
│   ├── social_media/
│   └── rla_official/     # Yearbooks, corporate, email, handbooks
│
├── entities/             # CANONICAL DOSSIERS
│   └── people/{person_slug}/
│       ├── README.md, subject.yml
│       ├── interviews/   # If interview subject
│       └── dossier/      # Intelligence folder
│           ├── MASTER_INTELLIGENCE.md  ⭐ Canonical truth
│           ├── BIOGRAPHICAL_TIMELINE.csv
│           ├── newspapers/, facebook/, linkedin/, corporate/, interviews/
│
├── investigations/       # DERIVED DATA & ANALYSIS
│   └── rla_master/analyses/  # Mirrors collections/ (1:1 traceability)
│       ├── legal_court/, legal_coroner/
│       ├── media/newspapers/{ocr,quotes}
│       └── mortality/, themes/, selections/, story/
│
├── metadata/             # STRUCTURED REFERENCE DATA (ICIJ/OCCRP)
│   ├── registries/       # ⭐ UUID AUTHORITIES (7 master registries)
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
    ├── visualizations/   # D2 network charts
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
- Newspaper: `collections/newspapers/ → ocr/ → metadata/indices/ → entities/.../dossier/newspapers/`

**Full details**: `SYSTEM/docs/COMPLETE_SYSTEM_MAP.md`

---

## Standard Workflows

**Ingesting New Evidence**:
- **Newspaper Articles**: `SYSTEM/workflows/newspaper-ingest.md` (6-phase workflow)
- **Facebook Posts**: `/facebook-process-next` command (automated) OR `SYSTEM/workflows/facebook-ingest-v2.md` (manual reference)
  - **Command**: `.claude/commands/documentary/facebook-process-next.md` (complete instructions)
  - **Helper**: `SYSTEM/tools/facebook/process_facebook_post.py` (mechanical CSV operations)
- **Interview Transcripts**: `SYSTEM/workflows/transcript-ingest.md` (7-phase workflow)
- **LinkedIn Profiles**: `SYSTEM/workflows/linkedin-ingest.md` (5-phase workflow)
- **Corporate Intelligence**: `SYSTEM/workflows/corporate-intelligence-integration.md` (entity updates)
- **External Documentaries**: `SYSTEM/workflows/external-documentary-ingest.md` (10-phase workflow)

**Entity Processing**:
- **Complete Guide**: `SYSTEM/workflows/entity-processing.md`
- **UUID Integration**: `SYSTEM/workflows/uuid-integration.md` (7-step process)

---

## Command System

**How Commands Work**:
- Commands in `.claude/commands/` (markdown files with YAML frontmatter)
- Access via `/` prefix (e.g., `/newspaper-profile-generate "Paul Zahra"`)
- **ALWAYS use commands when available** - don't recreate functionality

**Essential Commands**:
```bash
/facebook-process-next [batch_size]        # Process next unprocessed Facebook post(s)
/facebook-dossier-complete "{Name}"        # Complete Facebook workflow
/newspaper-profile-generate "{Name}"       # Generate newspaper profile
/master-intelligence-update "{Subject}"    # Consolidate all intelligence
/transcript-process [path]                 # Full analysis pipeline
/genesis-process-batch-parallel [batch]    # 10-agent parallel processing
/slack-week-process "{month}" {week}       # Process Slack week (e.g., "2025_02_01-28" 2)
/slack-week-validate {week_folder_path}    # Validate Slack week processing
```

**Full Command Library**: `.claude/commands/documentary/` and `.claude/commands/documentary/README.md`

---

## Critical Documents

### Master Context Files
- `README.md` - Project overview (human onboarding)
- `CLAUDE.md` - This file (agent instructions)
- `docs/templates/ENTITY_DOSSIER_STRUCTURE.md` - ⭐ Standard template for all entities
- `SYSTEM/docs/COMPLETE_SYSTEM_MAP.md` - ⭐ Comprehensive system architecture guide
- `SYSTEM/docs/DOCUMENTARY_CONTEXT.md` - Story, timeline, ethics, intelligence principles
- `SYSTEM/docs/RLA_MASTER_CONTEXT.md` - Institutional analysis

### Router READMEs
- `investigations/README.md` - Analysis workspace router
- `production/README.md` - Creative production router

### Reference Implementation
- `entities/people/rla_staff/priority/zahra_paul/` - ⭐ Complete template (use for structure reference)

---

**This is an investigative documentary repository**. Every piece of data matters. Track everything, verify everything, maintain evidence chain.

**When in doubt**:
1. Check router at top of this file for correct README
2. Read `MASTER_INTELLIGENCE.md` for person context
3. Check if command exists (`.claude/commands/`)
4. Reference template: `entities/people/rla_staff/priority/zahra_paul/`
5. Read `DOCUMENTARY_CONTEXT.md` for ethics and principles
