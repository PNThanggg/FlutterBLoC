import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants/languages.dart';
import '../bloc/language/language_bloc.dart';
import '../themes/theme_color.dart';
import 'navigation_list_item.dart';

class NavigationExpansionListItem extends StatelessWidget {
  final String title;
  final List<String> childList;

  const NavigationExpansionListItem({
    super.key,
    required this.title,
    required this.childList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        iconColor: AppColors.royalBlue,
        collapsedIconColor: AppColors.royalBlue,
        initiallyExpanded: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          for (int i = 0; i < childList.length; i++)
            NavigationListItem(
              title: childList[i],
              handlePress: () {
                context.read<LanguageBloc>().add(ChangePreferencesLanguageEvent(
                    language: Languages.languages[i]));
              },
              isSubItem: true,
            )
        ],
      ),
    );
  }
}
