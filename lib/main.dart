import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:task1/pages/home.dart';
Future<void> main() async {
  ///code sets the preferred device orientation for the app to portrait mode only. It uses SystemChrome.setPreferredOrientations() to restrict the app's screen rotation, allowing only DeviceOrientation.portraitUp orientation. This prevents the app from rotating to landscape mode when the device is turned sideways.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Color(0xFF32AE64),
            selectionHandleColor: Color(0xFF32AE64),
            cursorColor: Colors.green.shade600
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: UserListPage(),
    ),
  );
}


