import 'package:flutter/material.dart';

import 'application/firebase/firebase_options.dart';
import 'env.dart';
import 'presentation/onbording/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseInitializer.initialize(useLocal: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StartScreen(),
    );
  }
}
