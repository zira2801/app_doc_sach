import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  image: '',
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

  Future<void> pickImage() async {
    // Create an instance of ImagePicker
    final picker = ImagePicker();

    // Show the image picker dialog and wait for the user to select an image
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Check if the user has selected an image
    if (pickedFile != null) {
      // Check if the platform is web
      if (kIsWeb) {
        setState(() {
          // For web, store the path of the selected image in _webImagePath
          _webImagePath = pickedFile.path;
          users.image = pickedFile.path; // Store the image path in users.image
        });
      } else {
        setState(() {
            // For mobile platforms, create a File object with the selected image's path
          _imageFile = File(pickedFile.path);
          users.image = pickedFile.path; // Store the image path in users.image
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: users.age,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != users.age) {
      setState(() {
        users.age = picked;
        ageController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  Future save() async {
    try {
      Map data = {
        'data': {
          "fullName": users.fullName,
          "email": users.email,
          "age": users.age != null ? DateFormat('yyyy-MM-dd').format(users.age!) : '',
          "image": users.image,
          "phone": users.phone,
          "gender": users.gender,
          "address": users.address,
        }
      };
      var body = json.encode(data);
      var response = await http.post(
        Uri.parse("http://192.168.1.5:1337/api/profiles/"),
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
            height: 900,
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
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: Textfield(
                        controller: ageController,
                        hintText: 'Age',
                        hintStyle: const TextStyle(color: Colors.black54),
                        icon: const Icon(Icons.date_range),
                        onChanged: (String val) {
                          // No-op, as the value is selected using the date picker.
                        },
                      ),
                    ),
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
                      onPressed: pickImage,
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
