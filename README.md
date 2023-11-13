# expenses_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 06. Course Section - Responsive

App rotation disable code - This code prevent when the phone rotation happens, app not rotated to landscape mode
```
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized(); // only portrat mode happens do this
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (fn) => {
    runApp() // Full run app code
    }
}
```
How to find current app running device screen width and height??
```
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
```
