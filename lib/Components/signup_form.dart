import 'dart:developer';

import 'package:code/Components/country_local_dialog.dart';
import 'package:code/Components/date_input.dart';
import 'package:code/Components/gender_picker.dart';
import 'package:code/Components/main_input.dart';
import 'package:code/Components/main_input_button.dart';
import 'package:code/Services/auth_service.dart';
import 'package:code/Utils/parameters.dart';
import 'package:code/Utils/phone_length_limit_formatter.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/authentification_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var _selectedLocal = AuthVM.countryLocals[0];
  List<String?> signupErrorList = List.filled(6, null);
  bool _emailValid = false;
  bool _phoneValid = false;
  Map<String, dynamic> formValues = {
    "firstname": '',
    "lastname": '',
    "phoneNumber": '',
    "email": '',
    "password": '',
    "sex": 0,
    "dateOfBirth": '',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: Form(
          key: AuthVM.signupKey,
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                  AppLocalizations.of(context)!.signUp,
                  style: Palette.h1,
                ),
              ),
              SizedBox(height: 30.h),
              MainInput(
                placeholder: AppLocalizations.of(context)!.lname,
                onChanged: (value) {
                  formValues['lastname'] = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      signupErrorList[0] = 'Please enter a last name.';
                    });
                    return '';
                  }
                  setState(() {
                    signupErrorList[0] = null;
                  });
                  return null;
                },
                error: signupErrorList[0],
                keyboardType: TextInputType.name,
                /* autoFocus: true, */
              ),
              SizedBox(height: 10.h),
              MainInput(
                placeholder: AppLocalizations.of(context)!.fname,
                onChanged: (value) {
                  formValues['firstname'] = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      signupErrorList[1] = 'Please enter a first name.';
                    });
                    return '';
                  }
                  setState(() {
                    signupErrorList[1] = null;
                  });
                  return null;
                },
                error: signupErrorList[1],
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10.h),
              DateInput(
                placeholder: 'Birth Date (dd/MM/yyyy)',
                onChanged: (DateTime? pickedDate) {
                  if (pickedDate != null) {
                    formValues['dateOfBirth'] =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  }
                },
              ),
              SizedBox(height: 10.h),
              GenderPicker(
                initialValue: formValues['sex'],
                onChanged: (int? selected) {
                  log(selected.toString());
                  formValues['sex'] = selected;
                },
              ),
              SizedBox(height: 10.h),
              MainInput(
                placeholder: "+${_selectedLocal.countryCode}XXXXXXXXX",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s]')),
                  LengthLimitingTextInputFormatter(13),
                  PhoneLengthLimitingFormatter(),
                ],
                validator: (String? value) {
                  _phoneValid = Params.phoneFormat1.hasMatch(value ?? '') ||
                      Params.phoneFormat2.hasMatch(value ?? '');

                  if (!_phoneValid && !_emailValid) {
                    setState(() {
                      signupErrorList[2] =
                          'Please enter a valid phone number or email address.';
                    });
                    return '';
                  }

                  setState(() {
                    signupErrorList[3] = null;
                    signupErrorList[2] = null;
                  });
                  return null;
                },
                error: signupErrorList[2],
                leadingIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: _selectedLocal.flagPath != null
                      ? SvgPicture.asset(_selectedLocal.flagPath!)
                      : const Icon(Icons.rectangle),
                ),
                leadingAction: () async {
                  var result = await showDialog(
                    context: context,
                    builder: (context) =>
                        CountryLocalDialog(countryLocals: AuthVM.countryLocals),
                  );
                  if (result != null && result != _selectedLocal) {
                    setState(() {
                      _selectedLocal = result;
                    });
                  }
                },
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  formValues['phoneNumber'] = value;

                  bool isEmpty = value == null || value.isEmpty;
                  if (_phoneValid != isEmpty) {
                    setState(() {
                      _phoneValid = isEmpty;
                    });
                  }
                },
              ),
              SizedBox(height: 10.h),
              MainInput(
                placeholder: AppLocalizations.of(context)!.email,
                validator: (String? value) {
                  _emailValid = EmailValidator.validate(value ?? "");

                  if (!_emailValid && !_phoneValid) {
                    setState(() {
                      signupErrorList[3] =
                          'Please enter a valid email address or phone number.';
                    });
                    return '';
                  }

                  setState(() {
                    signupErrorList[3] = null;
                    signupErrorList[2] = null;
                  });
                  return null;
                },
                error: signupErrorList[3],
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  formValues['email'] = value;

                  bool isEmpty = value == null || value.isEmpty;
                  if (_emailValid != isEmpty) {
                    setState(() {
                      _emailValid = isEmpty;
                    });
                  }
                },
              ),
              SizedBox(height: 10.h),
              MainInput(
                placeholder: AppLocalizations.of(context)!.password,
                obscure: true,
                onChanged: (value) {
                  formValues['password'] = value;
                },
                validator: (String? value) {
                  if (value == null || value.length < 8) {
                    setState(() {
                      signupErrorList[4] =
                          'Password must be at least 8 characters long.';
                    });
                    return '';
                  }
                  setState(() {
                    signupErrorList[4] = null;
                  });
                  return null;
                },
                error: signupErrorList[4],
              ),
              SizedBox(height: 10.h),
              MainInput(
                placeholder: AppLocalizations.of(context)!.confirmPass,
                obscure: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      signupErrorList[5] = 'Please confirm your password.';
                    });
                    return '';
                  }
                  if (value != formValues['password']) {
                    setState(() {
                      signupErrorList[5] = 'Passwords do not match.';
                    });
                    return '';
                  }
                  setState(() {
                    signupErrorList[5] = null;
                  });
                  return null;
                },
                error: signupErrorList[5],
              ),
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Palette.secoundaryText,
                    fontSize: 16.sp,
                  ),
                  children: [
                    TextSpan(
                        text: "${AppLocalizations.of(context)!.byCreating} "),
                    TextSpan(
                      text: AppLocalizations.of(context)!.terms,
                      style: const TextStyle(
                          color: Palette.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " ${AppLocalizations.of(context)!.and} "),
                    TextSpan(
                      text: AppLocalizations.of(context)!.policy,
                      style: const TextStyle(
                          color: Palette.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              MainInputButton(
                label: AppLocalizations.of(context)!.signUp,
                onPressed: () async {
                  log('Clicked SIGN UP');
                  log(formValues.toString());
                  if (AuthVM.signupKey.currentState!.validate()) {
                    String? error =
                        await AuthService.signUp(context, formValues);
                    log('SIGN UP RESULTS: $error');
                  }
                },
              ),
            ],
          ),
        ));
  }
}
