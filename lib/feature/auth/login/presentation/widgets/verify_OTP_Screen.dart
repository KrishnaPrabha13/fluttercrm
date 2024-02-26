// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/auth/login/presentation/widgets/login_screen.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/screen/dashboard.dart';
import 'package:crm_dashboard/shared/data_sources/local/storage_service.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_auth_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  final String phoneNumber;

  const VerifyOTP({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final FirebaseAuthServices _firebasedatabaseServices = FirebaseAuthServices();
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();
  bool isLoading = false;
  var code = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final StroageService stroageService;
  final defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10)),
  );

  void verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginScreen.verify, smsCode: code);

      await auth.signInWithCredential(credential);
      await _firebasedatabaseServices
          .getUserDetails(context, widget.phoneNumber.replaceAll('+91', ''))
          .then((value) async {
        isLoading = false;
        if (value.toString().trim() == 'true') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Dashboard();
              },
            ),
            (route) => false,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      print('wrong otp1 ${e.code}');
      if (e.code == 'invalid-verification-code') {
        setState(() {
          isLoading = false;
          visibleWrongOTPText = true;
          print('invalid-verification-code');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? getMobileOtpScreenUi()
        : getDesktopOtpScreenUi();
  }

  Widget getMobileOtpScreenUi() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(logo, width: 250, height: 90),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 5, left: 5),
                child: Container(
                  width: 500,
                  height: 390,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
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
                            padding: const EdgeInsets.only(top: 30),
                            child: Image.asset(key, height: 50, width: 50),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.pleaseVerifyaccount,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'OTP sent to ${widget.phoneNumber}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Pinput(
                              defaultPinTheme: defaultPinTheme,
                              length: 6,
                              showCursor: true,
                              onChanged: (value) {
                                code = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive OTP code ?",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextButton(
                              onPressed: () async {
                                //print('OTP sent to ${widget.phoneNumber}');
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: widget.phoneNumber,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    LoginScreen.verify = verificationId;
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              },
                              child: const Text(
                                'Resend code',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF0CA1B6),
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                        height: 40,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              verifyOtp();
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0E1954),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)))),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                )
                              : const Text(AppString.VerifyAndProceed),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: visibleWrongOTPText,
                        child: const Text(
                          AppString.wrongOTP,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: red,
                            fontSize: 13,
                            fontFamily: FontName.montserrat,
                            fontWeight: FontWeight.w300,
                            height: 1,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          const Text(
            AppString.copyRights,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF959CB5),
              fontSize: 12,
              fontFamily: FontName.montserrat,
              fontWeight: FontWeight.w300,
              height: 1,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget getDesktopOtpScreenUi() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Image.asset(logo, width: 200, height: 100),
          Form(
            child: Container(
              width: 450,
              height: 390,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
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
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(key, height: 50, width: 50),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.pleaseVerifyaccount,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.enterOTPSentTo + widget.phoneNumber,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 6,
                        showCursor: true,
                        onChanged: (value) {
                          code = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.didnotReceiveOTPcode,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: widget.phoneNumber,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                LoginScreen.verify = verificationId;
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          child: const Text(
                            AppString.reSendCode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0CA1B6),
                              fontSize: 13,
                              fontFamily: FontName.montserrat,
                              fontWeight: FontWeight.w400,
                              height: 1,
                              letterSpacing: 0.16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          verifyOtp();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E1954),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)))),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            )
                          : const Text(AppString.VerifyAndProceed),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: visibleWrongOTPText,
                    child: const Text(
                      AppString.wrongOTP,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: red,
                        fontSize: 13,
                        fontFamily: FontName.montserrat,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 0.16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          const Text(
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
        ],
      ),
    );
  }
}
