import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/otp_widget.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:image_picker/image_picker.dart';

class EditEmployeeDetail extends StatefulWidget {
  @override
  _EditEmployeeDetailState createState() => _EditEmployeeDetailState();
}

class _EditEmployeeDetailState extends State<EditEmployeeDetail> {
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

  @override
  void initState() {
    nameController.text = "Jack";
    mobileController.text = "34534534534";
    dobController.text = "02/08/1991";
    genderController.text = "Male";
    locationController.text = "Jack";
    designationController.text = "Hair Stylist";
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
                  GestureDetector(
                    onTap: () {
                      getImage(ImgSource.Both);
                    },
                    child: _image != null
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
                              backgroundImage: FileImage(_image),
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
                                color: ColorConstants.kBlackColor,
                                width: 3,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "Full Name",
                    keyboardType: TextInputType.text,
                    controllerName: nameController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "Mobile Number",
                    keyboardType: TextInputType.number,
                    controllerName: mobileController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "Date of Birth",
                    keyboardType: TextInputType.text,
                    controllerName: dobController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "Gender",
                    keyboardType: TextInputType.text,
                    controllerName: genderController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "City",
                    keyboardType: TextInputType.text,
                    controllerName: locationController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    hintTxt: "Designation",
                    keyboardType: TextInputType.text,
                    controllerName: designationController,
                    onChanged: (val) {
                      print("object");
                    },
                    onSaved: (val) {
                      print("object");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.kWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isfullTimeCheck,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              isfullTimeCheck = value;
                            });
                          },
                        ),
                        Text(
                          "Full Time",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.kWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: ispartTimeCheck,
                          onChanged: (bool value) {
                            print(value);
                            setState(() {
                              ispartTimeCheck = value;
                            });
                          },
                        ),
                        Text(
                          "Part Time",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.kBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Enter Verification Code",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OTPWidget(
                    onSubmit: (val) {
                      print(val);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButtonWidget(
                    btnTxt: "UPDATE",
                    btnbackColor: ColorConstants.kButtonBackColor,
                    btnOntap: () {
                      _showSuccessPopup();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
              FlatButton(
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
