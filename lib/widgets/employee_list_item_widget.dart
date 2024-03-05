import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/EditEmployeeDetail.dart';

/*
Title:EmployeeListItemWidget
Purpose:EmployeeListItemWidget
Created By:17 Feb 2021
*/

class EmployeeListItemWidget extends StatefulWidget {
  final String earningAmountTxt;
  final String nameTxt;
  final String profileImg;
  final bool isIdle;
  
  final String custNameTxt;
  final String stylistNameTxt;
  final double custRatingTxt;
  final double stylistRatingTxt;
  final String custFeedbackTxt;
  final String stylistFeedbackTxt;

  const EmployeeListItemWidget({
    Key key,
    @required this.earningAmountTxt,
    @required this.nameTxt,
    @required this.profileImg,
    this.isIdle = true,
 
    @required this.custNameTxt,
    @required this.stylistNameTxt,
    @required this.custRatingTxt,
    @required this.stylistRatingTxt,
    @required this.custFeedbackTxt,
    @required this.stylistFeedbackTxt,
  }) : super(key: key);

  @override
  _EmployeeListItemWidgetState createState() => _EmployeeListItemWidgetState();
}

class _EmployeeListItemWidgetState extends State<EmployeeListItemWidget> {
  bool isFeedbackVisible = false;
  double height, width;
  @override
  Widget build(BuildContext context) {
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
                    "Today Earning:" + widget.earningAmountTxt,
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: ColorConstants.kTodayEarningColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEmployeeDetail(),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Edit",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: ColorConstants.kBlueColor,
                        ),
                      ),
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
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                children: [
                  Row(
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
                                color: ColorConstants.kGreyColor,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    baseImageURL + widget.profileImg),
                                fit: BoxFit.cover,
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
                              Row(
                                children: [
                                  Text(
                                    widget.nameTxt,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  widget.isIdle
                                      ? Text(
                                          "Idle",
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: ColorConstants.kRedColor,
                                          ),
                                        )
                                      : Text(
                                          "Vacant",
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: ColorConstants.kGreenColor,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: widget.custRatingTxt,
                                    minRating: 1,
                                    itemSize: 15,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.custRatingTxt.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Ratings",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFeedbackVisible = !isFeedbackVisible;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              5,
                              isFeedbackVisible ? 3 : 2,
                              5,
                              isFeedbackVisible ? 3 : 2),
                          decoration: BoxDecoration(
                            color: isFeedbackVisible
                                ? ColorConstants.kBlueColor
                                : ColorConstants.kWhiteColor,
                            border: isFeedbackVisible
                                ? Border.all(
                                    color: ColorConstants.kWhiteColor,
                                  )
                                : Border.all(
                                    color: ColorConstants.kBlueColor,
                                  ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: isFeedbackVisible
                                ? Text(
                                    "Collapse",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: ColorConstants.kWhiteColor,
                                    ),
                                  )
                                : Text(
                                    "VIEW",
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: ColorConstants.kBlueColor,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isFeedbackVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.kScreenBackColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Ratings",
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      color: ColorConstants.kTodayEarningColor,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 0.2,
                                color: ColorConstants.kBorderColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.custNameTxt,
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.kTodayEarningColor,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: widget.stylistRatingTxt,
                                    minRating: 1,
                                    itemSize: 15,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                    "10/12/2020",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ColorConstants.kTodayEarningColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.custFeedbackTxt,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: ColorConstants.kBlackColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.stylistNameTxt,
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.kTodayEarningColor,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    itemSize: 15,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                    "10/12/2020",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ColorConstants.kTodayEarningColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.custFeedbackTxt,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: ColorConstants.kBlackColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
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
