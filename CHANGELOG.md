# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **PRP Methodology Integration** - Complete Progressive Refinement Plan system
  - 8 new PRP commands (prp-create, prp-base-execute, prp-spec-execute, prp-task-execute, etc.)
  - 4 PRP templates (BASE, PLANNING, SPEC, TASK) in templates/prp/
  - Auto-integration between PRP creation and AI Guides patterns
  - PRP workspace structure (PRPs/in-progress, PRPs/completed, .templates)
- **INTEGRATION_GUIDE.md** - Comprehensive guide for using both systems together
  - Decision tree for which system to use when
  - Complete workflow examples (OAuth, database migration)
  - Monthly maintenance ritual combining both systems
  - Success metrics and troubleshooting
- **Enhanced Examples** - All 4 domain examples now include:
  - ai-guides/ subdirectory with pattern snippets
  - prp/ subdirectory with example PRPs
  - web-app: authentication-feature.md (BASE PRP)
  - api-project: database-migration.md (SPEC PRP)
  - Updated READMEs explaining both systems
- **Validation Enhancements**:
  - PRP workspace checks in validate_ai_guides.sh
  - examples/validation-scenarios.md with 6 test scenarios
  - Performance validation metrics
  - Error recovery procedures
- **Enhanced Documentation**:
  - commands/README.md documenting all 20 commands
  - Updated README.md with two-system overview
  - Updated WALKTHROUGH.md with "Two Systems" section
  - Updated CLAUDE.md template with PRP routing

### Changed
- **BREAKING**: `/setup-ai-guides` command renamed to `/setup`
  - Now creates both AI Guides system and PRP workspace
  - Enhanced with PRP template installation
  - Updated all documentation references
- **Template Reorganization**:
  - Moved AI Guides templates to templates/ai-guides/
  - Added templates/prp/ for PRP templates
  - CLAUDE.md.template now includes PRP routing logic
- **Command Library Expansion**: 11 commands → 20 commands
  - AI Guides: 4 commands (setup, discover, assess, update)
  - PRP: 8 commands (new)
  - Development: 8 commands (existing)
- **Validation Script**: Now checks both AI Guides and PRP workspace
  - Validates PRP directory structure
  - Counts active vs completed PRPs
  - Checks for all 4 PRP templates
  - Unified summary for both systems

### Fixed
- N/A (first major release with PRP integration)

### Removed
- N/A (all previous features retained)

---

## Change Log Format

Use the following categories for changes:

### Added
New features or capabilities added to the project.

**Examples**:
- New domain example (e.g., "Django backend example")
- New command (e.g., "/test-coverage command")
- New documentation section (e.g., "Performance optimization guide")
- New validation check (e.g., "Check for outdated dependencies")

### Changed
Updates to existing features or documentation.

**Examples**:
- Updated SETUP_GUIDE.md with clearer instructions
- Improved validation script error messages
- Enhanced materiality scoring framework
- Revised router integration approach

### Fixed
Bug fixes and corrections.

**Examples**:
- Fixed broken link in FAQ.md
- Corrected validation script false positive
- Fixed typo in CUSTOMIZATION_GUIDE.md
- Resolved issue with commands not loading

### Removed
Deprecated or removed features.

**Examples**:
- Removed outdated example
- Deprecated old validation approach
- Removed unused template section

---

## Version History

Versions will be tagged using semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes (guide format changes, incompatible updates)
- **MINOR**: New features (new examples, commands, documentation)
- **PATCH**: Bug fixes, documentation corrections

**Example future versions**:
- `1.0.0` - Initial stable release
- `1.1.0` - Add Django example, security patterns guide
- `1.1.1` - Fix broken links, update documentation
- `2.0.0` - Major guide template restructure (breaking change)

---

## Contributing to Changelog

When submitting pull requests, add your changes to the `[Unreleased]` section:

1. Choose appropriate category (Added/Changed/Fixed/Removed)
2. Write clear, concise description
3. Reference issue number if applicable
4. Follow existing format

**Example**:
```markdown
### Added
- Django REST Framework API example with serializer patterns (#42)

### Fixed
- Corrected relative path in web-app example README (#43)
```

---

**Note**: This file is automatically updated during release process. Contributors should add changes to `[Unreleased]` section only.
