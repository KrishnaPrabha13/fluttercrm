import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/auth/login/presentation/widgets/verify_OTP_Screen.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

class VerifyOtpUI extends StatefulWidget {
  final String phoneNumber;
  const VerifyOtpUI({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  State<VerifyOtpUI> createState() => _VerifyOtpUIState();
}

class _VerifyOtpUIState extends State<VerifyOtpUI> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isMobile(context) ? getOtpMobileUI() : getOtpDesktopUi(),
    );
  }

  Widget getOtpMobileUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  //<-- Expanded widget
                  child: VerifyOTP(phoneNumber: widget.phoneNumber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOtpDesktopUi() {
    return Row(
      children: [
        Expanded(
          //<-- Expanded widget
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xFF0E1954),
                  Color(0xFF0D5982),
                  Color(0xFF0CA1B6)
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    'Account Verification',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 45),
                  Container(
                    width: 420,
                    height: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(otp),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          //<-- Expanded widget
          child: VerifyOTP(phoneNumber: widget.phoneNumber),
        ),
      ],
    );
  }
}
