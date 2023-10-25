import 'package:flutter/material.dart';
import 'package:movies_app/common/extensions/string_extensions.dart';

import '../../common/constants/language_constants.dart';
import '../../core/errors/failure.dart';
import 'button_widget.dart';

class AppErrorWidget extends StatelessWidget {
  final ErrorType errorType;
  final void Function() handleRetryPress;
  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.handleRetryPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorType == ErrorType.api
              ? LanguageConstants.someThingWentWrongError.translate(context)
              : LanguageConstants.checkNetworkError.translate(context),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: LanguageConstants.retry,
              handlePress: handleRetryPress,
            ),
            ButtonWidget(
              text: LanguageConstants.feedback,
              handlePress: () {},
            ),
          ],
        ),
      ],
    );
  }
}
