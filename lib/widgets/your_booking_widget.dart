import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/screens/UserReviewScreen.dart';

import '../common/color_constants.dart';

/*
Title:YourBookingWidget
Purpose:OffersWidget
Created By:18 Feb 2021
*/

class YourBookingWidget extends StatelessWidget {
  final String dateTxt;
  final String profileImg;
  final String barberNameTxt;
  final String serviceTxt;
  final double ratingTxt;
  final double amountTxt;

  const YourBookingWidget({
    Key key,
    this.dateTxt,
    this.profileImg,
    this.barberNameTxt,
    this.serviceTxt,
    this.ratingTxt,
    this.amountTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.kWhiteColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTxt,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: ColorConstants.kGreyColor,
                    ),
                  ),
                  Text(
                    "PAID",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kGreenColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.3,
              color: ColorConstants.kBlackColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40 / 2),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              profileImg,
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
                          Row(
                            children: [
                              Text(
                                barberNameTxt,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kBlackColor,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: ColorConstants.kratingStarColor,
                                size: 18,
                              ),
                              Text(
                                ratingTxt.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.kratingStarColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Black Salon ($serviceTxt)",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: ColorConstants.kBlackColor,
                            ),
                          ),
                          // Text(
                          //   serviceTxt,
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 12,
                          //     color: ColorConstants.kBlackColor,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹" + amountTxt.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.kBlackColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => UserReviewScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 20,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorConstants.kReviewBorderColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Review",
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: ColorConstants.kratingStarColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
