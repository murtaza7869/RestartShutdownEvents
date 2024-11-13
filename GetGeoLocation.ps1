param (
    [switch]$ShowMap  # Optional parameter to control Google Maps display
)

# Step 1: Retrieve the public IP address
$publicIP = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip

# Step 2: Use IP geolocation service to get location data
try {
    $geoData = Invoke-RestMethod -Uri "https://ipinfo.io/$publicIP/json"
    
    # Extract location data from the response
    $ip = $geoData.ip  
    $hostname = $geoData.hostname  
    $city = $geoData.city  
    $region = $geoData.region  
    $country = $geoData.country  
    $loc = $geoData.loc  
    $org = $geoData.org  
    $postal = $geoData.postal  
    $timezone = $geoData.timezone  

    # Display the IP-based location information
    Write-Output "Location Information:"
    Write-Output "Public IP: $ip"  
    Write-Output "Hostname: $hostname"  
    Write-Output "City: $city"  
    Write-Output "Region: $region"  
    Write-Output "Country: $country"  
    Write-Output "Coordinates (Latitude, Longitude): $loc"  
    Write-Output "Organization: $org"  
    Write-Output "Postal Code: $postal"  
    Write-Output "Timezone: $timezone"  

    # Step 3: Open Google Maps with the latitude and longitude if -ShowMap is specified
    if ($ShowMap) {
        $googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$loc"
        Start-Process $googleMapsUrl
    } else {
        Write-Output "Google Maps display is disabled. Use the -ShowMap parameter to enable."
    }

} catch {
    Write-Output "Failed to retrieve IP-based location information. Check your internet connection or the availability of the IP geolocation service."
}
