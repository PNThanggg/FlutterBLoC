import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constants/app_icon.dart';
import '../../widget/app_container.dart';
import '../../widget/app_scroolview.dart';
import 'bloc/sign_in_bloc.dart';
import 'widget/sign_in_appbar.dart';
import 'widget/sign_in_forget_password.dart';
import 'widget/sign_in_text_field.dart';
import 'widget/sign_in_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return AppContainer(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          child: AppScrollview(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildThirdPartyLogin(context),
                Center(
                  child: reusableText(
                    text: "Or use your email account to login",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 36.h,
                  ),
                  padding: EdgeInsets.only(
                    left: 25.0.w,
                    right: 25.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                        text: "Email",
                      ),
                      buildTextField(
                        hintText: "Enter your email address",
                        textType: "email",
                        iconPath: AppIcon.icUser,
                        onTextChange: (value) {
                          context.read<SignInBloc>().add(
                                EmailEvent(value),
                              );
                        },
                      ),
                      SizedBox(height: 5.0.h),
                      reusableText(
                        text: "Password",
                      ),
                      buildTextField(
                        hintText: "Enter your password",
                        textType: "password",
                        iconPath: AppIcon.icLock,
                        onTextChange: (value) {
                          context.read<SignInBloc>().add(
                                PasswordEvent(value),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                forgetPassword(),
                buildLoginAndRegButton(
                  buttonName: "Log in",
                  buttonType: "log_in",
                ),
                buildLoginAndRegButton(
                  buttonName: "Register",
                  buttonType: "register",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
