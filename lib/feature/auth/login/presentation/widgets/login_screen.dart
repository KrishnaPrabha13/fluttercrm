// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:country_picker/country_picker.dart';
import 'package:crm_dashboard/config/flavor/flavors.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/auth/login/presentation/screen/verify_OTP_ui.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_auth_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  var phone = "";
  bool isLoading = false;
  final FirebaseAuthServices _firebasedatabaseServices = FirebaseAuthServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
  }

  void sendOtpMessage() async {
    if (_formKey.currentState?.validate() == true) {
      if (mobile.text.length.toString() == 0 || mobile.text.toString() == '') {
        setState(() {
          isLoading = false;
          visibleEmptyText = !visibleEmptyText;
          visibleErrorText = false;
        });
      } else {
        isLoading = false;
        await _firebasedatabaseServices
            .getValidUserName(context, phone)
            .then((value) async {
          if (value.toString().trim() == 'true') {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+${selectedCountry.phoneCode}$phone',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                LoginScreen.verify = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
            print('login phone +${selectedCountry.phoneCode}$phone');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyOtpUI(
                        phoneNumber: '+${selectedCountry.phoneCode}$phone')));
          } else {
            setState(() {
              visibleErrorText = !visibleErrorText;
              visibleEmptyText = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? getMobileLoginScreenUi()
        : getDesktopLoginScreenUi();
  }

  Widget getMobileLoginScreenUi() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 70),
          Image.asset(logo, width: 220, height: 70),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 500,
                  height: 352,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x3F000000),
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 0)
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Image.asset(lock, height: 50, width: 50),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        AppString.signInMobileNumber,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: FontName.montserrat,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 45),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, top: 3, bottom: 3),
                        child: TextFormField(
                          controller: mobile,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white54,
                            filled: true,
                            hintText: AppString.enterTenDigitsMobileNumber,
                            border: OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        bottomSheetHeight: 500,
                                        flagSize: 25,
                                        backgroundColor: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontFamily: FontName.montserrat,
                                            color: Colors.blueGrey),
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.countrycodeflag,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                          print(
                                              'phone country code ${selectedCountry.phoneCode}');
                                        });
                                      });
                                },
                                child: Text(
                                  "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 5.0, top: 10.0, right: 5.0, bottom: 0.0),
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 3), () {
                              sendOtpMessage();
                            });
                          },
                          //sendOtpMessage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0E1954),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                )
                              : const Text(
                                  AppString.signIn,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: FontName.montserrat,
                                    fontWeight: FontWeight.w200,
                                    height: 1,
                                    letterSpacing: 0.16,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                        visible: visibleEmptyText,
                        child: const Text(
                          AppString.emptyValue,
                          style: TextStyle(
                            color: red,
                            fontSize: 14,
                            fontFamily: FontName.montserrat,
                            fontWeight: FontWeight.w400,
                            height: 1,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ),
                      visibilityText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          (AppFlavors.title.toString() != 'SRMT CRM')
              ? Text(
                  AppFlavors.title,
                  style: const TextStyle(
                    color: srmDoveGrey,
                    fontSize: 12,
                    fontFamily: FontName.montserrat,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: 0.16,
                  ),
                )
              : Container(),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                AppString.copyRights,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF959CB5),
                  fontSize: 12,
                  fontFamily: FontName.montserrat,
                  fontWeight: FontWeight.w400,
                  height: 1,
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget getDesktopLoginScreenUi() {
    return Column(
      children: [
        const SizedBox(height: 50),
        Image.asset(logo, width: 200, height: 100),
        Form(
          key: _formKey,
          child: Container(
            width: 500,
            height: 342,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x3F000000),
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 0)
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(lock, height: 50, width: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  AppString.signInMobileNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: FontName.montserrat,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 45.0, left: 45.0, top: 3, bottom: 3),
                  child: TextFormField(
                    controller: mobile,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white54,
                      filled: true,
                      hintText: AppString.emptyValue,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500,
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontFamily: FontName.montserrat,
                                      color: Colors.blueGrey),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.countrycodeflag,
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                    print(
                                        'phone country code ${selectedCountry.phoneCode}');
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(
                      left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                  height: 50,
                  width: 415,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        sendOtpMessage();
                      });
                    },
                    //sendOtpMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E1954),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          )
                        : const Text(
                            AppString.signIn,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: FontName.montserrat,
                              fontWeight: FontWeight.w300,
                              height: 1,
                              letterSpacing: 0.16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: visibleEmptyText,
                  child: const Text(
                    AppString.emptyValue,
                    style: TextStyle(
                      color: red,
                      fontSize: 14,
                      fontFamily: FontName.montserrat,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleErrorText,
                  child: const Text(
                    AppString.errorMsg,
                    style: TextStyle(
                      color: red,
                      fontSize: 14,
                      fontFamily: FontName.montserrat,
                      fontWeight: FontWeight.w300,
                      height: 1,
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 100),
        (AppFlavors.title.toString() != 'SRMT CRM')
            ? Text(
                AppFlavors.title,
                style: const TextStyle(
                  color: srmDoveGrey,
                  fontSize: 12,
                  fontFamily: FontName.montserrat,
                  fontWeight: FontWeight.w300,
                  height: 1,
                  letterSpacing: 0.16,
                ),
              )
            : Container(),
        const Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              AppString.copyRights,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF959CB5),
                fontSize: 12,
                fontFamily: FontName.montserrat,
                fontWeight: FontWeight.w400,
                height: 1,
                letterSpacing: 0.16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget visibilityText() {
    return Visibility(
      visible: visibleErrorText,
      child: const Text(
        AppString.errorMsg,
        style: TextStyle(
          color: red,
          fontSize: 14,
          fontFamily: FontName.montserrat,
          fontWeight: FontWeight.w400,
          height: 1,
          letterSpacing: 0.16,
        ),
      ),
    );
  }
}
