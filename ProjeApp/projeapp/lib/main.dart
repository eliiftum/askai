import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginPage();
          }
          return const Scaffold(
            body: Center(
              child: Text('Projemize Hoşgeldiniz! ASK TO AI'),
            ),
          );
        },
      ),
    );
  }
}


