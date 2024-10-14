import 'package:app_doc_sach/model/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_doc_sach/const/constant.dart';
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

CategoryModel category = CategoryModel(id:  0,nameCategory:  '',desCategory:  '');
//TextEditingController là một lớp trong Flutter để quản lý trạng thái và xử lý dữ liệu của một TextField.
TextEditingController nameController =
    TextEditingController(text: category.nameCategory);
TextEditingController descriptionController =
    TextEditingController(text: category.desCategory);

class _CreateCategoryState extends State<CreateCategory> {
  //Phương thức save được định nghĩa để gửi một yêu cầu POST đến API để tạo mới một danh mục.
  Future save() async {
    try {
      Map data = {
        'data': {
          "name": category.nameCategory,
          "Description": category.desCategory,
        }
      };
      // Encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(
          Uri.parse("http://192.168.1.5:1337/api/categories/"),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
          },
          body: body);
        //Nếu yêu cầu thành công, 
        //ứng dụng sẽ điều hướng đến màn hình DisplayCategory 
        //và xóa tất cả các màn hình khác trong stack điều hướng.
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
                  width: double.infinity,//nó sẽ chiếm toàn bộ chiều rộng có sẵn của không gian bố cục.
                  color: Colors.white,
                  child: Textfield(
                    controller: nameController,
                    //onChanged là một callback được gọi khi giá trị của TextField thay đổi.
                    //Trong callback này, giá trị mới của TextField (val) 
                    //được gán cho thuộc tính name của đối tượng category.
                    onChanged: (val) {
                      category.nameCategory = val;
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
                      category.desCategory = val;
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
