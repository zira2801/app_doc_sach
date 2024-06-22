import 'package:intl/intl.dart';

class Author {
  final int id;
  late final String authorName;
  late final DateTime birthDate;
  late final String born;
  late final String telphone;
  late final String nationality;
  late final String bio;

  Author({
    required this.id,
    required this.authorName,
    required this.birthDate,
    required this.born,
    required this.telphone,
    required this.nationality,
    required this.bio,
  });

  @override
  String toString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return 'Author(id: $id, authorName: $authorName, birthDate: ${formatter.format(birthDate)}, born: $born, telphone: $telphone, nationality: $nationality, bio: $bio)';
  }
}
