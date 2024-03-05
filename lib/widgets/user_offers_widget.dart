import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import '../common/color_constants.dart';

/*
Title:OffersWidget
Purpose:OffersWidget
Created By:18 Feb 2021
*/

class OffersWidget extends StatelessWidget {
  // final String salonImg;
  final String nameTxt;
  // final String addressTxt;
  // final double ratingTxt;
  final String priceTxt;
  final String discountTxt;

  const OffersWidget({
    Key key,
    // @required this.salonImg,
    @required this.nameTxt,
    // @required this.addressTxt,
    // @required this.ratingTxt,
    @required this.priceTxt,
    @required this.discountTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage(
                        "assets/images/1.jpg",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: ColorConstants.kBlueColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        discountTxt + "% OFF",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                          // Text(
                          //   ratingTxt.toString(),
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w700,
                          //     color: ColorConstants.kRatingColor,
                          //   ),
                          // )
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
                      // Text(
                      //   addressTxt,
                      //   style: GoogleFonts.roboto(
                      //     fontSize: 11,
                      //     color: ColorConstants.kGreyColor,
                      //   ),
                      // ),
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
