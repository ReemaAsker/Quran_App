import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quran_audio/services/Linked.dart';
import 'package:quran_audio/Model/Surah.dart';
import 'package:quran_audio/View/Pages/SearchPage.dart';

import 'SurahPage.dart';

class SurahsList extends StatefulWidget {
  final List<Surah> suars;
  const SurahsList({super.key, required this.suars});

  @override
  State<SurahsList> createState() => _SurahsListState();
}

class _SurahsListState extends State<SurahsList> {
  @override
  void initState() {
    super.initState();
  }

  Linked lin = Linked();

  void prepareSurahPages(int surahnum) {
    //this method for :get the surah chosen pages and audioUrl and move it to QuranAudio page to show them
    lin.prepareAudioURL(surahnum).then(
      (audio) {
        lin.prepareSurahPages(surahnum).then((pages) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranAudio(
                  surahPages: pages,
                  audioUrllink: audio,
                ),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bcgimg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Color.fromARGB(255, 250, 244, 229).withOpacity(0.5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ترتيب\nالسورة',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
                        Text(
                          'اسم السورة',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
                        Text(' '),
                        Text(''),
                        Text(''),
                        Text(
                          'مدنية/مكية',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 114,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: GestureDetector(
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 250, 244, 229),
                                      Color.fromARGB(255, 214, 209, 196),
                                    ],
                                  ),
                                ),
                                child: ListTile(
                                  title: Text('   ${widget.suars[index].name}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      'عدد الايات : ${widget.suars[index].noOfAyah} '),
                                  leading: Text('   ${index + 1}'),
                                  trailing: Image(
                                      image: widget.suars[index].imgSurah()),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (mounted) {
                                prepareSurahPages(index + 1);
                              }
                              ;
                            }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  )),
              child: CircleAvatar(
                backgroundColor: Colors.brown.withOpacity(0.8),
                foregroundColor: Colors.brown[50],
                maxRadius: 30,
                child: Icon(
                  Icons.search,
                ),
              ),
            ),
          )),
    );
  }
}
