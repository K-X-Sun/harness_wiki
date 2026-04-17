#!/bin/bash
# Web Discovery Batch Script
# Modified for: Proxy support, GitHub priority, raw/web/ output, HTML->MD batch conversion
#
# Usage: ./batch_web_discovery.sh <dimension> <topic> [--limit=N]
#
# Features:
# 1. Uses proxy: http://child-prc.intel.com:913
# 2. GitHub search prioritizes: latest, high stars, fast star growth
# 3. Downloads to raw/web/
# 4. Batch converts HTML to MD, then deletes HTML

set -e

# Configuration
PROXY="http://child-prc.intel.com:913"
RAW_WEB_DIR="raw/web"
DATE=$(date +%Y-%m-%d)

# Ensure directories exist
mkdir -p "$RAW_WEB_DIR/assets"

echo "========================================"
echo "Web Discovery Batch"
echo "========================================"
echo "Proxy: $PROXY"
echo "Output: $RAW_WEB_DIR/"
echo ""

# Parse arguments
DIMENSION="${1:-harness}"
TOPIC="${2:-agent harness}"
LIMIT="${3:-10}"
LIMIT="${LIMIT/--limit=/}"
LIMIT="${LIMIT:-10}"

# Function to download content with proxy
download_with_proxy() {
    local url="$1"
    local output="$2"
    local type="${3:-web}"

    echo "Downloading: $url"

    # Use curl with proxy
    case "$type" in
        "github-readme")
            curl --proxy "$PROXY" -sL "$url" -o "$output"
            ;;
        "arxiv-html")
            # Fetch HTML from ar5iv mirror (better parsing)
            local arxiv_id=$(echo "$url" | grep -oE '[0-9]+\.[0-9]+')
            curl --proxy "$PROXY" -sL "https://ar5iv.labs.arxiv.org/html/${arxiv_id}" -o "$output"
            ;;
        *)
            curl --proxy "$PROXY" -sL "$url" -o "$output.html"
            ;;
    esac
}

# Function to search GitHub for latest repos with high stars or fast growth
search_github_priority() {
    local query="$1"
    local min_stars="${2:-1000}"
    local output_file="$3"

    echo "Searching GitHub: $query (min_stars: $min_stars)"

    # Search by stars (high star count)
    local stars_result=$(mktemp)
    curl --proxy "$PROXY" -sL \
        "https://api.github.com/search/repositories?q=${query}+stars:>=${min_stars}&sort=stars&order=desc&per_page=20" \
        > "$stars_result"

    # Search by recently updated (last 2 months)
    local updated_result=$(mktemp)
    local two_months_ago=$(date -d "2 months ago" +%Y-%m-%d 2>/dev/null || date -v-2m +%Y-%m-%d)
    curl --proxy "$PROXY" -sL \
        "https://api.github.com/search/repositories?q=${query}+updated:>${two_months_ago}&sort=stars&order=desc&per_page=20" \
        > "$updated_result"

    # Combine and deduplicate
    cat "$stars_result" "$updated_result" | jq -s 'unique_by(.full_name)' > "$output_file"

    rm -f "$stars_result" "$updated_result"
}

# Function to convert HTML to Markdown
convert_html_to_md() {
    local html_file="$1"
    local md_file="${html_file%.html}.md"

    if [ -f "$html_file" ]; then
        # Try pandoc first
        if command -v pandoc &> /dev/null; then
            pandoc -f html -t markdown "$html_file" -o "$md_file" 2>/dev/null
            rm -f "$html_file"
        else
            # Fallback: basic cleanup
            sed 's/<script[^>]*>.*<\/script>//g' "$html_file" | \
            sed 's/<style[^>]*>.*<\/style>//g' | \
            sed 's/<[^>]*>//g' | \
            sed 's/^[[:space:]]*$//' | \
            sed '/^$/N;/^\n$/d' > "$md_file" 2>/dev/null
        fi
    fi
}

# Function to discover and download GitHub repos for a dimension
discover_github_repos() {
    local dimension="$1"
    local query_keywords="$2"
    local limit="${3:-10}"

    echo ""
    echo "========================================"
    echo "Discovering GitHub repos for: $dimension"
    echo "Query: $query_keywords"
    echo "Limit: $limit"
    echo "========================================"

    local search_file="/tmp/github_search_${dimension}_${DATE}.json"

    # Search with increasing star thresholds
    for min_stars in 10000 5000 1000; do
        search_github_priority "${query_keywords} stars:>=${min_stars}" "$min_stars" "$search_file"

        if [ -f "$search_file" ]; then
            count=$(cat "$search_file" | jq 'length')
            if [ "$count" -ge "$limit" ]; then
                break
            fi
        fi
    done

    # Process top results
    if [ -f "$search_file" ]; then
        cat "$search_file" | jq -r '.[] | "\(.full_name)|\(.stargazers_count)|\(.updated_at)' | head -n "$limit" | while IFS='|' read -r repo stars updated; do
            [ -z "$repo" ] && continue

            owner=$(echo "$repo" | cut -d'/' -f1)
            name=$(echo "$repo" | cut -d'/' -f2)

            md_file="$RAW_WEB_DIR/${DATE}_github_${owner}-${name}.md"

            # Skip if already exists
            if [ -f "$md_file" ]; then
                echo "  [SKIP] Already exists: $repo"
                continue
            fi

            # Try to get README from different branches
            for branch in main master develop; do
                readme_url="https://raw.githubusercontent.com/${owner}/${name}/${branch}/README.md"
                if curl --proxy "$PROXY" -sL --head "$readme_url" 2>/dev/null | grep -q "200 OK"; then
                    echo "  [DOWN] $repo ($stars stars, updated: $updated)"
                    curl --proxy "$PROXY" -sL "$readme_url" -o "$md_file" 2>/dev/null && break
                fi
            done

            # Add frontmatter if file downloaded
            if [ -f "$md_file" ] && [ -s "$md_file" ]; then
                if ! head -1 "$md_file" | grep -q "^---$"; then
                    tmp_file=$(mktemp)
                    cat > "$tmp_file" << EOF
---
title: "${owner}/${name}"
source_url: "https://github.com/${owner}/${name}"
source_type: repo
fetched: ${DATE}
stars: ${stars}
updated: ${updated}
dimension: ${dimension}
---
EOF
                    cat "$md_file" >> "$tmp_file"
                    mv "$tmp_file" "$md_file"
                fi
                echo "    [SAVED] $md_file"
            else
                rm -f "$md_file"
            fi
        done
    fi

    # Cleanup
    rm -f "$search_file"
}

# Function to discover arXiv papers
discover_arxiv_papers() {
    local dimension="$1"
    local query_keywords="$2"
    local limit="${3:-5}"

    echo ""
    echo "========================================"
    echo "Discovering arXiv papers for: $dimension"
    echo "Query: $query_keywords"
    echo "Limit: $limit"
    echo "========================================"

    # Search arXiv API (uncomment if needed)
    # curl --proxy "$PROXY" -sL "http://export.arxiv.org/api/query?search_query=${query_keywords}&start=0&max_results=${limit}" \
    #     | grep "arxiv.org/abs" | head -n "$limit"
}

# Discover repos for each dimension
echo "Starting batch discovery..."
echo ""

discover_github_repos "$DIMENSION" "$TOPIC" "$LIMIT"

# Discover arXiv papers
# discover_arxiv_papers "$DIMENSION" "$TOPIC" "$LIMIT"

echo ""
echo "========================================"
echo "Discovery Complete!"
echo "========================================"
echo "Files in $RAW_WEB_DIR/:"
ls -la "$RAW_WEB_DIR"/*.md 2>/dev/null | head -20

# Convert any remaining HTML files
echo ""
echo "Converting HTML files to Markdown..."
find "$RAW_WEB_DIR" -name "*.html" -type f 2>/dev/null | while read -r html_file; do
    echo "Converting: $html_file"
    convert_html_to_md "$html_file"
done

echo ""
echo "Done! Check $RAW_WEB_DIR/ for downloaded files."
