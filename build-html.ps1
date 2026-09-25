# Sinh GIT-HUONG-DAN.html từ GIT-HUONG-DAN.md (sửa file .md rồi chạy lại script này).
# Cần pandoc: winget install JohnMacFarlane.Pandoc
# Chạy: powershell -ExecutionPolicy Bypass -File docs\build-html.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
pandoc GIT-HUONG-DAN.md -f gfm -t html5 --standalone --toc --toc-depth=3 --section-divs `
    --metadata pagetitle="Sổ tay Git" --metadata lang=vi `
    --include-in-header html-assets/header.html `
    --include-after-body html-assets/after-body.html `
    -o GIT-HUONG-DAN.html
if ($LASTEXITCODE -ne 0) { throw "pandoc failed" }
"Đã tạo $(Join-Path $PSScriptRoot 'GIT-HUONG-DAN.html')"
