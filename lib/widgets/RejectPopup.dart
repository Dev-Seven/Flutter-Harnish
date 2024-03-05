import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';

class RejectRequestPopup extends StatefulWidget {
  @override
  _RejectRequestPopupState createState() => _RejectRequestPopupState();
}

class _RejectRequestPopupState extends State<RejectRequestPopup> {
  TextEditingController txtReason1 = new TextEditingController();
  TextEditingController txtReason2 = new TextEditingController();
  TextEditingController txtReason3 = new TextEditingController();
  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.kScreenBackColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      height: 350,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          setTextWithCustomFont("Please specify reason for reject request", 12,
              Colors.grey, FontWeight.w400, 1.5),
          Spacer(),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  new Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Waiting queue is full',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: [
                  new Radio(
                    value: 1,
                    groupValue: _radioValue2,
                    onChanged: _handleRadioValueChange2,
                  ),
                  new Text(
                    'I am busy With another client',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  new Radio(
                    value: 2,
                    groupValue: _radioValue3,
                    onChanged: _handleRadioValueChange3,
                  ),
                  new Text(
                    'Salon is about to close',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          TextButtonWidget(
            btnTxt: "Submit",
            btnbackColor: ColorConstants.kButtonBackColor,
            btnOntap: () {
              print("Button Presses");
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (builder) =>
              //         UserOTPScreen(
              //       mobileTxt:
              //           mobileController.text,
              //     ),
              //   ),
              // );
            },
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue3 = -1;
      _radioValue2 = -1;
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue1 = -1;
      _radioValue3 = -1;
      _radioValue2 = value;

      switch (_radioValue1) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue1 = -1;
      _radioValue2 = -1;
      _radioValue3 = value;

      switch (_radioValue1) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }
}
