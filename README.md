# action-install-google-fonts

Install Google Fonts in GitHub Actions

## Features

- 🎨 **Full Customization**: Choose any font from [Google Fonts](https://fonts.google.com/)
- 🎯 **Flexible Font Weights**: Specify required weights (100-900)
- ⚡ **Fast Installation**: Quick download using wget
- 🔒 **Security Verification**: SHA256 checksum provided

## Requirements

- Ubuntu runner

## Usage

### Basic Examples

#### Example 1: Install a Single Font

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto'
```

#### Example 2: Install Multiple Fonts (Comma-Separated)

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto,Noto Sans TC,Noto Color Emoji'
```

#### Example 3: Install Multiple Fonts (Multi-Line Format)

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: |
        Roboto
        Noto Sans TC
        Noto Serif TC
        Noto Color Emoji
```

#### Example 4: Specify Font Weights

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto,Lato'
      weights: '300,400,500,700,900'
```

#### Example 5: Full Configuration

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: |
        Roboto
        Noto Sans TC
        Noto Serif TC
      weights: '400,700'
      download-flag: '-v'  # verbose output
```

### Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `fonts` | ✅ Yes | - | List of fonts to install (comma or newline separated) |
| `weights` | ❌ No | `'400,700'` | Font weights to install (100-900) |
| `download-flag` | ❌ No | `'-nv'` | wget download flags |

### Advanced Configuration Recommendations

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: |
        Roboto
        Noto Sans TC
      weights: '400,700'
    timeout-minutes: 10  # Recommended to set execution timeout to avoid getting stuck due to network issues
  
  # Next step
  - name: your next step
    if: always()  # Prevent font installation failure from interrupting the workflow
```

## Popular Google Fonts

### Chinese Fonts

- `Noto Sans TC` - Noto Sans Traditional Chinese
- `Noto Serif TC` - Noto Serif Traditional Chinese
- `Noto Sans SC` - Noto Sans Simplified Chinese
- `Noto Sans HK` - Noto Sans Hong Kong

### English Fonts

- `Roboto` - Google's standard font
- `Open Sans` - Friendly sans-serif font
- `Lato` - Elegant sans-serif font
- `Montserrat` - Modern geometric font

### Special Fonts

- `Noto Color Emoji` - Color Emoji
- `Noto Emoji` - Monochrome Emoji

For a complete list of fonts, please refer to [Google Fonts](https://fonts.google.com/)

## License

Copyright © 2022 hms5232, jim60105

This project is licensed under the [Apache 2.0 License](LICENSE).
