import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_model.dart';
import 'package:harnishsalon/screens/stylist_login_screen.dart';
import 'package:harnishsalon/screens/stylist_otp_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StylistRegistrationScreen extends StatefulWidget {
  final String deviceToken;
  StylistRegistrationScreen({
    Key key,
    this.deviceToken,
  }) : super(key: key);

  @override
  _StylistRegistrationScreenState createState() =>
      _StylistRegistrationScreenState();
}

class _StylistRegistrationScreenState extends State<StylistRegistrationScreen> {
  TextEditingController mobileController;
  TextEditingController salonController;
  TextEditingController nameController;
  double height, width;
  bool isSalonName = false;
  bool isFullName = false;
  bool isMobileNumber = false;
  bool isMobileInvalid = false;
  bool isLoading = false;
  String salonIDTxt = "";
  @override
  void initState() {
    mobileController = TextEditingController();
    salonController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
    print(widget.deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Text(
                "TRIMIFY",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),

              setTextField(
                salonController,
                "Salon name",
                false,
                TextInputType.text,
                isSalonName,
                msgEmptysalonName,
                () => {
                  setState(() {
                    isSalonName = false;
                  })
                },
                () {},
              ),

              SizedBox(
                height: 15,
              ),
              setTextFieldMaxNumber(
                  mobileController,
                  "Mobile number",
                  false,
                  TextInputType.number,
                  isMobileNumber,
                  msgEmptyMobileNumber, () {
                setState(() {
                  isMobileNumber = false;
                });
              }, 10),

              SizedBox(
                height: 15,
              ),
              setTextField(
                nameController,
                "Owner name",
                false,
                TextInputType.text,
                isFullName,
                msgEmptyFullName,
                () {
                  setState(() {
                    isFullName = false;
                  });
                },
                () {},
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have a account ?",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
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
                          builder: (builder) => StylistLoginScreen(
                            deviceToken: widget.deviceToken,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Login Here",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.kButtonBackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              Expanded(child: Container()),
              // SizedBox(
              //   height: height * 0.3,
              // ),
              TextButtonWidget(
                btnTxt: "Register",
                btnbackColor: ColorConstants.kButtonBackColor,
                btnOntap: () {
                  onStylistRegisterTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveSharedPref() async {
    String salonName = salonController.text;
    String fullName = nameController.text;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("salonname", salonName);
    sharedPreferences.setString("fullname", fullName);
  }

  onStylistRegisterTap() {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).unfocus();
    if (salonController.text.trim() == "") {
      setState(() {
        isSalonName = true;
      });
      return;
    }
    if (mobileController.text.trim() == "") {
      setState(() {
        isMobileNumber = true;
      });
      return;
    }
    if (mobileController.text.trim().length < 10) {
      setState(() {
        isMobileNumber = false;
        isMobileInvalid = true;
      });
    }

    if (nameController.text.trim() == "") {
      setState(() {
        isFullName = true;
      });
      return;
    }

    saveSharedPref();

    FormData param = FormData.fromMap({
      "phone_number": mobileController.text,
      "full_name": nameController.text,
      "salon_name": salonController.text,
    });
    postDataRequest(registerApi, param).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        _responseHandling(value[kData]);
        showCustomToast("OTP on your mobile", context);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseHandling(userData) async {
    print(salonIDTxt);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => StylistOTPScreen(
          isFromLogin: false,
          mobileTxt: mobileController.text,
          deviceTokenTxt: widget.deviceToken,
        ),
      ),
    );
  }
}
