import 'dart:convert';

class Chapter {
  int? id;
  final String nameChapter;
  final String fileUrl;

  Chapter({
    this.id,
    required this.nameChapter,
    required this.fileUrl,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var filesData = json['attributes']['files']['data'];
    String fileUrl = '';
    if (filesData is List && filesData.isNotEmpty) {
      fileUrl = filesData[0]['attributes']['url'] ?? '';
    }

    return Chapter(
      id: json['id'],
      nameChapter: json['attributes']['nameChaper'],
      fileUrl: fileUrl,
    );
  }

  @override
  String toString() {
    return 'Chapter(id: $id, name: $nameChapter, fileUrl: $fileUrl)';
  }
}

// Phương thức để parse danh sách chapters từ JSON
List<Chapter> parseChapters(String jsonString) {
  final parsed = json.decode(jsonString);
  return (parsed['chapters']['data'] as List)
      .map((chapterJson) => Chapter.fromJson(chapterJson))
      .toList();
}