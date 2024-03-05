import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';
import 'package:harnishsalon/model/support_data_model.dart';
import 'package:harnishsalon/model/user_salon_model.dart';
import 'package:harnishsalon/screens/CheckOutScreen.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import 'package:harnishsalon/widgets/top_rated_salon_widget.dart';
import 'package:harnishsalon/widgets/last_visited_widget.dart';
import 'package:harnishsalon/widgets/recommended_stylist_widget.dart';
import 'package:harnishsalon/widgets/salon_around_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_prefix_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

/*
Title:UserDashBoardScreen
Purpose:UserDashBoardScreen
Created By:17 Feb 2021
*/

class UserDashBoardScreen extends StatefulWidget {
  UserDashBoardScreen({
    Key key,
  }) : super(key: key);

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashBoardScreen> {
  TextEditingController searchController;
  double height, width;
  bool isLoading = false;
  List<StylistModel> recommendedStylistList = List.from([StylistModel()]);
  List<SalonModel> topRatedSalonList = List.from([SalonModel()]);
  List lastVisitedSalonList = [];
  List<int> list = [1, 2, 3, 4];
  final _currentPageNotifier2 = ValueNotifier<int>(0);
  List<SuppportDataModel> supportList = List.from([SuppportDataModel()]);
  String nearByKiloMeter = "";
  double currentLatitude;
  String currentAddress;
  double currentLongitude;
  List<UserSalonModel> allSalonList = List.from([UserSalonModel()]);
  List<UserSalonModel> nearBySalonList = List.from([UserSalonModel()]);
  List<UserSalonModel> finalNearBySalonList = List.from([UserSalonModel()]);
  String currentLatitudeTxt;
  String salonLongitude;
  String salonImage = "";

  var usersalonModelObj = UserSalonModel();

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
    5.0,
    4.8,
    4.8,
    4.6,
    4.6,
  ];

  final saloonArray = [
    "assets/images/2.png",
    "assets/images/1.jpg",
    "assets/images/2.png",
    "assets/images/1.jpg",
    "assets/images/2.png",
  ];

  final nameArray = [
    "Black Salon",
    "Black Salon",
    "Black Salon",
    "Black Salon",
    "Black Salon",
  ];

  final addressArray = [
    "Drive in Road,Ahmedabad",
    "Drive in Road,Ahmedabad",
    "Drive in Road,Ahmedabad",
    "Drive in Road,Ahmedabad",
    "Drive in Road,Ahmedabad",
  ];

  final priceArray = [
    "120 for Hair",
    "120 for Hair",
    "120 for Hair",
    "120 for Hair",
    "120 for Hair",
  ];

  final controller = PageController(viewportFraction: 0.3);

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();
    getCurrentLatLong();
    getSupportData();
    getAllSalonList();
    getRecommendedStylistList();
    //  getTopRatedSalonList();
    //getLastVisitedSalonList();
  }

  getAllSalonList() {
    allSalonList.clear();
    nearBySalonList.clear();
    finalNearBySalonList.clear();

    postDataRequestWithToken(allSalonListApi, null, context).then((value) {
      if (value is List) {
        handleAllSalonListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleAllSalonListResponse(value) async {
    var arraySalonList = value
        .map<UserSalonModel>((json) => UserSalonModel.fromJson(json))
        .toList();

    setState(() {
      allSalonList = arraySalonList;
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (allSalonList.isNotEmpty) {
      for (var item in allSalonList) {
        var responseLatitude = item.latitude;
        var responseLongitude = item.longitude;
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
        if (responseLatitude != null && responseLongitude != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            currentLatitude,
            currentLongitude,
            double.parse(responseLatitude),
            double.parse(responseLongitude),
          );

          int realnearByKiloMeter = int.parse(nearByKiloMeter);
          double distanceInKm = distanceInMeters / 1000;
          int roundedDistanceInKM = distanceInKm.toInt();
          if (realnearByKiloMeter > roundedDistanceInKM) {
            nearBySalonList.add(item);
            setState(() {
              finalNearBySalonList = nearBySalonList;
            });
            print(finalNearBySalonList);
          } else {
            print("salon");
          }
        }
      }
    } else {
      print("object");
    }
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

  getSupportData() {
    setState(() {
      isLoading = true;
    });
    supportList.clear();
    postDataRequestWithToken(supportData, null, context).then((value) {
      setState(() {
        isLoading = false;
      });

      if (value is List) {
        handleSupportDataResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleSupportDataResponse(value) {
    String nearByradius = value[2]['type'];
    String radiusInKiloMeter = value[2]['name'];
    setState(() {
      nearByKiloMeter = radiusInKiloMeter;
    });
    print(nearByKiloMeter);
  }

  getRecommendedStylistList() {
    setState(() {
      isLoading = true;
    });
    recommendedStylistList.clear();
    postDataRequestWithToken(recommendedStylist, null, context).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        _getRecommendedListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _getRecommendedListResponse(value) {
    var arrData =
        value.map<StylistModel>((json) => StylistModel.fromJson(json)).toList();
    print(arrData);
    setState(() {
      recommendedStylistList = arrData;
    });
    print(recommendedStylistList);
  }

  void getLastVisitedSalonList() {
    // arrStylistList.clear();
    setState(() {
      isLoading = true;
    });
    lastVisitedSalonList.clear();
    postDataRequestWithToken(lastVisitedSalonListApi, null, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        if (value.isEmpty) {
          showCustomToast(value.toString(), context);
        }

        lastVisitedSalonResponse(value);
      } else {
        print("data");
      }
    });
  }

  lastVisitedSalonResponse(value) {
    print(value);
    // var arrData =
    //     value.map<StylistModel>((json) => StylistModel.fromJson(json)).toList();
    setState(() {
      lastVisitedSalonList = value;
    });
    print(lastVisitedSalonList);
  }

  getTopRatedSalonList() {
    setState(() {
      isLoading = true;
    });
    topRatedSalonList.clear();
    postDataRequestWithToken(topRatedSalonListApi, null, context).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        handleTopRatedSalonListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleTopRatedSalonListResponse(value) {
    var arrData =
        value.map<SalonModel>((json) => SalonModel.fromJson(json)).toList();
    print(arrData);
    setState(() {
      topRatedSalonList = arrData;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: ColorConstants.kScreenBackColor,
        leadingWidth: 1,
        title: Container(
          padding: EdgeInsets.only(top: 10, bottom: 0),
          child: TextFormFieldPrefixWidget(
            hintTxt: "Search for location or Salon",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.search,
            hintTextColor: ColorConstants.khintColor,
            controllerName: searchController,
            onChanged: () {
              print("object");
            },
            onSaved: () {
              print("object");
            },
          ),
        ),
      ),
      backgroundColor: ColorConstants.kScreenBackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.15 / 2,
                    decoration: BoxDecoration(
                      color: ColorConstants.kDashBoardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(42 / 2),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                          "assets/images/1.jpg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.kOrangeColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 10,
                                            color: ColorConstants.kWhiteColor,
                                          ),
                                          Text(
                                            "4.8",
                                            style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              color: ColorConstants.kWhiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enrich Salon",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: ColorConstants.kWhiteColor,
                                    ),
                                  ),
                                  Text(
                                    "Its been 30 days to your service",
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      color: ColorConstants.kWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: EmployeeWithSalonVC(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height * 0.1 / 3,
                                  width: width * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: ColorConstants.kLogoBackColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "BOOK",
                                      style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        color:
                                            ColorConstants.kDiscountBorderColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.close,
                                size: 15,
                                color: ColorConstants.kWhiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,

                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: topRatedSalonList.length,
                            itemBuilder: (BuildContext context, index) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                    onPageChanged: (page, reason) {
                                      _currentPageNotifier2.value = page - 1;
                                    },
                                    pageSnapping: true,
                                    // autoPlay: true,
                                    viewportFraction: 1.0),
                                items: list
                                    .map((item) => TopRatedSalonWidget(
                                          salonNameTxt:
                                              topRatedSalonList[index].name,
                                          //ratingTxt: topRatedSalonList[index].rating,
                                        ))
                                    .toList(),
                              );
                            }),

                        // CarouselSlider(
                        //   options: CarouselOptions(
                        //       onPageChanged: (page, reason) {
                        //         _currentPageNotifier2.value = page - 1;
                        //       },
                        //       pageSnapping: true,
                        //       // autoPlay: true,
                        //       viewportFraction: 1.0),
                        //   items: list
                        //       .map((item) => TopRatedSalonWidget())
                        //       .toList(),
                        // ),
                      ),

                      // Container(
                      //     height: 100,
                      //     width: double.infinity,
                      //     child: CarouselSlider(
                      //       options: CarouselOptions(height: 400.0),
                      //       items: topRatedSalonList.take(3).map((i) {
                      //         print("ITEM MODEL : $i");
                      //         return Builder(
                      //           builder: (BuildContext context) {
                      //             return Container(
                      //               width: MediaQuery.of(context).size.width,
                      //               margin:
                      //                   EdgeInsets.symmetric(horizontal: 5.0),
                      //               decoration:
                      //                   BoxDecoration(color: Colors.amber),
                      //               child: Text(
                      //                 'text $i',
                      //                 style: TextStyle(fontSize: 16.0),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       }).toList(),
                      //     )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        height: 100,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Spacer(),
                            Row(
                              children: [
                                Spacer(),
                                CirclePageIndicator(
                                  size: 5,
                                  dotSpacing: 5,
                                  selectedSize: 6,
                                  dotColor: Colors.white,
                                  selectedDotColor: appYellowColor,
                                  itemCount: 4,
                                  currentPageNotifier: _currentPageNotifier2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Recommended Available Stylist",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 130,
                    child: Column(
                      children: [
                        recommendedStylistList.isEmpty
                            ? Text(
                                "No Recommended Stylist",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kBlackColor,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: false,
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recommendedStylistList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: RecommendedStylistWidget(
                                        profileImg:
                                            recommendedStylistList[index]
                                                        .image !=
                                                    null
                                                ? recommendedStylistList[index]
                                                    .image
                                                : "",
                                        nameTxt: recommendedStylistList[index]
                                                    .name !=
                                                null
                                            ? recommendedStylistList[index].name
                                            : "",
                                        ratingTxt: recommendedStylistList[index]
                                                    .ratings !=
                                                null
                                            ? recommendedStylistList[index]
                                                .ratings
                                            : "",
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    " Last Visited Salons",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 150,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            crossAxisCount: 2,
                            childAspectRatio: 5 / 2,
                            children: List.generate(4, (index) {
                              return LastVisitedWidget(
                                salonImg: "assets/images/1.jpg",
                                nameTxt: "Enrich Salon",
                                cityTxt: "Ahmedabad",
                                ratingTxt: 5.0,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                onPageChanged: (page, reason) {
                                  _currentPageNotifier2.value = page - 1;
                                },
                                pageSnapping: true,
                                // autoPlay: true,
                                viewportFraction: 1.0),
                            items: list
                                .map((item) => TopRatedSalonWidget())
                                .toList(),
                          ),
                        ),

                        // CarouselSlider(
                        //   options: CarouselOptions(
                        //       onPageChanged: (page, reason) {
                        //         _currentPageNotifier2.value = page - 1;
                        //       },
                        //       pageSnapping: true,
                        //       // autoPlay: true,
                        //       viewportFraction: 1.0),
                        //   items: topRatedSalonList.map((item) {
                        //     print("ITEM RESPONSE : $item");
                        //     TopRatedSalonWidget(
                        //       salonImgName:
                        //           item.image != null ? item.image : "",
                        //       salonNameTxt: item.name != null ? item.name : "",
                        //       //ratingTxt: item.rating != null ? item.rating : "",
                        //     );
                        //   }).toList(),
                        // ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Spacer(),
                            Row(
                              children: [
                                Spacer(),
                                CirclePageIndicator(
                                  size: 5,
                                  dotSpacing: 5,
                                  selectedSize: 6,
                                  dotColor: Colors.white,
                                  selectedDotColor: appYellowColor,
                                  itemCount: 4,
                                  currentPageNotifier: _currentPageNotifier2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    finalNearBySalonList.length != 0
                        ? finalNearBySalonList.length.toString() +
                            " Salon arround you"
                        : "",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: finalNearBySalonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        usersalonModelObj = finalNearBySalonList[index];
                        for (var item in finalNearBySalonList) {
                          print(item.salonImages);
                          if (item.salonImages != null) {
                            for (var newitem in item.salonImages) {
                              if (newitem.type == "logo") {
                                print("hello");
                                print(newitem.name);
                              }
                            }
                          } else {
                            print("No Images uploaded");
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            String salonIDTxt =
                                finalNearBySalonList[index].sId.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeWithSalonVC(
                                  salonID: salonIDTxt,
                                ),
                              ),
                            );
                          },
                          child: SalonAroundWidget(
                            salonImg:
                            usersalonModelObj.salonImages[0].name !=
                                        null
                                    ? usersalonModelObj.salonImages[0].name
                                    : "",
                            nameTxt: usersalonModelObj.salonName != null
                                ? usersalonModelObj.salonName
                                : "",
                            addressTxt: usersalonModelObj.area != null
                                ? usersalonModelObj.area
                                : "",
                            priceTxt: usersalonModelObj.totalRevenue,
                            ratingTxt: usersalonModelObj.ratings != null
                                ? usersalonModelObj.ratings
                                : "",
                            cityTxt: usersalonModelObj.city != null
                                ? usersalonModelObj.city
                                : "",
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
