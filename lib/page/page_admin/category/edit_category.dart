import 'dart:convert';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/page/page_admin/category/display_category.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditCategory extends StatefulWidget {
  final Category? categories;
  const EditCategory({Key? key, this.categories});
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.categories?.name);
    descriptionController = TextEditingController(text: widget.categories?.Description);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void editCategory(
      {required Category categories,
      required String name,
      required String Description}) async {
    Map data1 = {
      'data': {
        "name": name,
        "Description": Description,
      }
    };
    //encode Map to JSON
    var body = json.encode(data1);
    final response = await http.put(
        Uri.parse(
          "http://192.168.1.7:1337/api/categories/${categories.id}",
        ),
        headers: <String, String>{
          'content-type': 'application/json;charset=UTF-8',
        },
        body: body);
    print(response.body);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const DisplayCategory()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Edit Category'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 500, // Adjusted height to make the form longer
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // reduced opacity
                  spreadRadius: 2, // reduced spread radius
                  blurRadius: 5, // reduced blur radius
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: nameController,
                    onChanged: (val) {
                      setState(() {
                        widget.categories?.name = val;
                      });
                    },
                    hintText: 'Name',
                    icon: const Icon(Icons.book_sharp),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: descriptionController,
                    onChanged: (val) {
                      setState(() {
                        widget.categories?.Description = val;
                      });
                    },
                    hintText: 'Description',
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: const Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      editCategory(
                        categories: widget.categories!,
                        name: nameController.text,
                        Description: descriptionController.text,
                      );
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
