import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utilits/constant.dart';

class Network {
  Future<Map<String, dynamic>> fetchData() async {
    var response = await http.get(Uri.parse(baseMetaDataAPI));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('erorr');
  }

  Future<Map<String, dynamic>> fectchDatapages(int surahNumber) async {
    //from page number.. to page number ..
    var response = await http.get(Uri.parse('$baseFromToDataAPI$surahNumber'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('erorr');
  }

  Future<String> audioUrlLink(int surahNumber) async {
    String audioNum = FormatNumber(surahNumber);

    return '$baseaudioUrlAPI$audioNum.mp3';
  }

  Future<Map<String, dynamic>> ayahSerarchResult(String ayaText) async {
    String querySearch = "\"$ayaText\"";
    var response = await http.get(Uri.parse('$baseSearchAPI$querySearch'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('error');
  }

  String SurahImage(int pageIndex) {
    String pageNum = FormatNumber(pageIndex);
    return '$baseSearchImageAPI$pageNum.png'; /////
  }

  String FormatNumber(int num) {
    String newText = num < 10 ? '00$num' : (num >= 100 ? '$num' : '0$num');

    return newText;
  }
}
