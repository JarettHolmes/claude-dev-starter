#!/bin/bash
# Monthly validation of AI guides
# Run on 1st of each month to check guide health
#
# Usage: ./validate_ai_guides.sh [guides_dir]
#   guides_dir: Directory containing the guides (default: current directory)
#
# Configuration:
#   Set GUIDES_DIR environment variable to override default location
#   Set MIN_MAPPINGS and MIN_ANTIPATTERNS to customize thresholds

set -e

# Configuration with defaults
GUIDES_DIR="${1:-${GUIDES_DIR:-.}}"
MIN_MAPPINGS="${MIN_MAPPINGS:-15}"
MIN_ANTIPATTERNS="${MIN_ANTIPATTERNS:-5}"

# File paths
TRANSLATION_GUIDE="$GUIDES_DIR/AI_DOMAIN_TRANSLATION_GUIDE.md"
CAPABILITIES_GUIDE="$GUIDES_DIR/AI_CAPABILITIES_AND_LIMITS.md"
CLAUDE_MD="${CLAUDE_MD:-CLAUDE.md}"

# Check if guides exist
if [ ! -f "$TRANSLATION_GUIDE" ]; then
  echo "❌ Translation Guide not found: $TRANSLATION_GUIDE"
  echo "   Run from project root or set GUIDES_DIR environment variable"
  exit 1
fi

if [ ! -f "$CAPABILITIES_GUIDE" ]; then
  echo "❌ Capabilities Guide not found: $CAPABILITIES_GUIDE"
  echo "   Run from project root or set GUIDES_DIR environment variable"
  exit 1
fi

echo "=== AI Guides Validation Report ==="
echo "Date: $(date +%Y-%m-%d)"
echo "Guides Directory: $GUIDES_DIR"
echo ""

# Check 1: Minimum content requirements
echo "📊 Content Minimums"
echo "-------------------"
mappings=$(grep "^|" "$TRANSLATION_GUIDE" | grep -v "Generic Mental Model" | grep -v "Project Implementation" | grep -v "^|---" | wc -l | tr -d ' ')
antipatterns=$(grep "^❌" "$TRANSLATION_GUIDE" | wc -l | tr -d ' ')

if [ "$mappings" -lt "$MIN_MAPPINGS" ]; then
  echo "⚠️  Translation Guide: $mappings mappings (minimum: $MIN_MAPPINGS)"
else
  echo "✅ Translation Guide: $mappings mappings (minimum: $MIN_MAPPINGS)"
fi

if [ "$antipatterns" -lt "$MIN_ANTIPATTERNS" ]; then
  echo "⚠️  Translation Guide: $antipatterns anti-patterns (minimum: $MIN_ANTIPATTERNS)"
else
  echo "✅ Translation Guide: $antipatterns anti-patterns (minimum: $MIN_ANTIPATTERNS)"
fi
echo ""

# Check 2: Internal link validation
echo "🔗 Internal Links"
echo "-----------------"
broken_links=0

# Translation Guide links
while IFS= read -r link; do
  path=$(echo "$link" | sed -E 's/.*\((.*)\)/\1/')
  # Try both relative to guide and absolute paths
  if [ ! -f "$GUIDES_DIR/$path" ] && [ ! -f "$path" ]; then
    echo "⚠️  Broken link in Translation Guide: $link"
    broken_links=$((broken_links + 1))
  fi
done < <(grep -o '\[.*\](.*\.md)' "$TRANSLATION_GUIDE" || true)

# Capabilities Guide links
while IFS= read -r link; do
  path=$(echo "$link" | sed -E 's/.*\((.*)\)/\1/')
  if [ ! -f "$GUIDES_DIR/$path" ] && [ ! -f "$path" ]; then
    echo "⚠️  Broken link in Capabilities Guide: $link"
    broken_links=$((broken_links + 1))
  fi
done < <(grep -o '\[.*\](.*\.md)' "$CAPABILITIES_GUIDE" || true)

if [ "$broken_links" -eq 0 ]; then
  echo "✅ All internal links valid"
else
  echo "⚠️  Found $broken_links broken links - review and fix"
fi
echo ""

# Check 3: Future testing backlog
echo "🧪 Capability Testing Backlog"
echo "------------------------------"

# Count "Future Testing Needed" sections
future_test_sections=$(grep -c "### Future Testing Needed" "$CAPABILITIES_GUIDE" || echo "0")

# Count total future test items (rows in future testing tables)
total_backlog=$(grep -A 50 "### Future Testing Needed" "$CAPABILITIES_GUIDE" | grep "^| " | grep -v "^| Test " | grep -v "^|---" | wc -l | tr -d ' ')

echo "📊 Future testing sections: $future_test_sections"
echo "📊 Total backlog items: $total_backlog"

if [ "$total_backlog" -gt 0 ]; then
  echo "💡 Aim to complete 3 tests per quarter to reduce backlog"
fi
echo ""

# Check 4: Last update dates (only if git repo)
if git rev-parse --git-dir > /dev/null 2>&1; then
  echo "📅 Staleness Check"
  echo "------------------"
  last_update_translation=$(git log -1 --format="%cr" -- "$TRANSLATION_GUIDE" 2>/dev/null || echo "Never committed")
  last_update_capabilities=$(git log -1 --format="%cr" -- "$CAPABILITIES_GUIDE" 2>/dev/null || echo "Never committed")

  echo "Translation Guide last updated: $last_update_translation"
  echo "Capabilities Guide last updated: $last_update_capabilities"
  echo ""
else
  echo "📅 Staleness Check"
  echo "------------------"
  echo "⚠️  Not a git repository - skipping staleness check"
  echo ""
fi

# Check 5: Router integration (if CLAUDE.md exists)
echo "🧭 Router Integration"
echo "---------------------"

if [ -f "$CLAUDE_MD" ]; then
  if grep -q "AI_DOMAIN_TRANSLATION_GUIDE" "$CLAUDE_MD"; then
    echo "✅ Translation Guide referenced in CLAUDE.md"
  else
    echo "⚠️  Translation Guide NOT referenced in CLAUDE.md"
  fi

  if grep -q "AI_CAPABILITIES_AND_LIMITS" "$CLAUDE_MD"; then
    echo "✅ Capabilities Guide referenced in CLAUDE.md"
  else
    echo "⚠️  Capabilities Guide NOT referenced in CLAUDE.md"
  fi
else
  echo "⚠️  CLAUDE.md not found - skipping router integration check"
  echo "   Set CLAUDE_MD environment variable if file is elsewhere"
fi
echo ""

# Check 6: Customization markers (warn if templates not customized)
echo "🔧 Customization Status"
echo "------------------------"
customize_markers_translation=$(grep -c "\[CUSTOMIZE" "$TRANSLATION_GUIDE" || echo "0")
customize_markers_capabilities=$(grep -c "\[CUSTOMIZE" "$CAPABILITIES_GUIDE" || echo "0")

if [ "$customize_markers_translation" -gt 0 ]; then
  echo "⚠️  Translation Guide has $customize_markers_translation [CUSTOMIZE] markers remaining"
else
  echo "✅ Translation Guide fully customized (no [CUSTOMIZE] markers)"
fi

if [ "$customize_markers_capabilities" -gt 0 ]; then
  echo "⚠️  Capabilities Guide has $customize_markers_capabilities [CUSTOMIZE] markers remaining"
else
  echo "✅ Capabilities Guide fully customized (no [CUSTOMIZE] markers)"
fi
echo ""

# Summary
echo "=== Summary ==="
echo "Content: $mappings mappings, $antipatterns anti-patterns"
echo "Links: $broken_links broken"
echo "Testing backlog: $total_backlog items"
echo "Customization: $((customize_markers_translation + customize_markers_capabilities)) markers remaining"
echo ""

if [ "$broken_links" -gt 0 ] || [ "$mappings" -lt "$MIN_MAPPINGS" ] || [ "$antipatterns" -lt "$MIN_ANTIPATTERNS" ]; then
  echo "⚠️  Action required:"
  [ "$broken_links" -gt 0 ] && echo "  - Fix $broken_links broken links"
  [ "$mappings" -lt "$MIN_MAPPINGS" ] && echo "  - Add $((MIN_MAPPINGS - mappings)) more concept mappings"
  [ "$antipatterns" -lt "$MIN_ANTIPATTERNS" ] && echo "  - Add $((MIN_ANTIPATTERNS - antipatterns)) more anti-patterns"
  echo ""
fi

echo "Next steps:"
echo "1. Fix any broken links"
echo "2. Complete 3 capability tests this quarter"
echo "3. Update guides if workflows changed recently"
if [ "$((customize_markers_translation + customize_markers_capabilities))" -gt 0 ]; then
  echo "4. Replace remaining [CUSTOMIZE] markers with project-specific content"
fi
echo ""
echo "Validation complete: $(date +%Y-%m-%d)"
