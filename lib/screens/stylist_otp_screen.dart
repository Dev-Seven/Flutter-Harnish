import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/screens/stylist_address_detail.dart';
import 'package:harnishsalon/screens/stylist_bottom_navigation_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/otp_widget.dart';
import '../common/Global.dart';
/*
Title:StylistOTPScreen
Purpose:StylistOTPScreen
Required Params:OTPWidget
Created By:Kalpesh Khandla
Created Date: 11 Feb 2021
*/

class StylistOTPScreen extends StatefulWidget {
  final String mobileTxt;
  final bool isFromLogin;
  final String deviceTokenTxt;
  final String salonID;
  final bool isLoginAsStylist;
  final String stylistID;

  StylistOTPScreen({
    Key key,
    @required this.mobileTxt,
    @required this.isFromLogin,
    @required this.deviceTokenTxt,
    this.isLoginAsStylist,
    this.salonID,
    this.stylistID,
  }) : super(key: key);

  @override
  _StylistScreenState createState() => _StylistScreenState();
}

class _StylistScreenState extends State<StylistOTPScreen> {
  double height, width;
  bool isNewUser;
  bool isLoading = false;
  String submittedOTP = "";
  String salonIDFromOTPResponpse = "";
  @override
  void initState() {
    super.initState();
    isNewUser = false;
    print("DEVICE TOKEN : ${widget.deviceTokenTxt}");
   
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
      body: SafeArea(
        child: Column(
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
              onSubmit: (text) {
                setState(() {
                  submittedOTP = text;
                });
              },
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 20,
            ),
            TextButtonWidget(
              btnTxt: "VERIFY",
              btnbackColor: ColorConstants.kButtonBackColor,
              btnOntap: () {
                // if (widget.isFromLogin) {
                //   Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => StylistBottomNavigationScreen(
                //         isNewSalon: isNewUser,
                //         isStylist: widget.isLoginAsStylist,
                //         deviceToken: widget.deviceTokenTxt,
                //         salonIdFromOTP: widget.salonID,
                //       ),
                //       fullscreenDialog: false,
                //     ),
                //     (route) => false,
                //   );
                // } else {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (builder) => StylistAddressDetailVC(),
                //     ),
                //   );
                // }
                onVerifyOTPTap();
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
                    onResendOTP();
                  },
                  child: Text(
                    "RESEND",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kBlueColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  onVerifyOTPTap() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (submittedOTP.length == 0) {
      showCustomToast("Please enter valid OTP", context);
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
        isLoading = false;
      });
      if (value is Map) {
        // salonIDFromOTPResponpse = value['kData'];
        showCustomToast("OTP verified Successfully", context);
        print("SALON ID FROM OTP : ${value[kData]['salon_id']}");


        salonIDFromOTPResponpse = value[kData]['salon_id'];
        _responseOTPRequestHandling(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseOTPRequestHandling(userData) async {
    // print("OTP USER DATA : ${userData.salon_id}");
    if (widget.isLoginAsStylist == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => StylistBottomNavigationScreen(
            isNewSalon: isNewUser,
            isStylist: isStylist,
            deviceToken: widget.deviceTokenTxt,
            stylistID: widget.stylistID,
          ),
          fullscreenDialog: false,
        ),
        (route) => false,
      );
    } else {
      SalonModel salon = SalonModel.fromJson(userData);
      salonObj = salon;
      setUserData();
      if (widget.isFromLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => StylistBottomNavigationScreen(
              isNewSalon: isNewUser,
              isStylist: isStylist,
              deviceToken: widget.deviceTokenTxt,
              salonIdFromOTP: widget.salonID,
            ),
            fullscreenDialog: false,
          ),
          (route) => false,
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => StylistAddressDetailVC(
              salonIdFromOTP: salonIDFromOTPResponpse,
            ),
          ),
        );
      }
    }
  }

  onResendOTP() {
    setState(() {});
    FormData param = FormData.fromMap({
      "mobile_number": widget.mobileTxt,
    });
    postDataRequest(resendOTP, param).then((value) {
      setState(() {
        isLoading = true;
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
