#!/usr/bin/env bash

# Install Python libraries using conda

# Update all installed packages
conda update --all --yes

# TODO: Switch to miniconda and only install what is needed

# Remove unused packages and caches
conda clean --all --yes
