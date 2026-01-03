---
command: update-claude-readme
description: Update CLAUDE.md and/or README.md based on repository changes
signature: "[UPDATE_DESCRIPTION]"
arguments:
  - name: UPDATE_DESCRIPTION
    description: "Description of changes made or work completed (optional - will analyze current conversation if not provided)"
    required: false
---

Update CLAUDE.md and/or README.md documentation based on recent repository changes, following the established update logic for each file.

Example usage:
- `/update-claude-readme` - Analyzes current conversation for changes
- `/update-claude-readme "reorganized repository structure into three-tier system"`
- `/update-claude-readme "added new transcript processing pipeline"`

The command will:

1. **ANALYZE CHANGES** - Determine what has changed
   - If UPDATE_DESCRIPTION provided, use that context
   - Otherwise, analyze current conversation for:
     - Directory structure changes
     - Command system modifications
     - Workflow updates
     - New tools or scripts
     - Content/narrative changes
     - Discovery of new evidence

2. **DETERMINE TARGET FILES** - Apply update logic
   
   **Update CLAUDE.md when:**
   - Command system changes (paths, new commands, syntax)
   - Workflow processes change (interview processing, intelligence updates)
   - Directory structure changes (file organization, paths)
   - Claude-specific instructions (anti-patterns, working patterns)
   - Technical infrastructure (tools, scripts, automation)
   
   **Update README.md when:**
   - Project mission/scope changes
   - High-level narrative updates (story focus, documentary approach)
   - Major milestones achieved (interviews completed, evidence discovered)
   - Public-facing information changes
   - Quick reference stats (number of subjects, documents, etc.)
   
   **Update BOTH when:**
   - Major reorganizations
   - Critical new discoveries that change project direction
   - New team members/collaborators need onboarding
   - Fundamental workflow changes affecting both humans and Claude

3. **PERFORM UPDATES** - Make appropriate changes
   - For CLAUDE.md: Update operational instructions, paths, commands, workflows
   - For README.md: Update project overview, stats, milestones, narrative focus
   - Preserve existing structure and formatting
   - Add timestamps for significant changes

4. **VERIFY CONSISTENCY** - Ensure alignment
   - Cross-check paths and commands work correctly
   - Verify statistics are accurate (count files if needed)
   - Ensure both files remain synchronized where they overlap

5. **REPORT CHANGES** - Summarize what was updated
   - List specific sections modified in each file
   - Highlight any critical changes requiring user attention
   - Suggest follow-up actions if needed

Decision matrix:
```
Change Type                    | CLAUDE.md | README.md
------------------------------|-----------|----------
New command added             | ✓         |
Directory reorganization      | ✓         | ✓
Interview count update        |           | ✓
Workflow process change       | ✓         |
Story narrative shift         |           | ✓
Technical tool addition       | ✓         |
Evidence discovery milestone  |           | ✓
Command path changes          | ✓         |
Project scope change          | ✓         | ✓
```

The command will analyze the changes contextually and make intelligent decisions about which file(s) to update, ensuring documentation remains accurate and useful for both Claude and human users.

Note: Always preserves critical sections like command discovery, anti-patterns, and working patterns in CLAUDE.md, and project mission, key statistics, and contact information in README.md.