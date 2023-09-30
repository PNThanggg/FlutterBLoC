import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/app_icon.dart';
import '../../../resources/app_color.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 40.h,
      bottom: 20.h,
      left: 25.w,
      right: 25.w,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _icon(
          iconPath: AppIcon.icGoogle,
        ),
        _icon(
          iconPath: AppIcon.icApple,
        ),
        _icon(
          iconPath: AppIcon.icFacebook,
        ),
      ],
    ),
  );
}

Widget _icon({Function()? onPressed, required String iconPath}) => AppTouchable(
      onPressed: onPressed,
      margin: EdgeInsets.only(
        left: 8.0.sp,
        right: 8.0.sp,
      ),
      child: AppImageWidget.asset(
        path: iconPath,
        width: 40.0.w,
        height: 40.0.w,
      ),
    );

Widget reusableText({
  required String text,
}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 5.0.h,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontSize: 14.0.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget buildLoginAndRegButton({
  required String buttonName,
  required String buttonType,
}) =>
    GestureDetector(
      onTap: () {},
      child: Container(
        width: 325.w,
        height: 50.h,
        margin: EdgeInsets.only(
          top: buttonType == "log_in" ? 40.0.h : 16.0.h,
          left: 25.0.w,
          right: 25.0.w,
        ),
        decoration: BoxDecoration(
          color: buttonType == "log_in" ? AppColor.primaryElement : AppColor.primaryBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(15.w),
          ),
          border: Border.all(
            color: buttonType == "log_in" ? Colors.transparent : AppColor.primaryFourElementText,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
              color: Colors.grey.withOpacity(0.1),
            )
          ],
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: buttonType == "log_in" ? AppColor.primaryBackground : AppColor.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 16.0.sp,
            ),
          ),
        ),
      ),
    );
