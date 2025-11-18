# action-install-google-fonts

在 GitHub Actions 執行時安裝 Google Fonts 字型

## 特色

- 🎨 **完全自訂**: 自由選擇任何 Google Fonts 上的字型
- 🌏 **支援各種語言**: 中文、日文、韓文、拉丁文等
- 🎯 **彈性字重**: 可指定需要的字重（100-900）
- ⚡ **快速安裝**: 使用 wget 快速下載
- 🔒 **安全驗證**: 提供 SHA256 checksum

## 需求

* Ubuntu runner（已測試完成）

## 使用方式

### 基本範例

**範例 1: 安裝單一字型**
```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto'
```

**範例 2: 安裝多個字型（逗號分隔）**
```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto,Noto Sans TC,Noto Color Emoji'
```

**範例 3: 安裝多個字型（多行格式）**
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

**範例 4: 指定字重**
```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: 'Roboto,Lato'
      weights: '300,400,500,700,900'
```

**範例 5: 完整設定**
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

### 參數說明

| 參數 | 必填 | 預設值 | 說明 |
|------|------|--------|------|
| `fonts` | ✅ 是 | - | 要安裝的字型列表（逗號或換行分隔）|
| `weights` | ❌ 否 | `'400,700'` | 要安裝的字重（100-900）|
| `download-flag` | ❌ 否 | `'-nv'` | wget 的下載參數 |

### 進階設定建議

```yaml
steps:
  - uses: jim60105/action-install-google-fonts@v2
    with:
      fonts: |
        Roboto
        Noto Sans TC
      weights: '400,700'
    timeout-minutes: 10  # 建議設定執行時限，避免因網路問題卡住
  
  # 下一個步驟
  - name: your next step
    if: always()  # 避免字型安裝失敗導致中斷流程
```

## 常用 Google Fonts

### 中文字型
- `Noto Sans TC` - 思源黑體繁體中文
- `Noto Serif TC` - 思源宋體繁體中文
- `Noto Sans SC` - 思源黑體簡體中文
- `Noto Sans HK` - 思源黑體香港

### 英文字型
- `Roboto` - Google 的標準字型
- `Open Sans` - 友善的無襯線字型
- `Lato` - 優雅的無襯線字型
- `Montserrat` - 現代幾何字型

### 特殊字型
- `Noto Color Emoji` - 彩色 Emoji
- `Noto Emoji` - 單色 Emoji

完整字型列表請參考 [Google Fonts](https://fonts.google.com/)

## 從 v1.x 遷移

如果您正在使用舊版的 CNS11643 字型安裝 action，請參考以下遷移指南：

**Before (v1.x):**
```yaml
- uses: jim60105/install-CNS11643-fonts-action@v1
  with:
    kai: 'true'
    sung: 'true'
```

**After (v2.x):**
```yaml
- uses: jim60105/action-install-google-fonts@v2
  with:
    fonts: 'Noto Sans TC,Noto Serif TC'
```

主要變更：
- ❌ 移除 `kai` 和 `sung` 參數
- ✅ 新增 `fonts` 參數（必填）- 使用者自行指定要安裝的字型
- ✅ 新增 `weights` 參數（選填）- 可指定字重
- ✅ 支援任何 Google Fonts 上的字型

## Release 策略

本專案依照語意化版本號（SemVer）更新版本號。

主版本號會切出分支管理，例如：`v2`；次版及修補版本號則使用 tag 功能，例如：`v2.0.0`。

## 授權

Copyright © 2024 jim60105

本專案使用 [Apache 2.0 開源許可證](LICENSE)。

Google Fonts 字型的授權依各字型而定，大多數使用 [Open Font License](https://scripts.sil.org/OFL)。請在使用前確認您選擇的字型授權條款。

## 相關連結

- [Google Fonts](https://fonts.google.com/)
- [Google Fonts API Documentation](https://developers.google.com/fonts/docs/developer_api)
- [原始專案 (CNS11643 版本)](https://github.com/hms5232/install-CNS11643-fonts-action)
