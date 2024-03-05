import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:harnishsalon/common/APIManager.dart';
import 'package:harnishsalon/common/Global.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/SelctServiceStylistVC.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import '../common/Constant.dart';

class StylistAddphotoVC extends StatefulWidget {
  final String salonID;
  final String salonNameTxt;
  final String addressTxt;
  StylistAddphotoVC({
    Key key,
    this.addressTxt,
    this.salonID,
    this.salonNameTxt,
  }) : super(key: key);

  @override
  _StylistAddphotoVCState createState() => _StylistAddphotoVCState();
}

class _StylistAddphotoVCState extends State<StylistAddphotoVC> {
  var images = [];
  String _error;
  List<MultipartFile> multipartImageList = new List<MultipartFile>();
  Asset profilePicture;
  double height, width;
  String name;
  var _image;
  String imageName = "";
  String uploadedImageName = "";
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: setbuttonWithChild(Icon(Icons.arrow_back), () {
          Navigator.of(context).pop();
        }, Colors.transparent, 0),
        // actions: [
        //   setbuttonWithChild(
        //     setTextWithCustomFont("SKIP", 16, Colors.grey, FontWeight.w600, 1),
        //     () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (builder) => SelectServiceStylistVC(),
        //         ),
        //       );
        //     },
        //     Colors.transparent,
        //     0,
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              ClipOval(
                child: InkWell(
                  onTap: () {
                    getImage(ImgSource.Both);
                  },
                  child: _image != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            border: Border.all(
                              color: ColorConstants.kGreyColor,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(
                              File(_image.path),
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.kGreyColor.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(100 / 2),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: ExactAssetImage(
                                "assets/images/iconAddImage.png",
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              setTextWithCustomFont(
                widget.salonNameTxt != null ? widget.salonNameTxt : "",
                16,
                Colors.black,
                FontWeight.w600,
                1,
              ),
              SizedBox(
                height: 10,
              ),
              setTextWithCustomFont(
                widget.addressTxt != null ? widget.addressTxt : "",
                12,
                Colors.black,
                FontWeight.w400,
                1,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 25, 0, 15),
                            alignment: Alignment.topLeft,
                            child: setTextWithCustomFont(
                                "Add" + widget.salonNameTxt != null
                                    ? widget.salonNameTxt
                                    : "" + "Photos",
                                14,
                                Colors.black,
                                FontWeight.w600,
                                1),
                          ),
                          Container(
                            height: 280,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: GridView.builder(
                              shrinkWrap: false,
                              primary: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (BuildContext context, index) {
                                Asset asset = images.length > index
                                    ? images[index]
                                    : null;
                                return InkWell(
                                  onTap: () {
                                    loadAssets();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        asset != null ? 0 : 35,
                                      ),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: (asset != null)
                                            ? AssetThumb(
                                                asset: asset,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width ~/
                                                    3.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width ~/
                                                    3.5,
                                              )
                                            : setImageHeightFit(
                                                "iconAddImage.png"),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(238, 238, 238, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: 6,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width - 30,
                child: setbuttonWithChild(
                  setTextWithCustomFont(
                      "NEXT", 14, Colors.white, FontWeight.w400, 1),
                  () {
                    onSavePhotos();
                  },
                  ColorConstants.kButtonBackColor,
                  3,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPath() {
    images.forEach((element) {
      print(element.identifier);
      File tempFile = File(element.identifier);
      print(tempFile);
    });
  }

  onSavePhotos() async {
    for (var item in images) {
      String newimagePath = item.identifier;
      imagePath = await FlutterAbsolutePath.getAbsolutePath(newimagePath);
      setState(() {
        uploadedImageName = imagePath.split('/').last;
      });
      FormData formData = FormData.fromMap({
        "images[]": await MultipartFile.fromFile(
          imagePath,
          filename: uploadedImageName,
        ),
      });
      postDataRequestWithTokenSalon(uploadSalonImages, formData, context).then(
        (value) => {
          if (value is List)
            {
              print(value),
              _profileUpdateResponseHandling(value),
            }
          else
            {
              showToast("Unable to update user profile", context: context),
            }
        },
      );
    }
  }

  _profileUpdateResponseHandling(userData) {
    showToast("Salon Images Uploaded Successfully", context: context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => SelectServiceStylistVC(
          salonIDSelectServiceTxt: widget.salonID,
        ),
      ),
    );
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: ColorConstants.kRedColor,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: ColorConstants.kRedColor,
      ),
      cameraText: Text(
        "From Camera",
        style: TextStyle(color: ColorConstants.kRedColor),
      ),
      galleryText: Text(
        "From Gallery",
        style: TextStyle(color: ColorConstants.kBlueColor),
      ),
    );

    File file = new File(image.path);
    String fileName = file.path.split('/').last;
    setState(() {
      _image = image;
      imageName = fileName;
    });
    uploadSalonLogo();
  }

  uploadSalonLogo() async {
    FormData formData = FormData.fromMap({
      "logo": await MultipartFile.fromFile(
        _image.path,
        filename: imageName,
      ),
    });
    postDataRequestWithTokenSalon(salonLogoApi, formData, context).then(
      (value) => {
        print(value),
        if (value != null)
          {
            showToast("Salon Logo Uploaded", context: context),
          }
        else
          {
            showToast(value.toString(), context: context),
          }
      },
    );
  }

  Future<void> loadAssets() async {
    var status = await Permission.photos.request();
    if (status == PermissionStatus.denied) {
      return _showPhotoPermissionDialog();
    }
    // setState(() {
    //   images = List<Asset>();
    // });
    if (images.length == 6) {
      return;
    }
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(maxImages: 1);
      print("RESULT LIST : $resultList");
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      if (resultList == null) return;
      for (var itemObj in resultList) {
        images.add(itemObj);
      }
    
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future<void> _showPhotoPermissionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission to Photos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'This app needs access to Photos in order to add an image',
                  style: TextStyle(fontFamily: RegFont),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text('Cancel', style: TextStyle(color: appRedColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
