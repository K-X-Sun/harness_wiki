#!/bin/bash
# Batch Web Discovery - Modified for Proxy + GitHub Priority
#
# Features:
# 1. Uses proxy: http://child-prc.intel.com:913
# 2. GitHub search prioritizes: latest, high stars, fast star growth
# 3. Downloads to raw/web/
# 4. Batch converts HTML to MD, then deletes HTML

set -e

PROXY="http://child-prc.intel.com:913"
RAW_WEB_DIR="raw/web"
DATE=$(date +%Y-%m-%d)

# Ensure directories exist
mkdir -p "$RAW_WEB_DIR/assets"

echo "========================================"
echo "Batch Web Discovery - with Proxy"
echo "========================================"
echo "Proxy: $PROXY"
echo "Output: $RAW_WEB_DIR/"
echo ""

# Function to download content with proxy
download_with_proxy() {
    local url="$1"
    local output="$2"
    local type="${3:-web}"

    echo "Downloading: $url"

    case "$type" in
        "github-readme")
            # Get raw README
            curl --proxy "$PROXY" -sL "$url" -o "$output"
            ;;
        "arxiv-html")
            # Get arXiv HTML version
            curl --proxy "$PROXY" -sL "$url" -o "$output.html"
            # Convert to markdown (basic approach)
            # For better conversion, use pandoc if available
            if command -v pandoc &> /dev/null; then
                pandoc -f html -t markdown "$output.html" -o "$output"
                rm -f "$output.html"
            fi
            ;;
        *)
            # General web page
            curl --proxy "$PROXY" -sL "$url" -o "$output.html"
            ;;
    esac
}

# Function to search GitHub for latest repos with high stars
search_github_recent() {
    local query="$1"
    local min_stars="${2:-1000}"
    local output_file="$3"

    echo "Searching GitHub: $query (min_stars: $min_stars)"

    # GitHub API search with proxy
    curl --proxy "$PROXY" -sL \
        "https://api.github.com/search/repositories?q=${query}+stars:>=${min_stars}&sort=stars&order=desc&per_page=50" \
        | jq -r '.items[] | {name: .full_name, stars: .stargazers_count, updated: .updated_at}' \
        > "$output_file"

    echo "Found $(cat "$output_file" | jq 'length') repositories"
}

# Function to convert HTML to Markdown
convert_html_to_md() {
    local html_file="$1"
    local md_file="${html_file%.html}.md"

    if [ -f "$html_file" ]; then
        # Try pandoc first
        if command -v pandoc &> /dev/null; then
            pandoc -f html -t markdown "$html_file" -o "$md_file"
            rm -f "$html_file"
        else
            # Fallback: basic HTML to text conversion
            # Remove HTML tags and save as text
            sed 's/<[^>]*>//g' "$html_file" | sed '/^[[:space:]]*$/d' > "$md_file"
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

    # Search GitHub for recent repos
    local search_file="/tmp/github_search_${dimension}_${DATE}.json"

    # Search with increasing star thresholds to find high-star repos
    for min_stars in 10000 5000 1000; do
        search_github_recent "${query_keywords} stars:>=${min_stars}" "$min_stars" "$search_file"

        if [ -f "$search_file" ]; then
            count=$(cat "$search_file" | jq 'length')
            if [ "$count" -ge "$limit" ]; then
                break
            fi
        fi
    done

    # Process results
    if [ -f "$search_file" ]; then
        cat "$search_file" | jq -r '.[] | "\(.name)|\(.stars)"' | while IFS='|' read -r repo stars; do
            owner=$(echo "$repo" | cut -d'/' -f1)
            name=$(echo "$repo" | cut -d'/' -f2)

            md_file="$RAW_WEB_DIR/${DATE}_github_${owner}-${name}.md"

            # Skip if already exists
            if [ -f "$md_file" ]; then
                echo "  Skipping (already exists): $repo"
                continue
            fi

            # Download README
            readme_url="https://raw.githubusercontent.com/${owner}/${name}/main/README.md"
            echo "  Downloading README: $repo ($stars stars)"

            # Try main branch first, then master, then develop
            for branch in main master develop; do
                readme_url="https://raw.githubusercontent.com/${owner}/${name}/${branch}/README.md"
                if curl --proxy "$PROXY" -sL --head "$readme_url" | grep -q "200 OK"; then
                    break
                fi
            done

            # Download with proxy
            curl --proxy "$PROXY" -sL "$readme_url" -o "$md_file" 2>/dev/null || continue

            # Add frontmatter if file is not empty
            if [ -s "$md_file" ]; then
                # Check if frontmatter already exists
                if ! head -1 "$md_file" | grep -q "^---$"; then
                    # Create temp file with frontmatter
                    tmp_file=$(mktemp)
                    cat > "$tmp_file" << EOF
---
title: "${owner}/${name}"
source_url: "https://github.com/${owner}/${name}"
source_type: repo
fetched: ${DATE}
stars: ${stars}
dimension: ${dimension}
---
EOF
                    cat "$md_file" >> "$tmp_file"
                    mv "$tmp_file" "$md_file"
                fi
                echo "    Saved: $md_file"
            else
                rm -f "$md_file"
            fi

            limit=$((limit - 1))
            if [ "$limit" -le 0 ]; then
                break
            fi
        done
    fi

    # Cleanup
    rm -f "$search_file"
}

# Discover repos for each dimension
echo "Starting batch discovery..."
echo ""

# Memory dimension
discover_github_repos "memory" "agent memory" 8

# Skills dimension
discover_github_repos "skills" "tool use" 8

# Protocols dimension
discover_github_repos "protocols" "MCP" 8

# Harness dimension
discover_github_repos "harness" "agent harness" 8

echo ""
echo "========================================"
echo "Discovery Complete!"
echo "========================================"
echo "Files downloaded to: $RAW_WEB_DIR/"
ls -la "$RAW_WEB_DIR"/*.md 2>/dev/null || echo "No markdown files found"
echo ""

# Check for any remaining HTML files and convert
echo "Checking for HTML files to convert..."
find "$RAW_WEB_DIR" -name "*.html" -type f | while read -r html_file; do
    echo "Converting: $html_file"
    convert_html_to_md "$html_file"
done

echo ""
echo "Done!"
