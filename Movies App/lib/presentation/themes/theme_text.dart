import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constants/app_sizes.dart';
import 'theme_color.dart';

class ThemeText {
  ThemeText._();

  static TextTheme get _popinsTextStyle => GoogleFonts.poppinsTextTheme();

//////////////////////////////////////// Whites ///////////////////////////////////////////////
  static TextStyle get _whiteTitleLarge =>
      _popinsTextStyle.titleLarge!.copyWith(
        color: Colors.white,
        fontSize: AppSizes.size_20,
      );

  static TextStyle get _whiteHeadlineSmall =>
      _popinsTextStyle.headlineSmall!.copyWith(color: Colors.white);

  static TextStyle get _whiteTitleMedium =>
      _popinsTextStyle.titleMedium!.copyWith(
        color: Colors.white,
        fontSize: AppSizes.size_16,
      );

  static TextStyle get _whiteBodyMedium =>
      _popinsTextStyle.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: AppSizes.size_14,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _whiteLabelLarge =>
      _popinsTextStyle.labelLarge!.copyWith(
        color: Colors.white,
        fontSize: AppSizes.size_14,
      );

///////////////////////////////////// Vulacans //////////////////////////////////////////////////

  static TextStyle get _vulcanTitleLarge =>
      _popinsTextStyle.titleLarge!.copyWith(
        color: AppColors.vulcan,
        fontSize: AppSizes.size_20,
      );
  static TextStyle get _vulcanHeadlineSmall =>
      _popinsTextStyle.headlineSmall!.copyWith(color: AppColors.vulcan);

  static TextStyle get _vulcanTitleMedium =>
      _popinsTextStyle.titleMedium!.copyWith(
        color: AppColors.vulcan,
        fontSize: AppSizes.size_16,
      );

  static TextStyle get _vulcanBodyMedium =>
      _popinsTextStyle.bodyMedium!.copyWith(
        color: AppColors.vulcan,
        fontSize: AppSizes.size_14,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _vulcanLabelLarge => _popinsTextStyle.labelLarge!
      .copyWith(color: AppColors.vulcan, fontSize: AppSizes.size_14);

///////////////////////////////////// TextThemes //////////////////////////////////////////////////
  static getLightTextTheme() => TextTheme(
        titleLarge: _vulcanTitleLarge,
        headlineSmall: _vulcanHeadlineSmall,
        titleMedium: _vulcanTitleMedium,
        bodyMedium: _vulcanBodyMedium,
        labelLarge: _vulcanLabelLarge,
      );

  static getDarkTextTheme() => TextTheme(
        titleLarge: _whiteTitleLarge,
        headlineSmall: _whiteHeadlineSmall,
        titleMedium: _whiteTitleMedium,
        bodyMedium: _whiteBodyMedium,
        labelLarge: _whiteLabelLarge,
      );
}

extension TextThemeExtension on TextTheme {
  TextStyle get royalBlueTitleMedium => ThemeText._whiteTitleMedium.copyWith(
        color: AppColors.royalBlue,
        fontWeight: FontWeight.w600,
      );

  TextStyle get greyTitleMedium =>
      ThemeText._whiteTitleMedium.copyWith(color: AppColors.grey);

  TextStyle get violetHeadline6 =>
      titleLarge!.copyWith(color: AppColors.violet);

  TextStyle get vulcanBodyText2 => bodyMedium!.copyWith(
        color: AppColors.vulcan,
        fontWeight: FontWeight.w600,
      );
  TextStyle get greyCaption => bodySmall!.copyWith(color: Colors.grey);
}
