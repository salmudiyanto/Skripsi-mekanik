import 'package:bengkel_mekanik/page/login.dart';
import 'package:bengkel_mekanik/page/utama.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Pencarian Mekanik Terdekat",
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginMekanik(),
        '/utama': (context) => UtamaScreen(),
      },
      // home: LoginMekanik(),
    );
  }
}
