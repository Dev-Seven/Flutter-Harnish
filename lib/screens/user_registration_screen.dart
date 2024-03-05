import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/user_model.dart';
import 'package:harnishsalon/screens/user_otp_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/screens/user_login_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  final String deviceToken;
  UserRegistrationScreen({
    Key key,
    this.deviceToken,
  }) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistrationScreen> {
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController fullNameController;

  double height, width;
  var isUserNameEmpty = false;
  bool isFullNameEmpty = false;
  var isMobileNumberEmpty = false;
  var isMobileInvalid = false;
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController();
    mobileController = TextEditingController();
    fullNameController = TextEditingController();

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
            horizontal: 10,
            vertical: 10,
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
              SizedBox(height: height * 0.1),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: setTextField(
                  nameController,
                  "Username",
                  false,
                  TextInputType.text,
                  isUserNameEmpty,
                  msgEmptyName,
                  () {
                    setState(() {
                      isUserNameEmpty = false;
                    });
                  },
                  () {},
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: setTextFieldMaxNumber(
                  mobileController,
                  "Mobile Number",
                  false,
                  TextInputType.number,
                  isMobileNumberEmpty,
                  msgEmptyMobileNumber,
                  () {
                    setState(() {
                      isMobileNumberEmpty = false;
                    });
                  },
                  10,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: setTextField(
                  fullNameController,
                  "Full Name",
                  false,
                  TextInputType.text,
                  isFullNameEmpty,
                  msgEmptyFullName,
                  () {
                    setState(() {
                      isFullNameEmpty = false;
                    });
                  },
                  () {},
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Spacer(
                flex: 3,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: TextButtonWidget(
                  btnTxt: "NEXT",
                  btnbackColor: appYellowColor,
                  btnOntap: () {
                    onRegisterTap();
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have a account ?",
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
                          builder: (builder) => UserLoginScreen(
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

  onRegisterTap() {
    FocusScope.of(context).unfocus();

    if (nameController.text.trim() == "") {
      setState(() {
        isUserNameEmpty = true;
      });
      return;
    }

    if (mobileController.text.trim() == "") {
      setState(() {
        isMobileNumberEmpty = true;
      });
      return;
    } else if (mobileController.text.trim().length < 10) {
      setState(() {
        isMobileNumberEmpty = true;
        isMobileInvalid = true;
      });
      return;
    }

    if (fullNameController.text.trim() == "") {
      setState(() {
        isFullNameEmpty = true;
      });
      return;
    }

    setState(() {
      isLoading = false;
    });
    FormData param = FormData.fromMap({
      "name": nameController.text,
      "phone_number": mobileController.text,
      "full_name": fullNameController.text,
    });
    postDataRequest(userRegister, param).then((value) {
      setState(() {
        isLoading = true;
      });
      if (value is Map) {
        _responseHandling(value[kData]);
        showCustomToast("OTP sent to your mobile", context);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseHandling(userData) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => UserOTPScreen(
          mobileTxt: mobileController.text,
          deviceTokenTxt: widget.deviceToken,
        ),
      ),
    );
  }
}
