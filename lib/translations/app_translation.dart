import 'ru.dart';
import 'tm.dart';
import 'en.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    'en': en,
    'ru': ru,
    'tm': tm,
  };
}
