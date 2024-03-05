import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/NotificationListVC.dart';
import 'package:harnishsalon/screens/employee_list_screen.dart';
import 'package:harnishsalon/screens/salon_order_list_screen.dart';
import 'package:harnishsalon/screens/services_list_screen.dart';
import 'package:harnishsalon/screens/stylist_dashboard_screen.dart';
import 'package:harnishsalon/screens/stylist_profile_screen.dart';

import 'package:page_transition/page_transition.dart';

class StylistBottomNavigationScreen extends StatefulWidget {
  final String salonIdFromOTP;
  final String deviceToken;
  final isNewSalon;
  final isStylist;
  final String stylistID;
  StylistBottomNavigationScreen({
    Key key,
    @required this.isNewSalon,
    this.salonIdFromOTP,
    this.isStylist,
    this.deviceToken,
    this.stylistID,
  }) : super(key: key);

  @override
  _StylistBottomNavigationScreenState createState() =>
      _StylistBottomNavigationScreenState();
}

class _StylistBottomNavigationScreenState
    extends State<StylistBottomNavigationScreen> with Observer {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _index = 0;
  double height, width;
  bool isLoading = false;
  String ownerName = "";
  String firstInitialData = "";

  @override
  void initState() {
    Observable.instance.addObserver(this);
    super.initState();
    if (widget.isStylist == true) {
        getStylistProfile();
    } else {
      getAddressDetail();
    }
  }

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
        String fName = value['first_name'];
        String lName = value['last_name'];

        String gender = value["gender"];
        String designation = value["designation"];

        _handleStylistProfileresponse(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _handleStylistProfileresponse(userData) {
    showCustomToast("Get Stylist Successful ", context);
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
        ownerName = value['owner_name'];
        if (ownerName != "") {
          setState(() {
            firstInitialData = ownerName.substring(0, 1).toUpperCase();
          });

          print("FIRST INITIAL : $firstInitialData");
        }
        _responseProfileHandling(value[kData]);
      } else {
        showCustomToast(value.toString(), context);
      }
    });
  }

  _responseProfileHandling(userData) {
    showCustomToast("User data get successfully ", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _getIndex(_index),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _openProfile();
          },
          child: Container(
            padding: EdgeInsets.all(11),
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: ColorConstants.kNameBackColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: ColorConstants.kWhiteColor,
                ),
              ),
              child: Center(
                child: Text(
                  firstInitialData != null ? firstInitialData : "",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: ColorConstants.kButtonBackColor,
        title: setTextWithCustomFont(
          "Welcome,  " + ownerName,
          16,
          Colors.white,
          FontWeight.w600,
          1,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: NotificationListVC(),
                ),
              );
            },
            child: _index == 1
                ? Container(
                    child: Image.asset(
                      "assets/images/bell.png",
                      height: 16,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: StylistProfileScreen(salonID: widget.salonIdFromOTP),
      ),
    );

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (builder) => StylistProfileScreen(),
    //   ),
    // );
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  Widget _getIndex(index) {
    switch (index) {
      case 0:
        {
          return StylistDashboardScreen(
            isNewSalon: widget.isNewSalon,
            salonId: widget.salonIdFromOTP,
            isStylist:widget.isStylist,
          );
        }
        break;
      case 1:
        {
          return SalonOrderListScreen(
            salonId: widget.salonIdFromOTP,
            stylistID: widget.stylistID,
          );
        }
        break;
      case 2:
        {
          return EmployeeListScreen(
            deviceTokenTxt: widget.deviceToken,
          );
        }
        break;

      case 3:
        {
          return ServicesListScreen();
        }
        break;
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: widget.isStylist
            ? [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu.png",
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu1.png",
                    ),
                    size: 22,
                  ),
                  label: "",
                ),
              ]
            : [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu.png",
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu1.png",
                    ),
                    size: 22,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu2.png",
                    ),
                    size: 22,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    ExactAssetImage(
                      "assets/images/Menu3.png",
                    ),
                    size: 22,
                  ),
                  label: "",
                )
              ],
        currentIndex: _index,
        selectedItemColor: ColorConstants.kBlueColor,
        unselectedItemColor: ColorConstants.kGreyColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  update(Observable observable, String notifyName, Map map) {
    if (map != null && map.containsKey("addEmployee")) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _index = 2;
        });
      });
    } else {
      print("null");
    }
  }
}
