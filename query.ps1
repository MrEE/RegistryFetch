Write-Host "Hello, we're about to query the Iowa Sex Offender Registry"
$numRecords = Read-Host "Enter how many records you'd like to return (example: 7000)"
$info = Invoke-RestMethod -Uri "https://www.iowasexoffender.gov/api/search/results.json?updated=1-1-2023&per_page=$numRecords"
$info.records | Export-Csv -NoTypeInformation -Path output.csv