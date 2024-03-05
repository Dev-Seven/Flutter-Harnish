import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';

class PackageCheckoutItemWidget extends StatefulWidget {
  final String packageName;
  final String packagePrice;
  final String packageDiscount;
  final Function() onAddPackageTap;
  PackageCheckoutItemWidget({
    Key key,
    this.packageName,
    this.packagePrice,
    this.packageDiscount,
    this.onAddPackageTap,
  }) : super(key: key);

  @override
  _PackageCheckoutItemWidgetState createState() =>
      _PackageCheckoutItemWidgetState();
}

class _PackageCheckoutItemWidgetState extends State<PackageCheckoutItemWidget> {
  bool isAddvisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setTextWithCustomFont(
                  widget.packageName,
                  12,
                  Colors.black,
                  FontWeight.w600,
                  1,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    setTextWithCustomFont(
                      "₹ " + widget.packagePrice,
                      12,
                      Colors.black,
                      FontWeight.w600,
                      1,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Stack(
                      children: [
                        setTextWithCustomFont(
                          "₹ " + widget.packageDiscount,
                          12,
                          Colors.grey,
                          FontWeight.w600,
                          1,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 55,
                          height: 17,
                          child: Text(
                            "----",
                            style: TextStyle(height: 0.5, color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Visibility(
              visible: isAddvisible,
              child: Container(
                width: 70,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(
                    color: appYellowColor,
                    width: 1,
                  ),
                ),
                child: setbuttonWithChild(
                  Text(
                    "Add",
                    style: TextStyle(color: appYellowColor),
                  ),
                  () {
                    onPackageAdd();
                  },
                  Colors.transparent,
                  0,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
    );
  }

  onPackageAdd() {
    setState(() {
      isAddvisible = false;
    });
    widget.onAddPackageTap();
  }
}
