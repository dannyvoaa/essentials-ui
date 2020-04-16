# Use this script to clean and reset the American Essentials project after moving it to a new machine
# Failure to execute this script will result in the project not being buildable

#!/bin/zsh
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
cp .dart_tool/build/generated/aae/lib/inject/mobile_module.inject.dart lib/inject/