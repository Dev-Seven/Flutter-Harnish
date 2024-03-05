import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

class OngoingItemWidget extends StatelessWidget {
  final String timeTxt;
  final String clientNameTxt;
  final String profileImg;
  final String serviceNameTxt;

  const OngoingItemWidget({
    Key key,
    this.timeTxt,
    this.clientNameTxt,
    this.profileImg,
    this.serviceNameTxt,
 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeTxt,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: ColorConstants.kTodayEarningColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.2,
              color: ColorConstants.kBorderColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          border: Border.all(
                            color: ColorConstants.kImageBorderColor,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                             // "assets/images/1.jpg",
                              profileImg,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientNameTxt != null ? clientNameTxt : "",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: ColorConstants.kBlackColor,
                            ),
                          ),
                          Text(
                            serviceNameTxt,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: ColorConstants.kBlackColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 20,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      color: ColorConstants.kGreenColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "ONGOING",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: ColorConstants.kWhiteColor,
                        ),
                      ),
                    ),
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
