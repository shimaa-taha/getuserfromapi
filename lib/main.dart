import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1/pages/home.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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


