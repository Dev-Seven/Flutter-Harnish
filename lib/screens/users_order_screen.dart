import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/appointment_model.dart';
import 'package:harnishsalon/widgets/your_booking_widget.dart';

class UsersOrderScreen extends StatefulWidget {
  UsersOrderScreen({
    Key key,
  }) : super(key: key);

  @override
  _UsersOrderScreenState createState() => _UsersOrderScreenState();
}

class _UsersOrderScreenState extends State<UsersOrderScreen> {
  double height, width;
  bool isLoading = false;
  List<AppointmentModel> userBookingList = List.from([AppointmentModel()]);

  @override
  void initState() {
    super.initState();
    getBookingList();
  }

  getBookingList() {
    setState(() {
      isLoading = true;
    });
    postDataRequestWithToken(userBookingListApi, null, context).then(
      (value) => {
        setState(() {
          isLoading = false;
        }),
        if (value is List)
          {
            handleBookingListResponse(value),
          }
        else
          {
            showCustomToast(value.toString(), context),
          }
      },
    );
  }

  handleBookingListResponse(appointment) {
    print(appointment);
    var bookingArray = appointment
        .map<AppointmentModel>((json) => AppointmentModel.fromJson(json))
        .toList();
    setState(() {
      userBookingList = bookingArray;
    });
    print(userBookingList);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.kScreenBackColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.kScreenBackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Your Bookings",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.kBlackColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorConstants.kBlackColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Container(
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return YourBookingWidget(
                  dateTxt: "03 Feb 2020",
                  profileImg: "assets/images/1.jpg",
                  barberNameTxt: "Barber Name",
                  serviceTxt: "Hair Color",
                  ratingTxt: 4.5,
                  amountTxt: 1299.00,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
