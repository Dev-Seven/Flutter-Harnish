import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/package_model.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import 'package:harnishsalon/screens/user_dashboard_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final List<SalonServiceModel> selectedItemList;
  final List<PackageModel> selectedPackageList;
  final bool isFromService;
  final String salonID;
  final String bookingDate;
  final String bookingTime;
  final String stylistID;
  final Function(List<PackageModel>) callbackFromCheckout;
  final String salonNameTxt;

  CheckoutScreen({
    this.selectedItemList,
    this.selectedPackageList,
    this.isFromService,
    this.salonID,
    this.bookingDate,
    this.bookingTime,
    this.stylistID,
    this.callbackFromCheckout,
    this.salonNameTxt,
  });
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double height, width;
  double _totalPrice = 0;
  double price;
  bool isLoading = false;
  String serviceID = "";
  String packageID = "";
  List<String> serviceList = [];
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print(widget.salonID);
    if (widget.isFromService) {
      getTotal();
    } else {
      getPackageTotal();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  getTotal() {
    widget.selectedItemList.forEach((element) {
      double.tryParse(element.servicePrice);
      double finalPrice = double.tryParse(element.servicePrice);
      double total = _totalPrice + finalPrice;
      setState(() {
        _totalPrice = total;
      });
    });
  }

  getPackageTotal() {
    widget.selectedPackageList.forEach((element) {
      double.tryParse(element.price);
      double finalPrice = double.tryParse(element.price);
      double total = _totalPrice + finalPrice;
      setState(() {
        _totalPrice = total;
      });
    });
  }

  onBookAppointment() async {
    var options = {
      'key': 'rzp_test_NYKQCDSzC8Fybu',
      'amount': _totalPrice,
      'name': 'Harnish Salon',
      'description': 'Harnish Salon Payment',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
      toastLength: Toast.LENGTH_SHORT,
    );
    String salonid = widget.salonID;
    String bookingDate = widget.bookingDate;
    String bookingTime = widget.bookingTime;
    String employeeID = widget.stylistID;
    setState(() {
      isLoading = true;
    });

    if (widget.isFromService == true) {
      if (widget.selectedItemList.isEmpty) {
        showCustomToast("No Service", context);
      } else {
        for (var item in widget.selectedItemList) {
          print("SID : ${item.sId}");
          String sID = item.sId;
          serviceList.add(sID);
        }
        FormData param = FormData.fromMap({
          "salon_id": widget.salonID,
          "date": bookingDate,
          "time": bookingTime,
          "employee_id": employeeID,
          "services[]": serviceList,
        });

        postDataRequestWithToken(bookAppointmentApi, param, context)
            .then((value) {
          setState(() {
            isLoading = false;
          });

          if (value is Map) {
            _serviceResponseHandling(value);
          } else {
            showCustomToast(value.toString(), context);
          }
        });
      }
    } else {
      if (widget.selectedPackageList.length != 0) {
        for (var item in widget.selectedPackageList) {
          packageID = item.sId;
          FormData param = FormData.fromMap({
            "salon_id": widget.salonID,
            "date": bookingDate,
            "time": bookingTime,
            "employee_id": employeeID,
            "package": packageID
          });
          postDataRequestWithToken(bookAppointmentApi, param, context)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            if (value is List) {
              _packageResponseHandling(value);
            } else {
              showCustomToast(value.toString(), context);
            }
          });
        }
      } else {
        showCustomToast("No packgae", context);
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  _packageResponseHandling(appointment) {
    showCustomToast("Appointment Booked Success", context);
    widget.selectedPackageList.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDashBoardScreen(),
        ));
  }

  _serviceResponseHandling(appointment) {
    showCustomToast("Appointment Booked Success", context);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      appBar: AppBar(
        backgroundColor: ColorConstants.kScreenBackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.salonNameTxt,
          //"Enrich Salon",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.kBlackColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EmployeeWithSalonVC(
                  salonID: widget.salonID,
                ),
              ),
            );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: setTextWithCustomFont(
                                "Item",
                                16,
                                Colors.grey,
                                FontWeight.w500,
                                1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: setTextWithCustomFont(
                                "Price",
                                16,
                                Colors.grey,
                                FontWeight.w500,
                                1,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.isFromService
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.selectedItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: setTextWithCustomFont(
                                              widget.selectedItemList[index]
                                                          .serviceName !=
                                                      null
                                                  ? widget
                                                      .selectedItemList[index]
                                                      .serviceName
                                                  : "",
                                              // widget.selectedItemList[index].,
                                              13,
                                              Colors.black,
                                              FontWeight.w500,
                                              1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: setTextWithCustomFont(
                                              widget.selectedItemList[index]
                                                          .servicePrice !=
                                                      null
                                                  ? "₹ " +
                                                      widget
                                                          .selectedItemList[
                                                              index]
                                                          .servicePrice
                                                  : "",
                                              13,
                                              Colors.black,
                                              FontWeight.w500,
                                              1,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.selectedPackageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: setTextWithCustomFont(
                                              widget.selectedPackageList[index]
                                                          .name !=
                                                      null
                                                  ? widget
                                                      .selectedPackageList[
                                                          index]
                                                      .name
                                                  : "",
                                              13,
                                              Colors.black,
                                              FontWeight.w500,
                                              1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: setTextWithCustomFont(
                                              widget.selectedPackageList[index]
                                                          .price !=
                                                      null
                                                  ? "₹ " +
                                                      widget
                                                          .selectedPackageList[
                                                              index]
                                                          .price
                                                  : "",
                                              13,
                                              Colors.black,
                                              FontWeight.w500,
                                              1,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: setTextWithCustomFont(
                        "Total :",
                        14,
                        Colors.grey,
                        FontWeight.w500,
                        1,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: setTextWithCustomFont(
                        "₹ " + _totalPrice.toString() != null
                            ? "₹ " + _totalPrice.toString()
                            : "",
                        15,
                        Colors.black,
                        FontWeight.w500,
                        1,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: setTextWithCustomFont("Select Payment Method", 16,
                      Colors.black, FontWeight.w500, 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setTextWithLightCustomFont("Credit / Debit Card", 14,
                            Colors.black, FontWeight.w300, 1),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setTextWithLightCustomFont(
                            "Netbanking", 14, Colors.black, FontWeight.w500, 1),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setTextWithLightCustomFont(
                            "UPI", 14, Colors.black, FontWeight.w500, 1),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setTextWithLightCustomFont(
                            "Paytm", 14, Colors.black, FontWeight.w500, 1),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setTextWithLightCustomFont(
                            "Pay @Salon", 14, Colors.black, FontWeight.w500, 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Spacer(),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: SafeArea(
                    child: Container(
                      height: 47,
                      child: setbuttonWithChild(
                        setTextWithLightCustomFont(
                          "CONFIRM",
                          14,
                          Colors.white,
                          FontWeight.w400,
                          1,
                        ),
                        () {
                          onBookAppointment();
                          // onConfirmTap();
                        },
                        appYellowColor,
                        5,
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
