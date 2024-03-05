import 'package:flutter/material.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';

class CheckoutItemWidget extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final Function() onAddItemTap;
  CheckoutItemWidget({
    Key key,
    this.itemName,
    this.itemPrice,
    this.onAddItemTap,
  }) : super(key: key);

  @override
  _CheckoutItemWidgetState createState() => _CheckoutItemWidgetState();
}

class _CheckoutItemWidgetState extends State<CheckoutItemWidget> {
  bool isAddvisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setTextWithCustomFont(
                  widget.itemName,
                  12,
                  Colors.black,
                  FontWeight.w600,
                  1,
                ),
                SizedBox(
                  height: 5,
                ),
                setTextWithCustomFont(
                  "₹ " + widget.itemPrice,
                  12,
                  Colors.black,
                  FontWeight.w600,
                  1,
                ),
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
                    )),
                child: setbuttonWithChild(
                  Text(
                    "Add",
                    style: TextStyle(color: appYellowColor),
                  ),
                  () {
                    onItemAdd();
                  },
                  Colors.transparent,
                  0,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }

  onItemAdd() {
    setState(() {
      isAddvisible = false;
    });
    widget.onAddItemTap();
  }
}
