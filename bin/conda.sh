#!/usr/bin/env bash

# Install Python libraries using conda

# Update all installed packages
conda update --all --yes

# Remove unused packages and caches
conda clean --all --yes
