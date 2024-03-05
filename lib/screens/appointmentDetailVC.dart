import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/ongoing_item_widget.dart';

class AppointmentDetailVC extends StatefulWidget {
  AppointmentDetailVC({Key key}) : super(key: key);

  @override
  _AppointmentDetailVCState createState() => _AppointmentDetailVCState();
}

class _AppointmentDetailVCState extends State<AppointmentDetailVC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kScreenBackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Nishit Mistry",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.kBlackColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorConstants.kBlackColor,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.kScreenBackColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    OngoingItemWidget(
                      profileImg: "assets/images/1.jpg",
                      serviceNameTxt: "Hair Cut & Beard",
                      timeTxt: "Start: 11:20",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.kScreenBackColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.fromLTRB(
                    15,
                    40,
                    15,
                    40,
                  ),
                  width: double.infinity,
                  child: setbuttonWithChild(
                      Text(
                        "Call",
                        style: TextStyle(color: Colors.white),
                      ), () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }, Colors.green, 5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
