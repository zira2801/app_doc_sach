import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/controller/auth_controller.dart';
import 'package:app_doc_sach/model/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:app_doc_sach/model/user_model.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/page/page_admin/user/display_user.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:flutter/foundation.dart';

class CreateUser extends StatefulWidget {
  final int? id;
  const CreateUser({Key? key, this.id});
  @override
  _CreateUserState createState() => _CreateUserState();
}

Users users = Users(
  id: 0,
  fullName: '',
  email: '',
  age: DateTime.now(),
  avatar: '',
  phone: '',
  gender: '',
  address: '',
);

// TextEditingController initialization
TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController ageController = TextEditingController(
  text: users.age != null ? DateFormat('yyyy-MM-dd').format(users.age!) : '',
);
TextEditingController imageController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController addressController = TextEditingController();

class _CreateUserState extends State<CreateUser> {
  File? _imageFile;
  String? _webImagePath;

  Future<FileUpload?> uploadImage(dynamic imageData) async {
    var uri = Uri.parse('$baseUrl/api/upload/');
    var request = http.MultipartRequest('POST', uri);

    if (kIsWeb) {
      // Handling for web
      if (imageData is String && imageData.startsWith('data:image')) {
        // This is a Data URL
        var bytes = base64Decode(imageData.split(',').last);
        request.files.add(http.MultipartFile.fromBytes(
          'files',
          bytes,
          filename: 'image.png',
          contentType: MediaType('image', 'png'),
        ));
      } else {
        throw Exception('Invalid image data for web');
      }
    } else {
      // Handling for mobile
      if (imageData is File) {
        var stream = http.ByteStream(imageData.openRead());
        var length = await imageData.length();
        request.files.add(http.MultipartFile(
          'files',
          stream,
          length,
          filename: imageData.path.split('/').last,
          contentType: MediaType('image', 'png'),
        ));
      } else {
        throw Exception('Invalid image data for mobile');
      }
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var fileUpload = FileUpload.fromJson(jsonResponse[0]);
        print('Upload successful: ${fileUpload.url}');
        return fileUpload;
      } else {
        print('Error uploading image. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      setState(() {
        _imageFile = imageFile;
      });

      try {
        var fileUpload = await uploadImage(imageFile);

        if (fileUpload != null) {
          setState(() {
            _webImagePath = fileUpload.url;
            users.avatar = fileUpload.url;
          });
        }
      } catch (e) {
        print('Error uploading image or updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image or updating profile: $e')),
        );
      }
    }
  }

  Future<void> save() async {
    try {
      Map data = {
        'data': {
          "fullName": users.fullName,
          "email": users.email,
          "age": users.age != null
              ? DateFormat('yyyy-MM-dd').format(users.age!)
              : '',
          "image": users.avatar,
          "phone": users.phone,
          "gender": users.gender,
          "address": users.address,
        }
      };
      var body = json.encode(data);
      var response = await http.post(
        Uri.parse("http://10.21.1.33:1337/api/profiles/"),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const DisplayUser()),
            (Route<dynamic> route) => false);
      } else {
        print('Failed to create user: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 850,
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
                    controller: fullNameController,
                    onChanged: (val) {
                      setState(() {
                        users.fullName = val;
                      });
                    },
                    hintText: 'Full Name',
                    icon: const Icon(Icons.person),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: emailController,
                    onChanged: (val) {
                      setState(() {
                        users.email = val;
                      });
                    },
                    hintText: 'Email',
                    icon: const Icon(Icons.email),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: ageController,
                    onChanged: (val) {
                      setState(() {
                        users.age = DateTime.tryParse(val);
                      });
                    },
                    hintText: 'Age (YYYY-MM-DD)',
                    icon: const Icon(Icons.cake),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 200,
                    width: 200,
                  )
                else if (_webImagePath != null)
                  Image.network(
                    _webImagePath!,
                    height: 200,
                    width: 200,
                  )
                else
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Select Image'),
                    ),
                  ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: phoneController,
                    onChanged: (val) {
                      setState(() {
                        users.phone = val;
                      });
                    },
                    hintText: 'Phone',
                    icon: const Icon(Icons.phone),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: genderController,
                    onChanged: (val) {
                      setState(() {
                        users.gender = val;
                      });
                    },
                    hintText: 'Gender',
                    icon: const Icon(Icons.wc),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: addressController,
                    onChanged: (val) {
                      setState(() {
                        users.address = val;
                      });
                    },
                    hintText: 'Address',
                    icon: const Icon(Icons.home),
                    hintStyle: const TextStyle(color: Colors.black54),
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
