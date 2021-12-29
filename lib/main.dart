import 'package:flutter/material.dart';

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
    setState(() {
      number++;
    });
  }

  void _minusCounter() {
    setState(() {
      number--;
    });
  }

  setPreferences() {
    setState(() {});
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
              primary: Colors.teal, side: BorderSide(color: Colors.teal))),
      appBarTheme: const AppBarTheme(color: Colors.teal));

  void changesTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
