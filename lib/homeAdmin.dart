import 'package:dhkhapp/addPlayer.dart';
import 'package:dhkhapp/playersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _homeScore = 0;
  int _awayScore = 0;
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
                                onTap: () {
                                  // get photo from gallery
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
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 15.sp,
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
}
