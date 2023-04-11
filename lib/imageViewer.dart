import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.imageURL});
  final String? imageURL;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            color: const Color(0xFF030A32),
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(
                color: Color(0xFF030A32),
              ),
              imageProvider: FileImage(File(widget.imageURL.toString())),
            ),
          ),
        ),
      ),
    );
  }
}
