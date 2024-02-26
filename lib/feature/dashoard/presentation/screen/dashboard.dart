import 'dart:async';
import 'dart:convert';
import 'package:crm_dashboard/component/app_bar.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/config/responsive/size_config.dart';
import 'package:crm_dashboard/feature/auth/login/presentation/screen/login_ui.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/BusinessUnitModel.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_content.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_detail_tab.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/tabview/lead_detail_tab.dart';
import 'package:crm_dashboard/shared/data_sources/local/shared_preference.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_lead_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/common_widgets/common_widgets.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<CrmLeadModel>? crmLeadList = [];
  List<DealsDataModel> crmDealList = [];

  List<Map<dynamic, dynamic>> lists = [];
  String? _version;
  String? _buildNumber;
  String? _buildSignature;
  String? _appName;
  String? _packageName;
  String? _installerStore;
  bool isLoading = false;
  bool? loginstatus;
  SharedPreferences? prefs;
  final FirebaseLeadServices _firebaseLeadServices = FirebaseLeadServices();
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  List<CrmLeadModel> businessUnitList = [];
  List<BusinessUnitModel> businessUnitModel = [];
  List<String> bUnitList = [];
  List<BusinessUnitModel>? selectedUserList = [];
  bool isHovered = false;
  late DateTime _currentDateTime;
  late Timer _timer;
  String? formattedDateTime;




  void _initCheck() async {
    setState(() {
      getSharedPreference();
    });
  }



  @override
  void initState() {
    super.initState();
    _getAppVersion();
    _initCheck();

    // _currentDateTime = DateTime.now();
    // // Set up a timer to update the UI every second
    // _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   setState(() {
    //     // Update the current date and time
    //     _currentDateTime = DateTime.now();
    //   });
    // });
  }

  void getDate(){
    _currentDateTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1),(Timer timer){
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
  }


  // @override
  // void initState() {
  //   super.initState();
  //   _getAppVersion();
  //   _initCheck();
  // }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    final buildSignature = packageInfo.buildSignature;
    final appName = packageInfo.appName;
    final packageName = packageInfo.packageName;
    final installerStore = packageInfo.installerStore;

    setState(() {
      _version = version;
      _buildNumber = buildNumber;
      _buildSignature = buildSignature;
      _appName = appName;
      _packageName = packageName;
      _installerStore = installerStore;
    });
  }

  @override
  void didUpdateWidget(Dashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAccess;
      // print('getAccess97 ${getAccess.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {


    userAccess.toString() == 'All'
        ? (selectedText == 'Select Business Unit')
            ? getAccess = 'All'
            : getAccess = selectedText
        : getAccess = userAccess.toString();
    // _firebaseLeadServices.getUntouchedLeads(context, '', getAccess);

    final List<Widget> sideMenus = [
      // Content for Home tab
      FutureBuilder<List<CrmLeadModel>>(
          future: _firebaseLeadServices.getTotalLeads(context, '', getAccess),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CrmLeadModel>? data = snapshot.data;
              if (data!.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: getNodatafoundImage(
                            context, nodatafound, srmDoveGrey),
                      ),
                      Text(
                        AppString.noDatasFound,
                        style: TextStyle(
                            color: srmDoveGrey,
                            fontFamily: FontName.montserrat,
                            fontSize:
                                (Responsive.isDesktop(context)) ? 16 : 11),
                      ),
                    ],
                  ),
                );
              }
              String jsonLead = jsonEncode(data);
              final crmLeadData = json.decode(jsonLead);
              var leadlist = crmLeadData as List<dynamic>;
              crmLeadList = [];
              crmLeadList!.clear();
              crmLeadList =
                  leadlist.map((e) => CrmLeadModel.fromJson(e)).toList();
              return DashboardContent(
                crmLeadlist: crmLeadList!.toList(),
                getAccess: getAccess,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      // Content for Lead tab
      LeadDetailTab(
          selectIndex: leadTabIndex, hideappbar: true, getAccess: getAccess),
      // Content for deal detail tab
      DealsDetailTab(hideappbar: true, getAccess: getAccess),
    ];
   // currentDateTime();
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        appBar: commonAppBar(
            context: context,
            onChanged: () {
              setState(() {
                _onChanged.call();
              });
            },
            currentDateTime: formattedDateTime,
            logOut: () {
              _logOut();
            },
            profileScreen: () {
              _profileScreen();
            }),
        bottomNavigationBar:
            (Responsive.isMobile(context)) ? _bottomNavigation() : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640) _navigationRail(),
            Expanded(child: sideMenus[navigationSelectedIndex]),
          ],
        ),
      ),
    );
  }

  Future<void> _onChanged() async {
    getAccess = selectedText;
  }

  // Future<void> currentDateTime() async{
  //   formattedDateTime = DateFormat('dd-MMM-yyyy ').format(_currentDateTime);
  //   print("Date time : ${formattedDateTime}");
  //   setState(() {
  //     formattedDateTime;
  //   });
  //
  // }

  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _sharedPrefsService.removeUserdata();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginUI();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      return;
    }
  }

  Future<void> _profileScreen() async {
    /*try {
      Responsive.isDesktop(context) | Responsive.isTablet(context)
          ? _showProfileDialog(context) : _showMobileview(context);
    } catch (e) {
      print('profile error ${e}');
      return;
    }*/
    if (Responsive.isDesktop(context) | Responsive.isTablet(context)) {
      try {
        _showProfileDialog(context);
      } catch (e) {
        print('profile error ${e}');
        return;
      }
    } else {
      try {
        _showMobileview(context);
      } catch (e) {
        print('profile error ${e}');
        return;
      }
    }
  }

  void _showMobileview(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red[100],
              ),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: srmBlueGreen),
                      height: 150,
                      //width: 500,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage(profileIcon),
                                fit: BoxFit.fill),
                            shape: const OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            Text(
                              'Account Info',
                              style: TextStyle(
                                  fontSize:
                                      Responsive.isDesktop(context) ? 20 : 15,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                profile,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 1),
                              // : const SizedBox(width: 1),
                              Text(
                                ' Employee ID ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              SizedBox(width: 1),

                              Text(
                                ': ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: srmGulfBlue),
                              ),
                              const SizedBox(width: 10),
                              Center(
                                child: Text(
                                  getEmpId!,
                                  style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 15
                                          : Responsive.isTablet(context)
                                              ? 14
                                              : 12,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                name,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 1),
                              Text(
                                ' Name ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              SizedBox(width: 1),

                              /// : const SizedBox(width: 3),
                              Text(
                                ': ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  getUserName!,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: Responsive.isDesktop(context)
                                          ? 15
                                          : Responsive.isTablet(context)
                                              ? 14
                                              : 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                  maxLines: 2,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                dept,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 1),
                              Text(
                                ' Department ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 1),
                              Text(
                                ': ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  getDepartment!,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: Responsive.isDesktop(context)
                                          ? 15
                                          : Responsive.isTablet(context)
                                              ? 14
                                              : 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                  maxLines: 2,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                email,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 1),
                              Text(
                                ' Email ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              SizedBox(width: 1),
                              const SizedBox(width: 3),
                              Text(
                                ': ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  getEmail!,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: Responsive.isDesktop(context)
                                          ? 15
                                          : Responsive.isTablet(context)
                                              ? 14
                                              : 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                  maxLines: 2,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                phone,
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 1),
                              Text(
                                ' Phone No ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 1),
                              Text(
                                ': ',
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                getMobile!,
                                style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? 15
                                        : Responsive.isTablet(context)
                                            ? 14
                                            : 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() async {
                              print('onClickk');
                              Navigator.pop(context);
                              await FirebaseAuth.instance.signOut();
                              _sharedPrefsService.removeUserdata();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    print("Logout");
                                    return LoginUI();
                                  },
                                ),
                                (route) => false,
                              );
                              //_logOut;
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
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: const Text('LogOut'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Version - ${_version!}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: srmDoveGrey,
                            fontSize: 14,
                            fontFamily: FontName.montserrat,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    businessUnitModel.clear();
    _currentDateTime;
    _timer.cancel();
    _timer;
    super.dispose();
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
        currentIndex: navigationSelectedIndex,
        unselectedItemColor: srmDoveGrey,
        selectedItemColor: srmCadiumOrange,
        // called when one tab is selected
        onTap: (int index) {
          setState(() {
            navigationSelectedIndex = index;
          });
        },
        // bottom tab items
        items: [
          BottomNavigationBarItem(
              icon: navigationSelectedIndex == 0
                  ? SvgPicture.asset(
                      dashboard,
                      color: srmCadiumOrange,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      dashboard,
                      color: srmDoveGrey,
                      height: 20,
                    ),
              label: AppString.dashboard),
          BottomNavigationBarItem(
              icon: navigationSelectedIndex == 1
                  ? SvgPicture.asset(
                      profile,
                      color: srmCadiumOrange,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      profile,
                      color: srmDoveGrey,
                      height: 20,
                    ),
              label: AppString.lead),
          BottomNavigationBarItem(
              icon: navigationSelectedIndex == 2
                  ? SvgPicture.asset(
                      deals,
                      color: srmCadiumOrange,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      deals,
                      color: srmDoveGrey,
                      height: 20,
                    ),
              label: AppString.deals),
        ]);
  }

  Widget _navigationRail() {
    return NavigationRail(
      onDestinationSelected: (int index) {
        setState(() {
          navigationSelectedIndex = index;
        });
      },
      selectedIndex: navigationSelectedIndex,
      destinations: [
        NavigationRailDestination(
            icon: navigationSelectedIndex == 0
                ? SvgPicture.asset(
                    dashboard,
                    color: srmCadiumOrange,
                    height: 20,
                  )
                : SvgPicture.asset(
                    dashboard,
                    color: srmDoveGrey,
                    height: 20,
                  ),
            label: const Text(AppString.dashboard)),
        NavigationRailDestination(
            icon: navigationSelectedIndex == 1
                ? SvgPicture.asset(
                    profile,
                    color: srmCadiumOrange,
                    height: 20,
                  )
                : SvgPicture.asset(
                    profile,
                    color: srmDoveGrey,
                    height: 20,
                  ),
            label: const Text(AppString.lead)),
        NavigationRailDestination(
            icon: navigationSelectedIndex == 2
                ? SvgPicture.asset(
                    deals,
                    color: srmCadiumOrange,
                    height: 20,
                  )
                : SvgPicture.asset(
                    deals,
                    color: srmDoveGrey,
                    height: 20,
                  ),
            label: const Text(AppString.deals)),
      ],
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: const TextStyle(
        color: srmCadiumOrange,
      ),
      unselectedLabelTextStyle: const TextStyle(
        color: srmDoveGrey,
      ),
      selectedIconTheme:
          const IconThemeData(color: srmCadiumOrange, size: 20.0),
      unselectedIconTheme: const IconThemeData(color: srmDoveGrey, size: 20.0),
    );
  }

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
                height: Responsive.isDesktop(context)
                    ? 60
                    : Responsive.isTablet(context)
                        ? 50
                        : 20,
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
                    width: Responsive.isDesktop(context)
                        ? 450
                        : Responsive.isTablet(context)
                            ? 400
                            : 400,
                    height: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 550
                        : 650,
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
                                  width: Responsive.isDesktop(context)
                                      ? 450
                                      : Responsive.isTablet(context)
                                          ? 400
                                          : 350,
                                  height: 122,
                                  decoration:
                                      const BoxDecoration(color: srmBlueGreen),
                                ),
                                Positioned(
                                  top: 60,
                                  left: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
                                      ? 180
                                      : 100,
                                  child: Container(
                                    width: 100,
                                    height: 105,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(profileIcon),
                                          fit: BoxFit.fill),
                                      shape: const OvalBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  'Account Info',
                                  style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 20
                                          : 15,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 35),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     (Responsive.isDesktop(context) ||
                            //             Responsive.isTablet(context))
                            //         ? const SizedBox(width: 50)
                            //         : const SizedBox(width: 3),
                            //     (Responsive.isDesktop(context) ||
                            //             Responsive.isTablet(context))
                            //         ? SvgPicture.asset(
                            //             profile,
                            //             height: 20,
                            //             width: 20,
                            //           )
                            //         : SvgPicture.asset(
                            //             profile,
                            //             height: 15,
                            //             width: 15,
                            //           ),
                            //     (Responsive.isDesktop(context) ||
                            //             Responsive.isTablet(context))
                            //         ? const SizedBox(width: 5)
                            //         : const SizedBox(width: 1),
                            //     Text(
                            //       'Employee ID ',
                            //       style: TextStyle(
                            //           fontSize:
                            //               (Responsive.isDesktop(context) ||
                            //                       Responsive.isTablet(context))
                            //                   ? 15
                            //                   : 14,
                            //           color: srmGulfBlue),
                            //     ),
                            //     (Responsive.isDesktop(context) ||
                            //             Responsive.isTablet(context))
                            //         ? const SizedBox(width: 19)
                            //         : const SizedBox(width: 3),
                            //     const Text(
                            //       ': ',
                            //       style: TextStyle(
                            //           fontSize: 15, color: srmGulfBlue),
                            //     ),
                            //     const SizedBox(width: 18),
                            //     Center(
                            //       child: Text(
                            //         getEmpId!,
                            //         style: TextStyle(
                            //           fontSize:
                            //               (Responsive.isDesktop(context) ||
                            //                       Responsive.isTablet(context))
                            //                   ? 15
                            //                   : 14,
                            //           color: srmGulfBlue,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context))
                                    ? const SizedBox(width: 43)
                                    : const SizedBox(width: 3),
                                (Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context))
                                    ? SvgPicture.asset(
                                  profile,
                                  height: 20,
                                  width: 20,
                                )
                                    : SvgPicture.asset(
                                  profile,
                                  height: 15,
                                  width: 15,
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Employee ID ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                (Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context))
                                    ? const SizedBox(width: 8)
                                    : const SizedBox(width: 3),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  getEmpId!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 43)
                                    : const SizedBox(width: 3),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? SvgPicture.asset(
                                        name,
                                        height: 20,
                                        width: 20,
                                      )
                                    : SvgPicture.asset(
                                        name,
                                        height: 15,
                                        width: 15,
                                      ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Name ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 56)
                                    : const SizedBox(width: 3),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  getUserName!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 43)
                                    : const SizedBox(width: 3),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? SvgPicture.asset(
                                        dept,
                                        height: 20,
                                        width: 20,
                                      )
                                    : SvgPicture.asset(
                                        dept,
                                        height: 15,
                                        width: 15,
                                      ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Department ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 9),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  getDepartment!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 43)
                                    : const SizedBox(width: 3),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? SvgPicture.asset(
                                        email,
                                        height: 20,
                                        width: 20,
                                      )
                                    : SvgPicture.asset(
                                        email,
                                        height: 15,
                                        width: 15,
                                      ),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 5)
                                    : const SizedBox(width: 2),
                                const Text(
                                  'Email ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 58)
                                    : const SizedBox(width: 3),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  getEmail!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? const SizedBox(width: 43)
                                    : const SizedBox(width: 3),
                                (Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context))
                                    ? SvgPicture.asset(
                                        phone,
                                        height: 20,
                                        width: 20,
                                      )
                                    : SvgPicture.asset(
                                        phone,
                                        height: 15,
                                        width: 15,
                                      ),
                                (Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context))
                                    ? const SizedBox(width: 5)
                                    : const SizedBox(width: 2),
                                const Text(
                                  'Phone No ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 26),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                const SizedBox(width: 18),
                                Text(
                                  getMobile!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        (Responsive.isMobile(context))
                            ? ElevatedButton(
                                onPressed: () async {
                                  setState(() async {
                                    print('onClickk');
                                    Navigator.pop(context);
                                    await FirebaseAuth.instance.signOut();
                                    _sharedPrefsService.removeUserdata();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginUI();
                                        },
                                      ),
                                      (route) => false,
                                    );
                                    //_logOut;
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
                                child: const Text('LogOut'),
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Version - ${_version!}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: srmDoveGrey,
                              fontSize: 14,
                              fontFamily: FontName.montserrat,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.16,
                            ),
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

  void getSharedPreference() {
    _sharedPrefsService.getAccess().then((value) {
      userAccess = value;
      //print('user57 Access ${userAccess.toString()}');
    });
    _sharedPrefsService.UserName().then((userName) {
      getUserName = userName;
      //print('user UserName ${getUserName.toString()}');
    });
    _sharedPrefsService.EmpId().then((EmpId) {
      getEmpId = EmpId;
      //print('user getEmpId ${getEmpId.toString()}');
    });
    _sharedPrefsService.Email().then((Email) {
      getEmail = Email;
      //print('user getEmail ${getEmail.toString()}');
    });
    _sharedPrefsService.Mobile().then((Mobile) {
      getMobile = Mobile;
      //print('user getMobile ${getMobile.toString()}');
    });
    _sharedPrefsService.BusinessUnit().then((BusinessUnit) {
      getDepartment = BusinessUnit;
      //print('user getDepartment ${getDepartment.toString()}');
    });
  }
}
