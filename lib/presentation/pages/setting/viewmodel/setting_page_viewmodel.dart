import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/domain/entities/def_enum.dart';

class SettingPageViewModel extends BaseViewModel {
  SettingPageViewModel({required super.context});

  RemindOption currentRemind = RemindOption.manual;
  ThemeOption currentTheme = ThemeOption.day;
  LanguageOption currentLang = LanguageOption.uzbek;
  int currentHourValue = 1;
  int currentMinuteValue = 0;
  int currentRepeatHourValue = 1;
  double fontSizeValue = 4;
}
