import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_timing_model.dart';

class StylistTimeUpdateVC extends StatefulWidget {
  final String salonIDTxt;

  StylistTimeUpdateVC({
    Key key,
    this.salonIDTxt,
  }) : super(key: key);

  @override
  _StylistTimeUpdateVCState createState() => _StylistTimeUpdateVCState();
}

class _StylistTimeUpdateVCState extends State<StylistTimeUpdateVC> {
  DateTime startTime;
  DateTime endTime;
  DateTime selectedDate;
  bool isLoading = false;
  var isMon = false;
  var isTue = false;
  var isWed = false;
  var isThu = false;
  var isFri = false;
  var isSat = false;
  var isSun = false;

  List<SalonTimingModel> salonList = List.from([SalonTimingModel()]);

  String day;
  String dayStatus;
  String openingTime;
  String closingTime;

  String day1 = "Monday";
  String day2 = "Tuesday";
  String day3 = "Wednesday";

  // Monday
  String mondayStatus;
  String mondayopeningTime;
  String mondayclosingTime;

  // Tuesaday

  String tuesdayStatus;
  String tuesdayopeningTime;
  String tuesdayclosingTime;

  String mondayTxt;
  List arrayItem;

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
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  var dropDownValue = [
    "Open",
    "Close",
    "Close",
    "Close",
    "Close",
    "Close",
    "Close",
  ];

  @override
  void initState() {
    super.initState();
    getSalonTiming();
  }

  getSalonTiming() {
    setState(() {
      isLoading = true;
    });

    FormData param = FormData.fromMap({
      "salon_id": widget.salonIDTxt,
    });
    salonList.clear();
    postDataRequestWithTokenSalon(salonDetailApi, param, context)
        .then((value) => {
              setState(() {
                isLoading = false;
              }),
              if (value is Map)
                {
                  if (value['salon_timing'] != null)
                    {
                      _handleTimingListResponse(value['salon_timing']),
                    }
                }
              else
                {
                  print("OBJSALON MODEL ELSE PART"),
                }
            });
  }

  _handleTimingListResponse(userData) {
    salonList = userData
        .map<SalonTimingModel>((json) => SalonTimingModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorConstants.kButtonBackColor,
          title: setTextWithCustomFont(
            "Day Open & Time Slot",
            18,
            Colors.white,
            FontWeight.w500,
            1,
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 44),
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          setTextWithCustomFont(
                            "Weekdays",
                            12,
                            ColorConstants.kBlackColor,
                            FontWeight.w700,
                            1,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          setTextWithCustomFont(
                            "Status",
                            12,
                            ColorConstants.kBlackColor,
                            FontWeight.w700,
                            1,
                          ),
                          Spacer(),
                          setPoppinsfontWitAlignment(
                            "Opening \n Time",
                            12,
                            ColorConstants.kBlackColor,
                            FontWeight.w700,
                            1,
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          setPoppinsfontWitAlignment("Closing \nTime", 12,
                              ColorConstants.kBlackColor, FontWeight.w700, 1),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: salonList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: isMon
                                              ? ColorConstants.kButtonBackColor
                                              : appGreyColor),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      height: 35,
                                      width: 90,
                                      child: setTextWithCustomFont(
                                          salonList[index].weekDay != null
                                              ? salonList[index].weekDay
                                              : "",
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: isMon
                                              ? ColorConstants.kButtonBackColor
                                              : appGreyColor),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      height: 35,
                                      width: 90,
                                      child: setTextWithCustomFont(
                                          salonList[index].status != null
                                              ? salonList[index].status
                                              : "",
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: isMon
                                              ? ColorConstants.kButtonBackColor
                                              : appGreyColor),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      height: 35,
                                      width: 90,
                                      child: setTextWithCustomFont(
                                          salonList[index].openingTime != null
                                              ? salonList[index].openingTime
                                              : "00:00",
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: isMon
                                              ? ColorConstants.kButtonBackColor
                                              : appGreyColor),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      height: 35,
                                      width: 90,
                                      child: setTextWithCustomFont(
                                          salonList[index].closingTime != null
                                              ? salonList[index].closingTime
                                              : "00:00",
                                          12,
                                          isMon
                                              ? Colors.white
                                              : ColorConstants.kBlackColor,
                                          FontWeight.w600,
                                          1),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            // Container(
            //   height: 44,
            //   width: MediaQuery.of(context).size.width - 20,
            //   child: setbuttonWithChild(
            //     setTextWithCustomFont(
            //         "Update", 14, Colors.white, FontWeight.w400, 1),
            //     () {
            //       print("Update BUtton Tap");
            //       onUpdateDayTimeTap();
            //       // Navigator.pop(context);
            //     },
            //     ColorConstants.kButtonBackColor,
            //     3,
            //   ),
            // ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context, bool isStart) {
    var dateTime = isStart
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute)
        : DateTime(startTime.year, startTime.month, startTime.day,
            startTime.hour, startTime.minute);
    if (isStart) {
      // setState(() {
      //   isEmptyStarTime = false;
      // });
      // String formattedDate =
      //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(dateTime)}";
      // _txtFromTime.text = formattedDate;
      startTime = dateTime;
    } else {
      // setState(() {
      //   isEmptyEndTime = false;
      // });
      // String formattedDate =
      //     "${isStart ? "From" : "TO"}: ${DateFormat('HH : mm').format(dateTime)}";
      // _txtToTime.text = formattedDate;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  if (isStart) {
                    startTime = value;
                    // String formattedDate =
                    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(value)}";
                    // _txtFromTime.text = formattedDate;
                    // isEmptyStarTime = false;
                    // _dateOfBirth = value;
                  } else {
                    // String formattedDate =
                    //     "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(value)}";
                    // _txtToTime.text = formattedDate;
                    // isEmptyEndTime = false;
                    // _dateOfBirthAnother = value;
                  }
                });
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
}
