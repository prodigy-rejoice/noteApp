import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/screens/animation_home.dart';
import 'package:noteapp/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAO2QujqYLfEDCxK61MX-4N5_tlTK9aIqE',
          appId: '1:950267603417:android:61b7220fb2573a07f891c8',
          messagingSenderId: '950267603417',
          projectId: 'noteapp-37b9d'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      home: NotHomePage(),
    );
  }
}
