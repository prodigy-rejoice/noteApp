import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/home.dart';

class NotHomePage extends StatefulWidget {
  const NotHomePage({super.key});

  @override
  State<NotHomePage> createState() => _NotHomePageState();
}

class _NotHomePageState extends State<NotHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())));
    return Scaffold(body: buildUI());
  }
}

Widget buildUI() {
  return Center(
    child: Lottie.asset("assets/animations/girl.json"),
  );
}
