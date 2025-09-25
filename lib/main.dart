import 'package:flutter/material.dart';
import 'package:task1/pages/home.dart';
Future<void> main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Color(0xFF32AE64), // Color of selected text
            selectionHandleColor: Color(0xFF32AE64),
            cursorColor: Colors.green.shade600// Color of the selection handles (cursors)
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: UserListPage(),
    ),
  );
}


