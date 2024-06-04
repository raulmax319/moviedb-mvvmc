#!/bin/sh

xcodeproj=$(find . -maxdepth 1 -type d -name "*.xcodeproj" -print | head -1)
rm -rf $xcodeproj
