#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Remove disk and partition encryption as we currently don't support them
find src -type f -iname "*.cpp" -exec sed -i 's|m_encryptWidget->show()|m_encryptWidget->hide()|gi' {} +
