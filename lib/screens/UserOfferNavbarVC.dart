import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/CheckOutScreen.dart';
import 'package:harnishsalon/widgets/discount_service_widget.dart';
import 'package:harnishsalon/widgets/text_form_field_prefix_widget.dart';
import 'package:harnishsalon/widgets/user_offers_widget.dart';
import 'package:page_transition/page_transition.dart';

import 'EmployeeWithSAlonVC.dart';

class UserOfferNavbarVC extends StatefulWidget {
  @override
  _UserOfferNavbarVCState createState() => _UserOfferNavbarVCState();
}

class _UserOfferNavbarVCState extends State<UserOfferNavbarVC> {
  TextEditingController searchController;
  double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kScreenBackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Offers",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            TextFormFieldPrefixWidget(
              hintTxt: "Search for location or Salon",
              keyboardType: TextInputType.number,
              prefixIcon: Icons.search,
              controllerName: searchController,
              onChanged: () {
                print("object");
              },
              onSaved: () {
                print("object");
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: height * 0.15 / 2,
              decoration: BoxDecoration(
                color: ColorConstants.kDashBoardColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(42 / 2),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage(
                                    "assets/images/1.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: ColorConstants.kOrangeColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: ColorConstants.kWhiteColor,
                                    ),
                                    Text(
                                      "4.8",
                                      style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        color: ColorConstants.kWhiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enrich Salon",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: ColorConstants.kWhiteColor,
                              ),
                            ),
                            Text(
                              "Its been 30 days to your service",
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: ColorConstants.kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: EmployeeWithSalonVC(),
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.1 / 3,
                            width: width * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: ColorConstants.kLogoBackColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "BOOK",
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: ColorConstants.kDiscountBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.close,
                          size: 15,
                          color: ColorConstants.kWhiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: height * 0.1 / 3,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: DiscountServiceWidget(
                      percentageTxt: "20",
                      servicesTxt: "Haircut",
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return OffersWidget(
                   // salonImg: "assets/images/1.jpg",
                    nameTxt: "Black Salon",
                    // addressTxt: "Drive in Road,Ahmedabad",
                    priceTxt: "120 for Hair",
                    //  ratingTxt: 5.0,
                    discountTxt: "50% Beard",
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
