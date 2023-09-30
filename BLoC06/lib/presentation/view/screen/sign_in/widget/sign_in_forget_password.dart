import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/app_color.dart';

Widget forgetPassword() => Container(
      margin: EdgeInsets.only(
        left: 25.0.w,
      ),
      width: 260.w,
      height: 44.h,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "Forgot password",
          style: TextStyle(
            color: AppColor.primaryText,
            decoration: TextDecoration.underline,
            decorationColor: AppColor.primaryText,
            fontSize: 12.0.sp,
          ),
        ),
      ),
    );
