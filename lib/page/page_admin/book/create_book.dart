import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/author_model.dart';
import '../../../model/book_model.dart';
import '../../../model/category_model.dart';

class BookCreate extends StatefulWidget {
  const BookCreate({Key? key}) : super(key: key);

  @override
  _BookCreateState createState() => _BookCreateState();
}

class _BookCreateState extends State<BookCreate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _coverImageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _likesController = TextEditingController();
  final TextEditingController _viewController = TextEditingController();

  List<Author> _authors = []; // Populate this list from your data source
  List<CategoryModel> _categories = []; // Populate this list from your data source

  Author? _selectedAuthor;
  CategoryModel? _selectedCategory;
  File? _imageFile; // To store the selected image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sách mới'),
        elevation: 0.0,
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
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Tiêu đề sách'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được bỏ trống tiêu đề sách';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _isbnController,
                  decoration: const InputDecoration(labelText: 'ISBN'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được bỏ trống ISBN';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được bỏ trống Mô tả';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pagesController,
                  decoration: const InputDecoration(labelText: 'Số trang'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được bỏ trống Số trang';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _languageController,
                  decoration: const InputDecoration(labelText: 'Ngôn ngữ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được bỏ trống Ngôn ngữ';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<Author>(
                  decoration: const InputDecoration(labelText: 'Tác giả'),
                  value: _selectedAuthor,
                  items: _authors.map((Author author) {
                    return DropdownMenuItem<Author>(
                      value: author,
                      child: Text(author.authorName),
                    );
                  }).toList(),
                  onChanged: (Author? newValue) {
                    setState(() {
                      _selectedAuthor = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Hãy chọn tác giả';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<CategoryModel>(
                  decoration: const InputDecoration(labelText: 'Thể loại'),
                  value: _selectedCategory,
                  items: _categories.map((CategoryModel category) {
                    return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Text(category.nameCategory),
                    );
                  }).toList(),
                  onChanged: (CategoryModel? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Hãy chọn thể loại';
                    }
                    return null;
                  },
                ),
                // Inside _BookCreateState build method
                _imageFile != null
                    ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: _pickImage,
                  tooltip: 'Chọn ảnh bìa',
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(); // Call function to pick an image
                  },
                  child: const Text('Chọn ảnh bìa'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Book newBook = Book(
                        title: _titleController.text,
                        coverImage: _coverImageController.text,
                        description: _descriptionController.text,
                        pages: int.parse(_pagesController.text),
                        isbn: _isbnController.text,
                        language: _languageController.text,
                        authors: [_selectedAuthor!],
                        categories: [_selectedCategory!],
                        chapters: [],
                        likes: int.parse(_likesController.text),
                        view: int.parse(_viewController.text),
                      );
                      // Process the new book data here (e.g., save to a database or API call)
                      print(newBook);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

}
