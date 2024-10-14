class FileUpload {
  String? id;
  String url;
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  Map<String, dynamic>? formats;

  FileUpload({
    this.id,
    required this.url,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      id: json['id']?.toString(),
      url: json['url'],
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      formats: json['formats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'alternativeText': alternativeText,
      'caption': caption,
      'width': width,
      'height': height,
      'formats': formats,
    };
  }

  @override
  String toString() => url;
}