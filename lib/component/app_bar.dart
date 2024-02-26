import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

AppBar commonAppBar({
  BuildContext? context,
  String? title,
  String? subTitle,
  String? action1IconPath,
  String? action2IconPath,
  double elevation = 0,
  Color? background,
  String? backIconPath,
  String? currentDateTime,
  VoidCallback? logOut,
  VoidCallback? onChanged,
  VoidCallback? profileScreen,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    title: Center(
        child: Text(
      AppString.crm.substring(0, 3),
      style: AppTextStyles.titleStyle_w300,
    )),
    actions: [
      Row(
        children: [
          (!Responsive.isMobile(context!))
              ? const SizedBox(
                  width: 8,
                )
              : Container(),
          (!Responsive.isMobile(context))
              ? Text(
                  'Hi $getUserName',
                  style: AppTextStyles.srmDoveGreyStyle_w200,
                )
              : Container(),
          (!Responsive.isMobile(context))
              ? const SizedBox(
                  width: 8,
                )
              : Container(),
          (!Responsive.isMobile(context))
              ? InkWell(
                  onTap: profileScreen,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      profileIcon,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          (!Responsive.isMobile(context))
              ? const SizedBox(
                  width: 8,
                )
              : Container(),
          userAccess == 'All'
              ? Container(
                  height: (Responsive.isMobile(context)) ? 35 : 30,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(50)),
                  child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 20,
                      focusColor: Colors.transparent,
                      underline: const SizedBox(),
                      value: selectedText,
                      items: selectBusinessUnit.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        onChanged?.call();
                        selectedText = val!;
                        getAccess = selectedText;
                        //print('onChanged 81 ${getAccess}');
                      }),
                )
              : Container(),
          const SizedBox(
            width: defaultPadding,
          ),
          (!Responsive.isMobile(context))
              ? InkWell(
                  onTap: logOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SvgPicture.asset(
                      logout,
                      color: srmCadiumOrange,
                      width: 35,
                      height: 35,
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            width: defaultPadding,
          ),
          (Responsive.isMobile(context))
              ? InkWell(
                  onTap: profileScreen,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      profileIcon,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    ],
    leadingWidth: 430,
    leading: Responsive.isDesktop(context)
        ? Padding(
            padding: const EdgeInsets.all(Padding_8),
            child: Row(
              children: [
                GestureDetector(
                  child: Image.asset(
                    logo,
                    height: 30,
                    width: 252,
                  ),
                ),
                // Text(
                //   '${currentDateTime}',
                //   //'${DateFormat('dd-MMM-yyyy [kk:mm:ss]').format(DateTime.now())}',
                //   style: TextStyle(
                //       color: Colors.black
                //   ),),
              ],
            ),
          )
        : null,
  );


}
