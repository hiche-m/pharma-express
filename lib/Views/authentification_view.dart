import 'package:code/Components/loading_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/authentification_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code/Components/login_form.dart';
import 'package:code/Components/signup_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  Future loadLocals() async {
    var result = await AuthVM.getLocals();
    setState(() {
      AuthVM.countryLocals = result;
      AuthVM.loadingLocals = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocals();
    AuthVM.controller = PageController(initialPage: AuthVM.pageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    AuthVM.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AuthVM.loadingLocals) {
      return SafeArea(
          child: Container(
              color: Palette.mainColor,
              child: const Center(child: MyLoadingIndicator(type: 1))));
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/Assets/Images/medecine_wallpaper.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Palette.superLight,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, -10.h),
                        )
                      ],
                    ),
                    child: UnconstrainedBox(
                      constrainedAxis: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.all(40.r),
                        child: Column(
                          children: [
                            ExpandablePageView(
                              controller: AuthVM.controller,
                              children: const [
                                LogInForm(),
                                SignUpForm(),
                              ],
                              onPageChanged: (index) {
                                setState(() {
                                  AuthVM.pageIndex = index;
                                });
                              },
                            ),
                            SizedBox(height: 20.h),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            "${AuthVM.pageIndex == 0 ? AppLocalizations.of(context)!.noAccount : AppLocalizations.of(context)!.haveAccount} ",
                                        style: TextStyle(
                                          color: Palette.secoundaryText,
                                          fontSize: 16.sp,
                                        )),
                                    TextSpan(
                                        text: AuthVM.pageIndex == 0
                                            ? AppLocalizations.of(context)!
                                                .signUp
                                            : AppLocalizations.of(context)!
                                                .logIn,
                                        style: TextStyle(
                                          color: Palette.mainColor,
                                          fontSize: 16.sp,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            AuthVM.togglePage();
                                            setState(() {});
                                          }),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
