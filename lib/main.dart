import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/firebase/firebase_options.dart';
import 'application/user/auth_bloc.dart';
import 'env.dart';
import 'presentation/onbording/splash_screen.dart';
import 'providers/dashboard_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/question_provider.dart';

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
    return MultiProvider(
           providers: [
        ChangeNotifierProvider(create: (context) => UserBloc()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => JournalProvider()),
        ChangeNotifierProvider(create: (context) => QuestionProvider()),

      ],
      child: MaterialApp(
        title: appName,
      
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
