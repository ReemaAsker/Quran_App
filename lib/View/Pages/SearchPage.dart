import 'package:flutter/material.dart';
import 'package:quran_audio/services/Linked.dart';
import 'package:quran_audio/services/Network.dart';
import 'package:quran_audio/Model/Surah_search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  void showImageAlert(int pageNum) {
    showDialog(
      context: context,
      builder: (context) {
        return InteractiveViewer(
          panEnabled: true,
          minScale: 0.1,
          maxScale: 5.0,
          child: AlertDialog(
            content: Image.network(
                Network().SurahImage(pageNum), // Replace with your image URL
                fit: BoxFit.fill),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bcgimg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.brown.withOpacity(0.2),
                          hintText:
                              'اكتب ما تريد البحث عنه في القران الكريم هنا..',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      FutureBuilder<List<SearchModel>>(
                        future: Linked().getResults(_searchController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('No results');
                          } else {
                            List<SearchModel> searchResult = snapshot.data!;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.brown,
                                        ),
                                        child: Text(
                                          'عدد النتائج : ${searchResult.length}',
                                          style: TextStyle(
                                            color: Colors.brown[50],
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: searchResult.map((result) {
                                    return GestureDetector(
                                      onTap: () {
                                        showImageAlert(result.page_num);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.brown[50],
                                        ),
                                        margin: EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'سورة ${result.surah} ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '(الجزء ${result.juz})',
                                                  style: TextStyle(
                                                    color: Colors.brown,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          subtitle: Text(
                                            '"${result.aya_text}" (صفحة ${result.page_num})  (اية ${result.aya_num}) ',
                                            style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
