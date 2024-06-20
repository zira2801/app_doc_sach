import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
     Future<String> uploadImage(File image) async {
    AuthController authController = Get.find();
    String token = authController.getToken()!;
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/api/upload/'));

    var stream = http.ByteStream(image.openRead().cast());
    var length = await image.length();

    if (length == 0) {
      throw Exception('File is empty');
    }

    var multipartFile = http.MultipartFile(
      'files',
      stream,
      length,
      filename: image.path.split('/').last,
      contentType: MediaType('image', 'png'),
    );

    request.files.add(multipartFile);
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      var jsonResponse = json.decode(result);
      return jsonResponse[0]
          ['url']; // Assuming 'url' is the key where image URL is returned
    } else {
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      throw Exception(
          'Failed to upload image. Status code: ${response.statusCode}. Response: $result');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      try {
        AuthController authController = Get.find();
        var imageUrl = await uploadImage(_imageFile!);

        // // Update profile with the image URL
        // int userId = authController.user.value?.id ?? '';
        // var profileUpdateResponse = await updateProfileImage(userId, imageUrl);

        // // Handle response from profile update API
        // if (profileUpdateResponse.statusCode == 200) {
        //   // Profile image updated successfully
        //   print('Profile image updated successfully.');
        // } else {
        //   throw Exception('Failed to update profile image. Status code: ${profileUpdateResponse.statusCode}');
        // }
      } catch (e) {
        print('Error uploading image or updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error uploading image or updating profile: $e')),
        );
      }
    }
  }
 

    Future save() async {
      try {
        Map data = {
          'data': {
            "fullName": users.fullName,
            "email": users.email,
            "age": users.age != null
                ? DateFormat('yyyy-MM-dd').format(users.age!)
                : '',
            "image": users.image,
            "phone": users.phone,
            "gender": users.gender,
            "address": users.address,
          }
        };
        var body = json.encode(data);
        var response = await http.post(
          Uri.parse("http://10.21.41.211:1337/api/profiles/"),
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
