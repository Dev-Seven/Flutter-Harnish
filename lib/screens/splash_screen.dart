import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/role_selector_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height, width;
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleSelectorScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.kLogoBackColor,
      body: Center(
        child: Image.asset(
          "assets/images/artboard.jpg",
          height: height * 0.3,
        ),
      ),
    );
  }
}
