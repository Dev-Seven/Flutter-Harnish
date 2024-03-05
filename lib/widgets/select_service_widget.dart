import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/model/salon_services_model.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';
import '../common/color_constants.dart';

class SelectServiceWidget extends StatefulWidget {
  final String servicesNameTxt;

  final Function(String) onRateSubmitted;
  final Function() onDeleteTap;

  SelectServiceWidget({
    Key key,
    @required this.servicesNameTxt,
    @required this.onRateSubmitted,
    @required this.onDeleteTap,
  }) : super(key: key);

  @override
  _SelectServiceWidgetState createState() => _SelectServiceWidgetState();
}

class _SelectServiceWidgetState extends State<SelectServiceWidget> {
  double height, width;
  bool isEdit = true;
  bool isAdd = true;
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
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.servicesNameTxt,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.kBlackColor,
                ),
              ),

              isEdit == false
                  ? Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: ColorConstants.kGreyColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: 80,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintTxt: " Rate",
                                    keyboardType: TextInputType.number,
                                    controllerName: amountController,
                                    onChanged: (val) {
                                      print(val);
                                      print(amountController.text);
                                    },
                                    onSaved: (val) {
                                      print("Saved");
                                      print(amountController.text);
                                    },
                                    onEditingComplete: () {
                                      print("Saved");
                                      print(amountController.text);
                                    },
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              String rate = amountController.text;
                              widget.onRateSubmitted(rate);
                              setState(() {
                                isEdit = true;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 40,
                              decoration: BoxDecoration(
                                color: ColorConstants.kBlueColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: 20,
                                  color: ColorConstants.kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEdit = true;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 40,
                              decoration: BoxDecoration(
                                color: ColorConstants.kRedColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.clear,
                                  size: 20,
                                  color: ColorConstants.kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Visibility(
                      visible: isEdit,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEdit = false;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: ColorConstants.kBlueColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ColorConstants.kBlueColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
