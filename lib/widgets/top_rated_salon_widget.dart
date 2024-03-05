import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/EmployeeWithSalonVC.dart';
import 'package:page_transition/page_transition.dart';

class TopRatedSalonWidget extends StatefulWidget {
  final String salonNameTxt;
  //final String salonImgName;
  //final String addressTxt;
 // final int ratingTxt;

  TopRatedSalonWidget({
    @required this.salonNameTxt,
   // @required this.salonImgName,
    // @required this.addressTxt,
  //  @required this.ratingTxt,
  });
  @override
  _TopRatedSalonWidgetState createState() => _TopRatedSalonWidgetState();
}

class _TopRatedSalonWidgetState extends State<TopRatedSalonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: EmployeeWithSalonVC(),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Stack(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: setImageNamePath("", "hairsalon.jpg"),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black.withAlpha(80),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      setTextWithCustomFont(
                       // "Enrich Salon",
                         widget.salonNameTxt != null ? widget.salonNameTxt : "",
                        16,
                        Colors.white,
                        FontWeight.w500,
                        1,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 11,
                            color: ColorConstants.kRatingColor,
                          ),
                          Text(
                            "5.0",

                            // widget.ratingTxt != null
                            //     ? widget.ratingTxt.toString()
                            //     : "",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kRatingColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      setTextWithLightCustomFont(
                        "Prahaladnagar, Ahmedabad",

                        //  widget.addressTxt,
                        14,
                        Colors.white,
                        FontWeight.w500,
                        1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ))
            ],
          ),
        ),
        // color: Colors.red,
      ),
    );
  }
}
