import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Constant.dart';
import 'Global.dart';

var baseURL = "http://67.205.148.222/harnish/api/";

var baseImageURL = "http://67.205.148.222/harnish/users/";
var baseSalonImageURL = "http://67.205.148.222/harnish/salon_image/";

const String loginApi = "login";
const String registerApi = "register";
const String registerVarificationApi = "register_verification";
const String checkOTP = "check_otp";
const String verifyOTP = "verify_otp";
const String resendOTP = "resend_otp";
const String updateSalonAddress = "stylist/address/update";
const String getSalonAddressApi = "stylist/address/detail";
const String appointmentBookingList = "stylist/appointment/list";
const String ongoingList = "stylist/appointment/on-going";
const String bookAppointmentApi = "client/appointment/booked";
const String userBookingListApi = "client/appointment/list";

const String allSalonListApi = "client/salon/list";
const String getUserProfileApi = "client/get_profile";
const String updateUserProfileApi = "client/get_profile";
const String recommendedStylist = "client/recommended-stylist";
const String topRatedSalonListApi = "client/salon/top-rated";
const String lastVisitedSalonListApi = "client/salon/last-visited";
const String addEmployee = "stylist/employee/create";
const String verifyEmployeeApi = "stylist/employee/varification";

const String employeeList = "stylist/employee/list";
const String serviceRequest = "stylist/service/service-request";
const String addPackageRequest = "stylist/package/create";
const String packageListApi = "stylist/package/list";
const String deletePackageApi = "stylist/package/delete";
const String serviceListApi = "services";
const String serviceCreateApi = "stylist/service/create";
const String packageServiceListApi = "stylist/service/list";
const String uploadSalonImages = "stylist/upload_images";
const String getStylistProfileApi = "stylist/get_profile";
const String salonLogoApi = "stylist/upload_logo";
const String logoutApi = "logout";
const String userRegister = "client-register";
const String userLogin = "client-login";
const String clientOfferList = "client/package";
const String cmsPageApi = "cms_page";
const String salonDetailApi = "client/salon/detail";
const String supportData = "support_data";
const String newPasswordPostApi = "forgot_pwd_post";
const String getUser = "get_user";
const String changePasswordAPI = "user/change_password";
const String addCardAPI = "user/card/add";
const String getCardlistAPI = "user/card/list";
const String removeCard = "user/card/delete";
const String socialLoginAPI = "social_login";
const String autoLoginAPI = "auto_login";
const String getStateList = "state/list";
const String getCityList = "city/list";
const String getSettings = "settings";

const String getClientStylistList = "client/stylist_list";
const String followStylist = "client/follow";
const String getFollowingStylistList = "client/following_list";
const String unfollowStylist = "client/unfollow";
const String getClientAppointmentList = "client/appointment/list";
const String getAppointmentDetail = "client/appointment/detail";
const String bookAppontment = "client/appointment/booked";
const String getClientAppointmentHistory = "client/appointment/history";
const String getAppointmentList = "client/appointment/list";
const String clientAppointmentDetail = "client/appointment/detail";
const String clientMyAppointments = "client/appointment/my_appointments";

const String udateProfileAPI = "stylist/profile_update";
const String createNewAppointment = "stylist/appointment/create";
const String updateCompanyDetail = "stylist/update_company_detail";
const String getStylistAppointmentList = "stylist/appointment/list";
const String subscriptionDetail = "stylist/subscription-detail";
const String accountVerify = "stylist/bank/account-varify";
const String addBankAccount = "stylist/bank/account-add";
const String complateAppointment = "stylist/appointment/complete";
const String deleteAppointMent = "stylist/appointment/delete";
const String updateAppointment = "stylist/appointment/update";
const String subscribeStylist = "stylist/subscribe";
const String stylistAppointmentDetail = "stylist/appointment/detail";
const String unSubscribeStylist = "stylist/unsubscribe";
const String stylistAppointmentHistory = "stylist/appointment/history";
const String stylistUploadDocument = "stylist/stripe/upload_document";

void getHttp() async {
  try {
    Response response = await Dio().get("http://www.google.com");
    print(response);
  } catch (e) {
    print(e);
  }
}

Future<dynamic> getresponse(String url) async {
  try {
    Response response = await Dio().get(url);
    var responseJson = json.decode(response.data);
    if (response.statusCode == 200) {
      if (responseJson[kStatusCode] as int == 200) {
        return responseJson;
      } else {
        return responseJson[kMessage];
      }
    } else {
      return responseJson[kMessage];
    }
  } catch (e) {
    print(e);
  }
}

Future<dynamic> postDataRequest(String urlPath, FormData params) async {
  try {
    var header = Options(
      headers: {
        "AuthorizationUser":
            "eyJpdiI6IllRNlR6VkxZS2JQbitvUklNeUdPTlE9PSIsInZhbHVlIjoib3Z4VEwvQVNndGhybE5LaW1BMG5DUEptcmxKVXQzUUZTZVBKeUY0QS9xbGM1NnF5OWJ4VTllQ0Q4RER4NnVwNSIsIm1hYyI6IjBmNjc0OGMyMzZkOTQ2NzA3NTEwZTY0NjIwZGVkZTExMDlmNWYwMzA1ZTg0MmMzM2ZkZjJhOWI3YmY3OGNmOTMifQ==",
      },
    );
    Response<String> response =
        await Dio().post(baseURL + urlPath, data: params, options: header);
    print("RESPONSE : $response");
    var responseJson = json.decode(response.data);
    if (response.statusCode == 200) {
      if (responseJson[kStatusCode] as int == 200) {
        return responseJson;
      } else {
        return responseJson[kMessage];
      }
    } else {
      return responseJson[kMessage];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<dynamic> postDataRequestWithToken(
    String urlPath, FormData params, BuildContext context) async {
  try {
    var header = Options(
      headers: {
        "AuthorizationUser":
            "eyJpdiI6IllRNlR6VkxZS2JQbitvUklNeUdPTlE9PSIsInZhbHVlIjoib3Z4VEwvQVNndGhybE5LaW1BMG5DUEptcmxKVXQzUUZTZVBKeUY0QS9xbGM1NnF5OWJ4VTllQ0Q4RER4NnVwNSIsIm1hYyI6IjBmNjc0OGMyMzZkOTQ2NzA3NTEwZTY0NjIwZGVkZTExMDlmNWYwMzA1ZTg0MmMzM2ZkZjJhOWI3YmY3OGNmOTMifQ==",
        "authorization": "bearer" + userObj.token,
      },
    );
    Response<String> response =
        await Dio().post(baseURL + urlPath, data: params, options: header);

    print(response);
    var responseJson = json.decode(response.data);
    print(responseJson);

    if (response.statusCode == 200) {
      if (responseJson["status_code"] as int == 200) {
        return responseJson["data"];
      } else if (responseJson["status_code"] as int == 500) {
        // clearUserData();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => IntroVC()),
        //     (Route<dynamic> route) => false);
      } else {
        return responseJson["message"];
      }
    } else {
      return responseJson["message"];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<dynamic> postDataRequestWithTokenStylist(
    String urlPath, FormData params, BuildContext context) async {
  try {
    var header = Options(
      headers: {
        "AuthorizationUser":
            "eyJpdiI6IllRNlR6VkxZS2JQbitvUklNeUdPTlE9PSIsInZhbHVlIjoib3Z4VEwvQVNndGhybE5LaW1BMG5DUEptcmxKVXQzUUZTZVBKeUY0QS9xbGM1NnF5OWJ4VTllQ0Q4RER4NnVwNSIsIm1hYyI6IjBmNjc0OGMyMzZkOTQ2NzA3NTEwZTY0NjIwZGVkZTExMDlmNWYwMzA1ZTg0MmMzM2ZkZjJhOWI3YmY3OGNmOTMifQ==",
        "authorization": "bearer" + stylistObj.token,
      },
    );
    print(stylistObj.token);
    Response<String> response =
        await Dio().post(baseURL + urlPath, data: params, options: header);
    var responseJson = json.decode(response.data);
    print(responseJson);
    if (response.statusCode == 200) {
      if (responseJson["status_code"] as int == 200) {
        return responseJson["data"];
      } else if (responseJson["status_code"] as int == 500) {
        // clearUserData();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => IntroVC()),
        //     (Route<dynamic> route) => false);
      } else {
        return responseJson["message"];
      }
    } else {
      return responseJson["message"];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<dynamic> postDataRequestWithTokenSalon(
    String urlPath, FormData params, BuildContext context) async {
  try {
    var header = Options(
      headers: {
        "AuthorizationUser":
            "eyJpdiI6IllRNlR6VkxZS2JQbitvUklNeUdPTlE9PSIsInZhbHVlIjoib3Z4VEwvQVNndGhybE5LaW1BMG5DUEptcmxKVXQzUUZTZVBKeUY0QS9xbGM1NnF5OWJ4VTllQ0Q4RER4NnVwNSIsIm1hYyI6IjBmNjc0OGMyMzZkOTQ2NzA3NTEwZTY0NjIwZGVkZTExMDlmNWYwMzA1ZTg0MmMzM2ZkZjJhOWI3YmY3OGNmOTMifQ==",
        "authorization": "bearer" + salonObj.token,
      },
    );
    print(salonObj.token);
    Response<String> response =
        await Dio().post(baseURL + urlPath, data: params, options: header);
    var responseJson = json.decode(response.data);
    print(responseJson);
    if (response.statusCode == 200) {
      if (responseJson["status_code"] as int == 200) {
        return responseJson["data"];
      } else if (responseJson["status_code"] as int == 500) {
        // clearUserData();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => IntroVC()),
        //     (Route<dynamic> route) => false);
      } else {
        return responseJson["message"];
      }
    } else {
      return responseJson["message"];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<dynamic> postAPIRequestWithToken(
    String urlPath, FormData params, BuildContext context) async {
  try {
    var header = Options(
      headers: {
        "AuthorizationUser":
            "eyJpdiI6IllRNlR6VkxZS2JQbitvUklNeUdPTlE9PSIsInZhbHVlIjoib3Z4VEwvQVNndGhybE5LaW1BMG5DUEptcmxKVXQzUUZTZVBKeUY0QS9xbGM1NnF5OWJ4VTllQ0Q4RER4NnVwNSIsIm1hYyI6IjBmNjc0OGMyMzZkOTQ2NzA3NTEwZTY0NjIwZGVkZTExMDlmNWYwMzA1ZTg0MmMzM2ZkZjJhOWI3YmY3OGNmOTMifQ==",
        "authorization": "bearer" + salonObj.token,
      },
    );
    Response<String> response =
        await Dio().post(baseURL + urlPath, data: params, options: header);
    var responseJson = json.decode(response.data);
    if (response.statusCode == 200) {
      if (responseJson[kStatusCode] as int == 500) {
        if (response.statusCode == 500) {
          // clearUserData();
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => IntroVC()),
          //     (Route<dynamic> route) => false);
          return;
        }
      }
      return responseJson;
    } else {
      showCustomToast(responseJson[kMessage], context);
      return null;
    }
  } catch (e) {
    if (e is DioError) {
      var error = e as DioError;
      var errorDetail = error.error as SocketException;
      showCustomToast(errorDetail.osError.message.toString(), context);
      return errorDetail.osError.message.toString();
    }
    return e.toString();
  }
}
