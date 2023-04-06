import 'package:dhkhapp/main.dart';

class Player {
  final int? id;
  final String? fullName;
  final int? phoneNumber;
  final int? stripNumber;
  final String? profilePicture;
  final List<String?> images_list;
  final bool? hasPaid;
  final int? toPay;

  Player(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.stripNumber,
      required this.profilePicture,
      required this.images_list,
      required this.hasPaid,
      required this.toPay});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      '_fullName': fullName,
      '_phoneNumber': phoneNumber,
      '_stripNumber': stripNumber,
      '_profilePicture': profilePicture,
      '_imageList': images_list,
      '_hasPaid': hasPaid,
      '_toPay': toPay,
    };
  }

  // return players list from map
  static Player fromMap(Map<String, Object?> map) {
    return Player(
        id: map['_id'] as int?,
        fullName: map['_fullName'] as String?,
        phoneNumber: map['_phoneNumber'] as int?,
        stripNumber: map['_stripNumber'] as int?,
        profilePicture: map['_profilePicture'] as String?,
        images_list: map['_imageList'] as List<String?>,
        hasPaid: map['_hasPaid'] as bool?,
        toPay: map['_toPay'] as int?);
  }
}
