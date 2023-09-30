import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constants/app_image.dart';
import '../../resources/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import 'bloc/welcome_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12.0.sp,
            ),
            width: 375.w,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    state.page = value;
                    context.read<WelcomeBloc>().add(WelcomeEvent());

                    // BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                      context: context,
                      index: 1,
                      title: "First See Learning",
                      subTitle: "Forget about a for of paper all knowledge in one learning.",
                      imgPath: AppImage.imgBoy,
                      textButton: "Next",
                    ),
                    _page(
                      context: context,
                      index: 2,
                      title: "Connect With Everyone",
                      subTitle:
                          "Allays keep in touch with your tutor & friend. Let's get connected.",
                      imgPath: AppImage.imgMan,
                      textButton: "Next",
                    ),
                    _page(
                      index: 3,
                      context: context,
                      title: "Always Fascinated Learning",
                      subTitle:
                          "Anywhere, anytime. The time is at our discretion so study whenever you want",
                      imgPath: AppImage.imgReading,
                      textButton: "Get started",
                    ),
                  ],
                ),
                Positioned(
                  bottom: 80.0.h,
                  child: DotsIndicator(
                    position: state.page,
                    dotsCount: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                      color: AppColor.primaryThreeElementText,
                      size: const Size.square(8.0),
                      activeSize: const Size(24.0, 8.0),
                      activeColor: AppColor.primaryElement,
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _page({
    required BuildContext context,
    required int index,
    required String title,
    required String subTitle,
    required String imgPath,
    required String textButton,
  }) =>
      Column(
        children: [
          SizedBox(
            width: 345.w,
            height: 345.w,
            child: AppImageWidget.asset(
              path: imgPath,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColor.primaryText,
              fontSize: 24.0.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 30.0.w,
              right: 30.0.w,
            ),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primarySecondaryElementText,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          AppTouchable(
            onPressed: () {
              if (index < 3) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/sign_in_screen",
                  (route) => false,
                );
              }
            },
            width: 325.0.w,
            height: 50.0.h,
            margin: EdgeInsets.only(
              top: 100.0.h,
              left: 25.0.w,
              right: 25.0.w,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryElement,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0.sp),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Center(
              child: Text(
                textButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      );
}
