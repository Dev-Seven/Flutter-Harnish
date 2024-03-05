import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/user_model.dart';
import 'package:harnishsalon/screens/user_registration_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/screens/user_otp_screen.dart';

class UserLoginScreen extends StatefulWidget {
  final String deviceToken;
  UserLoginScreen({
    Key key,
    @required this.deviceToken,
  }) : super(key: key);

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  double height, width;
  var isUserName = false;
  var isMobileNumber = false;
  var isMobileInvalid = false;
  bool isLoading = false;
  FirebaseMessaging messaging;

  @override
  void initState() {
    mobileController = TextEditingController();
    //  getDeviceToken();
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
      body: Padding(
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
            SizedBox(height: height * 0.1),
            Container(
              child: setTextField(
                userNameController,
                "Username (Optional)",
                false,
                TextInputType.text,
                isUserName,
                msgEmptyFirstName,
                () {
                  setState(() {
                    isUserName = false;
                  });
                },
                () {},
              ),
            ),
            SizedBox(
              height: 15,
            ),
            setTextField(
              mobileController,
              "Mobile Number",
              false,
              TextInputType.number,
              isMobileNumber,
              msgEmptyMobileNumber,
              () {
                setState(() {
                  isMobileNumber = false;
                });
              },
              () {},
            ),
            Spacer(
              flex: 2,
            ),
            TextButtonWidget(
              btnTxt: "LOGIN",
              btnbackColor: appYellowColor,
              btnOntap: () {
                loginButtonTap();
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
                        builder: (builder) => UserRegistrationScreen(
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
    );
  }

  loginButtonTap() {
    FocusScope.of(context).unfocus();
    // if (userNameController.text.trim().length < 1) {
    //   setState(() {
    //     isUserName = true;
    //     return;
    //   });
    // } else

    if (mobileController.text.trim() == "") {
      setState(() {
        isMobileNumber = true;
      });
      return;
    } else if (mobileController.text.trim().length < 10) {
      setState(() {
        isMobileNumber = true;
        isMobileInvalid = true;
      });
      return;
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
        _responseHandling(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseHandling(userData) async {
    UserModel user = UserModel.fromJson(userData);
    // userObj = user;
    // setUserData();
    int role = user.role;
    if (role == 3) {
      showCustomToast("OTP sent to your mobile", context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => UserOTPScreen(
            mobileTxt: mobileController.text,
            deviceTokenTxt: widget.deviceToken,
          ),
        ),
      );
    } else if (role == 4) {
      print("Login As a SALON");
      showToast("Your number is already register as a salon ",
          context: context);
    } else if (role == 5) {
      print("Login As a STYLIST");
    }
  }
}
