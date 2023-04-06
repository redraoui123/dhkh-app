import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({super.key});

  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  int _stripNumber = 0;
  bool _tmpPaid = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF030A32),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Add Players ',
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
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 80.r,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
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
                                                    labelText: 'strip number',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 20.sp,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    )),
                                                onChanged: (val) {
                                                  setState(() {
                                                    _stripNumber =
                                                        int.parse(val);
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
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20.r,
                                  color: Colors.white,
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
                        onChanged: (val) {},
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
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
                        onChanged: (val) {},
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
                            '- photos',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            '0 dhs',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        children: [
                          Container(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        ],
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
}
