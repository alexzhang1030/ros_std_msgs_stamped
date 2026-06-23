#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $0 [version]

Creates and pushes the release tag for std_msgs_stamped. If version is omitted,
the version is read from package.xml. The tag format is v<version>.

The GitLab pipeline publishes ROS-distro-specific packages:
ros-humble-std-msgs-stamped for jammy and ros-jazzy-std-msgs-stamped for noble from generated ROS install artifacts.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

cd "$(git rev-parse --show-toplevel)"

package_version=$(python3 - <<'PY'
import xml.etree.ElementTree as ET
print(ET.parse("package.xml").getroot().findtext("version"))
PY
)

ci_versions=$(python3 - <<'PY'
from pathlib import Path
versions = []
for line in Path(".gitlab-ci.yml").read_text().splitlines():
    stripped = line.strip()
    if stripped.startswith("package_version:"):
        versions.append(stripped.split(":", 1)[1].strip())
print(" ".join(sorted(set(versions))))
PY
)

version="${1:-$package_version}"
tag="v${version}"

if [[ "${version}" != "${package_version}" ]]; then
  echo "Release version ${version} does not match package.xml version ${package_version}" >&2
  exit 1
fi

if [[ "${ci_versions}" != "${version}" ]]; then
  echo "Release version ${version} does not match .gitlab-ci.yml package_version set: ${ci_versions}" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Working tree is not clean; commit or stash changes before releasing." >&2
  git status --short >&2
  exit 1
fi

git fetch origin --tags

if git rev-parse --verify --quiet "refs/tags/${tag}" >/dev/null; then
  echo "Tag ${tag} already exists." >&2
  exit 1
fi

current_branch=$(git branch --show-current)
if [[ -z "${current_branch}" ]]; then
  echo "Release must be run from a branch, not detached HEAD." >&2
  exit 1
fi

git push origin "${current_branch}"
git tag -a "${tag}" -m "Release ${tag}"
git push origin "${tag}"

echo "Released ${tag}"
echo "GitLab CI will publish ros-humble-std-msgs-stamped to jammy and ros-jazzy-std-msgs-stamped to noble."
