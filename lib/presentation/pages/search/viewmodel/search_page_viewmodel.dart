import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/di/app_locator.dart';

class SearchPageViewModel extends BaseViewModel {
  SearchPageViewModel({required super.context});

  Future<void> searchByWord(String word) async {
    var words = await locator<DBHelper>().searchByWord(word);
    print(words);
  }
}
