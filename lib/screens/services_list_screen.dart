import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/package_model.dart';

import 'package:harnishsalon/model/package_service_model.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/widgets/AddCustomServiceView.dart';
import 'package:harnishsalon/widgets/select_service_widget.dart';
import 'package:harnishsalon/widgets/add_package_widget.dart';
import 'package:harnishsalon/widgets/services_list_item_widget.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ServicesListScreen extends StatefulWidget {
  ServicesListScreen({
    Key key,
  }) : super(key: key);

  @override
  _ServicesListScreenState createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen>
    with SingleTickerProviderStateMixin {
  double height, width;
  TabController _tabController;
  List<PackageServiceModel> serviceList = List.from([PackageServiceModel()]);
  List<PackageModel> packageList = List.from([PackageModel()]);

  // List<PackageModel> packageList = List.from([PackageModel()]);
  List<SalonServiceModel> salonServicesList = List.from([SalonServiceModel()]);
  List servicePackageList = [];
  List servicesList = [];
  List tempList = [];
  bool isLoading = false;
  bool isDataLoading = true;
  TextEditingController serviceNameController;
  TextEditingController amountController;
  TextEditingController actualAmountController;
  TextEditingController discountedAmountController;
  TextEditingController packageController;
  bool packageName = false;
  bool packageAmount = false;
  bool packageDiscount = false;
  String serviceName, servicePrice;
  int sPrice;
  double amt = 0;

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
  bool isEmptyActualAmount = false;
  bool isEmptyDiscountAmount = false;
  bool isEmptypackageName = false;
  bool isSerivcePackageList = false;
  bool isPackageAdded = false;

  final priceArray = [
    "240",
    "240",
    "240",
    "240",
    "240",
    "240",
    "240",
    "240",
    "240",
    "240",
  ];

  static List<SalonServiceModel> packageServicesList = [];

  @override
  void initState() {
    super.initState();
    getAllServiceList();
    getSalonServiceList();
    getPackageList();
    _tabController = new TabController(length: 2, vsync: this);
    serviceNameController = new TextEditingController();
    amountController = new TextEditingController();
    actualAmountController = new TextEditingController();
    discountedAmountController = new TextEditingController();
    packageController = new TextEditingController();
  }

  getPackageList() {
    setState(() {
      isLoading = true;
    });
    packageList.clear();
    postDataRequestWithTokenSalon(packageListApi, null, context).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        _handlePackageListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _handlePackageListResponse(value) {
    var arrData =
        value.map<PackageModel>((json) => PackageModel.fromJson(json)).toList();

    setState(() {
      packageList = arrData;
    });
  }

  getAllServiceList() {
    serviceList.clear();
    setState(() {
      isLoading = true;
    });
    postDataRequestWithTokenSalon(serviceListApi, null, context).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        handleAllServiceListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleAllServiceListResponse(value) {
    var arrData = value
        .map<PackageServiceModel>((json) => PackageServiceModel.fromJson(json))
        .toList();
    setState(() {
      serviceList = arrData;
    });
  }

  getSalonServiceList() {
    setState(() {
      isLoading = true;
    });

    salonServicesList.clear();
    postDataRequestWithTokenSalon(packageServiceListApi, null, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        handleSalonServiceListResponse(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  handleSalonServiceListResponse(value) {
    var arrData = value
        .map<SalonServiceModel>((json) => SalonServiceModel.fromJson(json))
        .toList();
    setState(() {
      salonServicesList = arrData;
      packageServicesList = salonServicesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final _items = packageServicesList
        .map((animal) =>
            MultiSelectItem<SalonServiceModel>(animal, animal.serviceName))
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                    text: 'Package',
                  ),
                  Tab(
                    text: 'Service Request',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Package List
                  packageList.isEmpty
                      ? Center(
                          child: Text(
                            "No package Added",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.kBlackColor,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: packageList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return packageList.length > 0
                                ? ServicesListItemWidget(
                                    servicesNameTxt:
                                        packageList[index].name != null
                                            ? packageList[index].name
                                            : "",
                                    priceTxt: packageList[index].price != null
                                        ? packageList[index].price
                                        : "",
                                  )
                                : SizedBox();
                          },
                        ),

                  // ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: serviceArray.length,
                  //   shrinkWrap: false,
                  //   itemBuilder: (BuildContext context, index) {
                  //     return SelectServiceWidget(
                  //       servicesNameTxt: serviceList[index].name != null
                  //           ? serviceList[index].name
                  //           : "",
                  //       onDeleteTap: () {},
                  //       onRateSubmitted: (val) {
                  //         String price = val;
                  //         //onRateSubmittedApi(index, serviceID, price);
                  //       },
                  //     );
                  //   },
                  // ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: serviceList.length.toDouble() * 60,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: serviceList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: false,
                            itemBuilder: (BuildContext context, index) {
                              var serviceID = serviceList[index].sId;
                              var servicesName = serviceList[index].name;
                              return SelectServiceWidget(
                                servicesNameTxt: serviceList[index].name != null
                                    ? serviceList[index].name
                                    : "",
                                onDeleteTap: () {},
                                onRateSubmitted: (val) {
                                  bool isAdded = false;
                                  for (var sName in packageServicesList) {
                                    if (sName.serviceName == servicesName) {
                                      print("sName" + sName.serviceName);
                                      print(servicesName);
                                      isAdded = true;
                                    }
                                  }
                                  if (isAdded == true) {
                                    showCustomToast(
                                        "You have Already added this service",
                                        context);
                                  } else {
                                    String price = val;
                                    onRateSubmittedApi(index, serviceID, price);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Expanded(
                            //   child: DottedLine(
                            //     direction: Axis.horizontal,
                            //     dashColor: Colors.grey,
                            //     lineThickness: 1.5,
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              alignment: Alignment.center,
                              child: setPoppinsfontWitAlignment(
                                  "OR",
                                  12,
                                  Color.fromRGBO(153, 153, 153, 1),
                                  FontWeight.w400,
                                  1),
                            ),
                            // Expanded(
                            //   child: DottedLine(
                            //     direction: Axis.horizontal,
                            //     dashColor: Colors.grey,
                            //     lineThickness: 1.5,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 44,
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border:
                                  Border.all(color: ColorConstants.kBlueColor)),
                          child: setbuttonWithChild(
                            setTextWithCustomFont(
                              "Add Service Request",
                              14,
                              ColorConstants.kBlueColor,
                              FontWeight.w400,
                              1,
                            ),
                            () {
                              openCustomServicePopup();
                            },
                            Colors.white,
                            3,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        DottedLine(
                          lineThickness: 1.5,
                          dashColor: ColorConstants.kGreyColor,
                        ),
                        SizedBox(
                          height: height * 0.1 / 2,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add Packages",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ColorConstants.kBlackColor,
                                  ),
                                ),
                                Text(
                                  amt.toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: ColorConstants.kBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // MultiSelect(
                            //   saveButtonIcon: null,
                            //   saveButtonText: "Next",
                            //   buttonBarColor: Colors.white,
                            //   initialValue: ['IN', 'US'],
                            //   titleText: 'Select Services',
                            //   errorBorderColor: ColorConstants.kGreyColor,
                            //   titleTextColor: ColorConstants.kBlackColor,
                            //   validator: (dynamic value) {
                            //     if (value == null) {
                            //       return 'Please select one or more option(s)';
                            //     }
                            //     return null;
                            //   },
                            //   errorText: 'Please select one or more option(s)',
                            //   dataSource: serviceList,
                            //   // dataSource: [
                            //   //   {"name": "Haricut", "code": "AF"},
                            //   //   {"name": "Shampoo", "code": "AX"},
                            //   //   {"name": "Hair Oil", "code": "AL"},
                            //   //   {"name": "Hair Color", "code": "DZ"},
                            //   //   {"name": "Hair Spa", "code": "AS"},
                            //   //   {"name": "Hair Shampoo", "code": "AD"},
                            //   //   {"name": "Beard", "code": "AO"},
                            //   //   {"name": "Trimming", "code": "AI"},
                            //   //   {"name": "Waxing", "code": "AQ"},
                            //   //   {"name": "Facial", "code": "AG"},
                            //   // ],
                            //   textField: 'name',
                            //   valueField: 'code',
                            //   filterable: true,
                            //   required: true,
                            //   onSaved: (value) {
                            //     print('The value is $value');
                            //   },
                            //   selectIcon: Icons.arrow_drop_down,
                            //   selectIconColor: ColorConstants.kBlackColor,
                            //   saveButtonColor: ColorConstants.kButtonBackColor,
                            //   checkBoxColor: Theme.of(context).primaryColorDark,
                            //   cancelButtonColor:
                            //       ColorConstants.kButtonBackColor,
                            //   clearButtonTextColor: Colors.white,
                            //   cancelButtonTextColor: Colors.white,
                            //   clearButtonColor: ColorConstants.kButtonBackColor,
                            // ),
                            MultiSelectDialogField(
                              chipDisplay: MultiSelectChipDisplay(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              confirmText: Text(
                                "NEXT",
                                style: TextStyle(fontSize: 15),
                              ),
                              items: _items,
                              title: Text("Select Services"),
                              selectedColor: Colors.blue,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                              // buttonIcon: Icon(
                              //   Icons.serv,
                              //   color: Colors.blue,
                              // ),
                              buttonText: Text(
                                "Select Services",
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 16,
                                ),
                              ),
                              onConfirm: (results) {
                                print("RESULT : $results");
                                setState(() {
                                  servicePackageList = results;
                                  servicesList = servicePackageList;
                                  dynamic list = servicesList
                                      .map((v) => v.toJson())
                                      .toList();
                                  dynamic listData = list;
                                  sPrice = 0;
                                  int price = 0;
                                  for (int i = 0; i < listData.length; i++) {
                                    SalonServiceModel ssm =
                                        SalonServiceModel.fromJson(listData[i]);
                                    price = int.parse(ssm.servicePrice);
                                    sPrice += price;
                                  }
                                  actualAmountController.text =
                                      sPrice.toString();
                                });
                                print("SERVICE PACKAGE LIST" +
                                    servicePackageList.toString());
                              },
                            ),
                            // Text("hello"),
                            SizedBox(
                              height: 10,
                            ),

                            setTextField(
                              packageController,
                              "Package name",
                              false,
                              TextInputType.text,
                              isEmptypackageName,
                              msgEmptyPackageName,
                              () => {
                                setState(() {
                                  isEmptypackageName = false;
                                })
                              },
                              () {},
                            ),

                            // TextFormFieldWidget(
                            //   hintTxt: "Package Name",
                            //   controllerName: packageController,
                            //   onChanged: (val) {
                            //     print("object");
                            //   },
                            //   onSaved: (val) {
                            //     print("object");
                            //   },
                            //   keyboardType: TextInputType.text,
                            // ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: setTextField(
                                    actualAmountController,
                                    "Amount",
                                    false,
                                    TextInputType.number,
                                    isEmptyActualAmount,
                                    msgEmptyAmount,
                                    () => {
                                      setState(() {
                                        isEmptyActualAmount = false;
                                      })
                                    },
                                    () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  // child: Container(
                                  //   height: 50,
                                  //   width: width * 0.3,
                                  //   decoration: BoxDecoration(
                                  //     color: ColorConstants.kWhiteColor,
                                  //   ),
                                  child: setTextField(
                                    discountedAmountController,
                                    "Discount",
                                    false,
                                    TextInputType.number,
                                    isEmptyDiscountAmount,
                                    msgEmptyDiscountedAmount,
                                    () => {
                                      setState(() {
                                        isEmptyDiscountAmount = false;
                                        double disc = double.parse(
                                            discountedAmountController.text);
                                        double discPrice =
                                            (sPrice * disc) / 100;
                                        amt = sPrice - discPrice;
                                      })
                                    },
                                    () {},
                                  ),
                                  // ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButtonWidget(
                              btnTxt: "ADD",
                              btnbackColor: ColorConstants.kButtonBackColor,
                              btnOntap: () {
                                onPackageAdded();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: height * 0.35,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: packageList.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: false,
                                itemBuilder: (BuildContext context, index) {
                                  var packageObj = packageList[index];
                                  return AddpackageWidget(
                                    itemName: packageObj.name != null
                                        ? packageObj.name
                                        : "",
                                    actualAmount: packageObj.price != null
                                        ? packageObj.price
                                        : "",
                                    discountedAmount:
                                        packageObj.discount != null
                                            ? packageObj.discount
                                            : "",
                                    onDeleteTap: () {
                                      onPackageDelete(packageObj);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPackageDelete(packageObj) {
    print(packageObj);
    FormData param = FormData.fromMap({
      "package_id": packageObj.sId,
    });

    postDataRequestWithTokenSalon(deletePackageApi, param, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is List) {
        packageDeleteResponseHandling(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  packageDeleteResponseHandling(userData) async {
    print(userData);
    //PackageModel packageModel = PackageModel.fromJson(userData);
    showCustomToast("Package Deleted", context);
    getPackageList();
    FocusScope.of(context).unfocus();
  }

  onPackageAdded() async {
    if (packageController.text.trim() == "") {
      setState(() {
        isEmptypackageName = true;
      });
      return;
    }
    if (actualAmountController.text.trim() == "") {
      setState(() {
        isEmptyActualAmount = true;
      });
      return;
    }
    if (discountedAmountController.text.trim() == "") {
      setState(() {
        isEmptyDiscountAmount = true;
      });
      return;
    }

    if (servicePackageList.isEmpty) {
      showCustomToast("Please Select Services", context);
    } else {
      if (packageList.isEmpty) {
        addPackage();
      } else {
        for (var itemName in packageList) {
          if (itemName.name == packageController.text) {
            showCustomToast(
                "You have already added a package with same name", context);
            isPackageAdded = true;
          }
        }
        if (isPackageAdded == false) {
          addPackage();
        }
      }
    }
  }

  addPackage() {
    for (var item in salonServicesList) {
      print(item.serviceId);
      setState(() {
        tempList.add(item.serviceId);
      });
    }

    setState(() {
      isLoading = true;
    });
    String amount = actualAmountController.text;
    String discount = discountedAmountController.text;
    String packageName = packageController.text;
    FormData param = FormData.fromMap({
      "name": packageName,
      "services": tempList,
      "price": amount,
      "discount": discount,
    });
    packageController.text = "";
    actualAmountController.text = "";
    discountedAmountController.text = "";
    postDataRequestWithTokenSalon(addPackageRequest, param, context)
        .then((value) {
      setState(() {
        isLoading = false;
        isDataLoading = false;
      });
      if (value is List) {
        _packageResponseHandling(value);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _packageResponseHandling(userData) async {
    print(userData);
    showCustomToast("Package Added", context);
    actualAmountController.clear();
    discountedAmountController.clear();
    packageController.clear();
    _tabController.index = 0;
    FocusScope.of(context).unfocus();
    getPackageList();
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
    getSalonServiceList();
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

// void _showMultiSelect(BuildContext context) async {
//   await showDialog(
//     context: context,
//     builder: (ctx) {
//       return MultiSelectDialog(
//         items: _items,
//         initialValue: _selectedAnimals,
//         onConfirm: (values) {},
//       );
//     },
//   );
// }
}
