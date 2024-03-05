import 'package:dio/dio.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/StylistAddPhotoVC.dart';
import 'package:harnishsalon/widgets/close_time_picker_widget.dart';
import 'package:harnishsalon/widgets/open_close_widget.dart';
import 'package:harnishsalon/widgets/start_time_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../common/Constant.dart';

class StylistAddressDetailVC extends StatefulWidget {
  final String salonIdFromOTP;
  StylistAddressDetailVC({
    Key key,
    this.salonIdFromOTP,
  }) : super(key: key);

  @override
  _StylistAddressDetailVCState createState() => _StylistAddressDetailVCState();
}

class _StylistAddressDetailVCState extends State<StylistAddressDetailVC> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController towerController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController salonNameController = TextEditingController();

  var isMon = false;
  var isTue = false;
  var isWed = false;
  var isThu = false;
  var isFri = false;
  var isSat = false;
  var isSun = false;
  DateTime startTime;
  DateTime endTime;
  DateTime selectedDate;
  double currentLatitude;
  String currentAddress;
  double currentLongitude;
  double height, width;
  bool isLoading = false;
  var _txtFromTime;
  var _txtToTime;
  bool isEmptyStarTime = true;
  bool isEmptyEndTime = true;
  bool openBottomSheetOpen = false;

  List<String> startTimeList = [];
  List<String> closeTimeList = [];
  List allopeningClosingList = [];

  bool isMonOpen = false;
  bool isTuesdayOpen = false;
  bool isThursdayOpen = false;
  bool isFridayOpen = false;
  bool isSaturdayOpen = false;
  bool isSundayOpen = false;

  String mondayTxt = "Monday";
  String tuesdayTxt = "Tuesday";
  String weddayTxt = "Wednesday";
  String thudayTxt = "Thursday";
  String fridayTxt = "Friday";
  String satdayTxt = "Saturday";
  String sundayTxt = "Sunday";

  // moday
  String monOpeningTime = "00:00";
  String monClosingTime = "00:00";
  bool isMonOpentimeVisible = true;
  bool isMonClosetimeVisible = true;
  String monDropselectedValue = "Open";
  String selectedModayOpenTime = "00:00";
  String selectedModayCloseTime = "00:00";

  // Tuesday

  String tueOpeningTime = "00:00";
  String tueClosingTime = "00:00";
  bool isTueOpentimeVisible = true;
  bool isTueClosetimeVisible = true;
  String tueDropselectedValue = "Open";
  String selectedTuesdayOpenTime = "00:00";
  String selectedTuesdayCloseTime = "00:00";

  // Wenesaday

  String wedOpeningTime = "00:00";
  String wedClosingTime = "00:00";
  bool isWedOpentimeVisible = true;
  bool isWedClosetimeVisible = true;
  String wedDropselectedValue = "Open";
  String selectedWednesdayOpenTime = "00:00";
  String selectedWednesdayCloseTime = "00:00";

  // Thursday

  String thuOpeningTime = "00:00";
  String thuClosingTime = "00:00";
  bool isThuOpentimeVisible = true;
  bool isThuClosetimeVisible = true;
  String thuDropselectedValue = "Open";
  String selectedThursdayOpenTime = "00:00";
  String selectedThursdayCloseTime = "00:00";

  // Friday

  String friOpeningTime = "00:00";
  String friClosingTime = "00:00";
  bool isFriOpentimeVisible = true;
  bool isFriClosetimeVisible = true;
  String friDropselectedValue = "Open";
  String selectedFridayOpenTime = "00:00";
  String selectedFridayCloseTime = "00:00";

  // Saturday

  String satOpeningTime = "00:00";
  String satClosingTime = "00:00";
  bool isSatOpentimeVisible = true;
  bool isSatClosetimeVisible = true;
  String satDropselectedValue = "Open";
  String selectedSaturdayOpenTime = "00:00";
  String selectedSaturdayCloseTime = "00:00";

  // Sunday

  String sunOpeningTime = "00:00";
  String sunClosingTime = "00:00";
  bool isSunOpentimeVisible = true;
  bool isSunClosetimeVisible = true;
  String sunDropselectedValue = "Open";
  String selectedSundayOpenTime = "00:00";
  String selectedSundayCloseTime = "00:00";

  final nameArray = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  var arrSelection = [
    "true",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
  ];

  List<String> dropDownValue = [
    "Open",
    "Close",
    "Close",
    "Close",
    "Close",
    "Close",
    "Close",
  ];

  bool isWednesdayOpen = false;

  bool isUserNameEmpty = false;
  bool isSalonNameEmpty = false;
  bool isAddressNameEmpty = false;
  bool isTowerNameEmpty = false;
  bool isAreaNameEmpty = false;
  bool isCityNameEmpty = false;
  bool isStateNameEmpty = false;
  bool isFloorNameEmpty = false;

  @override
  void initState() {
    super.initState();
    _txtFromTime = TextEditingController();
    getCurrentLatLong();
    getsalonData();
    print(widget.salonIdFromOTP);
    // getOpenCloseTime();
  }

  getsalonData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String salonNameFromReg = sharedPreferences.getString("salonname");
    String fullName = sharedPreferences.getString("fullname");
    print(salonNameFromReg);
    print(fullName);
    salonNameController.text = salonNameFromReg;
    firstNameController.text = fullName;
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

    setState(() {
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
    });
    var coordinates = new Coordinates(currentLatitude, currentLongitude);

    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      currentAddress = address[0].addressLine;
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Salon Details",
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kBlackColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setTextWithCustomFont(
                  "Address Detail",
                  16,
                  Colors.black,
                  FontWeight.w600,
                  1,
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  height: height * 0.13,
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.65,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                          ),
                          child: setTextWithCustomFont(
                              currentAddress != null ? currentAddress : "",
                              14,
                              Color.fromRGBO(138, 138, 138, 1.0),
                              FontWeight.w400,
                              1.0),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.gps_fixed_sharp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      setTextField(
                        salonNameController,
                        "Salon Name",
                        false,
                        TextInputType.text,
                        isSalonNameEmpty,
                        msgEmptysalonName,
                        () {
                          setState(() {
                            isSalonNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        firstNameController,
                        "Full  Name",
                        false,
                        TextInputType.text,
                        isUserNameEmpty,
                        msgEmptyfullName,
                        () {
                          setState(() {
                            isUserNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        addressController,
                        "Address",
                        false,
                        TextInputType.text,
                        isAddressNameEmpty,
                        msgEmptyaddress,
                        () {
                          setState(() {
                            isAddressNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        floorController,
                        "Floor",
                        false,
                        TextInputType.text,
                        isFloorNameEmpty,
                        msgEmptyFloorName,
                        () {
                          setState(() {
                            isFloorNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        towerController,
                        "Tower / Wing",
                        false,
                        TextInputType.text,
                        isTowerNameEmpty,
                        msgEmptyTowerName,
                        () {
                          setState(() {
                            isTowerNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        areaController,
                        "Area",
                        false,
                        TextInputType.text,
                        isAreaNameEmpty,
                        msgEmptyAreaName,
                        () {
                          setState(() {
                            isAreaNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        cityController,
                        "City",
                        false,
                        TextInputType.text,
                        isCityNameEmpty,
                        msgEmptyCityName,
                        () {
                          setState(() {
                            isCityNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                      Divider(
                        height: 1,
                      ),
                      setTextField(
                        stateController,
                        "State",
                        false,
                        TextInputType.text,
                        isStateNameEmpty,
                        msgEmptystateName,
                        () {
                          setState(() {
                            isStateNameEmpty = false;
                          });
                        },
                        () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                setTextWithCustomFont(
                  "Salon Timing",
                  16,
                  Colors.black,
                  FontWeight.w600,
                  1,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 44),
                  color: ColorConstants.kWhiteColor,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              setTextWithCustomFont(
                                  "Weekdays",
                                  14,
                                  ColorConstants.kBlackColor,
                                  FontWeight.w700,
                                  1),
                              SizedBox(
                                width: 5,
                              ),
                              setTextWithCustomFont(
                                  "Status",
                                  14,
                                  ColorConstants.kBlackColor,
                                  FontWeight.w700,
                                  1),
                              SizedBox(
                                width: 10,
                              ),
                              setPoppinsfontWitAlignment(
                                  "Opening \n Time",
                                  14,
                                  ColorConstants.kBlackColor,
                                  FontWeight.w700,
                                  1),
                              SizedBox(
                                width: 15,
                              ),
                              setPoppinsfontWitAlignment(
                                  "Closing \nTime",
                                  14,
                                  ColorConstants.kBlackColor,
                                  FontWeight.w700,
                                  1),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isMon = !isMon;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    color: isMon
                                        ? ColorConstants.kButtonBackColor
                                        : appGreyColor,
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  height: 35,
                                  width: 90,
                                  child: setTextWithCustomFont(
                                    mondayTxt,
                                    12,
                                    isMon
                                        ? Colors.white
                                        : ColorConstants.kBlackColor,
                                    FontWeight.w600,
                                    1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: appGreyColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                height: 35,
                                child: DropdownButton<String>(
                                  value: monDropselectedValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      if (newValue == "Open") {
                                        setState(() {
                                          isMonOpentimeVisible = true;
                                          isMonClosetimeVisible = true;
                                        });
                                      } else {
                                        setState(() {
                                          isMonOpentimeVisible = false;
                                          isMonClosetimeVisible = false;
                                        });
                                      }
                                      monDropselectedValue = newValue ?? "";
                                    });
                                  },
                                  items: <String>['Open', 'Close']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: isMonOpentimeVisible,
                                child: Container(
                                    height: 35,
                                    width: 90,
                                    child: InkWell(
                                      onTap: () {
                                        _monshowTimePicker(context, true);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        alignment: Alignment.center,
                                        child: setTextWithCustomFont(
                                          selectedModayOpenTime != null
                                              ? selectedModayOpenTime
                                              : "00:00",
                                          14,
                                          textBlackColor,
                                          FontWeight.w900,
                                          1.2,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                210, 210, 210, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        height: 35,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: isMonClosetimeVisible,
                                child: Container(
                                  height: 35,
                                  width: 90,
                                  child: InkWell(
                                    onTap: () {
                                      _monshowTimePicker(context, false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: setTextWithCustomFont(
                                        selectedModayCloseTime != null
                                            ? selectedModayCloseTime
                                            : "00:00",
                                        14,
                                        textBlackColor,
                                        FontWeight.w900,
                                        1.2,
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(210, 210, 210, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0))),
                                      height: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          tuesdayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: tueDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isTueOpentimeVisible = true;
                                                isTueClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isTueOpentimeVisible = false;
                                                isTueClosetimeVisible = false;
                                              });
                                            }
                                            tueDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Visibility(
                                      visible: isTueOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _tuesdayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedTuesdayOpenTime != null
                                                    ? selectedTuesdayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(4.0),
                                                  )),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isTueClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _tuesdayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedTuesdayCloseTime != null
                                                  ? selectedTuesdayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          weddayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: wedDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isWedOpentimeVisible = true;
                                                isWedClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isWedOpentimeVisible = false;
                                                isWedClosetimeVisible = false;
                                              });
                                            }
                                            wedDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isWedOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _weddayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedWednesdayOpenTime !=
                                                        null
                                                    ? selectedWednesdayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isWedClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _weddayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedWednesdayCloseTime != null
                                                  ? selectedWednesdayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          thudayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: thuDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isThuOpentimeVisible = true;
                                                isThuClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isThuOpentimeVisible = false;
                                                isThuClosetimeVisible = false;
                                              });
                                            }
                                            thuDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isThuOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _thudayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedThursdayOpenTime != null
                                                    ? selectedThursdayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isThuClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _thudayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedThursdayCloseTime != null
                                                  ? selectedThursdayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          fridayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: friDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isFriOpentimeVisible = true;
                                                isFriClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isFriOpentimeVisible = false;
                                                isFriClosetimeVisible = false;
                                              });
                                            }
                                            friDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Visibility(
                                      visible: isFriOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _fridayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedFridayOpenTime != null
                                                    ? selectedFridayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(width: 10),
                                    Visibility(
                                      visible: isFriClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _fridayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedFridayCloseTime != null
                                                  ? selectedFridayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          satdayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: satDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isSatOpentimeVisible = true;
                                                isSatClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isSatOpentimeVisible = false;
                                                isSatClosetimeVisible = false;
                                              });
                                            }
                                            satDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Visibility(
                                      visible: isSatOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _saturdayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedSaturdayOpenTime != null
                                                    ? selectedSaturdayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isSatClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _saturdayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedSaturdayCloseTime != null
                                                  ? selectedSaturdayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMon = !isMon;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: isMon
                                                ? ColorConstants
                                                    .kButtonBackColor
                                                : appGreyColor),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        height: 35,
                                        width: 90,
                                        child: setTextWithCustomFont(
                                          sundayTxt,
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: appGreyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        value: sunDropselectedValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            if (newValue == "Open") {
                                              setState(() {
                                                isSunOpentimeVisible = true;
                                                isSunClosetimeVisible = true;
                                              });
                                            } else {
                                              setState(() {
                                                isSunOpentimeVisible = false;
                                                isSunClosetimeVisible = false;
                                              });
                                            }
                                            sunDropselectedValue =
                                                newValue ?? "";
                                          });
                                        },
                                        items: <String>['Open', 'Close']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isSunOpentimeVisible,
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          child: InkWell(
                                            onTap: () {
                                              _sundaydayshowTimePicker(
                                                  context, true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              alignment: Alignment.center,
                                              child: setTextWithCustomFont(
                                                selectedSundayOpenTime != null
                                                    ? selectedSundayOpenTime
                                                    : "00:00",
                                                14,
                                                textBlackColor,
                                                FontWeight.w900,
                                                1.2,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              height: 35,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: isSunClosetimeVisible,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        child: InkWell(
                                          onTap: () {
                                            _sundaydayshowTimePicker(
                                                context, false);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            alignment: Alignment.center,
                                            child: setTextWithCustomFont(
                                              selectedSundayCloseTime != null
                                                  ? selectedSundayCloseTime
                                                  : "00:00",
                                              14,
                                              textBlackColor,
                                              FontWeight.w900,
                                              1.2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  210, 210, 210, 1),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4.0),
                                              ),
                                            ),
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 47,
                  width: MediaQuery.of(context).size.width - 20,
                  child: setbuttonWithChild(
                      setTextWithCustomFont(
                        "NEXT",
                        14,
                        Colors.white,
                        FontWeight.w400,
                        1,
                      ), () {
                    onSaveAddress();
                  }, ColorConstants.kButtonBackColor, 3),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _monshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isMonOpen = true;
    });

    var dateTime = isStart
        ? DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
          )
        : DateTime(
            startTime.year,
            startTime.month,
            startTime.day,
            startTime.hour,
            00,
          );

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      selectedModayOpenTime = formattedTime;
                      isEmptyStarTime = false;
                      isMonOpen = !isMonOpen;
                      print(isMonOpen);
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedModayCloseTime = formattedClosingTime;
                        isMonOpen = !isMonOpen;
                      });
                      print(isMonOpen);
                      isEmptyEndTime = false;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  void _tuesdayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isTuesdayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      selectedTuesdayOpenTime = formattedTime;

                      isEmptyStarTime = false;
                      isTuesdayOpen = !isTuesdayOpen;
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedTuesdayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute,
                        )
                      : DateTime(
                          startTime.year,
                          startTime.month,
                          startTime.day,
                          startTime.hour,
                          startTime.minute,
                        )
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(
                          startTime.year,
                          startTime.month,
                          startTime.day,
                          startTime.hour,
                          startTime.minute,
                        )
                  : null,
            ),
          );
        });
  }

  void _weddayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isWednesdayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      selectedWednesdayOpenTime = formattedTime;
                      isEmptyStarTime = false;
                      isWednesdayOpen = !isWednesdayOpen;
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedWednesdayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  void _thudayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isThursdayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      selectedThursdayOpenTime = formattedTime;
                      // widget.openingTime = formattedTime;
                      // widget.openingTimeTap(widget.openingTime);

                      //  print("WIDGET TIME : ${widget.openingTime}");
                      isEmptyStarTime = false;
                      isThursdayOpen = !isThursdayOpen;
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedThursdayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  void _fridayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isFridayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      print("FORMATED Time : $formattedTime");
                      selectedFridayOpenTime = formattedTime;
                      // widget.openingTime = formattedTime;
                      // widget.openingTimeTap(widget.openingTime);

                      //  print("WIDGET TIME : ${widget.openingTime}");
                      isEmptyStarTime = false;
                      isFridayOpen = !isFridayOpen;
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedFridayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  void _saturdayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isSaturdayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      selectedSaturdayOpenTime = formattedTime;
                      // widget.openingTime = formattedTime;
                      // widget.openingTimeTap(widget.openingTime);

                      //  print("WIDGET TIME : ${widget.openingTime}");
                      isEmptyStarTime = false;
                      isSaturdayOpen = !isSaturdayOpen;
                    } else {
                      String formattedClosingTime =
                          "${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedSaturdayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  void _sundaydayshowTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isSundayOpen = true;
    });
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    // if (isStart) {
    //   // setState(() {
    //   //   isEmptyStarTime = false;
    //   // });
    //   // String formattedDate =
    //   //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";

    //   //     print(formattedDate);
    //   // _txtFromTime.text = formattedDate;
    //   startTime = dateTime;
    //   String formattedTime = DateFormat.Hm().format(startTime);

    // } else {
    // setState(() {
    //   isEmptyEndTime = false;
    // });
    // String formattedDate =
    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
    // _txtToTime.text = formattedDate;
    // }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                if (this.mounted) {
                  setState(() {
                    if (isStart) {
                      startTime = value;
                      String formattedTime =
                          "${DateFormat('HH:00').format(value)}";
                      print("FORMATED Time : $formattedTime");
                      selectedSundayOpenTime = formattedTime;
                      // widget.openingTime = formattedTime;
                      // widget.openingTimeTap(widget.openingTime);

                      //  print("WIDGET TIME : ${widget.openingTime}");
                      isEmptyStarTime = false;
                      isSundayOpen = !isSundayOpen;
                    } else {
                      String formattedClosingTime =
                          " ${DateFormat('HH:00').format(value)}";
                      setState(() {
                        selectedSundayCloseTime = formattedClosingTime;
                        // widget.closingTime = formattedClosingTime;
                      });
                      // widget.closingTimeTap(widget.closingTime);
                      isEmptyEndTime = false;
                      //  _dateOfBirthAnother = value;
                    }
                  });
                }
              },
              use24hFormat: true,
              initialDateTime: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
              mode: CupertinoDatePickerMode.time,
              minimumDate: DateTime.now().isSameDate(selectedDate)
                  ? isStart
                      ? DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute)
                      : DateTime(startTime.year, startTime.month, startTime.day,
                          startTime.hour, startTime.minute)
                  : null,
            ),
          );
        });
  }

  onSaveAddress() {
    if (salonNameController.text.trim() == "") {
      setState(() {
        isSalonNameEmpty = true;
      });
      return;
    }

    if (addressController.text.trim() == "") {
      setState(() {
        isAddressNameEmpty = true;
      });
      return;
    }

    if (floorController.text.trim() == "") {
      setState(() {
        isFloorNameEmpty = true;
      });
      return;
    }

    if (towerController.text.trim() == "") {
      setState(() {
        isTowerNameEmpty = true;
      });
      return;
    }

    if (areaController.text.trim() == "") {
      setState(() {
        isAreaNameEmpty = true;
      });
      return;
    }

    if (cityController.text.trim() == "") {
      setState(() {
        isCityNameEmpty = true;
      });
      return;
    }

    if (stateController.text.trim() == "") {
      setState(() {
        isStateNameEmpty = true;
      });
      return;
    }

    if(selectedModayOpenTime != "00:00" && selectedModayCloseTime != "00:00" ||
        selectedTuesdayOpenTime != "00:00" && selectedTuesdayCloseTime != "00:00" ||
        selectedWednesdayOpenTime != "00:00" && selectedWednesdayCloseTime != "00:00" ||
        selectedThursdayOpenTime != "00:00" && selectedThursdayCloseTime != "00:00" ||
        selectedFridayOpenTime != "00:00" && selectedFridayCloseTime != "00:00" ||
        selectedSaturdayOpenTime != "00:00" && selectedSaturdayCloseTime != "00:00" ||
        selectedSundayOpenTime != "00:00" && selectedSundayCloseTime != "00:00"){
      String salonName = salonNameController.text;
      String towerName = towerController.text;
      String area = areaController.text;
      String city = cityController.text;
      String state = stateController.text;
      setState(() {
        isLoading = true;
      });
      FormData param = FormData.fromMap({
        "address": currentAddress,
        "latitude": currentLatitude,
        "longitude": currentLongitude,
        "salon_name": salonName,
        "tower_name": towerName,
        "area": area,
        "city": city,
        "state": state,
        "monday": mondayTxt,
        "monday_status": monDropselectedValue,
        "monday_from": selectedModayOpenTime,
        "monday_to": selectedModayCloseTime,
        "tuesday": tuesdayTxt,
        "tuesday_status": tueDropselectedValue,
        "tuesday_from": selectedTuesdayOpenTime,
        "tuesday_to": selectedTuesdayCloseTime,
        "wednesday": weddayTxt,
        "wednesday_status": wedDropselectedValue,
        "wednesday_from": selectedWednesdayOpenTime,
        "wednesday_to": selectedWednesdayCloseTime,
        "thursday": thudayTxt,
        "thursday_status": thuDropselectedValue,
        "thursday_from": selectedThursdayOpenTime,
        "thursday_to": selectedThursdayCloseTime,
        "friday": fridayTxt,
        "friday_status": friDropselectedValue,
        "friday_from": selectedFridayOpenTime,
        "friday_to": selectedFridayCloseTime,
        "saturday": satdayTxt,
        "saturday_status": satDropselectedValue,
        "saturday_from": selectedSaturdayOpenTime,
        "saturday_to": selectedSaturdayCloseTime,
        "sunday": sundayTxt,
        "sunday_status": sunDropselectedValue,
        "sunday_from": selectedSundayOpenTime,
        "sunday_to": selectedSundayCloseTime,
        "open_close_data": "Added"
      });
      postDataRequestWithTokenSalon(updateSalonAddress, param, context)
          .then((value) {
        print(value);
        setState(() {
          isLoading = false;
        });
        if (value is List) {
          _responseHandling(value);
        } else {
          showCustomToast(value.toString(), context);
        }
      });
    }else{
      showCustomToast("Please Add Salon Timings", context);
    }
  }

  _responseHandling(value) {
    print(value);
    //SalonDetailModel salonDetailModel = SalonDetailModel.fromJson(value);
    // print("SALON ADD DETAIL MODEL : $salonDetailModel");
    String salonName = salonNameController.text;
    showCustomToast("Address Saved Successfully ", context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => StylistAddphotoVC(
          addressTxt: currentAddress,
          salonNameTxt: salonName,
          salonID: widget.salonIdFromOTP,
        ),
      ),
    );
  }
}
