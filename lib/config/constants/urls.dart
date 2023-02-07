class Urls {
  static const baseUrl = 'http://api.wisdomedu.uz/';

  static var getWordsPaths = Uri.parse('${baseUrl}api/download/words');
  static var getLenta = Uri.parse('${baseUrl}api/lenta');
  static var getTariffs = Uri.parse('${baseUrl}api/subscribe/tariffs');

  static var login = Uri.parse('${baseUrl}api/auth/login');
  static var verify = Uri.parse('${baseUrl}api/auth/verify');

  static getSpeakingView(int id) => Uri.parse("${baseUrl}api/catalogue/speaking/word/view/$id");
}
