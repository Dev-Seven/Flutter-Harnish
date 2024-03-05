
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/Constant.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/widgets/your_booking_widget.dart';

class UserReviewScreen extends StatefulWidget {
  UserReviewScreen({Key key}) : super(key: key);

  @override
  _UserReviewScreenState createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  TextEditingController txtNotes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kWhiteColor,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              YourBookingWidget(
                dateTxt: "03 Feb 2020",
                profileImg: "assets/images/1.jpg",
                barberNameTxt: "John Hair Stylist",
                serviceTxt: "Hair Color",
                ratingTxt: 4.5,
                amountTxt: 1299.00,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                alignment: Alignment.topLeft,
                child: setTextWithCustomFont(
                    "Give Rating", 16, Colors.black, FontWeight.w800, 1),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width - 30,
                height: 80,
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  itemSize: Device.screenWidth / 8,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                alignment: Alignment.topLeft,
                child: setTextWithCustomFont(
                    "Add Photo", 16, Colors.black, FontWeight.w800, 1),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Center(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload),
                        SizedBox(
                          height: 5,
                        ),
                        setTextWithCustomFont(
                            "Add Photo", 13, Colors.black, FontWeight.w500, 1),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                alignment: Alignment.topLeft,
                child: setTextWithCustomFont(
                    "Write a review", 16, Colors.black, FontWeight.w800, 1),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: setTextFieldDynamic(
                        txtNotes,
                        "Would you like to write anything about barber services, behaviour or etc..",
                        false,
                        TextInputType.text,
                        16,
                        false,
                        "",
                        () {}),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                child: setbuttonWithChild(
                    setTextWithCustomFont(
                        "Submit review", 16, Colors.white, FontWeight.w800, 1),
                    () {},
                    appYellowColor,
                    5),
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// TextEditingController controller,
//     String hintText,
//     bool secureEntry,
//     TextInputType inputType,
//     double fontSize,
//     bool validtion,
//     String errorMSg,
//     Function onchange
