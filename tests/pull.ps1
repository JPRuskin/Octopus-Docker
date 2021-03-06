param (
  [Parameter(Mandatory=$true)]
  [string]$UserName,
  [Parameter(Mandatory=$true)]
  [string]$Password,
  [Parameter(Mandatory=$true)]
  [string]$OctopusVersion
)

$env:OCTOPUS_VERSION=$OctopusVersion;

Write-Host "docker login -u=`"$UserName`" -p=`"#########`""
& docker login -u="$UserName" -p="$Password"
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

Write-Host "docker-compose --file .\docker-compose.yml --file .\tests\docker-compose.yml pull"
& docker-compose --file .\docker-compose.yml --file .\tests\docker-compose.yml pull
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}