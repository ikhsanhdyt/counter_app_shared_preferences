import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int number = 0;
  var isDark = false;

  void _addCounter() {
    number++;
    setPreferences();
  }

  void _minusCounter() {
    number--;
    setPreferences();
  }

  Future<void> setPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('myData')) {
      pref.clear();
    }
    final myData =
        json.encode({'number': number.toString(), 'isDark': isDark.toString()});

    pref.setString('myData', myData);

    setState(() {});
  }

  Future<void> getPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey('myData')) {
      final myData = json.decode(pref.getString('myData').toString())
          as Map<String, dynamic>;

      number = int.parse(myData["number"]);
      isDark = myData["isDark"] == "true" ? true : false;
    }
  }

  ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.teal,
      primarySwatch: Colors.teal,
      appBarTheme: const AppBarTheme(color: Colors.teal),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.teal,
              side: BorderSide(color: Colors.teal),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)))));

  ThemeData light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.teal,
      primarySwatch: Colors.teal,
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.teal,
              side: BorderSide(color: Colors.teal),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)))),
      appBarTheme: const AppBarTheme(color: Colors.teal));

  void changesTheme() {
    isDark = !isDark;

    setPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreference(),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? dark : light,
          home: Scaffold(
            appBar: AppBar(
              title: Text("Counter App"),
              actions: [Icon(Icons.undo)],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                changesTheme();
              },
              label: Icon(Icons.color_lens),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Current Number  : $number",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              _minusCounter();
                            },
                            child: Icon(Icons.remove)),
                        OutlinedButton(
                            onPressed: () {
                              _addCounter();
                            },
                            child: Icon(Icons.add))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
