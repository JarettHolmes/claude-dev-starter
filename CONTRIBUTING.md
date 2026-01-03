# Contributing to Claude Development System Starter

Thank you for considering contributing! This project helps developers set up systematic AI agent instruction management for their projects.

## How to Contribute

### Reporting Issues

Use GitHub Issues for:
- **Bug reports** (broken links, validation errors, incorrect documentation)
- **Feature requests** (new examples, additional commands, improved workflows)
- **Documentation improvements** (clarity issues, missing information)

**Issue Templates**: Use provided templates in `.github/ISSUE_TEMPLATE/` for structured reporting.

### Submitting Changes

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub
   git clone https://github.com/YOUR_USERNAME/claude-dev-starter.git
   cd claude-dev-starter
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

   **Branch naming**:
   - `feature/` - New features or examples
   - `fix/` - Bug fixes
   - `docs/` - Documentation improvements
   - `chore/` - Maintenance tasks

3. **Make your changes**
   - Follow existing markdown formatting
   - Test all code examples
   - Run validation script
   - Update relevant documentation

4. **Commit with clear message**
   ```bash
   git commit -m "docs: Add Python/Flask API example"
   git commit -m "fix: Correct broken link in SETUP_GUIDE.md"
   git commit -m "feat: Add security patterns guide template"
   ```

   **Commit format**: `<type>: <description>`
   - `feat:` - New features
   - `fix:` - Bug fixes
   - `docs:` - Documentation changes
   - `chore:` - Maintenance tasks
   - `test:` - Test updates

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Go to GitHub repository
   - Click "New Pull Request"
   - Use provided PR template
   - Fill in all sections
   - Link related issues

**PR Template**: Use provided template in `.github/PULL_REQUEST_TEMPLATE.md`

---

## Code Style

### Markdown Conventions

**Headers**:
- Use `##` for main sections
- Use `###` for subsections
- Use `####` for sub-subsections
- No `#` (reserved for document title)

**Code Blocks**:
```markdown
# Always specify language
```bash
echo "Good"
```

```python
print("Good")
```

# Not this
```
echo "Bad - no syntax highlighting"
```
```

**Tables**:
```markdown
| Column 1 | Column 2 |
|----------|----------|
| Value 1  | Value 2  |
```

**Links**:
```markdown
# Internal links (relative paths)
[Setup Guide](SETUP_GUIDE.md)
[Examples](examples/web-app/README.md)

# External links (full URLs)
[Claude Code](https://claude.com/claude-code)
```

**Lists**:
```markdown
# Unordered
- Item 1
- Item 2
  - Sub-item 2.1
  - Sub-item 2.2

# Ordered
1. Step 1
2. Step 2
3. Step 3
```

### Example Quality Standards

**All code examples must be**:
1. **Tested** - Run the code before committing
2. **Complete** - No placeholder code (`// TODO: implement`)
3. **Commented** - Explain non-obvious logic
4. **Copy-paste ready** - Users should be able to use directly

**Good example**:
```python
# Load CSV with explicit dtypes to prevent inference errors
import pandas as pd

df = pd.read_csv('data.csv', dtype={
    'id': 'int64',
    'name': 'string',
    'created_at': 'string'
})
# Parse dates separately for better control
df['created_at'] = pd.to_datetime(df['created_at'])
```

**Bad example**:
```python
# Load data
df = pd.read_csv('data.csv')  # TODO: add dtypes
```

### Template Guidelines

**[CUSTOMIZE] Markers**:
- **Preserve format**: `[CUSTOMIZE: description]`
- **Include inline instructions**: Help users know what to fill in
- **Show examples**: Demonstrate pattern, not full implementation

**Good template**:
```markdown
| "Database query" | [CUSTOMIZE: your ORM - e.g., "Prisma ORM", "TypeORM", "Sequelize"] | [CUSTOMIZE: key detail - e.g., "Always use include for relations"] |
```

**Bad template**:
```markdown
| "Database query" | [CUSTOMIZE] | [CUSTOMIZE] |
```

---

## Testing

Before submitting pull request:

### 1. Run Validation Script

```bash
bash tools/validate_ai_guides.sh
```

**Check for**:
- ✅ No broken links
- ✅ Content minimums met (if applicable)
- ✅ No validation errors

### 2. Check All Links

```bash
# Manually verify links in changed files
# Click each link to ensure it works
```

**Common link issues**:
- Incorrect relative paths (`../../` vs `../`)
- Typos in filenames
- Missing files referenced

### 3. Test Code Examples

**Bash examples**:
```bash
# Run each bash command to ensure it works
bash -c "echo 'Test command'"
```

**Python examples**:
```bash
# Test Python snippets
python3 -c "import pandas as pd; print('Works')"
```

**JavaScript examples**:
```bash
# Test JS snippets if applicable
node -e "console.log('Works')"
```

### 4. Verify Markdown Rendering

- Preview markdown in GitHub or IDE
- Check tables render correctly
- Verify code blocks have syntax highlighting
- Ensure headers create proper hierarchy

---

## Documentation Updates

When updating guides or examples:

### 1. Update Corresponding README Files

If you change:
- Template → Update `templates/` comment
- Example → Update `examples/[domain]/README.md`
- Command → Update `commands/README.md`
- Tool → Update `tools/README.md`

### 2. Check Cross-References

```bash
# Find all references to changed file
grep -r "filename.md" .
```

Update cross-references if:
- File moved
- File renamed
- Content significantly changed

### 3. Add Entry to CHANGELOG.md

```markdown
## [Unreleased]

### Added
- Python/Flask API example with SQLAlchemy patterns

### Changed
- Updated SETUP_GUIDE.md with clearer installation steps

### Fixed
- Corrected broken link in FAQ.md to CUSTOMIZATION_GUIDE.md
```

### 4. Update Last Modified Date

If guide has "Last Updated" field:
```markdown
**Last Updated**: 2026-01-02
```

Update to current date.

---

## Contribution Areas

### High-Value Contributions

**New Domain Examples**:
- Django/Python backend
- Vue.js frontend
- Flutter mobile
- R data science
- Additional frameworks

**Enhanced Validation**:
- Additional checks
- Better error messages
- Performance improvements

**Documentation Clarity**:
- FAQ additions
- Troubleshooting guides
- Video walkthroughs

**Real-World Case Studies**:
- Before/after metrics
- Team adoption stories
- Success stories

### Lower Priority

**New Commands**:
- Must integrate with existing workflow
- Should not duplicate existing commands
- Requires documentation update

**Template Enhancements**:
- Additional guide templates (security, performance, etc.)
- Must follow existing structure
- Needs corresponding example

---

## Questions?

- **Unclear contribution process**: Open issue with "question" label
- **Need feature discussion**: Open issue with "enhancement" label before implementing
- **Security concerns**: Email maintainer directly (don't open public issue)

---

## License

By contributing, you agree your contributions will be licensed under the MIT License (see `LICENSE` file).

---

## Code of Conduct

**Be respectful**:
- Provide constructive feedback
- Welcome newcomers
- Assume good intent
- Focus on what's best for the project

**Unacceptable behavior**:
- Personal attacks
- Harassment
- Dismissive comments
- Off-topic discussions

Violations may result in contribution being rejected or ban from project.

---

**Thank you for contributing to making AI agent instruction management more accessible!**
