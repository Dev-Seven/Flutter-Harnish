import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/appointment_model.dart';
import 'package:harnishsalon/model/bar_chart_model.dart';
import 'package:harnishsalon/screens/AddNewEmployee.dart';
import 'package:harnishsalon/screens/appointmentDetailVC.dart';
import 'package:harnishsalon/widgets/bar_chart_graph_widget.dart';
import 'package:harnishsalon/widgets/ongoing_item_widget.dart';
import 'package:harnishsalon/widgets/salon_order_list_item_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../common/color_constants.dart';

class StylistDashboardScreen extends StatefulWidget {
  final String salonId;
  bool isNewSalon;
  final bool isStylist;
  StylistDashboardScreen({
    Key key,
    @required this.isNewSalon,
    this.salonId,
    this.isStylist,
  }) : super(key: key);

  @override
  _StylistDashBoardScreenState createState() => _StylistDashBoardScreenState();
}

class _StylistDashBoardScreenState extends State<StylistDashboardScreen>
    with TickerProviderStateMixin, Observer {
  double height, width;
  double totalEarning = 2340.00;
  String userName = "";
  bool isLoading = false;

  TabController _tabController;
  TabController _weektabController;
  List<AppointmentModel> ongoingAppointmentList =
      List.from([AppointmentModel()]);

  String firstname = "";
  String lastname = "";
  String city = "";

  final List<BarChartModel> data = [
    BarChartModel(
      year: "2014",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2015",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2016",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2017",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2018",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2019",
      financial: 1000,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
    BarChartModel(
      year: "2020",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(
        Colors.blue,
      ),
    ),
  ];

  @override
  void initState() {
    Observable.instance.addObserver(this);
    print(widget.isStylist);

    super.initState();
    getOngoingList();

    if (widget.isStylist == true) {
      getStylistProfile();
    } else {
      getAddressDetail();
    }

    //getonGoingAppointmentList();
    _tabController = new TabController(
      length: 3,
      vsync: this,
    );
    _weektabController = new TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
  }

  final serviceArray = [
    "Haricut",
    "Shampoo",
    "Hair Oil",
  ];

  final profileArray = [
    "assets/images/1.jpg",
    "assets/images/1.jpg",
    "assets/images/1.jpg",
  ];

  final timeLeftArray = [
    "2hr left",
    "3hr left",
    "5hr left",
  ];

  final nameArray = [
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
  ];

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
        firstname = value['first_name'];
        setState(() {
          userName = firstname;
        });
        lastname = value['last_name'];
        city = value['city'];
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  getAddressDetail() {
    setState(() {
      isLoading = true;
    });
    postDataRequestWithTokenSalon(getSalonAddressApi, null, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is Map) {
        userName = value['owner_name'];
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  getOngoingList() {
    setState(() {
      isLoading = true;
    });
    FormData formData = FormData.fromMap({
      "salon_id": widget.salonId,
    });
    postDataRequestWithTokenSalon(ongoingList, formData, context).then(
      (value) => {
        setState(() {
          isLoading = true;
        }),
        if (value is List)
          {
            handleOngoingList(value),
          }
        else
          {
            showCustomToast(value.toString(), context),
          }
      },
    );
  }

  handleOngoingList(value) {
    var arrayOngoing = value
        .map<AppointmentModel>((json) => AppointmentModel.fromJson(json))
        .toList();
    setState(() {
      ongoingAppointmentList = arrayOngoing;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return widget.isNewSalon
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: setPoppinsfontWitAlignment(
                      "Welcome to trimify, Start your salon services by adding an employee",
                      15,
                      Colors.grey,
                      FontWeight.w500,
                      1.5),
                ),
                setbuttonWithChild(
                  setTextWithCustomFont(
                      "Add Employee", 12, Colors.white, FontWeight.w500, 1),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => AddNewEmployeeVC(),
                      ),
                    );
                  },
                  ColorConstants.kButtonBackColor,
                  4,
                )
              ],
            ),
          )
        : Container(
            child: Scaffold(
              backgroundColor: ColorConstants.kScreenBackColor,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: ColorConstants.kButtonBackColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi, " + userName,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstants.kWhiteColor,
                                        ),
                                      ),
                                      Text(
                                        "Today total earning",
                                        style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstants.kWhiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹" + totalEarning.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.kWhiteColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kWhiteColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "05",
                                            style: GoogleFonts.roboto(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants.kBlackColor,
                                            ),
                                          ),
                                          Text(
                                            "Completed",
                                            style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              color: ColorConstants.kGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 70,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.kWhiteColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "01",
                                            style: GoogleFonts.roboto(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants.kBlackColor,
                                            ),
                                          ),
                                          Text(
                                            "Cancelled",
                                            style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              color: ColorConstants.kGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.kNameBackColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Check OUT",
                                              style: GoogleFonts.roboto(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ColorConstants.kWhiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              child: Text(
                                "Idle Time: 02:23:56",
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: ColorConstants.kWhiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => AppointmentDetailVC(),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 1.19,
                          decoration: BoxDecoration(
                            color: ColorConstants.kScreenBackColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                            ),
                            child: Column(
                              children: [
                                ongoingAppointmentList.length == 0
                                    ? Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            "No ongoing appointment found",
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants.kBlackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            ongoingAppointmentList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          // return Text("Hello");
                                          return OngoingItemWidget(
                                            clientNameTxt: "Nishit Mistry",
                                            profileImg: "assets/images/1.jpg",
                                            serviceNameTxt: "Hair Cut & Beard",
                                            timeTxt: "Start: 11:20",
                                          );
                                        },
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: TabBar(
                                          controller: _tabController,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color:
                                                ColorConstants.kButtonBackColor,
                                          ),
                                          labelColor:
                                              ColorConstants.kWhiteColor,
                                          unselectedLabelColor:
                                              ColorConstants.kBlackColor,
                                          tabs: [
                                            Tab(
                                              text: 'Upcoming',
                                            ),
                                            Tab(
                                              text: 'Completed',
                                            ),
                                            Tab(
                                              text: 'Cancelled',
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 350,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              itemCount: nameArray.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return SalonOrderListItemWidget(
                                                  timeTxt: timeLeftArray[index],
                                                  nameTxt: nameArray[index],
                                                  serviceTxt:
                                                      serviceArray[index],
                                                  timeleftTxt:
                                                      timeLeftArray[index],
                                                  profileImg:
                                                      profileArray[index],
                                                  isUpcoming: true,
                                                  context: context,
                                                );
                                              },
                                            ),
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: nameArray.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return SalonOrderListItemWidget(
                                                  timeTxt: timeLeftArray[index],
                                                  nameTxt: nameArray[index],
                                                  serviceTxt:
                                                      serviceArray[index],
                                                  timeleftTxt:
                                                      timeLeftArray[index],
                                                  profileImg:
                                                      profileArray[index],
                                                  isUpcoming: true,
                                                  context: context,
                                                );
                                              },
                                            ),
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: nameArray.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return SalonOrderListItemWidget(
                                                    timeTxt:
                                                        timeLeftArray[index],
                                                    nameTxt: nameArray[index],
                                                    serviceTxt:
                                                        serviceArray[index],
                                                    timeleftTxt:
                                                        timeLeftArray[index],
                                                    profileImg:
                                                        profileArray[index],
                                                    isUpcoming: true,
                                                    context: context);
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: ColorConstants.kWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: TabBar(
                                            controller: _weektabController,
                                            indicator: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: ColorConstants
                                                  .kButtonBackColor,
                                            ),
                                            labelColor:
                                                ColorConstants.kWhiteColor,
                                            unselectedLabelColor:
                                                ColorConstants.kBlackColor,
                                            tabs: [
                                              Tab(
                                                text: 'Day',
                                              ),
                                              Tab(
                                                text: 'Week',
                                              ),
                                              Tab(
                                                text: 'Month',
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            controller: _weektabController,
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: ColorConstants
                                                      .kWhiteColor,
                                                ),
                                                child: BarChartGraphWidget(
                                                  data: data,
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: ColorConstants
                                                      .kWhiteColor,
                                                ),
                                                child: BarChartGraphWidget(
                                                  data: data,
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: ColorConstants
                                                      .kWhiteColor,
                                                ),
                                                child: BarChartGraphWidget(
                                                  data: data,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  @override
  update(Observable observable, String notifyName, Map map) {
    if (map != null && map.containsKey("addEmployee")) {
      Future.delayed(const Duration(milliseconds: 0), () {
        widget.isNewSalon = false;
        setState(() {});
      });
    } else {
      print("null");
    }
  }
}
