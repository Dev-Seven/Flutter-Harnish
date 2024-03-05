import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';

import 'package:harnishsalon/model/package_service_model.dart';
import 'package:harnishsalon/widgets/text_button_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_widget.dart';

class AddCustomServiceView extends StatefulWidget {
  @override
  _AddCustomServiceViewState createState() => _AddCustomServiceViewState();
}

class _AddCustomServiceViewState extends State<AddCustomServiceView> {
  TextEditingController serviceNameController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  bool isLoading = false;
  bool isRequestServiceEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.kScreenBackColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      height: 220,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          setTextField(
              serviceNameController,
              "Add New Services Name",
              false,
              TextInputType.text,
              isRequestServiceEmpty,
              msgEmptyRequestedServiceName,
              () => {
                    setState(() {
                      isRequestServiceEmpty = false;
                    })
                  },
              () {}),
          Spacer(),
          TextButtonWidget(
            btnTxt: "Request",
            btnbackColor: ColorConstants.kButtonBackColor,
            btnOntap: () {
              print("Button Presses");

              onServiceRequestSubmitted();
              // Navigator.of(context).pop();
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
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: ColorConstants.kButtonBackColor, width: 1.5)),
            height: 40,
            child: setbuttonWithChild(
                Text(
                  "Cancel",
                  style: TextStyle(color: ColorConstants.kButtonBackColor),
                ), () {
              Navigator.of(context).pop();
            }, Colors.white, 5),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  onServiceRequestSubmitted() async {
    if (serviceNameController.text.trim() == "") {
      setState(() {
        isRequestServiceEmpty = true;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    String service = serviceNameController.text;
    FormData param = FormData.fromMap({
      "service_name": service,
    });
    postDataRequestWithTokenSalon(serviceRequest, param, context).then((value) {
      setState(() {
        isLoading = false;
      });

      print(value);

      if (value is List) {
        _responseHandling(value);
      } else {
        showCustomToast(value.toString(), context);
        Navigator.of(context).pop();
      }
    });
  }

  _responseHandling(value) async {
    print(value);
    //PackageServiceModel allserviceModel = PackageServiceModel.fromJson(value);
    showCustomToast("Service Requested", context);
    Navigator.of(context).pop();
  }
}
