import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/package_model.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/model/salon_timing_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/screens/CheckOutScreen.dart';
import 'package:harnishsalon/widgets/checkout_item_widget.dart';
import 'package:harnishsalon/widgets/package_checkout_item_widget.dart';
import 'package:intl/intl.dart';

class SelectStylistWidget extends StatefulWidget {
  @override
  _selectStylistWidgetState createState() => _selectStylistWidgetState();
}

class _selectStylistWidgetState extends State<SelectStylistWidget> {
  final saloonArray = [
    "Service0.png",
    "Service1.png",
    "Service2.png",
    "Service3.png",
    "Service4.png",
  ];

  final nameArray = [
    "Haircut",
    "Hairwash",
    "Beard",
    "Hair Color",
    "Facial and Massage",
  ];

  final priceArray = [
    "₹ 120.00",
    "₹ 120.00",
    "₹ 120.00",
    "₹ 120.00",
    "₹ 120.00",
  ];

  bool isLoading = false;
  List<StylistModel> salonStylistList = List.from([StylistModel()]);
  List<SalonServiceModel> salonServiceList = List.from([SalonServiceModel()]);
  List<PackageModel> packageList = List.from([PackageModel()]);
  List<SalonTimingModel> salonTimingList = List.from([SalonTimingModel()]);
  List<SalonServiceModel> checkServiceList = List.from([SalonServiceModel()]);
  List<PackageModel> checkPackageList = List.from([PackageModel()]);
  String salonAddress = "";
  String salonCity = "";
  bool isServiceAdd;
  bool isServiceVisible = true;
  bool isPackageVisible = true;
  List<TimeOfDay> openList = [];
  int selectedIndex = 1;
  String selectedTime = "";
  String currentDate = "";
  bool isDob = false;
  String currentDay = "";
  DateTime _selectedDate;
  String dayFromModel = "";
  TextEditingController bookingDateController = TextEditingController();
  String openVal = "";
  String closeVal = "";
  String salonName = "";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 99, 99, 1),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 60,
                height: 60,
                child: setbuttonWithChild(
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  () {
                    Navigator.of(context).pop();
                  },
                  Colors.black,
                  50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            setTextWithCustomFont("Salon - ", 12, Colors.grey,
                                FontWeight.w500, 1),
                            setTextWithCustomFont(
                              salonAddress != null
                                  ? salonName +
                                      " " +
                                      salonAddress +
                                      " , " +
                                      salonCity
                                  : "",
                              12,
                              Colors.black,
                              FontWeight.w500,
                              1,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          color: Colors.white,
                          height: 90,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 00, 0, 0),
                                height: 15,
                                child: setTextWithCustomFont(
                                  "Date",
                                  12,
                                  Colors.black,
                                  FontWeight.w400,
                                  1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              setTextField(
                                bookingDateController,
                                currentDate,
                                false,
                                TextInputType.text,
                                isDob,
                                msgEmptyLastName,
                                () => {},
                                () {
                                  setState(() {
                                    isDob = false;
                                  });
                                  cupertinoDatePicker();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                        ),
                        child: Container(
                          color: Colors.white,
                          height: 90,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: setTextWithCustomFont("Time", 12,
                                    Colors.black, FontWeight.w400, 1),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: openList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          selectedTime =
                                              openList[index].hour.toString() +
                                                  ":00";
                                        });
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? appYellowColor
                                                  : Color.fromRGBO(
                                                      210,
                                                      210,
                                                      210,
                                                      1,
                                                    ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            height: 10,
                                            child: setTextWithCustomFont(
                                              openList[index].hour.toString() +
                                                  ":00",
                                              14,
                                              Colors.black,
                                              FontWeight.w600,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: isServiceVisible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                              child: setTextWithCustomFont(
                                "Services",
                                16,
                                Colors.black,
                                FontWeight.w600,
                                1,
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: salonServiceList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final serviceObj = salonServiceList[index];
                                  return CheckoutItemWidget(
                                    itemName: salonServiceList[index]
                                                .serviceName !=
                                            null
                                        ? salonServiceList[index].serviceName
                                        : "",
                                    itemPrice: salonServiceList[index]
                                                .servicePrice !=
                                            null
                                        ? salonServiceList[index].servicePrice
                                        : "",
                                    onAddItemTap: () {
                                      setState(() {
                                        isServiceAdd = true;
                                        isPackageVisible = false;
                                      });
                                      onServiceAddTap(serviceObj, index);
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: isPackageVisible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: setTextWithCustomFont(
                                "Packages",
                                16,
                                Colors.black,
                                FontWeight.w600,
                                1,
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: packageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final packageObj = packageList[index];

                                  return PackageCheckoutItemWidget(
                                    packageName: packageList[index].name != null
                                        ? packageList[index].name
                                        : "",
                                    packagePrice:
                                        packageList[index].price != null
                                            ? packageList[index].price
                                            : "",
                                    packageDiscount:
                                        packageList[index].discount != null
                                            ? packageList[index].discount
                                            : "",
                                    onAddPackageTap: () {
                                      setState(() {
                                        isServiceVisible = false;
                                        isPackageVisible = true;
                                        isServiceAdd = false;
                                      });
                                      onPackageAdd(packageObj, index);
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: double.infinity,
                  child: Container(
                    height: 45,
                    child: setbuttonWithChild(
                      setTextWithCustomFont(
                        "Proceed to pay",
                        14,
                        Colors.white,
                        FontWeight.w500,
                        1,
                      ),
                      () {
                        onCheckOutTap();
                      },
                      appYellowColor,
                      4,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  onCheckOutTap() {
    print("SELECTED TIME : $selectedTime");
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
                    minimumDate: DateTime.now(),
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

      setState(() {
        _selectedDate = pickedDate;
        bookingDateController.text = formatted;
        currentDay = DateFormat('EEEE').format(pickedDate).toLowerCase();
      });
      for (var item in salonTimingList) {
        dayFromModel = item.weekDay;

        if (dayFromModel == currentDay) {
          print("DAYS ARE EQUAL");
          print(item.status);
          if (item.status == "open") {
            print(item.openingTime);
            print(item.closingTime);
            openVal = item.openingTime;
            closeVal = item.closingTime;
            String openhour = openVal.substring(0, 2);
            String openminute = openVal.substring(3, 5);

            String closehour = closeVal.substring(0, 2);
            String closeminute = closeVal.substring(3, 5);

            int openHour = int.tryParse(openhour);
            int openMinute = int.tryParse(openminute);

            int closeHour = int.tryParse(closehour);
            int closeMinute = int.tryParse(closeminute);
            print(openHour);
            final startTime = TimeOfDay(hour: openHour, minute: openMinute);
            final endTime = TimeOfDay(hour: closeHour, minute: closeMinute);
            final interval = Duration(hours: 1);
            final times = getTimeSlots(startTime, endTime, interval).toList();
            setState(() {
              openList = times;
            });
            print(openList);
          }
        } else {
          print("NOT SAME");
        }
      }
    }
  }

  Iterable<TimeOfDay> getTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += interval.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  onServiceAddTap(serviceObj, index) {
    print(serviceObj);
    print(index);
    checkServiceList.add(serviceObj);
  }

  onPackageAdd(packageObj, index) {
    print("Package Add");
    checkPackageList.add(packageObj);
  }
}
