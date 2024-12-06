import 'dart:convert';
import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/author_model.dart';
import 'package:app_doc_sach/page/page_admin/author/display_author.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Edit Author'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 700,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
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
                    controller: authorNameController,
                    onChanged: (val) {
                      setState(() {
                        authorNameController.text = val;
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
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: Textfield(
                        controller: birthDateController,
                        onChanged: (val) {
                          setState(() {
                            widget.authors?.birthDate =
                                DateFormat('dd-MM-yyyy').parse(val);
                          });
                        },
                        hintText: 'Birth Date',
                        hintStyle: const TextStyle(color: Colors.black54),
                        icon: const Icon(Icons.date_range),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: bornController,
                    onChanged: (val) {
                      setState(() {
                        widget.authors?.born = val;
                      });
                    },
                    hintText: 'Born',
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: const Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: teleController,
                    onChanged: (val) {
                      setState(() {
                        widget.authors?.telphone = val;
                      });
                    },
                    hintText: 'Telephone',
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: const Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 20),
               Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (Country country) {
                          setState(() {
                            widget.authors?.nationality = country.name;
                            nationalityController.text = country.name;
                          });
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: Textfield(
                        controller: nationalityController,
                        hintText: 'Nationality',
                        hintStyle: const TextStyle(color: Colors.black54),
                        icon: const Icon(Icons.description), onChanged: (String val) {  },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: bioController,
                    onChanged: (val) {
                      setState(() {
                        widget.authors?.bio = val;
                      });
                    },
                    hintText: 'Bio',
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận cập nhật'),
                            content: Text('Bạn có chắc chắn muốn cập nhật thông tin này không?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Huỷ'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Đóng dialog
                                },
                              ),
                              TextButton(
                                child: Text('Đồng ý'),
                                onPressed: () {
                                  // Gọi hàm để thực hiện cập nhật ở đây
                                  editAuthor(
                                    authors: widget.authors!,
                                    authorName: authorNameController.text,
                                    birthDate: DateFormat('dd-MM-yyyy').parse(birthDateController.text),
                                    born: bornController.text,
                                    telphone: teleController.text,
                                    nationality: nationalityController.text,
                                    bio: bioController.text,
                                  );
                                  Navigator.of(context).pop(); // Đóng dialog
                                },
                              ),
                            ],
                          );
                        },
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
