import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/EmployeeWithSAlonVC.dart';
import 'package:page_transition/page_transition.dart';

/*
Title:LastVisitedWidget
Purpose:LastVisitedWidget
Created By:18 Feb 2021
*/

class LastVisitedWidget extends StatelessWidget {
  final String salonImg;
  final String nameTxt;
  final String cityTxt;
  final double ratingTxt;

  const LastVisitedWidget({
    Key key,
    @required this.salonImg,
    @required this.nameTxt,
    @required this.cityTxt,
    @required this.ratingTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: EmployeeWithSalonVC(),
          ),
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (builder) => EmployeeWithSalonVC(),
        //   ),
        // );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage(
                  salonImg,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameTxt,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              Text(
                cityTxt,
                style: GoogleFonts.roboto(
                  fontSize: 11,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 9,
                    color: ColorConstants.kRatingColor,
                  ),
                  Text(
                    ratingTxt.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kRatingColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
