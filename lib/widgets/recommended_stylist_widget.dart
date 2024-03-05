import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import 'package:harnishsalon/screens/SalonDetailScreen.dart';

class RecommendedStylistWidget extends StatelessWidget {
  final String profileImg;
  final String nameTxt;
  final int ratingTxt;

  const RecommendedStylistWidget({
    Key key,
     @required this.profileImg,
    @required this.nameTxt,
    @required this.ratingTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 62,
          width: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(62 / 2),
            border: Border.all(
              color:appYellowColor,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 31,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              baseImageURL + profileImg,
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            nameTxt,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ColorConstants.kBlackColor,
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 10,
              color: ColorConstants.kRatingColor,
            ),
            Text(
              ratingTxt.toString(),
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kRatingColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
