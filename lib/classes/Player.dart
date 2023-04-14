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
}
