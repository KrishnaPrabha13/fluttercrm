import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                  child: Container(
                    width: 450,
                    height: 550,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 450,
                                  height: 122,
                                  decoration:
                                      BoxDecoration(color: Color(0xFF0CA1B6)),
                                ),
                                Positioned(
                                  top: 60,
                                  left: 180,
                                  child: Container(
                                    width: 100,
                                    height: 105,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("men.png"),
                                          fit: BoxFit.fill),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  'Account Info',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/profile.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Employee ID ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 19),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  'A1234',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/name.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Name ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 59),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  'Michael',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/designation.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Designation ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  'Manager',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/dept.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Department ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  'CIS',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/email.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Email ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 58),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  'michael.m@srmtech.com',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 43),
                                SvgPicture.asset(
                                  'assets/phone.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Phone No ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 30),
                                Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(width: 18),
                                Text(
                                  '8562312492',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Version 0.1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF959CB5),
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            height: 1,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _showProfileDialog(context));
    return Container(color: Colors.redAccent.withOpacity(0.5));
    /*return MouseRegion(
      */ /*child: IconButton(
        icon: Icon(Icons.account_circle_rounded, color: Colors.white),
        onPressed: () {
          _showProfileDialog(context);
        },
        //},
      ),*/ /*
    );*/
  }
}
