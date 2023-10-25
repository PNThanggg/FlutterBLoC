import 'package:flutter/material.dart';

import '../../../domain/entities/cast_member.dart';
import 'cast_card_widget.dart';

class CastListView extends StatelessWidget {
  final List<CastMember> castMembers;

  const CastListView({
    Key? key,
    required this.castMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemBuilder: (ctx, i) => CastCardWidget(castMember: castMembers[i]),
        itemCount: castMembers.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}
