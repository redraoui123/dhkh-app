import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dhkhapp/addPlayer.dart';
import 'package:dhkhapp/classes/Admin.dart';
import 'package:dhkhapp/classes/functions.dart';
import 'package:dhkhapp/playersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'classes/Player.dart';
import 'main.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _homeScore = 0, _awayScore = 0;
  String _awayName = "-",
      _awayImagePath = "",
      _adminImagePath = "",
      _adminName = "NAME",
      _adminPhone = "PHONE_NUMBER";
  bool _changed = false, _adminChanged = false;
  List<Player> lst_players_global = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF030A32),
      child: SafeArea(
        child: AdvancedDrawer(
          controller: _advancedDrawerController,
          drawer: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  'images/mylogo.png',
                  width: 122.w,
                  height: 122.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'D.H.K.H',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 30.sp,
                  ),
                ),
                Text(
                  'app',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(5 / 360),
                  child: Container(
                    width: 200.r,
                    height: 250.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        // get photo from gallery
                        final piickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (piickedFile != null) {
                          File? croppedFile = await ImageCropper().cropImage(
                            sourcePath: piickedFile.path,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            androidUiSettings: const AndroidUiSettings(
                              toolbarColor: Color.fromARGB(255, 6, 0, 85),
                              toolbarTitle: 'Edit Photo',
                              toolbarWidgetColor: Colors.white,
                              activeControlsWidgetColor: Colors.redAccent,
                              backgroundColor: Color.fromARGB(255, 44, 44, 44),
                            ),
                          );
                          if (croppedFile != null) {
                            setState(() {
                              _adminImagePath = croppedFile.path;
                              _adminChanged = true;
                            });
                          }
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          _adminImagePath = "";
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: _adminImagePath == ""
                            ? Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40.r,
                              )
                            : Image.file(
                                File(_adminImagePath),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
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
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.r),
                              child: TextFormField(
                                onEditingComplete: () {
                                  Navigator.pop(context);
                                },
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 26.sp,
                                ),
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    labelText: 'admin name',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.sp,
                                      color: Colors.white.withOpacity(0.5),
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    val != ""
                                        ? _adminName = val
                                        : _adminName = "NAME";

                                    _adminChanged = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    _adminName,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
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
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.r),
                              child: TextFormField(
                                onEditingComplete: () {
                                  Navigator.pop(context);
                                },
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 26.sp,
                                ),
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    labelText: 'admin phone',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.sp,
                                      color: Colors.white.withOpacity(0.5),
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    val != ""
                                        ? _adminPhone = val
                                        : _adminPhone = "PHONE_NUMBER";

                                    _adminChanged = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    _adminPhone,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        Admin admin = Admin(
                          name: _adminName,
                          phone: _adminPhone,
                          // ignore: use_build_context_synchronously
                          picture: await Functions.uploadImage(
                              _adminImagePath, context, 'admin photo'),
                        );

                        await Functions.saveAdminInfo(
                            admin: admin, context: context);
                      },
                      child: _adminChanged
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 15.h),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200.r,
                                    height: 45.r,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFF0000FE),
                                    ),
                                    child: Text(
                                      'Save Changes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  )))
                          : Container()),
                ),
              ],
            ),
          ),
          backdropColor: const Color(0xFF12136B),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0032FF).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    _advancedDrawerController.showDrawer();
                  },
                  child: const Icon(Icons.menu)),
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
                            builder: (context) => AddPlayer(
                              title: 'Add new Player',
                              lst_players_tmp: lst_players_global,
                              playerTmp: Player(
                                  fullName: "",
                                  hasPaid: false,
                                  images_list: [],
                                  phoneNumber: 0,
                                  profilePicture: "",
                                  stripNumber: 0,
                                  toPay: 0),
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            lst_players_global = value;
                          });
                        });
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
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 400),
                        slidingBeginOffset: const Offset(0.0, -0.3),
                        child: Container(
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
                                lst_players_global.isNotEmpty
                                    ? calculatePrices()
                                    : '0',
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
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 400),
                        child: Container(
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
                                      builder: (context) => PLayersList(
                                        lst_players_tmp: lst_players_global,
                                      ),
                                    ),
                                  ).then((value) {
                                    setState(() {
                                      lst_players_global = value;
                                    });
                                  });
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
                                      lst_players_global.isNotEmpty
                                          ? lst_players_global.length.toString()
                                          : '0',
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
                                    lst_players_global.isNotEmpty
                                        ? calculatePhotos()
                                        : '0',
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
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      _changed
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  _changed = false;
                                });
                              },
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 216, 89, 89),
                                  fontFamily: 'Inter',
                                  fontSize: 20.sp,
                                ),
                              ),
                            )
                          : DelayedDisplay(
                              delay: const Duration(milliseconds: 800),
                              slidingBeginOffset: const Offset(0.0, -0.3),
                              child: Text(
                                'Match',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10.h,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 900),
                        child: Container(
                          width: 350.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF12136B),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: _changed
                                    ? const Color.fromARGB(255, 216, 89, 89)
                                    : Colors.white,
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
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.asset(
                                              'images/tmpMatch1.png'))),
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
                                  _changed = true;
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
                                  _changed = true;
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
                                  _changed = true;
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
                                  _changed = true;
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
                                      final piickedFile =
                                          await picker.pickImage(
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
                                            backgroundColor:
                                                Color.fromARGB(255, 44, 44, 44),
                                          ),
                                        );
                                        if (croppedFile != null) {
                                          setState(() {
                                            //_image_64 = imageToBase64(croppedFile);
                                            _awayImagePath = croppedFile.path;
                                            _changed = true;
                                          });
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
                                      child: _awayImagePath != ""
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              child: Image.file(
                                                  File(_awayImagePath)),
                                            )
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
                                                      fillColor:
                                                          Colors.transparent,
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
                                                        _changed = true;
                                                      } else {
                                                        _awayName = "-";
                                                        _changed = true;
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
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
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

  _showWaitingDialog() {
    // show waiting dilog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            alignment: Alignment.center,
            height: 120.r,
            decoration: BoxDecoration(
              color: const Color(0xFF000B46),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please Wait',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.r,
                ),
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.2,
                )
              ],
            ),
          ),
        );
      },
    );
  }
  // local functions

  String calculatePrices() {
    int price = 0;
    for (var player in lst_players_global) {
      price += int.parse(player.toPay.toString());
    }
    return price.toString();
  }

  String calculatePhotos() {
    int totalPhotos = 0;
    for (var player in lst_players_global) {
      totalPhotos += player.images_list.length;
    }
    return totalPhotos.toString();
  }
}
