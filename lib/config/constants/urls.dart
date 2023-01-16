class Urls {
  static const baseUrl = 'http://api.wisdomedu.uz/';

  static var getWordsPaths = Uri.parse('${baseUrl}api/download/words');
  static var getLenta = Uri.parse('${baseUrl}api/lenta');

  static getSpeakingView(int id) => Uri.parse("${baseUrl}api/catalogue/speaking/word/view/$id");
}
