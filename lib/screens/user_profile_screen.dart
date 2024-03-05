import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/screens/UserOfferNavbarVC.dart';
import 'package:harnishsalon/screens/role_selector_screen.dart';
import 'package:harnishsalon/screens/user_profile_detail_screen.dart';

import '../common/color_constants.dart';
import 'users_order_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final int indexTxt;
  UserProfileScreen({
    Key key,
    this.indexTxt,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var _switchValue = false;
  double height, width;
  bool isLoading = false;
  String name = "";
  String mobile = "";
  String fullname = "";

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  getUserProfile() {
    setState(() {
      isLoading = true;
    });

    postDataRequestWithToken(getUserProfileApi, null, context).then((value) => {
          print(value),
          setState(() {
            isLoading = false;
          }),
          if (value is Map)
            {
              name = value['first_name'],
              print("NAME :$name"),
            }
          else
            {
              print("getProfile"),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.kScreenBackColor,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileDetailScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  height: height * 0.1 / 2,
                  child: Row(
                    children: [
                      // Container(
                      //   height: 30,
                      //   width: 30,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30 / 2),
                      //     image: DecorationImage(
                      //       fit: BoxFit.fill,
                      //       image: ExactAssetImage(
                      //         "assets/images/1.jpg",
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        name != null ? name : "",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.12 / 2,
              width: width * 0.999,
              color: ColorConstants.kScreenBackColor,
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
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsersOrderScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 46,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Bookings",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          size: 16,
                          color: ColorConstants.kBlackColor,
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserOfferNavbarVC(),
                  ),
                );
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 46,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Offers",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_outlined,
                          size: 16,
                          color: ColorConstants.kBlackColor,
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
              child: Row(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Notifications",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: ColorConstants.kBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            Divider(
              color: ColorConstants.kGreyColor,
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                onPrivacyPoliciesTap();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 46,
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
            GestureDetector(
              onTap: () {
                onTermConditionTap();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 46,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Term & Conditions",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
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
            GestureDetector(
              onTap: () {
                onHelpSupportTap();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 46,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Help & Supports",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
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
            GestureDetector(
              onTap: () {
                _showLogoutDialog();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 46,
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

  onPrivacyPoliciesTap() {
    String faq = "FAQS";
    FormData param = FormData.fromMap({
      "faq": faq,
    });
    postDataRequestWithToken(cmsPageApi, param, context).then(
      (value) => {
        if (value is Map)
          {
            responseFAQHandling(value),
          }
        else
          {
            print("data"),
          }
      },
    );
  }

  responseFAQHandling(userData) {
    print(userData);
  }

  onTermConditionTap() {
    String termCondition = "Term Condition";
    FormData param = FormData.fromMap({
      "about": termCondition,
    });
    postDataRequestWithToken(cmsPageApi, param, context).then(
      (value) => {
        if (value is Map)
          {
            responseTermConditionHandling(value),
          }
        else
          {
            print("data"),
          }
      },
    );
  }

  responseTermConditionHandling(userData) {
    print(userData);
  }

  onHelpSupportTap() {
    String contact = "Contact Us";
    FormData param = FormData.fromMap({
      "contact_us": contact,
    });
    postDataRequestWithToken(cmsPageApi, param, context).then(
      (value) => {
        if (value is Map)
          {
            _responseHelpHandling(value),
          }
        else
          {
            print("data"),
          }
      },
    );
  }

  _responseHelpHandling(userData) {
    print(userData);
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
                  logoutBtnTap();
                  //logoutBtnTap();
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

  logoutBtnTap() {
    postDataRequestWithToken(logoutApi, null, context).then(
      (value) => {
        print(value),
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
        // if (value == null)
        //   {
        //     handleLogoutResponse(),
        //   }
        // else
        //   {}
      },
    );
  }

  handleLogoutResponse() async {
    clearUserData();
    showCustomToast("Logged out successfully", context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => RoleSelectorScreen(),
        fullscreenDialog: false,
      ),
      (route) => false,
    );
  }
}
