# Windows：无 Node / 无 Playwright 的截图方式

本技能仍用 **单个 HTML + 内联 CSS** 设计信息图；截图改为调用系统已安装的 **Google Chrome** 或 **Microsoft Edge**（Chromium 内核）自带的 **headless + `--screenshot`**，不安装 Node.js、Playwright 或任何额外运行时。

## 前置条件

- Windows 10/11，**PowerShell 5.1+**（系统自带）
- 已安装 **Chrome** 或 **Edge**（脚本会按顺序自动查找常见安装路径）

## 用法

在 `scripts` 目录下打开 PowerShell，或使用下面任一方式。

### PowerShell

```powershell
cd path\to\infographic\scripts
.\screenshot.ps1 C:\path\to\input.html C:\path\to\output.png
```

参数与 Node 版对齐：

```text
.\screenshot.ps1 <input.html> <output.png> [scaleFactor=3] [viewportWidth=750] [viewportHeight=9000]
```

- **scaleFactor**：设备像素比，默认 `3`（与技能里「3× 截图」一致）
- **viewportWidth**：视口宽度，默认 `750`（与 HTML `body` 宽度一致）
- **viewportHeight**：视口高度，默认 `9000`；若长图**底部被裁切**，把该值调大（例如 `12000`）

### CMD

```cmd
cd path\to\infographic\scripts
screenshot.cmd C:\path\to\input.html C:\path\to\output.png 3 750
```

## 与 Playwright 版的差异

| 项目 | Playwright (`screenshot.js`) | Chrome/Edge headless (`screenshot.ps1`) |
|------|------------------------------|----------------------------------------|
| 依赖 | Node + playwright + Chromium 下载 | 本机 Chrome 或 Edge |
| 高度 | 按 `body` 实际高度截图 | 固定**视口高度**；过长页面需增大 `viewportHeight` |
| 清晰度 | `deviceScaleFactor=3` | `--force-device-scale-factor=3` |

## 故障排除

1. **提示找不到浏览器**：安装 [Chrome](https://www.google.com/chrome/) 或确保 Edge 存在；或把 `chrome.exe` / `msedge.exe` 安装到默认路径。
2. **执行策略**：若无法运行 `.ps1`，可临时使用：  
   `powershell -ExecutionPolicy Bypass -File .\screenshot.ps1 ...`  
   或使用同目录下的 `screenshot.cmd`。
3. **底部空白或内容被裁切**：调高或调低第五个参数 `viewportHeight`，使视口与内容高度匹配。
