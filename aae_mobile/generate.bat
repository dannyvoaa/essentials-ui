@echo off
call flutter pub get && call flutter packages pub run build_runner build --delete-conflicting-outputs
copy .dart_tool\build\generated\aae\lib\inject\mobile_module.inject.dart lib\inject /Y