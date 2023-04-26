import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhkhapp/classes/Admin.dart';
import 'package:dhkhapp/classes/FootbalMatch.dart';
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

// upload image to imgur
  static Future<String> uploadImage(
      String imgPath, BuildContext context, String msg) async {
    String retrieved_link = "";
    const clientID = '4b3921ad0dff3ca';
    final headers = {'Authorization': 'Client-ID $clientID'};

    final image = File(imgPath);
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    // ignore: use_build_context_synchronously
    _showMyDialog(context, msg);

    final response = await http.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: headers,
      body: {'image': base64Image},
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final link = jsonResponse['data']['link'];
      retrieved_link = link;
      debugPrint('Image link: $link');
    } else {
      debugPrint('Failed to upload image: ${response.statusCode}');
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
    _showMyDialog(context, 'Uploading Admin infos');

    // Reference to document
    final docPlayer =
        FirebaseFirestore.instance.collection('admin').doc("admin");

    await docPlayer.set(admin.toMap());

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  // read Admin info
  static Future<Admin?> getAdminInfo() async {
    DocumentSnapshot<Map<String, dynamic>> adminSnapshot =
        await FirebaseFirestore.instance.collection('admin').doc("admin").get();

    if (adminSnapshot.exists) {
      return Admin(
        name: adminSnapshot.data()!['_name'],
        phone: adminSnapshot.data()!['_phone'],
        picture: adminSnapshot.data()!['_picture'],
      );
    } else {
      return null;
    }
  }

// upload Match
  static Future createMatch(
      {required FootbalMatch match, required BuildContext context}) async {
    _showMyDialog(context, 'Creating Match');
    // Reference to document
    final docMatch =
        FirebaseFirestore.instance.collection('match').doc('match');
    Navigator.pop(context);
    await docMatch.set(match.toMap());
  }

// read Match
  static Future<FootbalMatch?> getMatch() async {
    DocumentSnapshot<Map<String, dynamic>> adminSnapshot =
        await FirebaseFirestore.instance.collection('match').doc("match").get();

    if (adminSnapshot.exists) {
      return FootbalMatch(
        awayName: adminSnapshot.data()!['_awayName'],
        awayScore: adminSnapshot.data()!['_awayScore'],
        teamLogo: adminSnapshot.data()!['_teamLogo'],
        video: adminSnapshot.data()!['_video'],
      );
    } else {
      return null;
    }
  }

  static _showMyDialog(BuildContext context, String message) {
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
                  'Uploading $message',
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

// temporary function to delete all imgur uploaded images
//-----------------------------------------------------------------------------------------//
  static Future<void> deleteAllImages(String accessToken) async {
    const url = 'https://api.imgur.com/3/account/me/images';
    final headers = {'Authorization': 'Bearer $accessToken'};

    try {
      // Retrieve all images uploaded by the user
      final response = await http.get(Uri.parse(url), headers: headers);
      final data = jsonDecode(response.body);

      if (data['success']) {
        final images = data['data'];

        // Delete each image one by one
        for (final image in images) {
          await deleteImage(accessToken, image['deletehash']);
        }

        print('All images deleted successfully');
      } else {
        throw Exception('Failed to retrieve images');
      }
    } catch (error) {
      print('Error occurred while deleting images: $error');
    }
  }

  static Future<void> deleteImage(String accessToken, String deleteHash) async {
    final url = 'https://api.imgur.com/3/image/$deleteHash';
    final headers = {'Authorization': 'Bearer $accessToken'};

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('Image deleted successfully');
      } else {
        throw Exception('Failed to delete image');
      }
    } catch (error) {
      print('Error occurred while deleting image: $error');
    }
  }
}
