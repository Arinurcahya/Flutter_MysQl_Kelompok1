import 'package:flutter/material.dart';
import 'package:flutter_mysql_kelompok1/home.dart';
import 'package:flutter_mysql_kelompok1/providers/note_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter + MySQl',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
      ),
    );
  }
}