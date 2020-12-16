# Code Authority, Inc | American Airlines - AAE

## Overview
The AA Essentials mobile app is built using [Flutter](http://flutter.dev/). This lets us
write our UI code once in Dart and deploy to both Android and iOS.

## Architecture
AAE is built around MVVM principles using Components and BLoC

## Things to Install

### Android SDK

A good first place to start is the Flutter guide for setting up your host
for general Flutter development [here](https://flutter.dev/docs/get-started/install). This
will walk you through setting up Android Studio and the Android SDK.

Alternatively feel free to use vim, vscode, or pretty much any other editor that has a Dart plugin.

After getting the Android SDK, add platform-tools to your `PATH`:

```shell
## add to your ~/.zshrc
export PATH=$PATH:/Users/<name>/Library/Android/Sdk/platform-tools
```

Source your `~/.zshrc` or restart your shell and verify `adb` is found:

```shell
## prints adb's version and exit:
adb version
```

## Prepare your Android Device

### Enable Developer Mode on Android

Enabling developer mode on your Android device lets you connect it to `adb`,
grab logs via `adb logcat`, get a shell on your device via `adb shell`, and
more.

Follow the instructions
[here](https://developer.android.com/studio/debug/dev-options).

## Building

Make sure you're one the beta Flutter channel. use `flutter channel` to see your current channel.
If you aren't on beta run: `flutter channel beta`, and then `flutter upgrade`.

This repo uses build_runner for code generation, use this command to generate the required code.

```shell
flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs
```
After code generation is completed copy `/.dart_tool/build/generated/aae/lib/inject/mobile_module.inject.dart` to `lib/inject`.

```shell
cp .dart_tool/build/generated/aae/lib/inject/mobile_module.inject.dart lib/inject/
```

## Creating New Components

To create new components use the `component-generate.sh` file provided in the repo. We do ask that you stick to the preexisting naming convention with files and directories having underscores

> Example
```shell
your_component/bloc/your_component_bloc.dart
```
> When initializing your new component you will be prompted to enter a name for it in this case we decided to call the new component for this example `your_component`.

This script will generate boilerplate code for your components view, repository, and buisness logic based on the existing architecture. 

After running this script all you would need to do is add in the other parametes that you would require for your new component. Additional instructions on how to link the new component with the navigation stack and the injection module will be in the heading of the appropriate generated file.