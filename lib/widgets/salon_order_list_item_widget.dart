import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/AcceptRejectScreen.dart';
import 'package:harnishsalon/screens/appointmentDetailVC.dart';

/*
Title:SalonOrderListItemWidget
Purpose:SalonOrderListItemWidget

Created By:17 Feb 2021
*/

class SalonOrderListItemWidget extends StatelessWidget {
  final String timeTxt;
  final String profileImg;
  final String nameTxt;
  final String serviceTxt;
  final String timeleftTxt;
  final bool isUpcoming;
  final BuildContext context;

  const SalonOrderListItemWidget({
    Key key,
    @required this.timeTxt,
    @required this.profileImg,
    @required this.nameTxt,
    @required this.serviceTxt,
    @required this.timeleftTxt,
    @required this.context,
    this.isUpcoming = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AcceptRejectScreen(),
            ),
          );
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeTxt,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.kTodayEarningColor,
                      ),
                    ),
                    isUpcoming
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              _showCancelPopup();
                            },
                            child: Container(
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.kRedColor,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: ColorConstants.kBorderColor.withOpacity(0.18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(37 / 2),
                                border: Border.all(
                                  color: ColorConstants.kImageBorderColor,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    profileImg,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: ColorConstants.kBlueColor,
                                  borderRadius: BorderRadius.circular(10 / 2),
                                ),
                              ),
                            ),
                          ],
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
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.kBlackColor,
                              ),
                            ),
                            Text(
                              serviceTxt,
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.kBlackColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 20,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: ColorConstants.kSalonItemColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          timeleftTxt,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.kWhiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showCancelPopup() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm'),
            content: Text('Are you sure want to cancel this appointment?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                /*Navigator.of(context).pop(true)*/

                child: Text(
                  'No',
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                /*Navigator.of(context).pop(true)*/

                child: Text(
                  'Yes',
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
