import 'author_model.dart';
import 'category_model.dart';

class Book {
  String? id;
  String title;
  String coverImage;
  String description;
  int pages;
  String isbn;
  String language;
  int likes;
  int view;
  List<Author> authors;
  List<CategoryModel> categories;
  List<String> chapters;
  Book({
    this.id,
    required this.title,
    required this.coverImage,
    required this.description,
    required this.pages,
    required this.isbn,
    required this.language,
    required this.authors,
    required this.categories,
    required this.chapters,
    required this.likes,
    required this.view
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Hàm hỗ trợ để lấy danh sách chuỗi từ một mảng
    List<String> getListValue(dynamic value) {
      if (value is List<dynamic>) {
        return value
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList();
      }
      return [];
    }

    // Hàm hỗ trợ để lấy URL hình ảnh bìa từ JSON
    String getCoverImageUrl(dynamic coverImageJson) {
      if (coverImageJson != null && coverImageJson['data'] != null && coverImageJson['data'].isNotEmpty) {
        var imageData = coverImageJson['data'][0]['attributes'];
        if (imageData != null && imageData['url'] != null) {
          return imageData['url'].toString();
        }
      }
      return '';
    }
// Extract authors from the JSON structure
    List<Author> getAuthors(dynamic authorsJson) {
      if (authorsJson != null && authorsJson['data'] != null) {
        return authorsJson['data']
            .map<Author>((author) => Author.fromJson(author))
            .toList();
      }
      return [];
    }

    // Extract categories from the JSON structure
    List<CategoryModel> getCategories(dynamic categoriesJson) {
      if (categoriesJson != null && categoriesJson['data'] != null) {
        return categoriesJson['data']
            .map<CategoryModel>((category) => CategoryModel.fromJson(category))
            .toList();
      }
      return [];
    }
    // Tạo đối tượng Book từ JSON
    Book book = Book(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      coverImage: getCoverImageUrl(json['cover_image']),
      description: json['description']?.toString() ?? '',
      pages: json['pages'] != null ? int.tryParse(json['pages'].toString()) ?? 0 : 0,
      isbn: json['isbn']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      authors: getAuthors(json['authors']),
      categories: getCategories(json['categories']),
      chapters: getListValue(json['chapters']),
      likes: json['likes'] != null ? int.tryParse(json['likes'].toString()) ?? 0 : 0,
      view: json['view'] != null ? int.tryParse(json['view'].toString()) ?? 0 : 0,
    );
// In ra thông tin của đối tượng Book
    print('ID: ${book.id}');
    print('Title: ${book.title}');
    print('Cover Image URL: ${book.coverImage}');
    print('Description: ${book.description}');
    print('Pages: ${book.pages}');
    print('ISBN: ${book.isbn}');
    print('Language: ${book.language}');
    print('Authors: ${book.authors}');
    print('Categories: ${book.categories}');

    // Trả về đối tượng Book đã tạo
    return book;
  }
}
