import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_audio/services/Linked.dart';
import 'package:quran_audio/View/Pages/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getDatafromapi() {
    setState(() {
      Linked().getSurahList().then((allSurah) {
        Timer(const Duration(seconds: 7), () {
          if (mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahsList(
                          suars: allSurah,
                        )));
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDatafromapi(); //prepare data and move it to Homepage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("images/bcgimg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
            child: Image(
          image: AssetImage('images/splash.gif'),
        )),
      ),
    );
  }
}
