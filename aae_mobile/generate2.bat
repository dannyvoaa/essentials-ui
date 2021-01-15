call flutter clean
call flutter pub get
call flutter packages pub run build_runner build --delete-conflicting-outputs
call xcopy ".\.dart_tool\build\generated\aae\lib\inject\mobile_module.inject.dart" ".\lib\inject" /y /f