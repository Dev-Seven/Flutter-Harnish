import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_entry_field/pin_entry_field.dart';
import 'package:pin_entry_field/pin_entry_style.dart';
import 'package:pin_entry_field/pin_input_type.dart';

/*
Title:OTPWidget
Purpose:OTPWidget
Required Params:onSubmit
Created By:Kalpesh Khandla
Created Date: 11 Feb 2021
*/

class OTPWidget extends StatefulWidget {
  final Function(String) onSubmit;
  final ValueChanged<String> onChanged;
  OTPWidget({
    Key key,
    @required this.onSubmit,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _OTPWidgetState createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldWidth: 60,
              fieldStyle: FieldStyle.box,
              keyboardType: TextInputType.number,
              outlineBorderRadius: 5,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: ColorConstants.kWhiteColor,
                borderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                disabledBorderColor: Colors.transparent,
                focusBorderColor: Colors.transparent,
              ),
              style: TextStyle(
                  color: ColorConstants.kBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
              ),
              onChanged: (code){
                widget.onSubmit(code);
              },
              onCompleted: (code){
                widget.onSubmit(code);
              },
            ),
          ),


          // PinEntryField(
          //   inputType: PinInputType.none,
          //   onSubmit: (text) {
          //      setState(() {
          //        print("kjfv" + text);
          //        widget.onSubmit(text);
          //      });
          //   },
          //   fieldCount: 4,
          //   fieldWidth: 60,
          //   height: 60,
          //   fieldStyle: PinEntryStyle(
          //     textStyle: GoogleFonts.roboto(
          //       color: ColorConstants.kBlackColor,
          //       fontSize: 20,
          //       fontWeight: FontWeight.w600,
          //     ),
          //     fieldBackgroundColor: ColorConstants.kWhiteColor,
          //     fieldBorderRadius: BorderRadius.circular(5),
          //     fieldPadding: 20,
          //   ),
          // )
        ],
      ),
    );
  }
}
