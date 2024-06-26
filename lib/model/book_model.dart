import 'author_model.dart';
import 'category_model.dart';
import 'chapter_model.dart';
import 'file_upload.dart';

class Book {
  String? id;
  String? title;
  FileUpload? coverImage;
  String? description;
  int? pages;
  String? isbn;
  String? language;
  int? likes;
  int? view;
  List<Author>? authors;
  List<CategoryModel>? categories;
  List<Chapter>? chapters;

  Book({
    this.id,
    this.title,
    this.coverImage,
    this.description,
    this.pages,
    this.isbn,
    this.language,
    this.likes,
    this.view,
    this.authors,
    this.categories,
    this.chapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<String> getListValue(dynamic value) {
      if (value is List<dynamic>) {
        return value
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList();
      }
      return [];
    }

    String getCoverImageUrl(dynamic coverImageJson) {
      if (coverImageJson != null &&
          coverImageJson['data'] != null &&
          coverImageJson['data'].isNotEmpty) {
        var imageData = coverImageJson['data'][0]['attributes'];
        if (imageData != null && imageData['url'] != null) {
          return imageData['url'].toString();
        }
      }
      return '';
    }

    List<Author> getAuthors(dynamic authorsJson) {
      if (authorsJson != null && authorsJson['data'] != null) {
        return authorsJson['data']
            .map<Author>((author) => Author.fromJson(author))
            .toList();
      }
      return [];
    }

    List<CategoryModel> getCategories(dynamic categoriesJson) {
      if (categoriesJson != null && categoriesJson['data'] != null) {
        return categoriesJson['data']
            .map<CategoryModel>((category) => CategoryModel.fromJson(category))
            .toList();
      }
      return [];
    }

    List<Chapter> getChapters(dynamic chaptersJson) {
      if (chaptersJson != null && chaptersJson['data'] != null) {
        return chaptersJson['data']
            .map<Chapter>((chapter) => Chapter.fromJson(chapter))
            .toList();
      }
      return [];
    }

    return Book(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      coverImage: json['cover_image'] != null
          ? FileUpload.fromJson(json['cover_image']['data'][0]['attributes'])
          : null,
      description: json['description']?.toString(),
      pages: json['pages'] != null ? int.tryParse(json['pages'].toString()) : null,
      isbn: json['isbn']?.toString(),
      language: json['language']?.toString(),
      likes: json['likes'] != null ? int.tryParse(json['likes'].toString()) : null,
      view: json['view'] != null ? int.tryParse(json['view'].toString()) : null,
      authors: getAuthors(json['authors']),
      categories: getCategories(json['categories']),
      chapters: getChapters(json['chapters']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'title': title,
        'description': description,
        'pages': pages,
        'isbn': isbn,
        'language': language,
        'likes': likes,
        'view': view,
        "authors": {
          "connect": authors?.map((author) => author.id).toList() ?? [], // Kiểm tra nếu authors là null
        },
        "categories": {
          "connect": categories?.map((category) => category.id).toList() ?? [], // Kiểm tra nếu categories là null
        },
        'cover_image': coverImage?.toJson(), // Kiểm tra nếu coverImage là null
      },
    };
  }
}
