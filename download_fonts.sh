#!/bin/bash

set -e

# Parse command line arguments
DOWNLOAD_FLAGS="-nv"
WEIGHTS="400,700"

while getopts 'f:w:' flag; do
  case "${flag}" in
    f) DOWNLOAD_FLAGS="${OPTARG}" ;;
    w) WEIGHTS="${OPTARG}" ;;
    *) echo "Usage: $0 [-f download_flags] [-w weights] fonts" >&2
       exit 1 ;;
  esac
done
shift $((OPTIND-1))

# Get fonts from remaining arguments
FONTS_INPUT="$*"

if [ -z "$FONTS_INPUT" ]; then
  echo "Error: No fonts specified" >&2
  exit 1
fi

echo "Fonts to install: $FONTS_INPUT"
echo "Weights: $WEIGHTS"
echo "Download flags: $DOWNLOAD_FLAGS"
echo ""

# Parse fonts (support comma or newline separated)
# Convert newlines to commas, then split
FONTS_INPUT=$(echo "$FONTS_INPUT" | tr '\n' ',')
IFS=',' read -ra FONT_ARRAY <<< "$FONTS_INPUT"

# Parse weights
IFS=',' read -ra WEIGHT_ARRAY <<< "$WEIGHTS"

# Create temporary directory
mkdir -p fonts_temp
cd fonts_temp || exit 1

# Track if any font was successfully downloaded
FONTS_DOWNLOADED=0
FONTS_FAILED=0

# Download each font
for font in "${FONT_ARRAY[@]}"; do
  # Trim whitespace
  font=$(echo "$font" | xargs 2>/dev/null || echo "$font" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  
  if [ -z "$font" ]; then
    continue
  fi
  
  echo "==================================="
  echo "Processing font: $font"
  echo "==================================="
  
  # Convert spaces to + for URL
  font_url_name=$(echo "$font" | sed 's/ /+/g')
  
  # Create safe filename (remove spaces and special characters)
  font_file_prefix=$(echo "$font" | sed 's/ /-/g' | sed 's/[^a-zA-Z0-9-]//g')
  
  for weight in "${WEIGHT_ARRAY[@]}"; do
    # Trim whitespace from weight
    weight=$(echo "$weight" | xargs 2>/dev/null || echo "$weight" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    
    if [ -z "$weight" ]; then
      continue
    fi
    
    echo "  Downloading weight: $weight"
    
    # Construct Google Fonts CSS URL
    css_url="https://fonts.googleapis.com/css2?family=${font_url_name}:wght@${weight}"
    
    # Download CSS and extract TTF URL
    echo "  Fetching CSS from: $css_url"
    css_content=$(curl -s "$css_url")
    
    if [ -z "$css_content" ]; then
      echo "  Warning: Failed to fetch CSS for $font (weight $weight)"
      FONTS_FAILED=$((FONTS_FAILED + 1))
      continue
    fi
    
    # Extract TTF URL from CSS using grep and sed
    # Look for url(...) with .ttf extension
    ttf_url=$(echo "$css_content" | grep -o 'https://[^)]*\.ttf' | head -1)
    
    if [ -z "$ttf_url" ]; then
      echo "  Warning: No TTF URL found for $font (weight $weight)"
      echo "  This might mean the font or weight doesn't exist on Google Fonts"
      FONTS_FAILED=$((FONTS_FAILED + 1))
      continue
    fi
    
    echo "  Font URL: $ttf_url"
    
    # Download the TTF file
    output_file="${font_file_prefix}-${weight}.ttf"
    
    if wget -O "$output_file" $DOWNLOAD_FLAGS "$ttf_url"; then
      # Verify the file was downloaded and has content
      if [ -s "$output_file" ]; then
        # Calculate and display checksum
        checksum=$(sha256sum "$output_file" | cut -d ' ' -f 1)
        echo "  ✓ Downloaded: $output_file"
        echo "  SHA256: $checksum"
        FONTS_DOWNLOADED=$((FONTS_DOWNLOADED + 1))
      else
        echo "  Warning: Downloaded file is empty: $output_file"
        rm -f "$output_file"
        FONTS_FAILED=$((FONTS_FAILED + 1))
      fi
    else
      echo "  Warning: Failed to download $output_file"
      FONTS_FAILED=$((FONTS_FAILED + 1))
    fi
    
    echo ""
  done
done

cd ..

# Copy all downloaded fonts to ~/.fonts
echo "==================================="
echo "Installation Summary"
echo "==================================="

if [ -d "fonts_temp" ] && [ "$(ls -A fonts_temp/*.ttf 2>/dev/null)" ]; then
  echo "Copying fonts to $HOME/.fonts/"
  cp fonts_temp/*.ttf "$HOME/.fonts/" 2>/dev/null || true
  
  font_count=$(ls -1 fonts_temp/*.ttf 2>/dev/null | wc -l)
  echo ""
  echo "✓ Successfully installed $font_count font file(s)"
  
  if [ $FONTS_FAILED -gt 0 ]; then
    echo "⚠ $FONTS_FAILED font(s) or weight(s) failed to download"
  fi
  
  echo ""
  echo "Installed fonts:"
  ls -1 fonts_temp/*.ttf | sed 's/fonts_temp\//  - /'
else
  echo "Error: No fonts were downloaded successfully"
  if [ $FONTS_FAILED -gt 0 ]; then
    echo "All $FONTS_FAILED font(s) or weight(s) failed to download"
    echo "Please check:"
    echo "  - Font names are correct (check https://fonts.google.com/)"
    echo "  - Weights are available for the specified fonts"
    echo "  - Network connectivity"
  fi
  exit 1
fi

echo ""
echo "Font installation completed!"
