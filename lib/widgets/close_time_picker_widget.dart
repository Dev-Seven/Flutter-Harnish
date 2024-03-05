import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';

class CloseTimePickerWidget extends StatefulWidget {
  final Function() closeTimePickerTap;
  final String closeTime;
  CloseTimePickerWidget({
    Key key,
    @required this.closeTimePickerTap,
     this.closeTime = "00:00",
  }) : super(key: key);

  @override
  _CloseTimePickerWidgetState createState() => _CloseTimePickerWidgetState();
}

class _CloseTimePickerWidgetState extends State<CloseTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          widget.closeTimePickerTap();
          //_showTimePicker(context, true);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          alignment: Alignment.center,
          child: setTextWithCustomFont(
            widget.closeTime != null ? widget.closeTime : "00:00",
            14,
            textBlackColor,
            FontWeight.w900,
            1.2,
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(210, 210, 210, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          height: 35,
        ),
      ),
    );
  }
}
