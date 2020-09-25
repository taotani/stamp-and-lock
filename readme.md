# About
This is a simple powershell script that converts pdf files to secured ones with a watermark.
## Dependencies
- [PDFtk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
- [PowerShell](https://github.com/PowerShell/PowerShell) >= v7.0
## Usage
```PowerShell
stampnlock.ps1 -DirTop <the topmost directory path> -PassWd <the password> -Watermark <a transparent pdf file> [-SkipIfConverted $True]
```
converts pdfs file under the given directory to secured ones using the given password and watermark.
## Options
- ``DirTop`` specifies the path to the topmost directory that contains target pdf files
- ``PassWd`` specifies the password
- ``Watermark`` specifies the transparent pdf file
- ``SkipIfConverted`` avoids converting pdf files if they have been already converted