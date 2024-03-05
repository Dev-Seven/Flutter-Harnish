import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/AcceptRejectScreen.dart';
import 'package:harnishsalon/widgets/select_service_widget.dart';

class NotificationListVC extends StatefulWidget {
  @override
  _NotificationListVCState createState() => _NotificationListVCState();
}

class _NotificationListVCState extends State<NotificationListVC> {
  final nameArray = [
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "John Sinha",
    "Shawn Ortiz",
    "Nishit Mistry",
    "Brandon Perry",
  ];

  final serviceArray = [
    "Requested for Hair Cut & Hair Wash",
    "Requested for Hair Color",
    "Requested for Hair Cut & Beard",
    "Requested for Hair Cut & Hair Wash",
    "Requested for Hair Cut & Hair Wash",
    "Requested for Hair Color",
    "Requested for Hair Cut & Beard",
    "Requested for Hair Cut & Hair Wash",
    "Requested for Hair Color",
    "Requested for Hair Cut",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(11),
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(Icons.close),
              ),
            ),
          ),
        ),
        backgroundColor: ColorConstants.kButtonBackColor,
        title: setTextWithCustomFont(
            "Notifications", 16, Colors.white, FontWeight.w600, 1),
        actions: [
          // Image.asset(
          //   "assets/images/bell.png",
          //   height: 16,
          // ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: nameArray.length,
          shrinkWrap: false,
          itemBuilder: (BuildContext context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              height: 70,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcceptRejectScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Center(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            setTextWithCustomFont(nameArray[index], 12,
                                Colors.black, FontWeight.w600, 1),
                            SizedBox(
                              height: 5,
                            ),
                            setTextWithCustomFont(serviceArray[index], 10,
                                Colors.black, FontWeight.w400, 1),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            setTextWithCustomFont("10/08/2020", 11,
                                Colors.black, FontWeight.w400, 1),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
