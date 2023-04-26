import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dhkhapp/auth.dart';
import 'package:dhkhapp/classes/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:delayed_display/delayed_display.dart';

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// prevent screenshot
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(390, 844),
      builder: ((context, child) {
        return MaterialApp(
          title: 'DHKH App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 6, 0, 85),
            child: Image.asset('images/background.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Authenticate()));

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const TMPTEST()));
              },
              child: DelayedDisplay(
                delay: const Duration(milliseconds: 400),
                child: Hero(
                  tag: 'mylogo',
                  child: Image.asset(
                    'images/mylogo.png',
                    width: 266.w,
                    height: 266.h,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: DelayedDisplay(
                delay: const Duration(seconds: 1),
                child: InkWell(
                  onTap: () async {
                    await Functions.deleteAllImages(
                        '6ad38cb939406bd26f8f0137dc07c39cc0992cb7');
                    // ignore: use_build_context_synchronously
                    Flushbar(
                      messageText: Text(
                        "All images are deleted successfully",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          fontSize: 20.sp,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ).show(context);
                  },
                  child: Text(
                    'reset all imgur images',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
