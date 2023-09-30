import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/app_color.dart';

AppBar buildAppBar() => AppBar(
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0.sp),
        child: Container(
          color: AppColor.primarySecondaryBackground,
          width: 1.0.sp,
        ),
      ),
      title: Text(
        "Log In",
        style: TextStyle(
          color: AppColor.primaryText,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
