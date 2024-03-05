import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/EditEmployeeDetail.dart';
import 'package:harnishsalon/screens/EditEmployeeOwnDetail.dart';
import 'package:harnishsalon/screens/StylistAddressDetail.dart';
import 'package:harnishsalon/screens/StylistTimeUpdateVC.dart';
import 'package:harnishsalon/screens/role_selector_screen.dart';
import 'package:harnishsalon/screens/stylist_login_screen.dart';
import 'package:harnishsalon/screens/user_profile_screen.dart';

class StylistProfileScreen extends StatefulWidget {
  final String salonID;
  final bool isStylist;
  StylistProfileScreen({
    Key key,
    this.salonID,
    this.isStylist,
  }) : super(key: key);

  @override
  _StylistProfileScreenState createState() => _StylistProfileScreenState();
}

class _StylistProfileScreenState extends State<StylistProfileScreen> {
  bool isLoading = false;
  String firstname = "";
  String lastname = "";
  String city = "";
  String ownerName = "";
  String salonCity = "";
  String salonArea = "";
  @override
  void initState() {
    super.initState();
    if (widget.isStylist == true) {
      getStylistProfile();
    } else {
      getAddressDetail();
    }
  }

  getAddressDetail() {
    setState(() {
      isLoading = true;
    });
    postDataRequestWithTokenSalon(getSalonAddressApi, null, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        ownerName = value['owner_name'];
        salonCity = value['city'];
        salonArea = value['area'];
        _responseProfileHandling(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseProfileHandling(userData) {
    showCustomToast("User data get successfully ", context);
  }

  getStylistProfile() {
    setState(() {
      isLoading = true;
    });

    postDataRequestWithTokenStylist(getStylistProfileApi, null, context)
        .then((value) {
      print(value);
      setState(() {
        isLoading = false;
      });

      if (value is Map) {
        print(value);
        firstname = value['first_name'];
        lastname = value['last_name'];
        city = value['city'];
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kScreenBackColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(11),
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(Icons.close),
              ),
            ),
          ),
        ),
        backgroundColor: ColorConstants.kButtonBackColor,
        title: setTextWithCustomFont(
          "Welcome,  " + ownerName,
          16,
          Colors.white,
          FontWeight.w600,
          1,
        ),
        actions: [
          // Image.asset(
          //   "assets/images/bell.png",
          //   height: 16,
          // ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              // height: height * 0.12 / 2,
              // width: width * 0.999,
              // color: ColorConstants.kScreenBackColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                ),
                child: Text(
                  "Profile",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kBlackColor,
                  ),
                ),
              ),
            ),
            isStylist
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEmployeeOwnDetail(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firstname != null
                                        ? firstname + "  " + lastname
                                        : "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    city != null ? city : "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_outlined,
                                size: 22,
                                color: ColorConstants.kGreyColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StylistAddressDetailVC(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ownerName != null ? ownerName : "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                  Text(
                                    salonArea + " , " + salonCity,
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.chevron_right_outlined,
                                size: 22,
                                color: ColorConstants.kGreyColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            Divider(
              color: ColorConstants.kGreyColor,
              height: 1,
            ),
            isStylist
                ? Container()
                : Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StylistTimeUpdateVC(
                                salonIDTxt: widget.salonID,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Days Open & Time Slot",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_outlined,
                                    size: 22,
                                    color: ColorConstants.kGreyColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Report",
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Earning Report",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ColorConstants.kBlackColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.file_upload, color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorConstants.kGreyColor,
                        height: 1,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Customer Report",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ColorConstants.kBlackColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.file_upload, color: Colors.grey)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            Container(
              height: 50,
              // height: height * 0.12 / 2,
              // width: width * 0.999,
              // color: ColorConstants.kScreenBackColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                ),
                child: Text(
                  "Settings",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kBlackColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => UsersOrderScreen(),
                //   ),
                // );
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Privacy Policy",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          size: 22,
                          color: ColorConstants.kGreyColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: ColorConstants.kGreyColor,
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Terms & Conditions",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 22,
                        color: ColorConstants.kGreyColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: ColorConstants.kGreyColor,
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Support",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 22,
                        color: ColorConstants.kGreyColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: ColorConstants.kGreyColor,
              height: 1,
            ),
            InkWell(
              onTap: () {
                _showLogoutDialog();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Logout",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          size: 22,
                          color: ColorConstants.kGreyColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLogoutDialog() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  isStylist = false;

                  onLogoutApiTap();
                },
                /*Navigator.of(context).pop(true)*/
                child: Text(
                  'Yes',
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  onLogoutApiTap() {
    postDataRequestWithTokenStylist(logoutApi, null, context).then(
      (value) => {
        clearUserData(),
        showCustomToast("Logged out successfully", context),
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => RoleSelectorScreen(),
            fullscreenDialog: false,
          ),
          (route) => false,
        ),
      },
    );
  }

  _handleResponse() async {
    clearUserData();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RoleSelectorScreen(),
          fullscreenDialog: false,
        ),
        (route) => false);
  }
}
