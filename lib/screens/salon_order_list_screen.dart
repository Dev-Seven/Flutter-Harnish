import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Global.dart';

import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/appointment_model.dart';
import 'package:harnishsalon/widgets/salon_order_list_item_widget.dart';
import 'package:intl/intl.dart';

/*
Title:SalonOrderListScreen
Purpose:SalonOrderListScreen
Widgets Used:SalonOrderListItemWidget,
Created By:17 Feb 2021
*/

class SalonOrderListScreen extends StatefulWidget {
  final String salonId;
  final String stylistID;
  SalonOrderListScreen({
    Key key,
    this.salonId,
    this.stylistID,
  }) : super(key: key);

  @override
  _SalonOrderListScreenState createState() => _SalonOrderListScreenState();
}

class _SalonOrderListScreenState extends State<SalonOrderListScreen>
    with SingleTickerProviderStateMixin {
  final nameArray = [
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "Brandon Perry",
  ];

  final serviceArray = [
    "Hair Cut & Hair Wash",
    "Hair Color",
    "Hair Cut & Beard",
    "Hair Cut & Hair Wash",
    "Hair Cut & Hair Wash",
    "Hair Color",
    "Hair Cut & Beard",
    "Hair Cut & Hair Wash",
    "Shawn Ortiz",
    "Nishit Mistry",
  ];
  final profileImagerray = [
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
  final timeArray = [
    "09:00 - 10:00",
    "10:30 - 11:00",
    "11:15 - 12:45",
    "09:00 - 10:00",
    "09:00 - 10:00",
    "09:00 - 10:00",
    "09:00 - 10:00",
    "09:00 - 10:00",
    "09:00 - 10:00",
    "09:00 - 10:00",
  ];

  final timeLeftArray = [
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
    "2hr left",
  ];
  TabController _tabController;
  DateTime currentDate = DateTime.now();
  String todayDate = "";
  bool isLoading = false;
  List<AppointmentModel> ongoingAppointmentList =
      List.from([AppointmentModel()]);

  @override
  void initState() {
    super.initState();
    getTodayDate();
    if (isStylist == true) {
      getStylistTodaysOrder();
    } else {
      getSalonTodaysOrder();
    }
    _tabController = new TabController(
      length: 3,
      vsync: this,
    );
  }

  getTodayDate() {
    var formatter = new DateFormat('dd-MM-yyyy');
    setState(() {
      todayDate = formatter.format(currentDate);
    });
    print(todayDate);
  }

  getStylistTodaysOrder() {
    print("STYLIST ID : ${widget.stylistID}");
    setState(() {
      isLoading = true;
    });

    FormData formData = FormData.fromMap({
      "salon_id": widget.stylistID,
    });
    ongoingAppointmentList.clear();
    postDataRequestWithTokenStylist(appointmentBookingList, formData, context)
        .then((value) {
      // setState(() {
      //   isLoading = false;
      // });
      if (value is List) {
        _handleStylistTodayListResponse(value);
      } else {
        print("data");
      }
    });
  }

  _handleStylistTodayListResponse(value) {
    var arrData = value
        .map<AppointmentModel>((json) => AppointmentModel.fromJson(json))
        .toList();
    ongoingAppointmentList = arrData;
    print(ongoingAppointmentList);
  }

  getSalonTodaysOrder() {
    print(widget.salonId);
    setState(() {
      isLoading = true;
    });

    FormData formData = FormData.fromMap({
      "salon_id": widget.salonId,
      "status": 1,
    });

    postDataRequestWithToken(appointmentBookingList, formData, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        _handleSalonTodayListResponse(value);
      } else {
        print("data");
      }
    });
  }

  _handleSalonTodayListResponse(value) {
    print(value);
    var arrData = value
        .map<AppointmentModel>((json) => AppointmentModel.fromJson(json))
        .toList();
    ongoingAppointmentList = arrData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kScreenBackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
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
                      text: 'Today',
                    ),
                    Tab(
                      text: 'Tomorrow ',
                    ),
                    Tab(
                      text: 'Upcoming',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: nameArray.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return SalonOrderListItemWidget(
                                  serviceTxt: serviceArray[index],
                                  timeTxt: timeArray[index],
                                  nameTxt: nameArray[index],
                                  profileImg: profileImagerray[index],
                                  timeleftTxt: timeLeftArray[index],
                                  context: context,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 2,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return SalonOrderListItemWidget(
                                    serviceTxt: serviceArray[index],
                                    timeTxt: timeArray[index],
                                    nameTxt: nameArray[index],
                                    profileImg: profileImagerray[index],
                                    timeleftTxt: timeLeftArray[index],
                                    context: context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return SalonOrderListItemWidget(
                                    serviceTxt: serviceArray[index],
                                    timeTxt: timeArray[index],
                                    nameTxt: nameArray[index],
                                    profileImg: profileImagerray[index],
                                    timeleftTxt: timeLeftArray[index],
                                    context: context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
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
}
