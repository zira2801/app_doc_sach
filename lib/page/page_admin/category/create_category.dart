import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/model/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/page/page_admin/category/display_category.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../color/mycolor.dart';

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
          Uri.parse("$baseUrl/api/categories/"),
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
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Thêm thể loại mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              // padding: const EdgeInsets.all(20),
              // height: 500, // Adjusted height to make the form longer
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.3), // reduced opacity
              //       spreadRadius: 2, // reduced spread radius
              //       blurRadius: 5, // reduced blur radius
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: double.infinity,//nó sẽ chiếm toàn bộ chiều rộng có sẵn của không gian bố cục.
                  //   color: Colors.white,
                  //   child: Textfield(
                  //     controller: nameController,
                  //     //onChanged là một callback được gọi khi giá trị của TextField thay đổi.
                  //     //Trong callback này, giá trị mới của TextField (val)
                  //     //được gán cho thuộc tính name của đối tượng category.
                  //     onChanged: (val) {
                  //       category.nameCategory = val;
                  //     },
                  //     hintText: 'Name',
                  //     icon: const Icon(Icons.book_sharp),
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   width: double.infinity,
                  //   child: Textfield(
                  //     controller: descriptionController,
                  //     onChanged: (val) {
                  //       category.desCategory = val;
                  //     },
                  //     hintText: 'Description',
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //     icon: const Icon(Icons.description),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        category.nameCategory = val;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Tên thể loại',
                        hintText: 'Nhập tên thể loại',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        category.desCategory = val;
                      },
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        labelStyle: const TextStyle(fontSize: 16),
                        hintText: 'Nhập mô tả thể loại',
                        floatingLabelBehavior: FloatingLabelBehavior.always, // Đặt thuộc tính này để labelText luôn nằm lên trên
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: Colors.black,
                  //       padding: const EdgeInsets.symmetric(vertical: 15),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //     onPressed: save,
                  //     child: const Text('Save'),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(MyColor.primaryColor), // Màu nền
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Màu chữ
                          minimumSize: MaterialStateProperty.all(Size(120, 50)), // Kích thước tối thiểu của button
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)), // Đệm bên trong button
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 15), // Cỡ chữ
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (nameController.text.isEmpty ||
                                descriptionController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff2A303E),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 20,),
                                          Image.asset('assets/icon/error.png',width: 50,),
                                          const SizedBox(height: 20,),
                                          Text('Thông tin bạn nhập chưa đầy đủ',
                                              style: GoogleFonts.montserrat(fontSize: 11, color: const Color(0xffEC5B5B), fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 5,),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              if (nameController.text.isEmpty)
                                                Text('• Vui lòng nhập tên thể loại',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (descriptionController.text.isEmpty)
                                                Text('• Vui lòng nhập mô tả thể loại',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              const SizedBox(height: 20,),
                                              Center(
                                                child: OutlinedButton(
                                                  onPressed: () {Navigator.of(context).pop();},
                                                  style: OutlinedButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                                      foregroundColor: const Color(0xffEC5B5B),
                                                      side: const BorderSide(color: Color(0xffEC5B5B),)
                                                  ),
                                                  child: const Text('Đóng'),
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              save();
                            }
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline_sharp,color: Colors.white,), // Biểu tượng
                            SizedBox(width: 5), // Khoảng cách giữa icon và văn bản
                            Text('Thêm'), // Văn bản
                          ],
                        ),
                      ),
                      const SizedBox(width: 85,),
                      ElevatedButton(
                        onPressed: () {
                          _refreshForm(); // Gọi hàm để làm mới form
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Màu nền
                          minimumSize: Size(120, 50), // Kích thước tối thiểu của button
                          padding: EdgeInsets.all(16), // Đệm bên trong button
                          textStyle: TextStyle(fontSize: 15), // Cỡ chữ
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh,color: Colors.white,), // Biểu tượng
                            SizedBox(width: 5), // Khoảng cách giữa icon và văn bản
                            Text('Làm mới'), // Văn bản
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _refreshForm() {
    setState(() {
      nameController.clear();
      descriptionController.clear();
    });
  }
}

