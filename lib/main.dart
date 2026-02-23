import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hollyb1213/app.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    // Forward Flutter framework errors to the zone handler so they are
    // printed when running `flutter run`.
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };

    configEasyLoading();
    runApp(const MyApp());
  }, (error, stack) {
    // Print uncaught errors and stack traces to the console/log.
    // This helps find crashes that otherwise silently exit.
    debugPrint('UNCAUGHT ERROR: $error');
    debugPrintStack(stackTrace: stack);
  });
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.grey
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}
