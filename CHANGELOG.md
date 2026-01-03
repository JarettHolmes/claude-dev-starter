# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release with full development suite
- 4 guide templates (Domain Translation, Capabilities & Limits, Usage Summary, Maintenance Plan)
- 11 development commands (3 AI guides + 8 dev tools)
- Configurable validation script with 6 quality checks
- 4 multi-domain examples (web-app, api-project, mobile-app, data-science)
- RLA documentary example (real-world reference implementation)
- Comprehensive documentation (Architecture, Customization, Success Metrics, FAQ)
- GitHub integration (issue templates, PR template, CONTRIBUTING.md)
- Router integration snippet for CLAUDE.md
- Validation scenarios template
- Complete setup guide (<30 minute basic setup)
- Monthly maintenance workflow
- 40-point materiality scoring framework
- Success metrics tracking framework

### Changed
- N/A (initial release)

### Fixed
- N/A (initial release)

### Removed
- N/A (initial release)

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
