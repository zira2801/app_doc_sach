import 'package:intl/intl.dart';

class Author {
  int id;
   String authorName;
  DateTime birthDate;
  String born;
  String telphone;
  String nationality;
  String bio;

  Author({
    required this.id,
    required this.authorName,
    required this.birthDate,
    required this.born,
    required this.telphone,
    required this.nationality,
    required this.bio,
  });
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      authorName: json['attributes']['authorName'] ?? '',
      birthDate: DateTime.parse(json['attributes']['birthDate']),
      born: json['attributes']['born'] ?? '',
      telphone: json['attributes']['telephone'] ?? '',
      nationality: json['attributes']['nationality'] ?? '',
      bio: json['attributes']['bio'] ?? '',
    );
  }
  @override
  String toString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return 'Author(id: $id, authorName: $authorName, birthDate: ${formatter.format(birthDate)}, born: $born, telphone: $telphone, nationality: $nationality, bio: $bio)';
  }
}
