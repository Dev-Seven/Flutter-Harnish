import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/stylist_login_screen.dart';
import 'package:harnishsalon/screens/stylist_registration_screen.dart';
import 'package:harnishsalon/screens/user_login_screen.dart';
import 'package:harnishsalon/screens/user_registration_screen.dart';

class RoleSelectorScreen extends StatefulWidget {
  RoleSelectorScreen({Key key}) : super(key: key);

  @override
  _RoleSelectorScreenState createState() => _RoleSelectorScreenState();
}

class _RoleSelectorScreenState extends State<RoleSelectorScreen> {
  Offset position;
  bool isLoading = true;
  FirebaseMessaging messaging;
  String firebaseDeviceToken;
  double currentLatitude;
  String currentAddress;
  double currentLongitude;

  @override
  void initState() {
    super.initState();
    getDeviceToken();
    position = Offset.zero;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
        position = Offset(MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2 + 5);
      });
    });
  }



  getDeviceToken() async {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      setState(() {
        firebaseDeviceToken = value.toString();
      });
    });
    print("FIREBASE TOKEN : $firebaseDeviceToken");
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    double _width = 100;
    double _height = 100;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.5,
                width: width * 0.9999,
                color: ColorConstants.kLogoBackColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "LOGIN AS USER",
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        color: ColorConstants.kBlackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: height * 0.1 / 2,
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashColor: ColorConstants.kBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "SWIPE UP",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: ColorConstants.kBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/images/short.png",
                      height: 150,
                    )
                  ],
                ),
              ),
              Container(
                height: height * 0.5,
                width: width * 0.9999,
                color: ColorConstants.kImageBlueColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.13,
                    ),
                    Image.asset(
                      "assets/images/electric.png",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SWIPE DOWN",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: ColorConstants.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: height * 0.1 / 2,
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashColor: ColorConstants.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "LOGIN AS STYLIST",
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        color: ColorConstants.kWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            onPanStart: (details) => _onPanStart(context, details),
            onPanUpdate: (details) => _onPanUpdate(context, details, position),
            onPanEnd: (details) => _onPanEnd(context, details, position),
            onPanCancel: () => _onPanCancel(context),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  top: position.dy - 40,
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isLoading
                            ? Colors.transparent
                            : ColorConstants.kWhiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(BuildContext context, DragStartDetails details) {
    print(details.globalPosition.dy / 2);
  }

  void _onPanUpdate(
      BuildContext context, DragUpdateDetails details, Offset offset) {
    setState(() {
      position = details.globalPosition;
    });
  }

  void _onPanEnd(BuildContext context, DragEndDetails details, Offset offset) {
    setState(() {
      position = Offset(MediaQuery.of(context).size.width / 2 - 50,
          MediaQuery.of(context).size.height / 2 + 5);
    });

    if (offset.dy > MediaQuery.of(context).size.height / 2 - 40) {
      print("Stylist");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StylistLoginScreen(
            deviceToken: firebaseDeviceToken,
          ),
        ),
      );
    } else {
      print("User");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLoginScreen(
            deviceToken: firebaseDeviceToken,
          ),
        ),
      );
    }
  }

  void _onPanCancel(BuildContext context) {
    print("Pan canceled !!");
  }
}

// class RoleSelectorScreen extends StatelessWidget {
//   const RoleSelectorScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height, width;
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Material(
//       type: MaterialType.transparency,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: height * 0.5,
//                 width: width * 0.9999,
//                 color: ColorConstants.kLogoBackColor,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Text(
//                       "LOGIN AS USER",
//                       style: GoogleFonts.roboto(
//                         fontSize: 30,
//                         color: ColorConstants.kBlackColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       height: height * 0.1 / 2,
//                       child: DottedLine(
//                         direction: Axis.vertical,
//                         dashColor: ColorConstants.kBlackColor,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "SWIPE UP",
//                       style: GoogleFonts.roboto(
//                         fontSize: 16,
//                         color: ColorConstants.kBlackColor,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Image.asset(
//                       "assets/images/short.png",
//                       height: 150,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: height * 0.5,
//                 width: width * 0.9999,
//                 color: ColorConstants.kImageBlueColor,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: height * 0.13,
//                     ),
//                     Image.asset(
//                       "assets/images/electric.png",
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "SWIPE DOWN",
//                       style: GoogleFonts.roboto(
//                         fontSize: 16,
//                         color: ColorConstants.kWhiteColor,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: height * 0.1 / 2,
//                       child: DottedLine(
//                         direction: Axis.vertical,
//                         dashColor: ColorConstants.kWhiteColor,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "LOGIN AS STYLIST",
//                       style: GoogleFonts.roboto(
//                         fontSize: 30,
//                         color: ColorConstants.kWhiteColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Stack(
//             children: <Widget>[
//               Positioned(
//                 left: 0,
//                 // top: position.dy - height + 20,
//                 child: Draggable(
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.red,
//                     child: Center(
//                       child: Text(
//                         "Drag",
//                         style: Theme.of(context).textTheme.headline,
//                       ),
//                     ),
//                   ),
//                   feedback: Container(
//                     child: Center(
//                       child: Text(
//                         "Drag",
//                         style: Theme.of(context).textTheme.headline,
//                       ),
//                     ),
//                     color: Colors.red[800],
//                     width: 100,
//                     height: 100,
//                   ),
//                   onDraggableCanceled: (Velocity velocity, Offset offset) {
//                     // setState(() => position = offset);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Center(
//             child: Container(
//               height: 80,
//               width: 80,
//               decoration: BoxDecoration(
//                 color: ColorConstants.kWhiteColor,
//                 borderRadius: BorderRadius.circular(80 / 2),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 5, bottom: 5),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => UserRegistrationScreen(),
//                           ),
//                         );
//                       },
//                       child: Icon(
//                         Icons.keyboard_arrow_up,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => StylistRegistrationScreen(),
//                           ),
//                         );
//                       },
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
