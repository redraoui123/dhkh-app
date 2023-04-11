import 'dart:io';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:dhkhapp/imageViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'classes/Player.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer(
      {super.key,
      required this.title,
      required this.lst_players_tmp,
      required this.playerTmp});
  final List<Player> lst_players_tmp;
  final Player playerTmp;
  final String title;
  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  int? _stripNumber = 0, _phoneNumber = 0, _topay = 0, _id = 0;
  bool _tmpPaid = false, loaded = false;
  final picker = ImagePicker();
  String _imagePath = "", _fullName = "";
  List<String?> lst_photos = [];

  Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    if (widget.title != 'Add new Player') {
      if (!loaded) {
        setState(() {
          _id = widget.playerTmp.id;
          _stripNumber = widget.playerTmp.stripNumber;
          _fullName = widget.playerTmp.fullName.toString();
          _phoneNumber = widget.playerTmp.phoneNumber;
          _imagePath = widget.playerTmp.profilePicture.toString();
          lst_photos = widget.playerTmp.images_list;
          _topay = widget.playerTmp.toPay;
          loaded = true;
        });
      }
    }
    return Container(
      color: const Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  // Add new player
                  if (widget.title == "Add new Player") {
                    if (_fullName != "" &&
                        _phoneNumber != 0 &&
                        _imagePath != "") {
                      await addPlayer();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, widget.lst_players_tmp);
                    } else if (_fullName != "" ||
                        _phoneNumber != 0 ||
                        _imagePath != "") {
                      Flushbar(
                        messageText: Text(
                          "One or more values are required!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                          ),
                        ),
                        backgroundColor: Colors.redAccent,
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    } else {
                      Navigator.pop(context, widget.lst_players_tmp);
                    }
                  }
                  // PLayer details
                  else {
                    if (_fullName != "" &&
                        _phoneNumber != 0 &&
                        _imagePath != "") {
                      await updatePlayer(widget.playerTmp);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, widget.lst_players_tmp);
                    }
                  }
                }),
            actions: [
              if (widget.title != 'Add new Player')
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    if (_id != 0) {
                      await removePlayer(_id);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, widget.lst_players_tmp);
                    }
                  },
                ),
            ],
            backgroundColor: const Color(0xFF030A32),
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontFamily: 'Inter',
                fontSize: 25.sp,
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
                      height: 215.h,
                      width: 215.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 215.r,
                            width: 215.r,
                            decoration: BoxDecoration(
                              color: const Color(0xFF051152),
                              borderRadius: BorderRadius.circular(2100),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: _imagePath != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(2100),
                                    child: Image.file(
                                      File(_imagePath),
                                      fit: BoxFit.cover,
                                    ))
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 80.r,
                                  ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.r,
                                width: 50.r,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF000B46),
                                  borderRadius: BorderRadius.circular(2100),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Alert to set number
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
                                                onEditingComplete: () {
                                                  Navigator.pop(context);
                                                },
                                                textAlign: TextAlign.center,
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType:
                                                    TextInputType.number,
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
                                                    labelText: 'strip number',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 20.sp,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    )),
                                                onChanged: (val) {
                                                  setState(() {
                                                    if (val != "") {
                                                      _stripNumber =
                                                          int.parse(val);
                                                    } else {
                                                      _stripNumber = 0;
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
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      '$_stripNumber',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100,
                                        fontFamily: 'Inter',
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 10),
                              child: Container(
                                height: 50.r,
                                width: 50.r,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF000B46),
                                  borderRadius: BorderRadius.circular(2100),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: InkWell(
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
                                          backgroundColor:
                                              Color.fromARGB(255, 44, 44, 44),
                                        ),
                                      );
                                      if (croppedFile != null) {
                                        setState(() {
                                          _imagePath = croppedFile.path;
                                        });
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: TextFormField(
                        initialValue: widget.title != 'Add new Player'
                            ? widget.playerTmp.fullName
                            : null,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            labelText: 'full name',
                            labelStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                              color: Colors.white.withOpacity(0.5),
                            )),
                        onChanged: (val) {
                          setState(() {
                            if (val != "") {
                              _fullName = val;
                            } else {
                              _fullName = "";
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: TextFormField(
                        initialValue: widget.title != 'Add new Player'
                            ? '0${widget.playerTmp.phoneNumber}'
                            : null,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            labelText: 'phone number',
                            labelStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                              color: Colors.white.withOpacity(0.5),
                            )),
                        onChanged: (val) {
                          setState(() {
                            if (val != "") {
                              _phoneNumber = int.parse(val);
                            } else {
                              _phoneNumber = 0;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lst_photos.length > 1
                                ? '${lst_photos.length} photos'
                                : '${lst_photos.length} photo',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
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
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.r),
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
                                              labelText: 'ammount to pay',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 20.sp,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              )),
                                          onChanged: (val) {
                                            if (val != "") {
                                              setState(() {
                                                _topay = int.parse(val);
                                              });
                                            } else {
                                              setState(() {
                                                _topay = 0;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 25.r,
                              width: 150.r,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  '$_topay dhs',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 140.r,
                      width: MediaQuery.of(context).size.width,
                      child: lst_photos.isNotEmpty
                          ? ListView.builder(
                              itemCount: lst_photos.length + 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 30.r, right: 20.r),
                                    child: InkWell(
                                      onTap: () async {
                                        // get photo from gallery
                                        List<XFile> pickedFiles =
                                            await picker.pickMultiImage();
                                        if (pickedFiles != null) {
                                          for (XFile image in pickedFiles) {
                                            setState(() {
                                              lst_photos.add(image.path);
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 140.r,
                                        width: 140.r,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF051152),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/add_photo.png',
                                            ),
                                            SizedBox(height: 30.h),
                                            Text(
                                              'add photo',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Inter',
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(right: 20.r),
                                  child: Container(
                                    height: 140.r,
                                    width: 140.r,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF051152),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ImageViewer(
                                                        imageURL: lst_photos[
                                                                index - 1]
                                                            .toString()),
                                              ),
                                            );
                                          },
                                          child: Image.file(
                                            File(lst_photos[index - 1]
                                                .toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                );
                              }),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 30.r),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // get photo from gallery
                                      List<XFile> pickedFiles =
                                          await picker.pickMultiImage();
                                      if (pickedFiles != null) {
                                        for (XFile image in pickedFiles) {
                                          setState(() {
                                            lst_photos.add(image.path);
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 140.r,
                                      width: 140.r,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF051152),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/add_photo.png',
                                          ),
                                          SizedBox(height: 30.h),
                                          Text(
                                            'add photo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Inter',
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paid ?',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 25.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_tmpPaid) {
                                  _tmpPaid = false;
                                } else {
                                  _tmpPaid = true;
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 75.r,
                              height: 35.r,
                              decoration: BoxDecoration(
                                color:
                                    _tmpPaid ? Colors.green : Colors.redAccent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                _tmpPaid ? 'YES' : 'NO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addPlayer() async {
    Player player = Player(
        id: rnd.nextInt(999999),
        fullName: _fullName,
        phoneNumber: _phoneNumber,
        stripNumber: _stripNumber,
        profilePicture: _imagePath,
        images_list: lst_photos,
        hasPaid: _tmpPaid,
        toPay: _topay);
    widget.lst_players_tmp.add(player);
  }

// error still here

  Future<void> updatePlayer(Player oldplayer) async {
    Player newplayer = Player(
        id: oldplayer.id,
        fullName: _fullName,
        phoneNumber: _phoneNumber,
        stripNumber: _stripNumber,
        profilePicture: _imagePath,
        images_list: lst_photos,
        hasPaid: _tmpPaid,
        toPay: _topay);

    int index = widget.lst_players_tmp
        .indexWhere((element) => element.id == oldplayer.id);

    setState(() {
      widget.lst_players_tmp[index] = newplayer;
    });
  }

  Future<void> removePlayer(int? id) async {
    widget.lst_players_tmp.removeWhere((element) => element.id == id);
  }
}
