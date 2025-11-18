#!/bin/bash

# Clean up temporary files from Google Fonts downloads
rm -rf fonts_temp/ 2>/dev/null || true
rm -f *.css 2>/dev/null || true
