import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/package_model.dart';
import 'package:harnishsalon/model/salon_detail_model.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/model/salon_timing_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/screens/CheckOutScreen.dart';
import 'package:harnishsalon/screens/SalonDetailScreen.dart';
import 'package:harnishsalon/widgets/AddCustomServiceView.dart';
import 'package:harnishsalon/widgets/checkout_item_widget.dart';
import 'package:harnishsalon/widgets/package_checkout_item_widget.dart';
import 'package:harnishsalon/widgets/recommended_stylist_widget.dart';
import 'package:intl/intl.dart';

class EmployeeWithSalonVC extends StatefulWidget {
  final String salonID;

  EmployeeWithSalonVC({
    Key key,
    this.salonID,
  }) : super(key: key);

  @override
  _EmployeeWithSalonVCState createState() => _EmployeeWithSalonVCState();
}

class _EmployeeWithSalonVCState extends State<EmployeeWithSalonVC> {
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

  final profileArray = [
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
  ];

  final stylistNameArray = [
    "Brittany",
    "Mellissa",
    "Pauline",
    "Tommy",
    "Tommy",
  ];

  final ratingArray = [
    5,
    4,
    4,
    4,
    4,
  ];

  List<StylistModel> salonStylistList = List.from([StylistModel()]);
  List<SalonServiceModel> salonServiceList = List.from([SalonServiceModel()]);
  List<PackageModel> packageList = List.from([PackageModel()]);
  List<SalonTimingModel> salonTimingList = List.from([SalonTimingModel()]);
  List<SalonServiceModel> checkServiceList = List.from([SalonServiceModel()]);
  List<PackageModel> checkPackageList = List.from([PackageModel()]);
  bool isLoading = false;
  bool isServiceVisible = true;
  bool isPackageVisible = true;
  SalonServiceModel serviceObj;
  DateTime _selectedDate;
  TextEditingController bookingDateController = TextEditingController();
  bool isDob = false;
  int selectedIndex = 1;
  String openingTimeTxt = "";
  String closingTimeTxt = "";
  String dayFromModel = "";
  String currentDay = "";
  String openVal = "";
  String closeVal = "";
  List<TimeOfDay> openList = [];
  bool isServiceAdd;
  String currentDate = "";
  String selectedTime = "";
  int selectedStylist = 1;
  bool selecteditem = false;
  double height, width;
  String salonName = "";

  @override
  void initState() {
    super.initState();
    print(widget.salonID);
    checkServiceList.clear();
    checkPackageList.clear();
    getSalonDetail();
    getCurrentdate();
    print(widget.salonID);
  }

  getCurrentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    setState(() {
      currentDate = formatter.format(now);
    });

    print(currentDate);
  }

  getSalonDetail() {
    FormData param = FormData.fromMap({
      "salon_id": widget.salonID,
    });
    salonServiceList.clear();
    salonStylistList.clear();
    packageList.clear();
    setState(() {
      isLoading = true;
    });
    postDataRequestWithToken(salonDetailApi, param, context).then((value) => {
          setState(() {
            isLoading = false;
          }),
          if (value is Map)
            {
              salonName = value['salon_name'],
              if (value['services'] != null)
                {
                  salonServiceList = value['services']
                      .map<SalonServiceModel>(
                          (json) => SalonServiceModel.fromJson(json))
                      .toList(),

                  print(salonServiceList),
                  //handleSalonServiceResponse(value['services']),
                }
              else
                {
                  showCustomToast("No service found", context),
                },
              if (value['employee'] != null)
                {
                  salonStylistList = value['employee']
                      .map<StylistModel>((json) => StylistModel.fromJson(json))
                      .toList(),
                  print(salonStylistList),
                }
              else
                {
                  showCustomToast("No Employess found", context),
                },
              if (value['packages'] != null)
                {
                  packageList = value['packages']
                      .map<PackageModel>((json) => PackageModel.fromJson(json))
                      .toList(),

                  print(packageList),
                  // handleSalonEmployeeResponse(value['employee']),
                }
              else
                {
                  showCustomToast("No package found", context),
                },
              if (value['salon_timing'] != null)
                {
                  salonTimingList = value['salon_timing']
                      .map<SalonTimingModel>(
                          (json) => SalonTimingModel.fromJson(json))
                      .toList(),
                  print(salonTimingList),
                }
              else
                {
                  showCustomToast("No Salon Timing", context),
                },
            }
          else
            {
              showCustomToast(value.toString(), context),
            }
        });
  }

  handleSalonEmployeeResponse(empData) {
    print(salonStylistList);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorConstants.kScreenBackColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.kScreenBackColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: Text(
            salonName != null ? salonName : "",
            // "Enrich Salon",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorConstants.kBlackColor,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorConstants.kBlackColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 145,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      color: ColorConstants.kScreenBackColor,
                      child: salonStylistList.length == 0
                          ? Center(
                              child: Text(
                                "No Employee Found",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kBlackColor,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: salonStylistList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedStylist = index;
                                      selecteditem = true;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => SalonDetailScreen(
                                          salonID: widget.salonID,
                                          stylistID:
                                              salonStylistList[index].sId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: RecommendedStylistWidget(
                                        profileImg: selectedStylist == index
                                            ? salonStylistList[index].image
                                            : "",
                                        nameTxt:
                                            salonStylistList[index].name != null
                                                ? salonStylistList[index].name
                                                : "",
                                        ratingTxt: salonStylistList[index]
                                                    .ratings !=
                                                null
                                            ? salonStylistList[index].ratings
                                            : "",
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
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
                              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: setTextWithCustomFont(
                                  "Time", 12, Colors.black, FontWeight.w400, 1),
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
                                itemBuilder: (BuildContext context, int index) {
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
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                  itemName:
                                      salonServiceList[index].serviceName !=
                                              null
                                          ? salonServiceList[index].serviceName
                                          : "",
                                  itemPrice:
                                      salonServiceList[index].servicePrice !=
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
                                  packagePrice: packageList[index].price != null
                                      ? packageList[index].price
                                      : "",
                                  packageDiscount:
                                      packageList[index].discount != null
                                          ? packageList[index].discount
                                          : "",
                                  onAddPackageTap: () {
                                    if (checkPackageList.isEmpty == true) {
                                      setState(() {
                                        isServiceVisible = false;
                                        isPackageVisible = true;
                                        isServiceAdd = false;
                                      });
                                      onPackageAdd(packageObj, index);
                                    } else {
                                      showCustomToast(
                                          "Item has already added", context);
                                    }
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
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
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
                    child: SafeArea(
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
                            openCustomServicePopup();
                            // onCheckOutTap();
                          },
                          appYellowColor,
                          4,
                        ),
                      ),
                    )),
              ],
            )
          ],
        ));
  }

  openCustomServicePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Stylist',
              style: TextStyle(color: Colors.black),
            ),
          ),
          content: setupAlertDialoadContainer(context),
        );
      },
    );
  }

  Widget setupAlertDialoadContainer(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          width: width * 0.75,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: salonStylistList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("hello");

                  String selectedStylist = salonStylistList[index].sId;
                  onCheckOutTap(selectedStylist);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: RecommendedStylistWidget(
                    profileImg: selectedStylist == index
                        ? salonStylistList[index].image
                        : "",
                    nameTxt: salonStylistList[index].name != null
                        ? salonStylistList[index].name
                        : "",
                    ratingTxt: salonStylistList[index].ratings != null
                        ? salonStylistList[index].ratings
                        : "",
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        ),
      ],
    );
  }

  onCheckOutTap(selectedStylist) {
    print(selectedStylist);
    String date = bookingDateController.text;
    if (isServiceAdd == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(
            selectedItemList: checkServiceList,
            isFromService: isServiceAdd,
            salonID: widget.salonID,
            bookingDate: date,
            bookingTime: selectedTime,
            stylistID: selectedStylist,
            salonNameTxt: salonName,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(
            selectedPackageList: checkPackageList,
            isFromService: isServiceAdd,
            salonID: widget.salonID,
            bookingDate: date,
            bookingTime: selectedTime,
            stylistID: selectedStylist,
            salonNameTxt: salonName,
          ),
        ),
      );
    }
  }

  onServiceAddTap(serviceObj, index) {
    print(serviceObj);
    print(index);
    checkServiceList.add(serviceObj);
  }

  onPackageAdd(packageObj, index) {
    if (checkPackageList.isEmpty == true) {
      checkPackageList.add(packageObj);
    } else {
      showCustomToast("package has already been added", context);
    }

    //
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

  cupertinoDatePicker() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
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
      print(formatted);
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
}

//

// Container(
//   color: Color.fromRGBO(247, 247, 247, 1),
//   width: double.infinity,
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//         height: 200,
//           width: double.infinity,
//           padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 15,
//                 child: setTextWithCustomFont("Time", 12,
//                     Colors.black, FontWeight.w400, 1),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ListView(
//                 scrollDirection: Axis.horizontal,
//
//                 children: <Widget>[
//
//
//                 ],
//               )
//             ],
//           )),
//     ],
//   ),
// ),

// SizedBox(
//   height: 15,
// ),
// Container(
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//         child: setTextWithCustomFont("Services", 16,
//             Colors.black, FontWeight.w600, 1),
//       ),
//       Container(
//         height:
//             MediaQuery.of(context).size.height / 3.7,
//         child: ListView.builder(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           itemCount: 5,
//           itemBuilder:
//               (BuildContext context, int index) {
//             return Container(
//               padding:
//                   EdgeInsets.fromLTRB(15, 10, 15, 10),
//               child: Container(
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FittedBox(
//                       child: setImageNameAndPath("",
//                           saloonArray[index], 25, 25),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       mainAxisAlignment:
//                           MainAxisAlignment.center,
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [
//                         setTextWithCustomFont(
//                             nameArray[index],
//                             12,
//                             Colors.black,
//                             FontWeight.w600,
//                             1),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         setTextWithCustomFont(
//                             priceArray[index],
//                             12,
//                             Colors.black,
//                             FontWeight.w600,
//                             1),
//                       ],
//                     ),
//                     Spacer(),
//                     Container(
//                       width: 60,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.all(
//                                   Radius.circular(4)),
//                           border: Border.all(
//                               color: appYellowColor,
//                               width: 1)),
//                       child: setbuttonWithChild(
//                           Text(
//                             "Add",
//                             style: TextStyle(
//                                 color: appYellowColor),
//                           ),
//                           () {},
//                           Colors.transparent,
//                           0),
//                     )
//                   ],
//                 ),
//                 width: double.infinity,
//                 height: 47,
//                 decoration: BoxDecoration(
//                     color: Color.fromRGBO(
//                         247, 247, 247, 1),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(4))),
//               ),
//             );
//           },
//         ),
//       ),
//       SizedBox(
//         height: 15,
//       ),
//       Container(
//         padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//         child: setTextWithCustomFont("Packages", 16,
//             Colors.black, FontWeight.w600, 1),
//       ),
//       Container(
//         height:
//             MediaQuery.of(context).size.height / 5.5,
//         child: ListView.builder(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           itemCount: 2,
//           itemBuilder:
//               (BuildContext context, int index) {
//             return Container(
//               padding:
//                   EdgeInsets.fromLTRB(15, 10, 15, 10),
//               child: Container(
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       mainAxisAlignment:
//                           MainAxisAlignment.center,
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [
//                         setTextWithCustomFont(
//                             "Haircut + Cleanup + Shampoo - Hair wash",
//                             12,
//                             Colors.black,
//                             FontWeight.w600,
//                             1),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           children: [
//                             setTextWithCustomFont(
//                                 "₹ 1299.00",
//                                 12,
//                                 Colors.black,
//                                 FontWeight.w600,
//                                 1),
//                             SizedBox(
//                               width: 30,
//                             ),
//                             Stack(
//                               children: [
//                                 setTextWithCustomFont(
//                                     "₹ 3000.00",
//                                     12,
//                                     Colors.grey,
//                                     FontWeight.w600,
//                                     1),
//                                 Container(
//                                   alignment:
//                                       Alignment.center,
//                                   width: 55,
//                                   height: 17,
//                                   child: Text(
//                                     "-------------",
//                                     style: TextStyle(
//                                         height: 0.5,
//                                         color: Colors
//                                             .grey),
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                     Spacer(),
//                     Container(
//                       width: 60,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.all(
//                                   Radius.circular(4)),
//                           border: Border.all(
//                               color: appYellowColor,
//                               width: 1)),
//                       child: setbuttonWithChild(
//                           Text(
//                             "Add",
//                             style: TextStyle(
//                                 color: appYellowColor),
//                           ),
//                           () {},
//                           Colors.transparent,
//                           0),
//                     )
//                   ],
//                 ),
//                 width: double.infinity,
//                 height: 47,
//                 decoration: BoxDecoration(
//                     color: Color.fromRGBO(
//                         247, 247, 247, 1),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(4))),
//               ),
//             );
//           },
//         ),
//       ),
//       SizedBox(
//         height: 0,
//       ),
//       Container(
//         padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//         height: 54,
//         width: double.infinity,
//         child: setbuttonWithChild(
//             setTextWithCustomFont("Proceed to pay", 14,
//                 Colors.white, FontWeight.w500, 1), () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CheckoutScreen(),
//             ),
//           );
//         }, appYellowColor, 4),
//       )
//     ],
//   ),
// )
