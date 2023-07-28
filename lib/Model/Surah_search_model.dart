class SearchModel {
  final String aya_text;
  final String surah;
  final int page_num;
  final int juz;
  final int aya_num;

  SearchModel(
      {required this.aya_text,
      required this.aya_num,
      required this.surah,
      required this.page_num,
      required this.juz});
}
