param (
    [parameter(mandatory)][string]$DirTop,
    [parameter(mandatory)][string]$PassWd,
    [parameter(mandatory)][string]$Watermark,
    [string]$LockedList = "locked.txt",
    [string]$SkipedList = "skipped.txt",
    [switch]$SkipIfConverted = $false
)

# the postfix of the generated files
$GEN_EXT = ".confidential.pdf"

function WatermarkAndLock {
    # finding the target pdf files
    $pdfs = Get-ChildItem -Path $DirTop -Recurse | Where-Object {$_.Name.EndsWith(".pdf") -and -not $_.name.EndsWith($GEN_EXT)}

    # conversion
    foreach ($pdf in $pdfs) {
        $outpdf = $pdf.FullName.Replace(".pdf", $GEN_EXT)
        if ($SkipIfConverted -And (Test-Path $outpdf)) {
            # skipping the file if it is already converted
            Out-file -FilePath $SkipedList -Append -InputObject $pdf.FullName
        } else {
            pdftk $pdf stamp $Watermark output $outpdf owner_pw $PassWd
            Out-file -FilePath $LockedList -Append -InputObject $pdf.FullName
        }
    }    
}

# removing the log files
remove-item -path $LockedList -Force -ErrorAction Ignore
remove-item -path $SkipedList -Force -ErrorAction Ignore

# execute the main process
WatermarkAndLock