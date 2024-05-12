#!/bin/bash
set -e

# Upgrade all installed packages to their latest version
sudo yum update -y

# Remove unused dependencies
sudo yum autoremove -y

# Remove older kernels (if necessary)
sudo package-cleanup --oldkernels --count=1 -y

# Clean up
sudo yum clean all
