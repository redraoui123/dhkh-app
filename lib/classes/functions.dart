import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhkhapp/classes/Admin.dart';
import 'package:dhkhapp/classes/photo.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'Player.dart';

class Functions {
  static int img_number = 0;
  // generate an id for image in imagelist of player
  static String generateRandomString() {
    Random random = Random();
    String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String numbers = '0123456789';

    String randomLetters = '';
    for (int i = 0; i < 2; i++) {
      randomLetters += letters[random.nextInt(letters.length)];
    }

    String randomNumbers = '';
    for (int i = 0; i < 2; i++) {
      randomNumbers += numbers[random.nextInt(numbers.length)];
    }

    String randomString = '$randomLetters$randomNumbers';
    randomLetters = '';
    for (int i = 0; i < 2; i++) {
      randomLetters += letters[random.nextInt(letters.length)];
    }

    randomNumbers = '';
    for (int i = 0; i < 2; i++) {
      randomNumbers += numbers[random.nextInt(numbers.length)];
    }

    randomString += '$randomLetters$randomNumbers';
    return randomString;
  }

  // upload profile picture of player
  static Future<String> uploadProfilePicture(String bytes) async {
    String photoId = "";
    Photo photo = Photo(id: photoId, base64: bytes);
    //upload image to Photos document
    final docImages =
        FirebaseFirestore.instance.collection('photos').doc(photo.id);

    //set Photo
    await docImages.set(photo.toMap());

    return photo.id.toString();
  }

  static Future<String> uploadImage(
      String imgPath, BuildContext context, String msg) async {
    String retrieved_link = "";
    const clientID = 'eb38b2f37cf720c';
    final headers = {'Authorization': 'Client-ID $clientID'};

    final image = File(imgPath);
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

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
                  'Uploading $msg',
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
    final response = await http.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: headers,
      body: {'image': base64Image},
    );
    Navigator.pop(context); // Dismiss the progress dialog
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final link = jsonResponse['data']['link'];
      retrieved_link = link;
      print('Image link: $link');
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }

    return retrieved_link;
  }

  // upload player
  static Future createPlayer({required Player player}) async {
    // Reference to document
    final docPlayer = FirebaseFirestore.instance.collection('players').doc(
        "${player.fullName!.split(' ')[0]}_${player.fullName!.split(' ')[1]}");

    await docPlayer.set(player.toMap());
  }

  // upload Admin info
  static Future saveAdminInfo(
      {required Admin admin, required BuildContext context}) async {
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
                  'Uploading Admin infos',
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

    // Reference to document
    final docPlayer =
        FirebaseFirestore.instance.collection('admin').doc("admin");

    await docPlayer.set(admin.toMap());

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
