import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:intl/intl.dart';

class OpenCloseWidget extends StatefulWidget {
  final String dayTxt;
  final String dayStatus;
  String openingTime;
  String closingTime;
  final Function(String) openingTimeTap;
  final Function(String) closingTimeTap;
  

  OpenCloseWidget({
    Key key,
    this.dayTxt,
    this.dayStatus,
    this.openingTime,
    this.closingTime,
    this.openingTimeTap,
    this.closingTimeTap,
  }) : super(key: key);

  @override
  _OpenCloseWidgetState createState() => _OpenCloseWidgetState();
}

class _OpenCloseWidgetState extends State<OpenCloseWidget> {
  var isMon = false;
  var isTue = false;
  var isWed = false;
  var isThu = false;
  var isFri = false;
  var isSat = false;
  var isSun = false;

  final nameArray = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  DateTime startTime;
  DateTime endTime;

  bool isEmptyStarTime = true;
  bool isEmptyEndTime = true;
  DateTime selectedDate;
  bool isOpen = false;
  bool isOpentimeVisible = true;
  bool isCloseTimeVisible = true;
  String selectedValue = "Open";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color:
                      isMon ? ColorConstants.kButtonBackColor : appGreyColor),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 35,
              width: 90,
              child: setTextWithCustomFont(
                widget.dayTxt,
                12,
                isMon ? Colors.white : ColorConstants.kBlackColor,
                FontWeight.w600,
                1,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: appGreyColor,
            height: 35,
            child: DropdownButton<String>(
              value: selectedValue,
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
                      isOpentimeVisible = true;
                      isCloseTimeVisible = true;
                    });
                  } else {
                    setState(() {
                      isOpentimeVisible = false;
                      isCloseTimeVisible = false;
                    });
                  }
                  selectedValue = newValue ?? "";
                });
              },
              items: <String>['Open', 'Close']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Spacer(),
          Visibility(
            visible: isOpentimeVisible,
            child: Container(
                child: InkWell(
              onTap: () {
                _showTimePicker(context, true);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                child: setTextWithCustomFont(
                  widget.openingTime != null ? widget.openingTime : "00:00",
                  14,
                  textBlackColor,
                  FontWeight.w900,
                  1.2,
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(210, 210, 210, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                height: 35,
              ),
            )),
          ),
          SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isCloseTimeVisible,
            child: Container(
              child: InkWell(
                onTap: () {
                  _showTimePicker(context, false);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  alignment: Alignment.center,
                  child: setTextWithCustomFont(
                    widget.closingTime != null ? widget.closingTime : "00:00",
                    14,
                    textBlackColor,
                    FontWeight.w900,
                    1.2,
                  ),
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(210, 210, 210, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context, bool isStart) {
    setState(() {
      isOpen = true;
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
                          "${isStart ? "From" : "TO"}:${DateFormat('HH:mm').format(value)}";
                      print("FORMATED Time : $formattedTime");
                      widget.openingTime = formattedTime;
                      widget.openingTimeTap(widget.openingTime);

                      print("WIDGET TIME : ${widget.openingTime}");
                      isEmptyStarTime = false;
                      isOpen = !isOpen;
                    } else {
                      String formattedClosingTime =
                          "${isStart ? "From" : "TO"}: ${DateFormat('HH:mm').format(value)}";
                      setState(() {
                        widget.closingTime = formattedClosingTime;
                      });
                      widget.closingTimeTap(widget.closingTime);
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
}
