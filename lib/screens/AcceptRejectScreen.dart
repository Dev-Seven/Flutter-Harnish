import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/RejectPopup.dart';

class AcceptRejectScreen extends StatefulWidget {
  AcceptRejectScreen({Key key}) : super(key: key);

  @override
  _AcceptRejectScreenState createState() => _AcceptRejectScreenState();
}

class _AcceptRejectScreenState extends State<AcceptRejectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kScreenBackColor,
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
            "Welcome, Enrich Salon", 16, Colors.white, FontWeight.w600, 1),
        actions: [
          // Image.asset(
          //   "assets/images/bell.png",
          //   height: 16,
          // ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                ClipOval(
                  child: Container(
                    child: setImageHeightFit("hairsalon.jpg"),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: setTextWithCustomFont(
                      "Jack Sparrow", 16, Colors.black, FontWeight.w500, 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: setTextWithCustomFont(
                      "NEW", 16, Colors.white, FontWeight.w500, 1),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white,
                  height: 46,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      setTextWithCustomFont(
                          "Processing", 14, Colors.black, FontWeight.w400, 1),
                      Spacer(),
                      FittedBox(
                        child: setImageName("iconCall.png", 25, 25),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  color: Colors.white,
                  height: 178,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            setTextWithCustomFont("Today, 16:30", 14,
                                Colors.black, FontWeight.w400, 1),
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              width: 70,
                              height: 25,
                              child: Text(
                                "2hr left",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            setTextWithCustomFont("Hair Cut", 14, Colors.black,
                                FontWeight.w400, 1),
                            Spacer(),
                            setTextWithCustomFont("₹ 1299.00", 14, Colors.black,
                                FontWeight.w600, 1),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            setTextWithCustomFont("Hair Shampoo", 14,
                                Colors.black, FontWeight.w400, 1),
                            Spacer(),
                            setTextWithCustomFont("₹ 1299.00", 14, Colors.black,
                                FontWeight.w600, 1),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            setTextWithCustomFont("Hair Color", 14,
                                Colors.black, FontWeight.w400, 1),
                            Spacer(),
                            setTextWithCustomFont("₹ 1299.00", 14, Colors.black,
                                FontWeight.w600, 1),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Spacer(),
                Container(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      setTextWithCustomFont(
                          "Total", 14, Colors.black, FontWeight.w400, 1),
                      Spacer(),
                      setTextWithCustomFont(
                          "₹ 1299.00", 14, Colors.black, FontWeight.w600, 1),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        height: 47,
                        child: setbuttonWithChild(
                            setTextWithCustomFont(
                                "REJECT", 14, Colors.black, FontWeight.w500, 1),
                            () {
                          openRejectResonePopup();
                        }, Colors.white, 4),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      // Expanded(
                      //     child: Container(
                      //   height: 47,
                      //   child: setbuttonWithChild(
                      //       setTextWithCustomFont(
                      //           "CONFIRM", 14, Colors.white, FontWeight.w500, 1),
                      //       () {
                      //     Navigator.pop(context);
                      //   }, ColorConstants.kButtonBackColor, 4),
                      // )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openRejectResonePopup() {
    showGeneralDialog(
      pageBuilder: (c, a, a2) {},
      barrierDismissible: true,
      useRootNavigator: true,
      barrierLabel: "0",
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder:
          (BuildContext context, Animation a, Animation b, Widget child) {
        return Transform.scale(
          scale: a.value,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: RejectRequestPopup(),
          ),
        );
      },
    );
  }
}
