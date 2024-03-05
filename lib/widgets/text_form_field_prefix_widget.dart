import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

class TextFormFieldPrefixWidget extends StatelessWidget {
  final TextEditingController controllerName;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintTxt;
  final Function() onChanged;
  final Function() onSaved;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final Color hintTextColor;

  TextFormFieldPrefixWidget({
    Key key,
    @required this.controllerName,
    @required this.hintTxt,
    this.hintTextColor,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: ColorConstants.kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: TextFormField(
        autofocus: false,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(
          fontSize: 16,
          color: ColorConstants.kBlackColor,
        ),
        controller: controllerName,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Color.fromRGBO(95, 95, 95, 1),
            size: 22,
          ),
          suffixIcon: Icon(
            suffixIcon,
            size: 13,
            color: ColorConstants.kBlackColor,
          ),
          contentPadding: EdgeInsets.all(15),
          errorStyle: GoogleFonts.roboto(
            color: ColorConstants.kRedColor,
            fontWeight: FontWeight.w700,
          ),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: hintTxt,
          hintStyle: GoogleFonts.roboto(
            fontSize: 16,
            color: hintTextColor,
          ),
          focusedBorder: InputBorder.none,
          focusColor: ColorConstants.kGreenColor,
        ),
        onChanged: (str) {
          onChanged();
          // To do
        },
        onSaved: (str) {
          //  To do
          onSaved();
        },
      ),
    );
  }
}
