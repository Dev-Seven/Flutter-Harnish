import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/user_profile_screen.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';

/*
Title:UserProfileDetailScreen
Purpose:UserProfileDetailScreen
Required Params:OTPWidget
Created By:Kalpesh Khandla

*/

class UserProfileDetailScreen extends StatefulWidget {
  UserProfileDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  _UserProfileDetailScreenState createState() =>
      _UserProfileDetailScreenState();
}

class _UserProfileDetailScreenState extends State<UserProfileDetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  bool isLoading = false;
  String name;
  String mobileNumber = "";
  String fullName = "";

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
          setState(() {
            isLoading = false;
          }),
          if (value is Map)
            {
              name = value['first_name'],
              mobileNumber = value['phone_number'],
              fullName = value['name'],
              nameController.text = name,
              mobileController.text = mobileNumber,
              fullNameController.text = fullName,
              _handleStylistProfileresponse(value),
            }
          else
            {
              showCustomToast(value.toString(), context),
            }
        });
  }

  _handleStylistProfileresponse(userData) {
    showCustomToast("Get Profile Successful ", context);
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(),
              ),
            );
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
                "Profile",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              Spacer(
                  // flex: 2,
                  ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: setTextField(
                  nameController,
                  "Enter name",
                  false,
                  TextInputType.text,
                  false,
                  "",
                  () {},
                  () {},
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AbsorbPointer(
                absorbing: true,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: setTextField(
                    mobileController,
                    "Mobile Number",
                    false,
                    TextInputType.phone,
                    false,
                    "",
                    () {},
                    () {},
                  ),
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
                  false,
                  "",
                  () {},
                  () {},
                ),
              ),
              Spacer(
                flex: 3,
              ),
              // Container(
              //   padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
              //   child: TextButtonWidget(
              //     btnTxt: "Update",
              //     btnbackColor: appYellowColor,
              //     btnOntap: () {
              //       //onUpdateTap();
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  onUpdateTap() {
    String firstname = nameController.text;
    String fullname = fullNameController.text;
    setState(() {
      isLoading = true;
    });
    FormData formdata = FormData.fromMap({
      "first_name": firstname,
      "last_name": fullname,
    });

    postDataRequestWithToken(updateUserProfileApi, formdata, context).then(
      (value) => {
        setState(() {
          isLoading = false;
        }),
        if (value is Map)
          {
            _responseHandling(value[kData]),
          }
        else
          {
            showCustomToast(value.toString(), context),
          }
      },
    );
  }

  _responseHandling(userData) {
    print(userData);
    showCustomToast("User Profile Update Success", context);
  }
}
