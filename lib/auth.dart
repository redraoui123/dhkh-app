import 'package:another_flushbar/flushbar.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dhkhapp/homeAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _isobscure = true;
  String _lockImage = "images/lock_off.png", _username = "", _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: const Color.fromARGB(255, 6, 0, 85),
              child: Image.asset(
                'images/background.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              child: Column(
                children: [
                  SizedBox(
                    height: 160.h,
                  ),
                  Hero(
                    tag: 'mylogo',
                    child: Image.asset(
                      'images/mylogo.png',
                      width: 190.w,
                      height: 190.h,
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  SizedBox(
                    height: 70.h,
                    width: 340.w,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 200),
                      fadingDuration: const Duration(milliseconds: 400),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                        decoration: InputDecoration(
                            fillColor: const Color(0xFF12136B),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              borderSide: const BorderSide(
                                  color: Color(0xFF939393), width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            labelText: 'username',
                            labelStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                              color: Colors.white.withOpacity(0.5),
                            )),
                        onChanged: (val) {
                          setState(() {
                            val != "" ? _username = val : _username = "";
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 70.h,
                    width: 340.w,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 400),
                      fadingDuration: const Duration(milliseconds: 400),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        obscureText: _isobscure ? true : false,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14, right: 10, bottom: 14),
                              child: InkWell(
                                onTap: () {
                                  if (_isobscure) {
                                    setState(() {
                                      _isobscure = false;
                                      _lockImage = "images/lock_on.png";
                                    });
                                  } else {
                                    setState(() {
                                      _isobscure = true;
                                      _lockImage = "images/lock_off.png";
                                    });
                                  }
                                },
                                child: Image.asset(
                                  _lockImage,
                                ),
                              ),
                            ),
                            fillColor: const Color(0xFF12136B),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              borderSide: const BorderSide(
                                  color: Color(0xFF939393), width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            labelText: 'password',
                            labelStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.sp,
                              color: Colors.white.withOpacity(0.5),
                            )),
                        onChanged: (val) {
                          setState(() {
                            val != "" ? _password = val : "";
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - (55.h + 20),
              left: MediaQuery.of(context).size.width / 2 - (175.w / 2),
              child: Bounce(
                duration: const Duration(milliseconds: 110),
                onPressed: () {
                  if (_username == "" || _password == "") {
                    Flushbar(
                      messageText: Text(
                        "Please check your information!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                      ),
                      backgroundColor: Colors.redAccent,
                      duration: const Duration(seconds: 2),
                    ).show(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeAdmin()));
                  }
                },
                child: DelayedDisplay(
                  delay: const Duration(milliseconds: 600),
                  fadingDuration: const Duration(milliseconds: 400),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    width: 175.w,
                    height: 55.h,
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
