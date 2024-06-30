import 'dart:convert';
import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/page/page_admin/category/display_category.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../const.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel? categories;
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
    nameController = TextEditingController(text: widget.categories?.nameCategory);
    descriptionController = TextEditingController(text: widget.categories?.desCategory);
  }

//Phương thức dispose được gọi khi StatefulWidget bị hủy, để giải phóng các tài nguyên đã sử dụng.
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void editCategory(
      {required CategoryModel categories,
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
          "$baseUrl/api/categories/${categories.id}",
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
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Sửa thông tin thể loại'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_backspace_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  //   width: double.infinity,
                  //   child: Textfield(
                  //     controller: nameController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         widget.categories?.nameCategory = val;
                  //       });
                  //     },
                  //     hintText: 'Name',
                  //     icon: const Icon(Icons.book_sharp),
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.categories?.nameCategory = val;
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
                  // const SizedBox(height: 20),
                  // Container(
                  //   width: double.infinity,
                  //   child: Textfield(
                  //     controller: descriptionController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         widget.categories?.desCategory = val;
                  //       });
                  //     },
                  //     hintText: 'Description',
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //     icon: const Icon(Icons.description),
                  //   ),
                  // ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.categories?.desCategory = val;
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
                  //     onPressed: () {
                  //       editCategory(
                  //         categories: widget.categories!,
                  //         name: nameController.text,
                  //         Description: descriptionController.text,
                  //       );
                  //     },
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
                              editCategory(categories: widget.categories!,
                                            name: nameController.text,
                                              Description: descriptionController.text);
                            }
                          }


                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit,color: Colors.white,), // Biểu tượng
                            SizedBox(width: 5), // Khoảng cách giữa icon và văn bản
                            Text('Lưu thông tin'), // Văn bản
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
}
