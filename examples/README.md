# Examples

- **`infographic-course.html`** — sample long-form infographic page (Chinese). After installing dependencies for the `infographic` skill, generate a PNG with:

  **Node + Playwright** (from repo root):

  ```bash
  cd ../infographic && node scripts/screenshot.js ../examples/infographic-course.html ../examples/infographic-course.png 3 750
  ```

  **Windows (Chrome/Edge)**:

  ```powershell
  cd ..\infographic\scripts
  .\screenshot.ps1 (Resolve-Path ..\..\examples\infographic-course.html) (Resolve-Path ..\..\examples\infographic-course.png) 3 750 12000
  ```

  Adjust the last height argument if the image is clipped.
