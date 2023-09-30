import 'package:bloc_06/presentation/view/widget/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/app_color.dart';

Widget buildTextField({
  required String hintText,
  required String textType,
  required String iconPath,
  Function(String)? onTextChange,
}) =>
    Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
        bottom: 14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0.sp),
        ),
        border: Border.all(
          color: AppColor.primaryFourElementText,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16.w,
            ),
            child: Center(
              child: AppImageWidget.asset(
                path: iconPath,
                width: 16.w,
                height: 16.w,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) => onTextChange!(value),
              autofocus: false,
              obscureText: textType == "password" ? true : false,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14.0.sp,
              ),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
