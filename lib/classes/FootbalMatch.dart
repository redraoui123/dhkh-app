import 'package:dhkhapp/main.dart';

class FootbalMatch {
  final String? awayName;
  final String? awayScore;
  final String? teamLogo;
  final String? video;

  FootbalMatch(
      {required this.awayName,
      required this.awayScore,
      required this.teamLogo,
      required this.video});

  Map<String, dynamic> toMap() {
    return {
      '_awayName': awayName,
      '_awayScore': awayScore,
      '_teamLogo': teamLogo,
      '_video': video,
    };
  }
}
