import 'package:flutter/cupertino.dart';

import '../../app_localizations.dart';

extension StringExtension on String {
  String get intelTrim {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String translate(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
