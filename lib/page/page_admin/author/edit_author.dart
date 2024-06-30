import 'dart:convert';
import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/author_model.dart';
import 'package:app_doc_sach/page/page_admin/author/display_author.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditAuthor extends StatefulWidget {
  final Author? authors;
  const EditAuthor({Key? key, this.authors});
  @override
  _EditAuthorState createState() => _EditAuthorState();
}

class _EditAuthorState extends State<EditAuthor> {
  late TextEditingController authorNameController;
  late TextEditingController birthDateController;
  late TextEditingController bornController;
  late TextEditingController teleController;
  late TextEditingController nationalityController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    authorNameController =
        TextEditingController(text: widget.authors?.authorName);
    birthDateController = TextEditingController(
      text: widget.authors?.birthDate != null
          ? DateFormat('dd-MM-yyyy').format(widget.authors!.birthDate!)
          : '',
    );
    bornController = TextEditingController(text: widget.authors?.born);
    teleController = TextEditingController(text: widget.authors?.telphone);
    nationalityController =
        TextEditingController(text: widget.authors?.nationality);
    bioController = TextEditingController(text: widget.authors?.bio);
  }

  @override
  void dispose() {
    authorNameController.dispose();
    birthDateController.dispose();
    bornController.dispose();
    teleController.dispose();
    nationalityController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.authors?.birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != widget.authors?.birthDate) {
      setState(() {
        widget.authors?.birthDate = picked;
        birthDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void editAuthor({
    required Author authors,
    required String authorName,
    required DateTime birthDate,
    required String born,
    required String telphone,
    required String nationality,
    required String bio,
  }) async {
    Map data = {
      'data': {
        "authorName": authorName,
        "birthDate": DateFormat('yyyy-MM-dd').format(birthDate),
        "born": born,
        "telephone": telphone,
        "nationality": nationality,
        "bio": bio,
      }
    };

    // Encode Map to JSON
    var body = json.encode(data);

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/api/authors/${authors.id}"),
        headers: <String, String>{
          'content-type': 'application/json;charset=UTF-8',
        },
        body: body,
      );

      print("Data after update: $data");
      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Nếu thành công, chuyển hướng về trang DisplayAuthor
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const DisplayAuthor(),
          ),
              (Route<dynamic> route) => false,
        );
      } else {
        // Xử lý lỗi, hiển thị thông báo lỗi phù hợp
        setState(() {
          print("Failed to update author. Please try again.");
        });
      }
    } catch (e) {
      // Xử lý lỗi trong trường hợp request bị lỗi
      setState(() {
       print("Error: $e");
      });
    } finally {
      setState(() {
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Sửa thông tin tác giả'),
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
              // height: 700,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.3),
              //       spreadRadius: 2,
              //       blurRadius: 5,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   color: Colors.white,
                  //   child: Textfield(
                  //     controller: authorNameController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         authorNameController.text = val;
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
                        widget.authors?.authorName = val;
                      },
                      controller: authorNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên tác giả',
                        hintText: 'Nhập tên tác giả',
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
                  //   child: GestureDetector(
                  //     onTap: () => _selectDate(context),
                  //     child: AbsorbPointer(
                  //       child: Textfield(
                  //         controller: birthDateController,
                  //         onChanged: (val) {
                  //           setState(() {
                  //             widget.authors?.birthDate =
                  //                 DateFormat('dd-MM-yyyy').parse(val);
                  //           });
                  //         },
                  //         hintText: 'Birth Date',
                  //         hintStyle: const TextStyle(color: Colors.black54),
                  //         icon: const Icon(Icons.date_range),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: birthDateController,
                          onChanged: (val) {
                            widget.authors?.birthDate =
                                DateFormat('dd-MM-yyyy').parse(val);
                          },
                          decoration: InputDecoration(
                            labelText: 'Ngày sinh',
                            suffixIcon: const Icon(Icons.date_range),
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
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   width: double.infinity,
                  //   child: Textfield(
                  //     controller: bornController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         widget.authors?.born = val;
                  //       });
                  //     },
                  //     hintText: 'Born',
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //     icon: const Icon(Icons.description),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.authors?.born = val;
                      },
                      controller: bornController,
                      decoration: InputDecoration(
                        labelText: 'Nơi sinh',
                        hintText: 'Nhập nơi sinh',
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
                  //     controller: teleController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         widget.authors?.telphone = val;
                  //       });
                  //     },
                  //     hintText: 'Telephone',
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //     icon: const Icon(Icons.description),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.authors?.telphone = val;
                      },
                      controller: teleController,
                      decoration: InputDecoration(
                        labelText: 'Điện thoại',
                        hintText: 'Nhập số điện thoại',
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
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       showCountryPicker(
                  //         context: context,
                  //         showPhoneCode: false,
                  //         onSelect: (Country country) {
                  //           setState(() {
                  //             widget.authors?.nationality = country.name;
                  //             nationalityController.text = country.name;
                  //           });
                  //         },
                  //       );
                  //     },
                  //     child: AbsorbPointer(
                  //       child: Textfield(
                  //         controller: nationalityController,
                  //         hintText: 'Nationality',
                  //         hintStyle: const TextStyle(color: Colors.black54),
                  //         icon: const Icon(Icons.description), onChanged: (String val) {  },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            setState(() {
                              widget.authors?.nationality = country.name;
                              nationalityController.text = country.name;
                            });
                          },
                        );
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: nationalityController,
                          onChanged: (String val) {
                            // No-op, as the value is selected using the country picker.
                          },
                          decoration: InputDecoration(
                            labelText: 'Quốc gia',
                            suffixIcon: const Icon(Icons.offline_bolt),
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
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   width: double.infinity,
                  //   child: Textfield(
                  //     controller: bioController,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         widget.authors?.bio = val;
                  //       });
                  //     },
                  //     hintText: 'Bio',
                  //     hintStyle: const TextStyle(color: Colors.black54),
                  //     icon: const Icon(Icons.description),
                  //   ),
                  // ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (val) {
                        widget.authors?.bio = val;
                      },
                      maxLines: 10,
                      controller: bioController,
                      decoration: InputDecoration(
                        labelText: 'Sơ yếu lý lịch',
                        hintText: 'Nhập sơ yếu lý lịch',
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
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //             title: Text('Xác nhận cập nhật'),
                  //             content: Text('Bạn có chắc chắn muốn cập nhật thông tin này không?'),
                  //             actions: <Widget>[
                  //               TextButton(
                  //                 child: Text('Huỷ'),
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop(); // Đóng dialog
                  //                 },
                  //               ),
                  //               TextButton(
                  //                 child: Text('Đồng ý'),
                  //                 onPressed: () {
                  //                   // Gọi hàm để thực hiện cập nhật ở đây
                  //                   editAuthor(
                  //                     authors: widget.authors!,
                  //                     authorName: authorNameController.text,
                  //                     birthDate: DateFormat('dd-MM-yyyy').parse(birthDateController.text),
                  //                     born: bornController.text,
                  //                     telphone: teleController.text,
                  //                     nationality: nationalityController.text,
                  //                     bio: bioController.text,
                  //                   );
                  //                   Navigator.of(context).pop(); // Đóng dialog
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         },
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
                            if (authorNameController.text.isEmpty ||
                                DateFormat('dd-MM-yyyy').parse(birthDateController.text).year > 2006 ||
                                bornController.text.isEmpty ||
                                teleController.text.isEmpty ||
                                nationalityController.text.isEmpty ||
                                bioController.text.isEmpty) {
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
                                              if (authorNameController.text.isEmpty)
                                                Text('• Vui lòng nhập tên tác giả',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (DateFormat('dd-MM-yyyy').parse(birthDateController.text).year > 2006)
                                                Text('• Vui lòng điều chỉnh lại năm sinh',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (bornController.text.isEmpty)
                                                Text('• Vui lòng nhập nơi sinh',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (teleController.text.isEmpty)
                                                Text('• Vui lòng nhập số điện thoại',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (nationalityController.text.isEmpty)
                                                Text('• Vui lòng nhập quốc gia',
                                                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w300)),
                                              if (bioController.text.isEmpty)
                                                Text('• Vui lòng nhập sơ yếu lý lịch',
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
                              editAuthor(authors: widget.authors!,
                                          authorName: authorNameController.text,
                                            birthDate: DateFormat('dd-MM-yyyy').parse(birthDateController.text),
                                              born: bornController.text,
                                                telphone: teleController.text,
                                                  nationality: nationalityController.text,
                                                    bio: bioController.text);
                            }
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline_sharp,color: Colors.white,), // Biểu tượng
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
