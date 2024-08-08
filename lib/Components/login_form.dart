import 'package:code/Components/main_input.dart';
import 'package:code/Components/main_input_button.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/authentification_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _hidePassword = true;
  List<String?> loginErrorList = List.filled(2, null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: Form(
          key: AuthVM.loginKey,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.logIn,
                style: Palette.h1,
              ),
              SizedBox(height: 30.h),
              MainInput.fromMap({
                "placeholder":
                    "${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.or} ${AppLocalizations.of(context)!.phone}",
                "autoFocus": true,
                "validator": (String? value) {
                  bool isFormatted =
                      Params.phoneFormat1.hasMatch(value ?? '') ||
                          Params.phoneFormat2.hasMatch(value ?? '') ||
                          EmailValidator.validate(value ?? '');

                  if (!isFormatted) {
                    setState(() {
                      loginErrorList[0] =
                          'Please enter a valid email address or phone number.';
                    });
                    return '';
                  }
                  setState(() {
                    loginErrorList[0] = null;
                  });
                  return null;
                },
                "error": loginErrorList[0],
              }),
              SizedBox(height: 10.h),
              MainInput.fromMap({
                "placeholder": AppLocalizations.of(context)!.password,
                "tailingIcon": FaIcon(
                  !_hidePassword
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  color: Palette.secoundaryText,
                ),
                "tailingAction": () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                "obscure": _hidePassword,
                "validator": (String? value) {
                  if (value.toString().length < 8) {
                    setState(() {
                      loginErrorList[1] = 'Please enter a valid password.';
                    });
                    return '';
                  }
                  setState(() {
                    loginErrorList[1] = null;
                  });
                  return null;
                },
                "error": loginErrorList[1],
              }),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Palette.mainColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              MainInputButton(
                label: AppLocalizations.of(context)!.logIn,
                onPressed: () {
                  if (AuthVM.loginKey.currentState!.validate()) {
                    print("Valid!");
                  }
                },
              ),
            ],
          ),
        ));
  }
}
