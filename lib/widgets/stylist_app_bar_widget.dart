import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

class StylistAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String leadingTxt;
  final String titleTxt;
  final String suffixImg;
  final Color backColor;
  final Color textColor;

  @override
  final Size preferredSize;

  StylistAppBarWidget({
    Key key,
    this.leadingTxt,
    this.titleTxt,
    this.suffixImg,
    this.backColor,
    this.textColor,
  })  : preferredSize = Size.fromHeight(58),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: backColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: ColorConstants.kNameBackColor,
                borderRadius: BorderRadius.circular(26 / 2),
                border: Border.all(
                  color: ColorConstants.kWhiteColor,
                ),
              ),
              child: Center(
                child: Text(
                  leadingTxt,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.kWhiteColor,
                  ),
                ),
              ),
            ),
            Text(
              titleTxt,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            Image.asset(
              suffixImg,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
