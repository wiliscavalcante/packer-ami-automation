#!/bin/bash
set -e

# Upgrade all installed packages to their latest version
sudo dnf update -y

# Remove unused dependencies
sudo dnf autoremove -y

# Remove older kernels (if necessary, here using dnf)
sudo dnf remove $(dnf repoquery --installonly --latest-limit=-1 -q)

# Clean up
sudo dnf clean all
# Other cleanup commands...
