Write-Host "Hello, we're about to query the Iowa Sex Offender Registry"

# Base URL and per-page count
$baseUrl = "https://www.iowasexoffender.gov/api/search/results.json"
$perPage = 100
$page = 1
$allResults = @()

while ($true) {
    $url = $baseUrl + "?page=" + $page + "&per_page=" + $perPage

    Write-Host "Fetching page $page..."
	
	 # Print the URL for debugging purposes
    Write-Host "Fetching URL: $url"

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get

        if ($response.records.Count -eq 0) {
            Write-Host "No more results. Exiting loop."
            break
        }

        $allResults += $response.records
        $page++
    }
    catch {
        Write-Warning ("Failed to fetch page ${page}: $($_)")
        break
    }
}

# $allResults now contains the combined JSON data from all pages
Write-Host "Retrieved $($allResults.Count) total results."

# Optional: Convert to JSON string if needed
# $json = $allResults | ConvertTo-Json -Depth 10

# Output to file (optional)
# $allResults | ConvertTo-Json -Depth 10 | Out-File -FilePath "all_results.json"

$allResults | Select-Object * | Export-Csv -NoTypeInformation -Path output.csv