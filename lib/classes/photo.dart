class Photo {
  final String? id;
  final String? base64;

  Photo({required this.id, required this.base64});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      '_base64': base64,
    };
  }
}
