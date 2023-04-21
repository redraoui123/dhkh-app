import 'package:dhkhapp/main.dart';

class Player {
  final String? fullName;
  final int? phoneNumber;
  final int? stripNumber;
  final String? profilePicture;
  final List<String?> images_list;
  final bool? hasPaid;
  final int? toPay;

  Player(
      {required this.fullName,
      required this.phoneNumber,
      required this.stripNumber,
      required this.profilePicture,
      required this.images_list,
      required this.hasPaid,
      required this.toPay});

  Map<String, dynamic> toMap() {
    return {
      '_fullName': fullName,
      '_phoneNumber': phoneNumber,
      '_stripNumber': stripNumber,
      '_profilePicture': profilePicture,
      '_imageList': images_list,
      '_hasPaid': hasPaid,
      '_toPay': toPay,
    };
  }
}
