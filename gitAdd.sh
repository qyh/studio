#!/bin/bash
git status | grep -e modified -e "new file" | awk -F "   " '{print $2}'
