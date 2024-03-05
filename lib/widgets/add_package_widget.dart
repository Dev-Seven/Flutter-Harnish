import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

/*
Title:AddpackageWidget
Purpose:AddpackageWidget
Created By:16 Feb 2021
*/

class AddpackageWidget extends StatefulWidget {
  final String itemName;
  final String discountedAmount;
  final String actualAmount;
  final Function() onDeleteTap;
  AddpackageWidget({
    Key key,
    @required this.itemName,
    @required this.discountedAmount,
    @required this.actualAmount,
    @required this.onDeleteTap,
  }) : super(key: key);

  @override
  _AddpackageWidgetState createState() => _AddpackageWidgetState();
}

class _AddpackageWidgetState extends State<AddpackageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: ColorConstants.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.itemName,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: ColorConstants.kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "₹" + widget.actualAmount,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: ColorConstants.kGreyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.discountedAmount + " % Off ",
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        color: ColorConstants.kBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                widget.onDeleteTap();
              },
              child: Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.kBlueColor,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "Delete",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: ColorConstants.kBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
