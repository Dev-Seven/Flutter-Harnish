import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';
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
import 'package:intl/intl.dart';

class AddNewEmployeeVC extends StatefulWidget {
  @override
  _AddNewEmployeeVCState createState() => _AddNewEmployeeVCState();
}

class _AddNewEmployeeVCState extends State<AddNewEmployeeVC> {
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
  bool isVerified = false;
  final picker = ImagePicker();
  bool isMobileNumber = false;
  bool isLoading = false;
  bool isMobileInvalid = false;
  bool isUserName = false;
  DateTime _selectedDate;

  @override
  void initState() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: setTextWithCustomFont(
          "Add Employee",
          14,
          Colors.black,
          FontWeight.w600,
          1,
        ),
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
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
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
                                // image: DecorationImage(
                                //   fit: BoxFit.fill,
                                //   image: ExactAssetImage(
                                //     "assets/images/hairsalon.jpg",
                                //   ),
                                // ),
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
                    !isVerified
                        ? Column(
                            children: [
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
                                btnTxt: "VERIFY",
                                btnbackColor: ColorConstants.kButtonBackColor,
                                btnOntap: () {
                                  setState(() {
                                    isVerified = true;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : Container(),
                    isVerified
                        ? Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              TextButtonWidget(
                                btnTxt: "ADD",
                                btnbackColor: ColorConstants.kButtonBackColor,
                                btnOntap: () {
                                  setState(() {
                                    _showSuccessPopup();
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cupertinoDatePicker() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      print(formatted); // something like 2013-04-20
      setState(() {
        _selectedDate = pickedDate;
        dobController.text = formatted;
      });
    }
  }

  onAddEmployee() {
    if (nameController.text.trim().length < 1) {
      setState(() {
        isUserName = true;
        return;
      });
    } else if (mobileController.text.trim().length < 1) {
      setState(() {
        isMobileNumber = true;
        return;
      });
    } else if (mobileController.text.trim().length < 10) {
      setState(() {
        isMobileNumber = false;
        isMobileInvalid = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      FormData param = FormData.fromMap({
        "first_name": mobileController.text,
        "last_name": nameController.text,
        // "email": salonController.text,
        "mobile_no": mobileController.text,
        "dob": nameController.text,
        "gender": mobileController.text,
        "location": nameController.text,
        "latitude": mobileController.text,
        "longitude": nameController.text,
        "designation": mobileController.text,
        "time_schedule": nameController.text,
        "city": nameController.text,
      });
      postDataRequest(registerApi, param).then((value) {
        setState(() {
          isLoading = true;
        });
        if (value is Map) {
          _responseHandling(value[kData]);
          showCustomToast("OTP on your mobile", context);
        } else {
          showCustomToast(value.toString(), context);
        }
      });
    }
  }

  _responseHandling(userData) async {
   // SalonModel salon = SalonModel.fromJson(userData);
   // print(salon);
    // userObj = user;
    // setUserData();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (builder) => StylistOTPScreen(
    //       isFromLogin: false,
    //       mobileTxt: mobileController.text,
    //     ),
    //   ),
    // );
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
                  Map map = Map();
                  map["addEmployee"] = true;
                  Observable().notifyObservers([
                    "_StylistBottomNavigationScreenState",
                  ], map: map);

                  Map map1 = Map();
                  map1["addEmployee"] = true;
                  Observable().notifyObservers([
                    "_StylistDashBoardScreenState",
                  ], map: map1);

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
