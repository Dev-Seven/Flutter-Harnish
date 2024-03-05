import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/widgets/employee_list_item_widget.dart';
import 'package:harnishsalon/widgets/otp_widget.dart';

import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';

/*
Title:EmployeeListScreen
Purpose:EmployeeListScreen
Created By:17 Feb 2021
*/

class EmployeeListScreen extends StatefulWidget {
  final String deviceTokenTxt;
  EmployeeListScreen({
    Key key,
    this.deviceTokenTxt,
  }) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen>
    with SingleTickerProviderStateMixin {
  double height, width;
  TabController _tabController;

  FocusNode submittedFocus;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController mobileController;
  TextEditingController dobController;
  TextEditingController cityController;
  TextEditingController designationController;
  bool isfullTimeCheck = false;
  bool ispartTimeCheck = false;
  bool isMaleSelected = false;
  bool isisFemaleSelected = false;
  var _image;
  final picker = ImagePicker();
  bool isOTPVisible = false;
  String imageName = "";
  DateTime _selectedDate;
  bool isLoading = false;
  bool isMobileNumber = false;
  String _genderRadioBtnVal = "Male";
  String _dutyTypeVal = "Full Time";

  bool isMobileInvalid = false;
  bool isUserName = false;
  String submittedOTP = "";
  List<StylistModel> empList = List.from([StylistModel()]);
  double currentLatitude;
  String currentAddress;
  double currentLongitude;
  bool isOTPSend = false;
  bool isOTPConfirm = true;
  bool isDataLoading = true;
  bool isSalonName = false;
  bool isFirstName = false;
  bool isLastName = false;
  bool isEmail = false;

  bool isDob = false;
  bool isCity = false;
  bool isDesignation = false;
  String employeeID;
  String currentDate = "";

  final nameArray = [
    "Brandon Perry",
    "Shane Banks",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
    "Brandon Perry",
  ];

  final idleArray = [
    "Idle",
    "Shampoo",
    "Idle",
    "Idle",
    "Idle",
    "Idle",
    "Idle",
    "Idle",
    "Idle",
    "Idle",
  ];

  final imgArray = [
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
  ];

  final custNameArray = [
    "Nishit Mistry",
    "Amit Shah",
    "Jay D",
    "Ketty ",
    "Victor",
    "Peter",
    "John",
    "Robert",
    "Vinch",
    "Priyanka",
  ];

  final styNameArray = [
    "Steve",
    "Buffet",
    "Cyrus Mistry",
    "Adar Mistry",
    "Nishit Mistry",
    "Nishit Mistry",
    "Nishit Mistry",
    "Nishit Mistry",
    "Nishit Mistry",
    "Nishit Mistry",
  ];

  final ratingArray = [
    125,
    125,
    125,
    125,
    125,
    125,
    125,
    125,
    125,
    125,
  ];

  final earningArray = [
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
    "1254",
  ];

  final custFeedbackArray = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
  ];

  final stylistFeedbackArray = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisi ante, dapibus vitae dapibus non, aliquam non sem. Aenean a quam laoreet, finibus justo sed",
  ];

  @override
  void initState() {
    super.initState();
    getCurrentdate();

    submittedFocus = FocusNode();

    getEmployeeList();
    getCurrentLatLong();
    _tabController = new TabController(
      length: 2,
      vsync: this,
    );
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    cityController = TextEditingController();
    dobController = TextEditingController();
    designationController = TextEditingController();
  }

  getCurrentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    setState(() {
      currentDate = formatter.format(now);
    });

    print(currentDate);
  }

  Future<Position> getCurrentLatLong() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (mounted) {
      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
      });
    }

    var coordinates = new Coordinates(currentLatitude, currentLongitude);

    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          setState(() {
            currentAddress = address[0].addressLine;
          })
        });

    return position;
  }

  getEmployeeList() {
    empList.clear();
    setState(() {
      isLoading = true;
    });
    postDataRequestWithTokenSalon(employeeList, null, context).then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (value is List) {
        _handleListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _handleListResponse(value) {
    var arrData =
        value.map<StylistModel>((json) => StylistModel.fromJson(json)).toList();
    setState(() {
      empList = arrData;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // firstNameFocus.dispose();
    // lastNameFocus.dispose();
    // emailFocus.dispose();
    // mobileFocus.dispose();
    // dobFocus.dispose();
    // cityFocus.dispose();
    // designationFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
          ),
          child: Column(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: ColorConstants.kWhiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: ColorConstants.kButtonBackColor,
                  ),
                  labelColor: ColorConstants.kWhiteColor,
                  unselectedLabelColor: ColorConstants.kBlackColor,
                  tabs: [
                    Tab(
                      text: 'Employee List',
                    ),
                    Tab(
                      text: 'Add Employee ',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    empList.isEmpty
                        ? Center(
                            child: Text(
                              "No Employee Added",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.kBlackColor,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: empList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    return EmployeeListItemWidget(
                                      earningAmountTxt: empList[index]
                                          .totalRevenue
                                          .toString(),
                                      nameTxt: empList[index].name,
                                      profileImg: empList[index].image != null
                                          ? empList[index].image
                                          : "",
                                      custNameTxt: custNameArray[index],
                                      stylistNameTxt: styNameArray[index],
                                      custRatingTxt:
                                          empList[index].ratings.toDouble(),
                                      stylistRatingTxt: 3,
                                      custFeedbackTxt: custFeedbackArray[index],
                                      stylistFeedbackTxt:
                                          stylistFeedbackArray[index],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                    ListView(
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
                                        borderRadius:
                                            BorderRadius.circular(67 / 2),
                                        border: Border.all(
                                          color: ColorConstants.kGreyColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 67,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: FileImage(
                                          File(_image.path),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 67,
                                      width: 67,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: ExactAssetImage(
                                            "assets/images/user.png",
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(67 / 2),
                                        border: Border.all(
                                          color: ColorConstants.kGreyColor
                                              .withOpacity(0.4),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                              firstNameController,
                              "First Name",
                              false,
                              TextInputType.text,
                              isFirstName,
                              msgEmptyFirstName,
                              () => {
                                setState(() {
                                  isFirstName = false;
                                })
                              },
                              () {},
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                                lastNameController,
                                "Last Name",
                                false,
                                TextInputType.text,
                                isLastName,
                                msgEmptyLastName,
                                () => {
                                      setState(() {
                                        isLastName = false;
                                      })
                                    },
                                () {}),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                              alignment: Alignment.topLeft,
                              color: Colors.white,
                              height: 90,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  setTextWithCustomFont(
                                    " Gender",
                                    16,
                                    ColorConstants.kBlackColor,
                                    FontWeight.w400,
                                    1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<String>(
                                        value: "Male",
                                        groupValue: _genderRadioBtnVal,
                                        onChanged: _handleGenderChange,
                                      ),
                                      Text(
                                        "Male",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: ColorConstants.kBlackColor,
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "Female",
                                        groupValue: _genderRadioBtnVal,
                                        onChanged: _handleGenderChange,
                                      ),
                                      Text(
                                        "Female",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: ColorConstants.kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                                emailController,
                                "Email",
                                false,
                                TextInputType.text,
                                isEmail,
                                msgEmptyLastName,
                                () => {
                                      setState(() {
                                        isEmail = false;
                                      })
                                    },
                                () {}),
                            SizedBox(
                              height: 10,
                            ),
                            setTextFieldMaxNumber(
                                mobileController,
                                "Mobile Number",
                                false,
                                TextInputType.number,
                                isMobileNumber,
                                msgEmptyMobileNumber, () {
                              setState(() {
                                isMobileNumber = false;
                              });
                            }, 10),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                                dobController,
                                "Date of Birth",
                                false,
                                TextInputType.text,
                                isDob,
                                msgEmptyLastName,
                                () => {
                                      // cupertinoDatePicker(),
                                      // FocusScopeNode currentFocus = FocusScope.of(context)

                                      // if (!currentFocus.hasPrimaryFocus) {
                                      //   currentFocus.unfocus();
                                      // }
                                      setState(() {
                                        isDob = false;
                                      })
                                    }, () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              cupertinoDatePicker();
                            }),
                            // TextFormFieldWidget(
                            //   hintTxt: "Date of Birth",
                            //   keyboardType: TextInputType.text,
                            //   controllerName: dobController,
                            //   onChanged: (val) {
                            //     //cupertinoDatePicker();
                            //   },
                            //   onTextFormFieldTap: () {

                            //   },
                            //   onSaved: (val) {
                            //     //
                            //   },

                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                                cityController,
                                "City",
                                false,
                                TextInputType.text,
                                isCity,
                                msgEmptyLastName,
                                () => {
                                      setState(() {
                                        isCity = false;
                                      })
                                    },
                                () {}),
                            SizedBox(
                              height: 10,
                            ),
                            setTextField(
                                designationController,
                                "Designation",
                                false,
                                TextInputType.text,
                                isDesignation,
                                msgEmptyDesignation,
                                () => {
                                      setState(() {
                                        isDesignation = false;
                                      })
                                    },
                                () {}),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 15, 15, 0),
                              alignment: Alignment.topLeft,
                              color: Colors.white,
                              height: 90,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  setTextWithCustomFont(
                                    " Time Schedule",
                                    16,
                                    ColorConstants.kBlackColor,
                                    FontWeight.w400,
                                    1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio<String>(
                                        value: "Full Time",
                                        groupValue: _dutyTypeVal,
                                        onChanged: _handleDutyChange,
                                      ),
                                      Text(
                                        "Full Time",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.w500,
                                          color: ColorConstants.kBlackColor,
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "Part Time",
                                        groupValue: _dutyTypeVal,
                                        onChanged: _handleDutyChange,
                                      ),
                                      Text(
                                        "Part Time",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: ColorConstants.kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Visibility(
                              visible: isOTPVisible,
                              child: Column(
                                children: [
                                  Text(
                                    "Enter Verification Code",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
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
                                      setState(() {
                                        submittedOTP = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextButtonWidget(
                                    btnTxt: "Verify",
                                    btnbackColor:
                                        ColorConstants.kButtonBackColor,
                                    btnOntap: () {
                                      verifyEmployee();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButtonWidget(
                              btnTxt: "CONFIRM",
                              btnbackColor: ColorConstants.kButtonBackColor,
                              btnOntap: () {
                                setState(() {
                                  isOTPVisible = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(submittedFocus);
                                onAddEmployee();
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
    print(_genderRadioBtnVal);
  }

  void _handleDutyChange(String value) {
    setState(() {
      _dutyTypeVal = value;
    });
  }

  verifyEmployee() {
    print(employeeID);

    setState(() {
      isLoading = false;
      _image = null;
    });
    print("UPLOADED IMAGE PATH : $_image");
    FormData param = FormData.fromMap({
      "employee_id": employeeID,
      "otp": submittedOTP,
    });
    postDataRequestWithTokenSalon(verifyEmployeeApi, param, context)
        .then((value) {
      setState(() {
        isLoading = true;
      });
      if (value is List) {
        _onResponseEmployeeHandling(value);
      } else {
        print(value);
        showCustomToast(value.toString(), context);
      }
    });
  }

  _onResponseEmployeeHandling(userData) async {
    showCustomToast("Employee Verify Success", context);
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    designationController.clear();
    mobileController.clear();
    dobController.clear();
    cityController.clear();

    //_tabController.index = 0;
    //getEmployeeList();
    // Navigator.pop(context);
    //FocusScope.of(context).unfocus();
    showSuccessPopup();
  }

  cupertinoDatePicker() async {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
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
      final String formatted = formatter.format(pickedDate);
      print(formatted);
      setState(() {
        _selectedDate = pickedDate;
        dobController.text = formatted;
      });
    }
  }

  onAddEmployee() async {
    FocusScope.of(context).unfocus();
    if (firstNameController.text.trim() == "") {
      setState(() {
        isFirstName = true;
      });
      return;
    }
    if (lastNameController.text.trim() == "") {
      setState(() {
        isLastName = true;
      });
      return;
    }

    if (emailController.text.trim() == "") {
      setState(() {
        isEmail = true;
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

    if (dobController.text.trim() == "") {
      setState(() {
        isDob = true;
      });
      return;
    }
    if (cityController.text.trim() == "") {
      setState(() {
        isCity = true;
      });
      return;
    }
    if (designationController.text.trim() == "") {
      setState(() {
        isDesignation = true;
      });
      return;
    }

    setState(() {
      isOTPSend = true;
      isOTPConfirm = false;
      isOTPVisible = true;
      isLoading = true;
    });
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String mobile = mobileController.text;
    String dob = dobController.text;
    String city = cityController.text;
    String designation = designationController.text;

    FormData param = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "mobile_no": mobile,
      "email": email,
      "dob": dob,
      "gender": _genderRadioBtnVal,
      "location": city,
      "city": city,
      "latitude": currentLatitude,
      "longitude": currentLongitude,
      "designation": designation,
      "time_schedule": _dutyTypeVal,
      "image": await MultipartFile.fromFile(
        _image.path,
        filename: imageName,
      ),
    });
    postDataRequestWithTokenSalon(addEmployee, param, context).then((value) {
      setState(() {
        isLoading = false;
      });
      print(value);
      if (value is Map) {
        String sendOTP = value['otp'];
        print("OTP Verification : $sendOTP");
        print("EMPL ID : ${value['_id']}");
        setState(() {
          employeeID = value['_id'];
        });
        print(" IMAGE PATH : $_image");
        _responseHandling(value[kData]);
        // verifyPin();
        // showSuccessPopup();
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseHandling(userData) async {
    showCustomToast("Employee Added", context);
    StylistModel stylistModel = StylistModel.fromJson(userData);
    print(stylistModel);
  }

  Future<bool> showSuccessPopup() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Employee'),
            content: Text('Employee added & verify successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  _tabController.index = 0;
                  getEmployeeList();
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
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
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: ColorConstants.kRedColor,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: ColorConstants.kRedColor,
      ),
      cameraText: Text(
        "From Camera",
        style: TextStyle(color: ColorConstants.kRedColor),
      ),
      galleryText: Text(
        "From Gallery",
        style: TextStyle(color: ColorConstants.kBlueColor),
      ),
    );

    File file = new File(image.path);
    String fileName = file.path.split('/').last;
    print("${image.path}");
    setState(() {
      _image = image;
      imageName = fileName;
    });
    // updateImageProfile();
  }
}
