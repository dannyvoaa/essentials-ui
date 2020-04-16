import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/startup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Aewa());
}

class Aewa extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'American Essentials (Web Admin)',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: BrandColors.blue,
          height: Dimensions.buttonHeight,
          textTheme: ButtonTextTheme.primary,
        ),
        canvasColor: BrandColors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.size4px),
            borderSide: BorderSide(
              color: CustomColors.separator,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.size4px),
            borderSide: BorderSide(
              color: CustomColors.separator,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.size4px),
            borderSide: BorderSide(
              color: BrandColors.red,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.size4px),
            borderSide: BorderSide(
              color: BrandColors.blue,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.size4px),
            borderSide: BorderSide(
              color: BrandColors.red,
              width: 1.0,
            ),
          ),
          contentPadding: EdgeInsets.all(12),
          errorStyle: TextStyles.body().copyWith(
            color: BrandColors.red,
          ),
          isDense: true,
        ),
        primarySwatch: ColorConverter.createMaterialColor(BrandColors.blue),
        textTheme: TextTheme(
          bodyText1: TextStyles.body(),
          bodyText2: TextStyles.body(),
          button: TextStyles.headline(),
          caption: TextStyles.body(),
          headline1: TextStyles.body(),
          headline2: TextStyles.body(),
          headline3: TextStyles.body(),
          headline4: TextStyles.body(),
          headline5: TextStyles.body(),
          headline6: TextStyles.body(),
          overline: TextStyles.body(),
          subtitle1: TextStyles.body(),
          subtitle2: TextStyles.body(),
        ),
      ),
      home: Startup(),
    );
  }
}
