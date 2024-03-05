import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';

class StartTimePickerWidget extends StatefulWidget {
  final Function() startTimePickerTap;
  String startTime;
  StartTimePickerWidget({
    Key key,
    @required this.startTimePickerTap,
    this.startTime,
  }) : super(key: key);

  @override
  _StartTimePickerWidgetState createState() => _StartTimePickerWidgetState();
}

class _StartTimePickerWidgetState extends State<StartTimePickerWidget> {
  String startTime = "00:00";

  @override
  void initState() {
    super.initState();
    // widget.startTime = defaultStartTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          widget.startTimePickerTap();
          //_showTimePicker(context, true);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          alignment: Alignment.center,
          child: setTextWithCustomFont(
            widget.startTime != null ? widget.startTime : "00:00",
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
