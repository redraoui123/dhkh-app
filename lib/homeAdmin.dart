import 'dart:convert';
import 'dart:io';

import 'package:dhkhapp/addPlayer.dart';
import 'package:dhkhapp/playersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _homeScore = 0, _awayScore = 0;
  String _awayName = "-", _image_64 = "", _imagePath = "";

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF030A32),
            elevation: 0,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 25.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPlayer()));
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  )),
            ],
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Inter',
                      fontSize: 25.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'Reda',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: const Color.fromARGB(255, 6, 0, 85),
                child: Image.asset('images/background.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      width: 275.w,
                      height: 310.h,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFF12136B),
                                Color(0xFF0A0A52),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 120.sp,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Dhs',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 60.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF0A0A52),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22.r),
                              bottomRight: Radius.circular(22.r)),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )),
                      height: 180.h,
                      width: 230.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PLayersList()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/player.png',
                                    width: 40.w, height: 40.h),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            child: const Divider(
                              color: Colors.white,
                              thickness: .5,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/photo.png',
                                  width: 40.w, height: 40.h),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 45.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Match',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 350.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF12136B),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 65.r,
                                  height: 65.r,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF000B46),
                                      border: Border.all(
                                          color: Colors.white, width: .5),
                                      borderRadius:
                                          BorderRadius.circular(1000)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child:
                                          Image.asset('images/tmpMatch1.png'))),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'DHKH',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () {
                              if (_homeScore < 9) {
                                setState(() {
                                  _homeScore++;
                                });
                              } else {
                                setState(() {
                                  _homeScore = 0;
                                });
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                _homeScore = 0;
                              });
                            },
                            child: Text(
                              '$_homeScore',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp,
                              ),
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 35.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_awayScore < 9) {
                                setState(() {
                                  _awayScore++;
                                });
                              } else {
                                setState(() {
                                  _awayScore = 0;
                                });
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                _awayScore = 0;
                              });
                            },
                            child: Text(
                              '$_awayScore',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  // get photo from gallery
                                  final piickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (piickedFile != null) {
                                    File? croppedFile =
                                        await ImageCropper().cropImage(
                                      sourcePath: piickedFile.path,
                                      aspectRatioPresets: [
                                        CropAspectRatioPreset.square,
                                        CropAspectRatioPreset.ratio3x2,
                                        CropAspectRatioPreset.original,
                                        CropAspectRatioPreset.ratio4x3,
                                        CropAspectRatioPreset.ratio16x9
                                      ],
                                      androidUiSettings:
                                          const AndroidUiSettings(
                                        toolbarColor:
                                            Color.fromARGB(255, 6, 0, 85),
                                        toolbarTitle: 'Edit Photo',
                                        toolbarWidgetColor: Colors.white,
                                        activeControlsWidgetColor:
                                            Colors.redAccent,
                                        backgroundColor: Colors.grey,
                                      ),
                                    );
                                    if (croppedFile != null) {
                                      setState(() {
                                        _image_64 = imageToBase64(croppedFile);
                                        _imagePath = croppedFile.path;
                                      });
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Container(
                                  width: 65.r,
                                  height: 65.r,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: .5),
                                      color: const Color(0xFF000B46),
                                      borderRadius:
                                          BorderRadius.circular(1000)),
                                  child: _imagePath != ""
                                      ? Image.file(File(_imagePath))
                                      : const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Container(
                                          width: 200.r,
                                          height: 100.r,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF000B46),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.r),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Inter',
                                                fontSize: 26.sp,
                                              ),
                                              decoration: InputDecoration(
                                                  fillColor: Colors.transparent,
                                                  filled: true,
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 1),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),
                                                  labelText: 'team name',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 20.sp,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  )),
                                              onChanged: (val) {
                                                setState(() {
                                                  if (val != "") {
                                                    _awayName = (val);
                                                  } else {
                                                    _awayName = "-";
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 20.r,
                                  width: 60.r,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      _awayName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String imageToBase64(File? image) {
    List<int> imageBytes = image!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
