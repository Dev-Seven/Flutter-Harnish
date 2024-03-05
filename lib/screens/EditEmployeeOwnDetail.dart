import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/otp_widget.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:image_picker/image_picker.dart';

class EditEmployeeOwnDetail extends StatefulWidget {
  @override
  _EditEmployeeOwnDetailState createState() => _EditEmployeeOwnDetailState();
}

class _EditEmployeeOwnDetailState extends State<EditEmployeeOwnDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  bool isfullTimeCheck = false;
  bool ispartTimeCheck = false;
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;
  String profileImage = "";

  @override
  void initState() {
    getStylistProfile();
  }

  getStylistProfile() {
    setState(() {
      isLoading = true;
    });
    postDataRequestWithTokenStylist(getStylistProfileApi, null, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        String fName = value['first_name'];
        String lName = value['last_name'];
        String name = value['name'];
        String mobile = value['phone_number'];
        String dob = value['dob'];
        String city = value["city"];
        String gender = value["gender"];
        String designation = value["designation"];
        setState(() {
          profileImage = value["image"];
        });

        nameController.text = fName;
        mobileController.text = mobile;
        locationController.text = city;
        dobController.text = dob;
        genderController.text = gender;
        designationController.text = designation;
        _handleStylistProfileresponse(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _handleStylistProfileresponse(userData) {
    showCustomToast("Get Stylist Successful ", context);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  profileImage != null
                      ? Container(
                          height: 67,
                          width: 67,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(67 / 2),
                            border: Border.all(
                              color: ColorConstants.kBlackColor,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 67,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(baseImageURL + profileImage),
                          ),
                        )
                      : Container(
                          height: 67,
                          width: 67,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: ExactAssetImage(
                                "assets/images/hairsalon.jpg",
                              ),
                            ),
                            borderRadius: BorderRadius.circular(67 / 2),
                            border: Border.all(
                              color: ColorConstants.kGreyColor,
                              width: 1,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      nameController,
                      "Full Name",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "Full Name",
                  //   keyboardType: TextInputType.text,
                  //   controllerName: nameController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      mobileController,
                      "Mobile Number",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "Mobile Number",
                  //   keyboardType: TextInputType.number,
                  //   controllerName: mobileController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      dobController,
                      "Date of Birth",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "Date of Birth",
                  //   keyboardType: TextInputType.text,
                  //   controllerName: dobController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      genderController,
                      "Gender",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "Gender",
                  //   keyboardType: TextInputType.text,
                  //   controllerName: genderController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      locationController,
                      "City",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "City",
                  //   keyboardType: TextInputType.text,
                  //   controllerName: locationController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  setReadableTextFieldwithTrelingImage(
                      designationController,
                      "Designation",
                      false,
                      "",
                      null,
                      Colors.white,
                      null,
                      false,
                      false,
                      "",
                      null),
                  // TextFormFieldWidget(
                  //   focusNode: new AlwaysDisabledFocusNode(),
                  //   hintTxt: "Designation",
                  //   keyboardType: TextInputType.text,
                  //   controllerName: designationController,
                  //   onChanged: () {
                  //     print("object");
                  //   },
                  //   onSaved: () {
                  //     print("object");
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showSuccessPopup() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Updated'),
            content: Text('Employee updated successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                /*Navigator.of(context).pop(true)*/
                child: Text(
                  'Done',
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: ColorConstants.kRedColor,
      ),
    );
    setState(() {
      _image = image;
    });
  }
}
