import 'dart:io';
import 'dart:ui';

import 'package:dhkhapp/imageViewerClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class ListImagesClient extends StatefulWidget {
  const ListImagesClient({super.key});

  @override
  State<ListImagesClient> createState() => _ListImagesClientState();
}

class _ListImagesClientState extends State<ListImagesClient> {
  List<String> lst_photos_tmp = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              actions: [
                Container(
                  alignment: Alignment.center,
                  height: 32.r,
                  width: 45.r,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      lst_photos_tmp.isNotEmpty
                          ? lst_photos_tmp.length.toString()
                          : '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: const Color(0xFF030A32),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Photos List',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 25.sp,
                ),
              )),
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
              lst_photos_tmp.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No Photos',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'Inter',
                          fontSize: 25.sp,
                        ),
                      ),
                    )
                  : IntrinsicGridView.vertical(
                      columnCount: 2,
                      margin: EdgeInsets.all(5.r),
                      children: lst_photos_tmp
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                  top: 10.r,
                                  right: 10.r,
                                  left: 10.r,
                                  bottom: 10.r),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageViewerClient(
                                                lst_photos: lst_photos_tmp,
                                                index:
                                                    lst_photos_tmp.indexOf(e),
                                              )));
                                },
                                child: Container(
                                  height: 250.r,
                                  width: 160.r,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF051152),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(e),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
