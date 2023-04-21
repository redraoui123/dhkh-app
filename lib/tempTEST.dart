// import 'dart:convert';
// import 'dart:io';

// import 'package:dhkhapp/classes/Player.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class TMPTEST extends StatefulWidget {
//   const TMPTEST({super.key});

//   @override
//   State<TMPTEST> createState() => _TMPTESTState();
// }

// class _TMPTESTState extends State<TMPTEST> {
//   String profile_Picture = "";
//   ImagePicker picker = ImagePicker();
//   Player player = Player(
//       fullName: 'fullName',
//       phoneNumber: 0645454545,
//       stripNumber: 17,
//       profilePicture: 'profilePicture',
//       images_list: [],
//       hasPaid: false,
//       toPay: 25);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: InkWell(
//             onTap: () {
//               profile_Picture != ""
//                   ? uploadImage(profile_Picture, context)
//                   : null;
//             },
//             child: const Text('Upload Image')),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: profile_Picture != ""
//             ? InkWell(
//                 onTap: () {
//                   setState(() {
//                     profile_Picture = "";
//                   });
//                 },
//                 child: Image.file(File(profile_Picture)))
//             : Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF000B46),
//                   borderRadius: BorderRadius.circular(2100),
//                   border: Border.all(color: Colors.white, width: 1),
//                 ),
//                 child: InkWell(
//                   onTap: () async {
//                     // get photo from gallery
//                     final piickedFile =
//                         await picker.pickImage(source: ImageSource.gallery);
//                     if (piickedFile != null) {
//                       File? croppedFile = await ImageCropper().cropImage(
//                         sourcePath: piickedFile.path,
//                         aspectRatioPresets: [
//                           CropAspectRatioPreset.square,
//                           CropAspectRatioPreset.ratio3x2,
//                           CropAspectRatioPreset.original,
//                           CropAspectRatioPreset.ratio4x3,
//                           CropAspectRatioPreset.ratio16x9
//                         ],
//                         androidUiSettings: const AndroidUiSettings(
//                           toolbarColor: Color.fromARGB(255, 6, 0, 85),
//                           toolbarTitle: 'Edit Photo',
//                           toolbarWidgetColor: Colors.white,
//                           activeControlsWidgetColor: Colors.redAccent,
//                           backgroundColor: Color.fromARGB(255, 44, 44, 44),
//                         ),
//                       );
//                       if (croppedFile != null) {
//                         setState(() {
//                           profile_Picture = croppedFile.path;
//                         });
//                       }
//                     }
//                   },
//                   child: const Icon(
//                     Icons.camera_alt,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   Future<String> uploadImage(String imgPath, BuildContext context) async {
//     String retrieved_link = "";
//     const clientID = 'eb38b2f37cf720c';
//     final headers = {'Authorization': 'Client-ID $clientID'};

//     final image = File(imgPath);
//     final bytes = await image.readAsBytes();
//     final base64Image = base64Encode(bytes);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             height: 120.r,
//             decoration: BoxDecoration(
//               color: const Color(0xFF000B46),
//               border: Border.all(
//                 color: Colors.white,
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Uploading Image(s)',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w100,
//                     fontFamily: 'Inter',
//                     fontSize: 20.sp,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.r,
//                 ),
//                 const CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 1.2,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     final response = await http.post(
//       Uri.parse('https://api.imgur.com/3/image'),
//       headers: headers,
//       body: {'image': base64Image},
//     );
//     Navigator.pop(context); // Dismiss the progress dialog
//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       final link = jsonResponse['data']['link'];
//       print('Image link: $link');

//       setState(() {
//         retrieved_link = link;
//       });
//     } else {
//       print('Failed to upload image: ${response.statusCode}');
//     }

//     return retrieved_link;
//   }
// }
