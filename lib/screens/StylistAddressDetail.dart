import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/stylist_profile_screen.dart';

class StylistAddressDetailVC extends StatefulWidget {
  StylistAddressDetailVC({Key key}) : super(key: key);

  @override
  _StylistAddressDetailVCState createState() => _StylistAddressDetailVCState();
}

class _StylistAddressDetailVCState extends State<StylistAddressDetailVC> {
  TextEditingController salonNameController = TextEditingController();
  TextEditingController officeNameController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController towerController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  double currentLatitude;
  String currentAddress;
  String address;
  double currentLongitude;
  bool isLoading = false;
  bool isMobileNumber = false;
  bool isMobileInvalid = false;
  double height, width;

  bool isFullName = false;
  var issalonName = false;
  var isownerName = false;
  var isfullAddressName = false;
  var istowerName = false;
  var isstateName = false;
  var isCityName = false;
  var isareaName = false;
  String name = "";
  String firstname = "";
  String tower = "";
  String state = "";
  String area = "";
  String city = "";

  @override
  void initState() {
    super.initState();
    // getCurrentLatLong();
    getAddressDetail();
    // officeNameController.text = "D - 402";
    // floorController.text = "3rd Floor";
    // towerController.text = "Malbar county";
    // areaController.text = "Sarkhej";
    // cityController.text = "Ahmedabad";
    // salonNameController.text = "Enrich Salon";
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
        name = value['salon_name'];
        firstname = value['owner_name'];
        tower = value['tower_name'];
        state = value['state'];
        area = value['area'];
        city = value['city'];
        address = value['address'];
        salonNameController.text = name;
        officeNameController.text = firstname;
        fullAddressController.text = address;
        towerController.text = tower;
        stateController.text = state;
        areaController.text = area;
        cityController.text = city;

        _responseProfileHandling(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseProfileHandling(userData) {
    showCustomToast("User data get successfully ", context);
  }

  onUpdateBtnTap() {
    if (salonNameController.text.trim() == "") {
      setState(() {
        issalonName = true;
      });
      return;
    }
    if (officeNameController.text.trim() == "") {
      setState(() {
        isownerName = true;
      });
      return;
    }
    if (towerController.text.trim() == "") {
      setState(() {
        istowerName = true;
      });
      return;
    }
    if (areaController.text.trim() == "") {
      setState(() {
        isareaName = true;
      });
      return;
    }
    if (cityController.text.trim() == "") {
      setState(() {
        isCityName = true;
      });
      return;
    }
    if (stateController.text.trim() == "") {
      setState(() {
        isstateName = true;
      });
      return;
    }

    String salonName = salonNameController.text;
    String towerName = towerController.text;
    String area = areaController.text;
    String city = cityController.text;
    String state = stateController.text;
    String address = fullAddressController.text;

    setState(() {
      isLoading = true;
    });
    FormData param = FormData.fromMap({
      "address": address,
      "latitude": currentLatitude,
      "longitude": currentLongitude,
      "salon_name": salonName,
      "tower_name": towerName,
      "area": area,
      "city": city,
      "state": state,
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
  }

  _responseHandling(userData) {
    showCustomToast("Address Updated Successfully ", context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StylistProfileScreen(),
        ));
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
        backgroundColor: ColorConstants.kButtonBackColor,
        title: setTextWithCustomFont(
          "Address Details",
          18,
          Colors.white,
          FontWeight.w500,
          1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              SizedBox(
                height: 18,
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
                      issalonName,
                      "",
                      () {
                        setState(() {
                          issalonName = false;
                        });
                      },
                      () {},
                    ),
                    Divider(
                      height: 1,
                    ),
                    setTextField(
                      officeNameController,
                      "Owner Name",
                      false,
                      TextInputType.text,
                      isownerName,
                      "",
                      () {
                        setState(() {
                          isownerName = false;
                        });
                      },
                      () {},
                    ),
                    Divider(
                      height: 1,
                    ),
                    setTextField(
                      fullAddressController,
                      "Full Address ",
                      false,
                      TextInputType.text,
                      isfullAddressName,
                      "",
                      () {
                        setState(() {
                          isfullAddressName = false;
                        });
                      },
                      () {},
                    ),
                    // Divider(
                    //   height: 1,
                    // ),
                    // setTextField(
                    //   floorController,
                    //   "Phone Number",
                    //   false,
                    //   TextInputType.text,
                    //   false,
                    //   "",
                    //   () {},
                    // ),
                    Divider(
                      height: 1,
                    ),
                    setTextField(
                      towerController,
                      "Tower / Wing",
                      false,
                      TextInputType.text,
                      istowerName,
                      "",
                      () {
                        setState(() {
                          istowerName = false;
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
                      false,
                      "",
                      () {
                        setState(() {
                          isareaName = false;
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
                      isCityName,
                      "",
                      () {
                        setState(() {
                          isCityName = false;
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
                      isstateName,
                      "",
                      () {
                        setState(() {
                          isstateName = false;
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
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width - 20,
                child: setbuttonWithChild(
                  setTextWithCustomFont(
                    "UPDATE",
                    14,
                    Colors.white,
                    FontWeight.w400,
                    1,
                  ),
                  () {
                    onUpdateBtnTap();
                  },
                  ColorConstants.kButtonBackColor,
                  3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
