import '../../../../common/constants/language_constants.dart';
import 'tab.dart';

class TabConstants {
  TabConstants._();

  static const List<Tab> movieTabs = [
    Tab(
      index: 0,
      title: LanguageConstants.popular,
    ),
    Tab(
      index: 1,
      title: LanguageConstants.now,
    ),
    Tab(
      index: 2,
      title: LanguageConstants.soon,
    ),
  ];
}
