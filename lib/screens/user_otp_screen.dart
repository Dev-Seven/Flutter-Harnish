import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/user_model.dart';
import 'package:harnishsalon/screens/user_bottom_navigation_screen.dart';
import 'package:harnishsalon/widgets/otp_widget.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';

/*
Title:UserOTPScreen
Purpose:UserOTPScreen
Required Params:OTPWidget
Created By:Kalpesh Khandla
Created Date: 11 Feb 2021
*/

class UserOTPScreen extends StatefulWidget {
  final String mobileTxt;
  final String deviceTokenTxt;
  UserOTPScreen({
    Key key,
    @required this.mobileTxt,
    @required this.deviceTokenTxt,
  }) : super(key: key);

  @override
  _UserOTPScreenState createState() => _UserOTPScreenState();
}

class _UserOTPScreenState extends State<UserOTPScreen> {
  double height, width;
  String submittedOTP = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.deviceTokenTxt);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kScreenBackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Verify Phone",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorConstants.kBlackColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorConstants.kBlackColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.10,
          ),
          Text(
            "OTP Sent to " + "+91" + " - " + widget.mobileTxt,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: ColorConstants.kBlackColor,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OTPWidget(
            onSubmit: (val) {
              setState(() {
                submittedOTP = val;
              });
            },
          ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            height: 20,
          ),
          TextButtonWidget(
            btnTxt: "VERIFY",
            btnbackColor: appYellowColor,
            btnOntap: () {
              setState(() {
                onVerifyOTPTap();
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive CODE? ",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  onResendOTPTap();
                },
                child: Text(
                  "RESEND",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appYellowColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  onVerifyOTPTap() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (submittedOTP.isEmpty == true) {
      showCustomToast("Verification code is required", context);
      return;
    } else if (submittedOTP.length < 4) {
      showCustomToast("Please enter valid OTP", context);
      return;
    }
    FormData param = FormData.fromMap({
      "mobile_number": widget.mobileTxt,
      "otp": submittedOTP,
      "device_token": widget.deviceTokenTxt,
    });
    postDataRequest(verifyOTP, param).then((value) {
      setState(() {
        isLoading = true;
      });
      if (value is Map) {
        showCustomToast("User verified Successfully", context);
        handleOTPResponse(value[kData]);
      } else {
        print(value);
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleOTPResponse(userData) async {
    //print(userData);
    UserModel user = UserModel.fromJson(userData);
    userObj = user;
    setUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => UserBottomNavigationScreen(),
        fullscreenDialog: false,
      ),
      (route) => false,
    );
  }

  onResendOTPTap() {
    setState(() {
      isLoading = true;
    });
    FormData param = FormData.fromMap({
      "mobile_number": widget.mobileTxt,
    });
    postDataRequest(resendOTP, param).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        showCustomToast("OTP Resend ", context);
        _responseResendHandling(value[kData]);
      } else {
        print(value);
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseResendHandling(userData) async {
    print(userData);
  }
}
