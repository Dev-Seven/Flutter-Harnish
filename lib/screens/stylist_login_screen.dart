import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/screens/stylist_otp_screen.dart';
import 'package:harnishsalon/screens/stylist_registration_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';

class StylistLoginScreen extends StatefulWidget {
  final String deviceToken;
  StylistLoginScreen({
    Key key,
    @required this.deviceToken,
  }) : super(key: key);

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<StylistLoginScreen> {
  TextEditingController mobileController;
  TextEditingController passwordController;
  double height, width;
  bool isUserName = false;
  bool isMobileNumber = false;
  bool isMobileInvalid = false;
  bool isLoading = false;
  String salonID = "";
  String stylistID = "";
  @override
  void initState() {
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.all(7),
          width: 45,
          height: 45,
          child: setbuttonWithChild(setImageNamePath("", "iconBackButton.png"),
              () {
            Navigator.of(context).pop();
          }, Colors.transparent, 00),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                "TRIMIFY",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              Spacer(),
              setTextFieldMaxNumber(
                mobileController,
                "Mobile number",
                false,
                TextInputType.number,
                isMobileNumber,
                msgEmptyMobileNumber,
                () {
                  setState(() {
                    isMobileNumber = false;
                    isMobileInvalid = false;
                  });
                },
                10,
              ),
              // setTextField(
              //   mobileController,
              //   "Mobile Number",
              //   false,
              //   TextInputType.number,
              //   false,
              //   "",
              //   () {},
              // ),
              Spacer(
                flex: 3,
              ),
              TextButtonWidget(
                btnTxt: "LOGIN",
                btnbackColor: ColorConstants.kButtonBackColor,
                btnOntap: () {
                  onStylistLoginTap();
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "New to Trimify ?",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => StylistRegistrationScreen(
                            deviceToken: widget.deviceToken,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Register Here",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kButtonBackColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onStylistLoginTap() {
    FocusScope.of(context).unfocus();

    if (mobileController.text.trim() == "") {
      isMobileNumber = true;
      return;
    }
    if (mobileController.text.trim().length < 10) {
      setState(() {
        isMobileNumber = false;
        isMobileInvalid = true;
      });
    }
    setState(() {
      isLoading = true;
    });
    FormData param = FormData.fromMap({
      "phone_number": mobileController.text,
    });
    postDataRequest(loginApi, param).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        // _responseHandling(value[kData]);
        int role = value[kData]['role'];
        if (role == 4) {
          print("Login As a SALON");
          SalonModel salon = SalonModel.fromJson(value[kData]);
          salonObj = salon;
          setState(() {
            salonID = salon.salonId;
          });
          print(salonID);
          setUserData();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => StylistOTPScreen(
                isFromLogin: true,
                mobileTxt: mobileController.text,
                deviceTokenTxt: widget.deviceToken,
                salonID: salonID,
              ),
            ),
          );
        } else if (role == 5) {
          print("Login As a STYLIST");
          StylistModel stylist = StylistModel.fromJson(value[kData]);
          stylistObj = stylist;
          setUserData();
          setState(() {
            isStylist = true;
            stylistID = stylist.sId;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => StylistOTPScreen(
                isFromLogin: true,
                mobileTxt: mobileController.text,
                deviceTokenTxt: widget.deviceToken,
                stylistID: stylistID,
                isLoginAsStylist: isStylist,
              ),
            ),
          );
        } else {
          print("No ROLE");
        }
        showCustomToast("OTP on your mobile", context);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseHandling(userData) async {
    SalonModel salon = SalonModel.fromJson(userData);
    salonObj = salon;
    setState(() {
      salonID = salon.salonId;
    });
    print(salonID);
    setUserData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => StylistOTPScreen(
          isFromLogin: true,
          mobileTxt: mobileController.text,
          deviceTokenTxt: widget.deviceToken,
          salonID: salonID,
        ),
      ),
    );
  }
}
