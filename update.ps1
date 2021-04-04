$gradleVersion = "7.0-rc-2"
$sha = $(Invoke-RestMethod -Uri https://downloads.gradle.org/distributions/gradle-${gradleVersion}-bin.zip.sha256)

dir -Recurse -Filter Dockerfile | ForEach-Object {
    (Get-Content -Path $_.FullName) -replace "ENV GRADLE_VERSION .+$", "ENV GRADLE_VERSION ${gradleVersion}" | Set-Content $_.FullName
    (Get-Content -Path $_.FullName) -replace "GRADLE_DOWNLOAD_SHA256=.+$", "GRADLE_DOWNLOAD_SHA256=${sha}" | Set-Content $_.FullName
}
(Get-Content -Path .github/workflows/ci.yaml) -replace "expectedGradleVersion: .+", "expectedGradleVersion: ${gradleVersion}" | Set-Content .github/workflows/ci.yaml
