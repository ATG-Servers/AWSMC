$zips = Get-ChildItem -Filter *.zip | Where-Object Name -ne 'AWSMCResourcepack.zip' | Where-Object Name -ne 'AWSMCResourcepack_Fixed.zip'
$outDir = "merged_temp"
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
foreach ($zip in $zips) {
    Write-Host "Extracting $($zip.Name)"
    Expand-Archive -Path $zip.FullName -DestinationPath $outDir -Force
}
Write-Host "Zipping up..."
Compress-Archive -Path "$outDir\*" -DestinationPath "AWSMCResourcepack_Fixed.zip" -Force
Remove-Item -Path $outDir -Recurse -Force
Write-Host "Done"
