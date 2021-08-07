//@dart = 2.9
import 'package:chess_lib/providers/theme.provider.dart';
import 'package:chess_lib/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = new ThemeProvider();

  @override
  void initState(){
    super.initState();
    getCurrentTheme();
  }

  void getCurrentTheme() async {
    themeChangeProvider.setTheme = await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeChangeProvider,
      child: MaterialApp(
        title: 'ChessLib',
        home: Home(),
      ),
    );
  }
}
