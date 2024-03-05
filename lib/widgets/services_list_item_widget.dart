import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';

class ServicesListItemWidget extends StatefulWidget {
  final String servicesNameTxt;
  final String priceTxt;

  ServicesListItemWidget({
    Key key,
    @required this.servicesNameTxt,
    @required this.priceTxt,
  }) : super(key: key);

  @override
  _ServicesListItemWidgetState createState() => _ServicesListItemWidgetState();
}

class _ServicesListItemWidgetState extends State<ServicesListItemWidget> {
  double height, width;
  bool isEdit = true;
  TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        height: 55,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.servicesNameTxt != null ? widget.servicesNameTxt : "",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.kBlackColor,
                ),
              ),
              // isEdit == false
              //     ? Container(
              //         height: 80,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //             color: ColorConstants.kGreyColor,
              //           ),
              //         ),
              //         child: Row(
              //           children: [
              //             Container(
              //               alignment: Alignment.center,
              //               height: 80,
              //               width: 80,
              //               child: Center(
              //                 child: Expanded(
              //                   child: TextFormFieldWidget(
              //                     hintTxt: " Rate",
              //                     keyboardType: TextInputType.number,
              //                     controllerName: amountController,
              //                     onChanged: (val) {
              //                       print(val);
              //                       print(amountController.text);
              //                     },
              //                     onSaved: (str) {
              //                       print("Saved");
              //                       print(amountController.text);
              //                     },
              //                     onEditingComplete: () {
              //                       print("Saved");
              //                       print(amountController.text);
              //                     },
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             GestureDetector(
              //               onTap: () {
              //                 String rate = amountController.text;
              //                 //  widget.onRateSubmitted(rate);
              //                 setState(() {
              //                   isEdit = true;
              //                 });
              //               },
              //               child: Container(
              //                 height: 80,
              //                 width: 40,
              //                 decoration: BoxDecoration(
              //                   color: ColorConstants.kBlueColor,
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.check,
              //                     size: 20,
              //                     color: ColorConstants.kWhiteColor,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   isEdit = true;
              //                 });
              //               },
              //               child: Container(
              //                 height: 80,
              //                 width: 40,
              //                 decoration: BoxDecoration(
              //                   color: ColorConstants.kRedColor,
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.clear,
              //                     size: 20,
              //                     color: ColorConstants.kWhiteColor,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Visibility(
              //         visible: isEdit,
              //         child: Row(
              //           children: [
              //             Text(
              //               "₹" + widget.priceTxt,
              //               style: GoogleFonts.roboto(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //                 color: ColorConstants.kBlackColor,
              //               ),
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   isEdit = false;
              //                 });
              //               },
              //               child: Container(
              //                 height: 100,
              //                 width: 80,
              //                 decoration: BoxDecoration(
              //                   color: ColorConstants.kBlueColor,
              //                   borderRadius: BorderRadius.circular(2),
              //                 ),
              //                 child: Center(
              //                   child: Text(
              //                     "EDIT",
              //                     style: GoogleFonts.roboto(
              //                       fontWeight: FontWeight.w300,
              //                       fontSize: 15,
              //                       color: ColorConstants.kWhiteColor,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
