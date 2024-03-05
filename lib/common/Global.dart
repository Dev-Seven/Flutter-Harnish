library constants;

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/model/salon_model.dart';
import 'package:harnishsalon/model/stylist_model.dart';

import 'package:harnishsalon/model/user_model.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

// import 'package:loading/loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant.dart';

var isSubscriptionDone = true;
var isStripeVerify = true;
var isBankDetailAdded = true;
var isHomeNeedsUpdate = false;
var isStylist = false;

var hcompanyNameFilter = "";
var hcityNameFilter = "";
var hstateNameFilter = "";

var scompanyNameFilter = "";
var scityNameFilter = "";
var sstateNameFilter = "";

UserModel userObj;
SalonModel salonObj;
StylistModel stylistObj;

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

String getMaskedEmail(String email) {
  var maskedEmail = email;
  var maskedNewEmail = "";
  var end = "@";
  final startIndex = 0;
  final endIndex = maskedEmail.indexOf(end, startIndex);
  var emailStartText = maskedEmail.substring(0, endIndex);
  for (var i = 0; i < emailStartText.length; i++) {
    maskedNewEmail = maskedNewEmail + ((i < 3) ? emailStartText[i] : "*");
  }
  return maskedNewEmail =
      maskedNewEmail + maskedEmail.substring(endIndex, maskedEmail.length);
}

String getMaskedCardNumber(String email) {
  var maskedEmail = email;
  var maskedNewEmail = "";
  final endIndex = email.length;
  var emailStartText = maskedEmail.substring(0, endIndex);
  for (var i = 0; i < emailStartText.length; i++) {
    maskedNewEmail = maskedNewEmail +
        ((i > emailStartText.length - 5)
            ? emailStartText[i]
            : (emailStartText[i] == " ")
                ? " "
                : "•");
  }
  return maskedNewEmail;
  // return maskedNewEmail =
  //     maskedNewEmail + maskedEmail.substring(endIndex, maskedEmail.length);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

String validateMobile(String value) {
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

bool validatePassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

Widget myAppBar(String navTitle, BuildContext context, Image imgBackButton,
    bool isbackbutton) {
  return Platform.isIOS
      ? CupertinoNavigationBar(
          leading: isbackbutton
              ? Container(
                  alignment: Alignment.topLeft,
                  width: 40,
                  child: RawMaterialButton(
                    child: imgBackButton,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                )
              : SizedBox(),
          middle: setBoldfont(navTitle, 18, Colors.black),
          backgroundColor: Colors.white,
        )
      : AppBar(
          leading: isbackbutton
              ? RawMaterialButton(
                  child: imgBackButton,
                  onPressed: () => Navigator.of(context).pop(),
                )
              : SizedBox(),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.5,
          title: setBoldfont(navTitle, 18, Colors.black),
          backgroundColor: Colors.white,
        );
}

List<int> getAudioQuality() {
  return [8000, 16000, 32000];
}

Widget myAppBarWithBebas(String navTitle, BuildContext context,
    Image imgBackButton, bool isbackbutton) {
  return AppBar(
    leading: isbackbutton
        ? RawMaterialButton(
            child: imgBackButton,
            onPressed: () => Navigator.of(context).pop(),
          )
        : SizedBox(),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    // title: setBebasfont(navTitle, 18, Colors.black),
    backgroundColor: Colors.white,
  );
}

String getDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  } else {
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

bool isAppPurchased = false;

setButton(String text, double fontSize, Color fontColor, FontWeight weight,
    Function onTap, Color burttonColor, double buttonRadius) {
  return Platform.isIOS
      ? Container(
          child: CupertinoButton(
            child: setBoldfont(text, fontSize, fontColor),
            onPressed: onTap,
            color: burttonColor,
            borderRadius: new BorderRadius.circular(buttonRadius),
          ),
        )
      : Container(
          child: MaterialButton(
            onPressed: onTap,
            child: setTextWithCustomFont(text, fontSize, fontColor, weight, 1),
            color: burttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius)),
          ),
        );
}

// Future<void> showNotificationImportance(
//     int id, NotificationImportance importance) async {
//   String importanceKey = importance.toString().toLowerCase().split('.').last;
//   String channelKey = 'importance_' + importanceKey + '_channel';
//   String title = 'Importance levels (' + importanceKey + ')';
//   String body = 'Test of importance levels to ' + importanceKey;
//
//   await AwesomeNotifications().setChannel(NotificationChannel(
//       channelKey: channelKey,
//       channelName: title,
//       channelDescription: body,
//       importance: importance,
//       defaultColor: Colors.red,
//       ledColor: Colors.red,
//       vibrationPattern: highVibrationPattern));
// }

showGreenToast(String text, BuildContext context) {
  // showToast(text,
  //     context: context,
  //     backgroundColor: appGreenColor,
  //     textStyle:
  //         TextStyle(color: Colors.white, fontFamily: RegFont, fontSize: 15),
  //     animation: StyledToastAnimation.slideFromBottom,
  //     reverseAnimation: StyledToastAnimation.slideFromBottom,
  //     position: StyledToastPosition.bottom,
  //     endOffset: Offset(0.0, -1.5),
  //     textPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  //     axis: Axis.vertical,
  //     duration: Duration(seconds: 3));
}

showCustomToast(String text, BuildContext context) {
  showToast(
    text,
    context: context,
    backgroundColor: ColorConstants.kGreyColor,
    textStyle: TextStyle(
        color: ColorConstants.kWhiteColor,
        fontFamily: RegFont,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.bottom,
    endOffset: Offset(0.0, 1.5),
    borderRadius: BorderRadius.all(Radius.circular(2)),
    textPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
    axis: Axis.vertical,
    duration: Duration(seconds: 5),
  );
}

setbuttonWithChild(
    Widget child, Function onTap, Color burttonColor, double buttonRadius) {
  return Container(
    child: FlatButton(
      disabledColor: Colors.grey,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onTap,
      child: child,
      color: burttonColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius)),
    ),
  );
}

setAuthTextField(TextEditingController controller, String hintText,
    bool secureEntry, bool validtion, String errorMSg, Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
        onChanged: (value) => {onchange()},
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setAuthTextFieldMaxLength(
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    bool validtion,
    String errorMSg,
    Function onchange,
    int lenght) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
        maxLength: lenght,
        onChanged: (value) => {onchange()},
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setButtonIndicator(double strokeWidth, Color backColor) {
  return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(backColor));
}

Future<bool> getRememberMeFlag() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('rememberMe') != null) {
    return prefs.getBool('rememberMe');
  } else {
    return false;
  }
}

Future<String> getStringValueWithKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString(key) != null) {
    return prefs.getString(key);
  } else {
    return "";
  }
}

setStringValueWithKey(String value, String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

setRememberMeFlag(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("rememberMe", value);
}

setUserData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user", json.encode(userObj));
}

clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user", null);
}

Future getuserData() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('user') != null) {
    UserModel user =
        UserModel.fromJson(json.decode(prefs.getString('user') ?? ''));
    userObj = user;
    return userObj;
  } else {
    return null;
  }
}

setLoadingState(bool isLoading) {
  return isLoading
      ? Container(
          width: Device.screenWidth,
          height: Device.screenHeight,
          color: Colors.transparent,
        )
      : Container();
}

setTextFieldDynamic(
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    double fontSize,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        maxLines: 3,
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: fontSize,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setTextField(
  TextEditingController controller,
  String hintText,
  bool secureEntry,
  TextInputType inputType,
  bool validtion,
  String errorMSg,
  Function onchange,
  Function ontextformTap,
) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        onTap: () {
          ontextformTap();
        },
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 0),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(164, 165, 169, 1),
            fontFamily: LightFont,
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setDigitTextField(
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setTextFieldMaxNumber(
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    bool validtion,
    String errorMSg,
    Function onchange,
    int maxLength) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        maxLength: maxLength,
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          counterText: "",
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(164, 165, 169, 1),
            fontFamily: LightFont,
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
          // hintStyle: TextStyle(
          //     color: Color.fromRGBO(164, 165, 169, 1),
          //     fontFamily: RegFont,
          //     fontSize: 16,
          //     fontWeight: FontWeight.w200),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setMaskedDigitTextField(
    TextInputFormatter formattor,
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        inputFormatters: [formattor],
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange(value)},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setPriceMaskedTextField(
    TextInputFormatter formattor,
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        inputFormatters: [formattor],
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange(value)},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setMaskedTextField(
    TextInputFormatter formattor,
    TextEditingController controller,
    String hintText,
    bool secureEntry,
    TextInputType inputType,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        inputFormatters: [formattor],
        obscureText: secureEntry,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        keyboardType: inputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: validtion ? errorMSg : null,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(244, 247, 250, 1), width: 1),
          ),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromRGBO(164, 165, 169, 1),
              fontFamily: RegFont,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
          ),
        ),
        cursorColor: Colors.black,
      ));
}

setTextFieldwithTrelingImage(
    TextEditingController controller,
    String hintText,
    bool hasTreling,
    String imageName,
    Function onDropDownTap,
    Color backgroundColor,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        decoration: InputDecoration(
            errorMaxLines: 2,
            errorText: validtion ? errorMSg : null,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 247, 250, 1), width: 1),
            ),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide:
                    new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
            filled: true,
            fillColor: backgroundColor,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Color.fromRGBO(164, 165, 169, 1),
                fontFamily: RegFont,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
            ),
            suffixIcon: hasTreling
                ? Container(
                    width: 40,
                    height: 40,
                    child: setbuttonWithChild(setImageName(imageName, 20, 20),
                        onDropDownTap, Colors.transparent, 0),
                  )
                : null),
        cursorColor: Colors.black,
      ));
}

setReadableTextFieldwithTrelingImage(
    TextEditingController controller,
    String hintText,
    bool hasTreling,
    String imageName,
    Function onDropDownTap,
    Color backgroundColor,
    FocusNode node,
    bool validation,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        focusNode: node,
        readOnly: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        decoration: InputDecoration(
            errorMaxLines: 2,
            errorText: validtion ? errorMSg : null,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 247, 250, 1), width: 1),
            ),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide:
                    new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
            filled: true,
            fillColor: backgroundColor,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Color.fromRGBO(164, 165, 169, 1),
                fontFamily: RegFont,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
            ),
            suffixIcon: hasTreling
                ? Container(
                    width: 40,
                    height: 40,
                    child: setbuttonWithChild(setImageName(imageName, 20, 20),
                        onDropDownTap, Colors.transparent, 0),
                  )
                : null),
        cursorColor: Colors.black,
      ));
}

setReadableTextFieldwithtrelignGreyFont(
    TextEditingController controller,
    String hintText,
    bool hasTreling,
    String imageName,
    Function onDropDownTap,
    Color backgroundColor,
    FocusNode node,
    bool validation,
    bool validtion,
    String errorMSg,
    Function onchange) {
  return Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.red,
      ),
      child: TextField(
        style: TextStyle(color: Colors.grey),
        focusNode: node,
        readOnly: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        onChanged: (value) => {onchange()},
        // autofocus: true,
        decoration: InputDecoration(
            errorMaxLines: 2,
            errorText: validtion ? errorMSg : null,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(15, 30, 0, 0),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(244, 247, 250, 1), width: 1),
            ),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide:
                    new BorderSide(color: Color.fromRGBO(244, 247, 250, 1))),
            filled: true,
            fillColor: backgroundColor,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Color.fromRGBO(164, 165, 169, 1),
                fontFamily: RegFont,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(244, 247, 250, 1)),
            ),
            suffixIcon: hasTreling
                ? Container(
                    width: 40,
                    height: 40,
                    child: setbuttonWithChild(setImageName(imageName, 20, 20),
                        onDropDownTap, Colors.transparent, 0),
                  )
                : null),
        cursorColor: Colors.grey,
      ));
}

setButtonwithImage(
    String imageName,
    Color imageColor,
    double width,
    double height,
    Function onTap,
    double buttonRadius,
    double buttonWidth,
    double buttonHeight) {
  return Container(
    width: buttonWidth,
    height: buttonHeight,
    child: MaterialButton(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      disabledColor: Colors.transparent,
      onPressed: onTap,
      child: setImageName(imageName, width, height),
    ),
  );
}

setBorderButton(
    String text,
    double fontSize,
    Color fontColor,
    FontWeight weight,
    Function onTap,
    Color burttonColor,
    double buttonRadius) {
  return Container(
    decoration: BoxDecoration(
        color: burttonColor,
        border: Border.all(
          color: appBlueColor,
          width: 2,
        ),
        borderRadius: new BorderRadius.all(Radius.circular(4))),
    child:
        setButton(text, 16, fontColor, FontWeight.w700, onTap, burttonColor, 4),
  );
}

String getDurationWithMicroSeconds(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String twoDigitMiliSeconds = twoDigits(duration.inMilliseconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds:$twoDigitMiliSeconds";
  } else {
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

getCalculated(double value) {
  double devicePixelRatio = ui.window.devicePixelRatio;
  ui.Size size = ui.window.physicalSize;
  double height = size.height;
  double screenHeight = height / devicePixelRatio;

  if (screenHeight >= 800.0 && screenHeight <= 895.0) {
    // For devices Iphone 10 range. For android hd.
    return 667.0 * (value / 568.0);
  } else if (screenHeight >= 896.0) {
    // For XR and XS max.
    return 736.0 * (value / 568.0);
  } else {
    // For other.
    return screenHeight * (value / 568.0);
  }
}

double getSizeByDevice(int phoneInput, int incresedCount) {
  if (Device.get().isTablet) {
    return phoneInput + incresedCount.toDouble();
  } else {
    return phoneInput.toDouble();
  }
}

Future<String> createFolderInAppDocDir(String folderName) async {
//Get this App Document Directory
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
//App Document Directory + folder name
  Directory _appDocDirFolder = Directory('${_appDocDir.path}/$folderName/');

  if (Platform.isAndroid) {
    var dir = await getExternalStorageDirectory();
    _appDocDirFolder = Directory('${dir.path}/$folderName/');
    print(_appDocDirFolder);
  }

  if (await _appDocDirFolder.exists()) {
//if folder already exists return path
    return _appDocDirFolder.path;
  } else {
//if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}

String setDateTime(DateTime date) {
  final DateFormat formatter = DateFormat(' dd-MMM-yy | hh:mm');
  final String formatted = formatter.format(date);
  return formatted;
}

String getFileSize(String path) {
  var file = File(path);
  var fileSizeMB = (file.lengthSync() / 1024 / 1024).toStringAsFixed(2);
  if ((file.lengthSync() / 1024 / 1024) < 1) {
    var fileSizeKB = (file.lengthSync() / 1024).toStringAsFixed(0);
    return fileSizeKB + " KB";
  } else {
    return fileSizeMB + " MB";
  }
}

removeSelectedFile(String path, BuildContext context) {
  final dir = Directory(path);
  dir.deleteSync(recursive: true);
  Navigator.pop(context, 'Remove');
}

// shareSelectedFile(String path, BuildContext context) async {
//   Share.shareFiles([path], text: 'Example share');
//
//   // await FlutterShare.shareFile(
//   //   title: 'Example share',
//   //   text: 'Example share text',
//   //   filePath: path,
//   // );
// }

Image setImageHeightFit(
  String path,
) {
  return Image.asset(
    "assets/images/" + path,
    fit: BoxFit.fitHeight,
  );
}

Image setImageNamePath(String path, String name) {
  return Image.asset(
    "assets/images/" + path + name,
    fit: BoxFit.fitWidth,
  );
}

Image setImageNameAndPath(
    String path, String name, double width, double height) {
  return Image.asset(
    "assets/images/" + path + name,
    width: width,
    height: height,
    fit: BoxFit.contain,
  );
}

Image setImageNameAndPathWithFit(
    String path, String name, double width, double height, BoxFit fit) {
  return Image.asset(
    "assets/images/" + path + name,
    width: width,
    height: height,
    fit: fit,
  );
}

Image setImageName(String name, double width, double height) {
  return Image.asset("assets/images/" + name, width: width, height: height);
}

Image setImageNameColor(String name, double width, double height, Color color) {
  return Image.asset(
    "assets/images/" + name,
    width: width,
    height: height,
    color: color,
  );
}

Text setTextWithLightCustomFont(String text, double size, Color color,
    FontWeight weight, double lineHeight) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
      height: lineHeight,
      fontSize: size + 2,
      fontFamily: LightFont,
      fontWeight: weight,
      color: color,
    ),
  );
}

Text setTextWithCustomFont(String text, double size, Color color,
    FontWeight weight, double lineHeight) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
      height: lineHeight,
      fontSize: size + 2,
      fontFamily: RegFont,
      fontWeight: weight,
      color: color,
    ),
  );
}

Text setPoppinsfontMultiline(String text, double size, Color color,
    FontWeight weight, double lineHeight) {
  return Text(
    text,
    softWrap: true,
    // maxLines: 100,
    style: TextStyle(
      height: lineHeight,
      fontSize: size,
      fontFamily: 'Poppins Regular',
      fontWeight: weight,
      color: color,
    ),
  );
}

Text setPoppinsfontWitAlignment(String text, double size, Color color,
    FontWeight weight, double lineHeight) {
  return Text(
    text,
    softWrap: true,
    textAlign: TextAlign.center,
    style: TextStyle(
      height: lineHeight,
      fontSize: size,
      fontFamily: RegFont,
      fontWeight: weight,
      color: color,
    ),
  );
}

Text setBoldfont(String text, double size, Color color) {
  return Text(
    text,
    maxLines: 50,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

Text setBoldFontMultiline(String text, double size, Color color) {
  return Text(
    text,
    maxLines: 100,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    softWrap: false,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

Text setHeavyFont(String text, double size, Color color) {
  return Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    softWrap: false,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.w900,
      color: color,
    ),
  );
}

Text setSemiboldFont(String text, double size, Color color) {
  return Text(
    text,
    maxLines: 100,
    overflow: TextOverflow.ellipsis,
    softWrap: false,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Text setPlaceholderSubtitle(String text, double size, Color color) {
  return Text(
    text,
    maxLines: 5,
    overflow: TextOverflow.ellipsis,
    softWrap: false,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.w600,
      color: color,
    ),
    textAlign: TextAlign.center,
  );
}

Text setNormalfont(String text, double size, Color color) {
  return Text(
    text,
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.normal,
      color: color,
    ),
    textAlign: TextAlign.center,
  );
}

Text setNormalfontWithUnderLine(String text, double size, Color color) {
  return Text(
    text,
    overflow: TextOverflow.fade,
    style: TextStyle(
        fontSize: size,
        fontFamily: 'Poppins Bold',
        fontWeight: FontWeight.normal,
        color: color,
        decoration: TextDecoration.underline),
    textAlign: TextAlign.center,
  );
}

Text setNormalfontWithAlign(
    String text, double size, Color color, TextAlign align) {
  return Text(
    text,
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.normal,
      color: color,
    ),
    textAlign: align,
  );
}

setCloudImageFull(String url) {
  if (url != null) {
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: "http://44.237.241.139/waitlisthero/img/user/" + url,
        // works for smaller images =>                  200',
        httpHeaders: {'Referer': ''},
        imageBuilder: (context, imageProvider) => Container(),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/Common/widePlaceholder.png',
          ),
        ),
        errorWidget: (context, url, error) => Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/Common/widePlaceholder.png',
          ),
        ),
      );
    } else {
      return Image(
        image: AssetImage(
          'assets/images/Common/widePlaceholder.png',
        ),
      );
    }
  } else {
    return Image(
      image: AssetImage(
        'assets/images/Common/widePlaceholder.png',
      ),
    );
  }
}

setCloudImageWithSize(String url, double width, double height) {
  if (url != null) {
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: "http://44.237.241.139/waitlisthero/img/user/" + url,
        // works for smaller images =>                  200',
        httpHeaders: {'Referer': ''},
        height: height,
        width: width,
        memCacheHeight: 50.round(),
        memCacheWidth: 50.round(),
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          image: AssetImage(
            'assets/images/Common/user_placehorder.png',
          ),
          width: width,
          height: height,
        ),
        errorWidget: (context, url, error) => Image(
          image: AssetImage(
            'assets/images/Common/user_placehorder.png',
          ),
          width: width,
          height: height,
        ),
      );
    } else {
      return Image(
        image: AssetImage(
          'assets/images/Common/user_placehorder.png',
        ),
        width: width,
        height: height,
      );
    }
  } else {
    return Image(
      image: AssetImage(
        'assets/images/Common/user_placehorder.png',
      ),
      width: width,
      height: height,
    );
  }
}

String getStateCity(String city, String state) {
  if (city != null) {
    if (city.length > 0) {
      if (state != null) {
        if (state.length > 0) {
          return "$city , $state";
        } else {
          return "$city";
        }
      } else {
        return "$city";
      }
    } else {
      return "${state ?? ""}";
    }
  }
}

String getFormatedDate(String date) {
  DateTime tempDate;
  if (date != null) {
    if (date.contains("/")) {
      tempDate = new DateFormat("MM/dd/yyyy").parse(date.trim());
    } else {
      tempDate = new DateFormat("dd-MM-yyyy").parse(date.trim());
    }

    final DateFormat formatter = DateFormat('MMMM dd, yyy');
    final String formatted = formatter.format(tempDate as DateTime);
    return formatted;
  } else {
    return "";
  }
}

setCloudImage(String url) {
  if (url != null) {
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: "http://44.237.241.139/waitlisthero/img/user/" + url,
        // works for smaller images =>                  200',
        httpHeaders: {'Referer': ''},
        height: 100,
        width: 100,
        memCacheHeight: 50.round(),
        memCacheWidth: 50.round(),
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          image: AssetImage(
            'assets/images/Common/user_placehorder.png',
          ),
          width: 100,
          height: 100,
        ),
        errorWidget: (context, url, error) => Image(
          image: AssetImage(
            'assets/images/Common/user_placehorder.png',
          ),
          width: 100,
          height: 100,
        ),
      );
    } else {
      return Image(
        image: AssetImage(
          'assets/images/Common/user_placehorder.png',
        ),
        width: 100,
        height: 100,
      );
    }
  } else {
    return Image(
      image: AssetImage(
        'assets/images/Common/user_placehorder.png',
      ),
      width: 100,
      height: 100,
    );
  }
}

setCloudImageStylistPlaceholder(String url) {
  if (url != null) {
    if (url != "null" && url.length > 1) {
      return CachedNetworkImage(
        imageUrl: "http://44.237.241.139/waitlisthero/img/user/" + url,
        // works for smaller images =>                  200',
        httpHeaders: {'Referer': ''},
        height: 100,
        width: 100,
        memCacheHeight: 50.round(),
        memCacheWidth: 50.round(),
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          image: AssetImage(
            'assets/images/Common/stylistPlaceholde.png',
          ),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        errorWidget: (context, url, error) => Image(
          image: AssetImage(
            'assets/images/Common/stylistPlaceholde.png',
          ),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      );
    } else {
      return Image(
        image: AssetImage(
          'assets/images/Common/stylistPlaceholde.png',
        ),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      );
    }
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    if (other == null) {
      return false;
    }
    if (other.year != null) {
      return this.year == other.year &&
          this.month == other.month &&
          this.day == other.day;
    }
    return this.month == other.month && this.day == other.day;
  }
}
