import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/about_screen.dart';
import './screens/settings_screen.dart';
import './screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const About(),
        '/settings': (context) => const Settings(),
        '/register': (context) => const Register(),
      },
    );
  }
}
