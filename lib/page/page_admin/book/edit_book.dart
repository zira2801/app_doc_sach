import 'dart:io';
import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/book_model.dart';
import '../../../model/author_model.dart';
import '../../../model/category_model.dart';
import '../../../controller/book_controller.dart';
import '../../../controller/author_controller.dart';
import '../../../controller/category_controller.dart';
import '../../../color/mycolor.dart';

class EditBookPage extends StatefulWidget {
  final Book book;
  const EditBookPage({Key? key, required this.book}) : super(key: key);

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _pagesController;
  late TextEditingController _isbnController;
  late TextEditingController _languageController;

  List<Author> _authors = [];
  List<CategoryModel> _categories = [];
  List<Author> _selectedAuthors = [];
  List<CategoryModel> _selectedCategories = [];
  String? _imagePath;
  File? _newImageFile;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _descriptionController = TextEditingController(text: widget.book.description);
    _pagesController = TextEditingController(text: widget.book.pages.toString());
    _isbnController = TextEditingController(text: widget.book.isbn);
    _languageController = TextEditingController(text: widget.book.language);
    _selectedAuthors = List.from(widget.book.authors ?? []);
    _selectedCategories = List.from(widget.book.categories ?? []);
    _imagePath = widget.book.coverImage?.url;
    _loadAuthors();
    _loadCategories();
  }

  Future<void> _loadAuthors() async {
    try {
      final List<Author> fetchedAuthors = await AuthorController.instance.fetchAuthors();
      setState(() {
        _authors = fetchedAuthors;
      });
    } catch (e) {
      print('Error loading authors: $e');
    }
  }

  Future<void> _loadCategories() async {
    try {
      final List<CategoryModel> fetchedCategories = await CategoryController.instance.fetchCategories();
      setState(() {
        _categories = fetchedCategories;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  void _showAuthorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn tác giả'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _authors.map((author) {
                return CheckboxListTile(
                  title: Text(author.authorName),
                  value: _selectedAuthors.any((selectedAuthor) => selectedAuthor.authorName == author.authorName),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        if (!_selectedAuthors.any((selectedAuthor) => selectedAuthor.authorName == author.authorName)) {
                          _selectedAuthors.add(author);
                        }
                      } else {
                        _selectedAuthors.removeWhere((selectedAuthor) => selectedAuthor.authorName == author.authorName);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn thể loại'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _categories.map((category) {
                return CheckboxListTile(
                  title: Text(category.nameCategory),
                  value: _selectedCategories.any((selectedCategory) => selectedCategory.nameCategory == category.nameCategory),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        if (!_selectedCategories.any((selectedCategory) => selectedCategory.nameCategory == category.nameCategory)) {
                          _selectedCategories.add(category);
                        }
                      } else {
                        _selectedCategories.removeWhere((selectedCategory) => selectedCategory.nameCategory == category.nameCategory);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _newImageFile = File(result.files.single.path!);
      });
    }
  }

  void _updateBook() async {
    if (_formKey.currentState!.validate()) {
      // Tạo đối tượng Book mới với thông tin đã cập nhật
      Book updatedBook = Book(
        id: widget.book.id,
        title: _titleController.text,
        description: _descriptionController.text,
        pages: int.parse(_pagesController.text),
        isbn: _isbnController.text,
        language: _languageController.text,
        authors: _selectedAuthors,
        categories: _selectedCategories,
      );

      // Kiểm tra xem có ảnh mới được chọn không
      dynamic newImageData = _imagePath != widget.book.coverImage?.url ? _imagePath : null;

      bool success = await BookController.instance.updateBook(updatedBook, newImageData);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sách đã được cập nhật thành công')),
        );
        Navigator.pop(context); // Quay lại màn hình trước
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể cập nhật sách. Vui lòng thử lại')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa thông tin sách'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_backspace_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề sách',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _isbnController,
                  decoration: const InputDecoration(
                    labelText: 'ISBN',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pagesController,
                  decoration: const InputDecoration(
                    labelText: 'Số trang',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _languageController,
                  decoration: const InputDecoration(
                    labelText: 'Ngôn ngữ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedAuthors.map((author) {
                          return Chip(
                            label: Text(author.authorName),
                            onDeleted: () {
                              setState(() {
                                _selectedAuthors.remove(author);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _showAuthorDialog,
                  child: const Text('Chọn tác giả'),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedCategories.map((category) {
                          return Chip(
                            label: Text(category.nameCategory),
                            onDeleted: () {
                              setState(() {
                                _selectedCategories.remove(category);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _showCategoryDialog,
                  child: const Text('Chọn thể loại'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _newImageFile != null
                          ? Image.file(_newImageFile!, fit: BoxFit.cover)
                          : (_imagePath != null
                          ? Image.network(
                        baseUrl+_imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Error loading image'));
                        },
                      )
                          : const Center(child: Text('No image selected'))),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Chọn ảnh bìa'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _updateBook,
                  child: const Text('Cập nhật sách'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}