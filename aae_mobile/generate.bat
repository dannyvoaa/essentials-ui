@echo off
flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs
copy .dart_tool\build\generated\aae\lib\inject\mobile_module.inject.dart lib\inject