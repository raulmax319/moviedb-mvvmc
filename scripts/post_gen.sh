#!/bin/sh

echo "✅ Podfile.lock removed"
rm -f Podfile.lock

echo "✅ Pods removed"
rm -rf Pods

echo "✅ xcworkspace removed"
rm -rf *.xcworkspace

if [ -f "Podfile" ]; then
    echo "🚀 Installing Pods"
    pod install
fi