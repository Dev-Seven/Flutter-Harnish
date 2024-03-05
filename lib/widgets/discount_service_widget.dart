import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/color_constants.dart';

class DiscountServiceWidget extends StatelessWidget {
  final String percentageTxt;
  final String servicesTxt;
  const DiscountServiceWidget({
    Key key,
    @required this.percentageTxt,
    @required this.servicesTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.kWhiteColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ColorConstants.kuserDiscountColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              percentageTxt + "%",
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: ColorConstants.kuserDiscountColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              servicesTxt,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: ColorConstants.kuserDiscountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
