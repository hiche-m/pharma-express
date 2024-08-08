import 'package:code/Models/phone_local.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/Utils/text_formulations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryLocalDialog extends StatelessWidget {
  const CountryLocalDialog({required this.countryLocals, super.key});

  final List<PhoneLocal> countryLocals;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Palette.backgroundColor,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      title: Text(AppLocalizations.of(context)!.selectCountry),
      children: [
        SizedBox(
          width: 0.9.w,
          height: 150.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int index = 0; index < countryLocals.length; index++)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(countryLocals[index]);
                        },
                        child: Ink(
                            child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30.r,
                                width: 40.r,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: countryLocals[index].flagPath != null
                                      ? SvgPicture.asset(
                                          countryLocals[index].flagPath!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.rectangle),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text(
                                  countryLocals[index].countryCode.toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Palette.secoundaryText,
                                  ),
                                ),
                              ),
                              Text(
                                TextFM.getCountryByIndex(
                                    AppLocalizations.of(context)!.countries,
                                    index),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ))),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
