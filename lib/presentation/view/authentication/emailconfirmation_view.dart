import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/header_custom.dart';
import '../../../customwidget/richtext_custom.dart';
import '../../../customwidget/sizedbox_custom.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class EmailConfirmationView extends StatelessWidget {
  const EmailConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppHeightSize.h12, horizontal: AppWidthSize.w20),
            child: ListView(children: [
              SizedBoxCustom(
                height: AppHeightSize.h135,
              ),
              Image.asset(
                ImagePath.undrawVerified,
                width: AppWidthSize.w180,
                height: AppHeightSize.h180,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              HeaderCustom(
                text1: LocaleKeys.emailConfirmationText.tr(),
                subText: LocaleKeys.subEmailConfirmationText.tr(),
                textAlign: TextAlign.center,
              ),
              SizedBoxCustom(
                height: AppHeightSize.h24,
              ),
              CustomButtonPrimary(
                onPressed: () async {
                  await LaunchApp.openApp(
                      androidPackageName: 'com.google.android.gm',
                      // openStore: true
                      openStore: false
                      );
                },
                text: Text(LocaleKeys.openEmailText.tr()),
              ),
              SizedBoxCustom(
                height: AppHeightSize.h16,
              ),
              RichTextCustom(
                  text1: LocaleKeys.activationEmailText.tr(),
                  text2: LocaleKeys.pressHereText.tr(),
                  color: ColorManager.brownColor,
                  textDecoration: TextDecoration.none,
                  onPressed: () => NavigationManager.pushNamed(
                      RouteConstants.newPasswordRoute)),
              SizedBoxCustom(
                height: AppHeightSize.h35,
              ),
            ])));
  }
}
