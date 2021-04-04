#!/usr/bin/env bash
set -o errexit -o nounset

gradleVersion=7.0-rc-2
sha=$(curl --fail --show-error --silent --location https://downloads.gradle.org/distributions/gradle-${gradleVersion}-bin.zip.sha256)

sed --regexp-extended --in-place "s/ENV GRADLE_VERSION .+$/ENV GRADLE_VERSION ${gradleVersion}/" ./*/*/Dockerfile
sed --regexp-extended --in-place "s/GRADLE_DOWNLOAD_SHA256=.+$/GRADLE_DOWNLOAD_SHA256=${sha}/" ./*/*/Dockerfile
sed --regexp-extended --in-place "s/expectedGradleVersion: .+$/expectedGradleVersion: ${gradleVersion}/" .github/workflows/ci.yaml
