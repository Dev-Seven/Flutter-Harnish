import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import 'package:harnishsalon/screens/SalonDetailScreen.dart';
import 'package:page_transition/page_transition.dart';

import '../common/color_constants.dart';

/*
Title:SalonAroundWidget
Purpose:SalonAroundWidget
Created By:18 Feb 2021
*/

class SalonAroundWidget extends StatelessWidget {
  final String salonImg;
  final String nameTxt;
  final String addressTxt;
  final int ratingTxt;
  final String cityTxt;
  final String priceTxt;

  const SalonAroundWidget({
    Key key,
    this.salonImg,
    @required this.nameTxt,
    @required this.addressTxt,
    @required this.ratingTxt,
    this.cityTxt,
    @required this.priceTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            salonImg.isEmpty == true
                ? Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage("assets/images/1.jpg"),
                      ),
                    ),
                  )
                : Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          baseSalonImageURL + salonImg,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameTxt,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 11,
                            color: ColorConstants.kRatingColor,
                          ),
                          Text(
                            ratingTxt.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kRatingColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addressTxt + " , " + cityTxt,
                        style: GoogleFonts.roboto(
                          fontSize: 11,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                      Text(
                        "₹" + priceTxt,
                        style: GoogleFonts.roboto(
                          fontSize: 9,
                          color: ColorConstants.kGreyColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
