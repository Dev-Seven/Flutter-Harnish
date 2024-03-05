import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controllerName;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintTxt;
  final Function(String) onChanged;
  final Function(String) onSaved;
  final bool obscureText;
  final TextInputFormatter inputFormatters;
  final bool isPrefixIcon;
  final Function() onEditCompleteTap;
  final Function () onTextFormFieldTap;

  TextFormFieldWidget({
    Key key,
    @required this.controllerName,
    @required this.hintTxt,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.isPrefixIcon = false,
    this.focusNode,
    GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    FormFieldValidator<String> validator,
    this.inputFormatters,
    this.onEditCompleteTap,
    this.onTextFormFieldTap
    // this.onFieldSubmittedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: ColorConstants.kWhiteColor,
      ),
      child: TextFormField(
        autofocus: false,
        inputFormatters: [],
        obscureText: obscureText,
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: ColorConstants.kBlackColor,
        ),
        controller: controllerName,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
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
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.kBlackColor,
          ),
          focusedBorder: InputBorder.none,
          focusColor: ColorConstants.kGreenColor,
        ),
        onChanged: (str) {
          onChanged(str);
          // To do
        },
        onSaved: (str) {
          print(str);
          onSaved(str);
        },
        onEditingComplete: () {},
      
        onTap: (){
          onTextFormFieldTap();

        },
      ),
    );
  }
}
