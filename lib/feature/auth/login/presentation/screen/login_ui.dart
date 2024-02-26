import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

import '../widgets/login_screen.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive.isMobile(context)
          ? getLoginMobileUI()
          : getLoginDesktopUi(),
    );
  }

  Widget getLoginMobileUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(child: LoginScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getLoginDesktopUi() {
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
                  const SizedBox(height: 60),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: FontName.montserrat,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '“Managing customer is \n our passion”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: FontName.montserrat,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    width: 390,
                    height: 290,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(logincrm),
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
          child: LoginScreen(),
        ),
      ],
    );
  }
}
