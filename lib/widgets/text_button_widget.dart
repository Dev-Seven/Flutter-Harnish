import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

class TextButtonWidget extends StatelessWidget {
  final String btnTxt;
  final Color btnbackColor;
  final Function() btnOntap;
  final Color textColor;

  const TextButtonWidget({
    Key key,
    this.btnTxt,
    this.btnbackColor,
    this.btnOntap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: btnbackColor,
      ),
      child: TextButton(
        onPressed: btnOntap,
        child: Text(
          btnTxt,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: ColorConstants.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
