import 'package:flutter/material.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/page/page_admin/category/display_category.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCategory extends StatefulWidget {
  final int? id;
  const CreateCategory({Key? key, this.id});
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

Category category = Category(0, '', '');
TextEditingController nameController =
    TextEditingController(text: category.name);
TextEditingController descriptionController =
    TextEditingController(text: category.Description);

class _CreateCategoryState extends State<CreateCategory> {
  Future save() async {
    try {
      Map data1 = {
        'data': {
          "name": category.name,
          "Description": category.Description,
        }
      };
      // Encode Map to JSON
      var body = json.encode(data1);
      var response = await http.post(
          Uri.parse("http://192.168.1.7:1337/api/categories/"),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
          },
          body: body);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const DisplayCategory()),
          (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  print(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Create Category'),
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
                  color: Colors.white,
                  child: Textfield(
                    controller: nameController,
                    onChanged: (val) {
                      category.name = val;
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
                      category.Description = val;
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
                    onPressed: save,
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