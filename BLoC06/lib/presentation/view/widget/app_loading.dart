import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/app_color.dart';

class AppLoading extends StatelessWidget {
  final Color? color;

  const AppLoading({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator(
                color: color ?? AppColor.blue,
              )
            : CupertinoActivityIndicator(
                color: color ?? AppColor.blue,
              ),
      ),
    );
  }
}
