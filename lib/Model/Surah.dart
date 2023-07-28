import 'package:flutter/cupertino.dart';

class Surah {
  final String name;
  final int noOfAyah;
  final bool isMadnia;
  late ImageProvider img;

  Surah({required this.name, required this.noOfAyah, required this.isMadnia});

  ImageProvider imgSurah() {
    return AssetImage(isMadnia ? 'images/madina.png' : 'images/kaba.png');
  }
}
