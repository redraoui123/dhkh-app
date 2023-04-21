import 'package:dhkhapp/main.dart';

class Admin {
  final String? name;
  final String? phone;
  final String? picture;

  Admin({
    required this.name,
    required this.phone,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      '_name': name,
      '_phone': phone,
      '_picture': picture,
    };
  }
}
