import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/model/package_service_model.dart';
import 'package:harnishsalon/screens/stylist_bottom_navigation_screen.dart';
import 'package:harnishsalon/widgets/AddCustomServiceView.dart';
import 'package:harnishsalon/widgets/select_service_widget.dart';

import '../common/Global.dart';
import '../common/color_constants.dart';

class SelectServiceStylistVC extends StatefulWidget {
  final String salonIDSelectServiceTxt;

  SelectServiceStylistVC({
    this.salonIDSelectServiceTxt,
  });
  @override
  _SelectServiceStylistVCState createState() => _SelectServiceStylistVCState();
}

class _SelectServiceStylistVCState extends State<SelectServiceStylistVC> {
  var txtSearchController = new TextEditingController();
  List<PackageServiceModel> serviceList = List.from([PackageServiceModel()]);
  bool isLoading = false;
  final serviceArray = [
    "Haricut",
    "Shampoo",
    "Hair Oil",
    "Hair Color",
    "Hair Spa",
    "Hair Shampoo",
    "Beard",
    "Trimming",
    "Waxing",
    "Facial",
  ];

  @override
  void initState() {
    super.initState();
    getAllServiceList();
  }

  getAllServiceList() {
    setState(() {
      isLoading = true;
    });

    serviceList.clear();

    postDataRequestWithTokenSalon(serviceListApi, null, context).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        handleServiceListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleServiceListResponse(value) {
    var arrData = value
        .map<PackageServiceModel>((json) => PackageServiceModel.fromJson(json))
        .toList();
    setState(() {
      serviceList = arrData;
    });
    // packageServicesList = serviceList;
    // print("PACKAGE LIST : $packageServicesList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: setTextWithCustomFont(
            "Select Services", 18, Colors.black, FontWeight.w500, 1),
        leading: setbuttonWithChild(Icon(Icons.arrow_back), () {
          Navigator.pop(context);
        }, Colors.transparent, 0),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                        child: setTextField(
                            txtSearchController,
                            "Search for services",
                            false,
                            TextInputType.text,
                            false,
                            "",
                            () {},
                            () {}))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: serviceList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, index) {
                      var serviceID = serviceList[index].sId;
                      return SelectServiceWidget(
                        servicesNameTxt: serviceList[index].name != null
                            ? serviceList[index].name
                            : "",
                        onDeleteTap: () {},
                        onRateSubmitted: (val) {
                          String price = val;
                          onRateSubmittedApi(index, serviceID, price);
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: DottedLine(
                      direction: Axis.horizontal,
                      dashColor: Colors.grey,
                      lineThickness: 1.5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: setPoppinsfontWitAlignment("OR", 12,
                        Color.fromRGBO(153, 153, 153, 1), FontWeight.w400, 1),
                  ),
                  Expanded(
                    child: DottedLine(
                      direction: Axis.horizontal,
                      dashColor: Colors.grey,
                      lineThickness: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: ColorConstants.kBlueColor)),
                child: setbuttonWithChild(
                    setTextWithCustomFont("Add Service Request", 14,
                        ColorConstants.kBlueColor, FontWeight.w400, 1), () {
                  openCustomServicePopup();
                }, Colors.white, 3),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width - 30,
                child: setbuttonWithChild(
                  setTextWithCustomFont(
                      "NEXT", 14, Colors.white, FontWeight.w400, 1),
                  () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StylistBottomNavigationScreen(
                            isNewSalon: false,
                            isStylist: isStylist,
                            salonIdFromOTP: widget.salonIDSelectServiceTxt,
                          ),
                          fullscreenDialog: false,
                        ),
                        (route) => false);
                  },
                  ColorConstants.kButtonBackColor,
                  3,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onRateSubmittedApi(index, serviceID, price) {
    setState(() {
      isLoading = true;
    });

    FormData param = FormData.fromMap({
      "service_id": serviceID,
      "service_price": price,
    });
    postDataRequestWithTokenSalon(serviceCreateApi, param, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      print(value);
      if (value is List) {
        responseSalonServicesHandling(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  responseSalonServicesHandling(userData) async {
    showCustomToast("Price Added", context);
    print(userData);
  }

  openCustomServicePopup() {
    showGeneralDialog(
      pageBuilder: (c, a, a2) {},
      barrierDismissible: true,
      useRootNavigator: true,
      barrierLabel: "0",
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder:
          (BuildContext context, Animation a, Animation b, Widget child) {
        return Transform.scale(
          scale: a.value,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: AddCustomServiceView(),
          ),
        );
      },
    );
  }
}
