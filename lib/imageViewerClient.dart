import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageViewerClient extends StatefulWidget {
  const ImageViewerClient(
      {super.key, required this.lst_photos, required this.index});
  final List<String> lst_photos;
  final int index;
  @override
  State<ImageViewerClient> createState() => _ImageViewerClientState();
}

class _ImageViewerClientState extends State<ImageViewerClient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.r),
                  child: Container(
                    alignment: Alignment.center,
                    height: 32.r,
                    width: 45.r,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.lst_photos.isNotEmpty
                            ? '${widget.index + 1} / ${widget.lst_photos.length}'
                            : '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 25.sp,
                        ),
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
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                ),
                items: widget.lst_photos
                    .map(
                      (e) => Container(
                        alignment: Alignment.center,
                        color: Colors.pink,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          (widget.lst_photos.indexOf(e) + 1).toString(),
                          style: TextStyle(fontSize: 40),
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
