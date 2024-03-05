import 'package:flutter/material.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:lottie/lottie.dart';


class AppointmentSuccessScreen extends StatefulWidget {
  AppointmentSuccessScreen({
    Key key,
  }) : super(key: key);

  @override
  _AppointmentSuccessScreenState createState() =>
      _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen> {
  double height, width;

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
                  Lottie.asset(
                    'assets/lottie/success.json',
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
