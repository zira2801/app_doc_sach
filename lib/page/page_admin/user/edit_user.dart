import 'dart:convert';
import 'dart:io';
import 'package:app_doc_sach/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'display_user.dart';
import 'package:app_doc_sach/model/user_model.dart';

class EditUser extends StatefulWidget {
  final Users? users;

  const EditUser({Key? key, this.users}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late TextEditingController imageController;
  late TextEditingController phoneController;
  late TextEditingController genderController;
  late TextEditingController addressController;

  File? _image;
  String? _webImagePath;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.users?.fullName);
    emailController = TextEditingController(text: widget.users?.email);
    ageController = TextEditingController(
      text: widget.users?.age != null
          ? DateFormat('yyyy-MM-dd').format(widget.users!.age!)
          : '',
    );
    imageController = TextEditingController(text: widget.users?.avatar);
    phoneController = TextEditingController(text: widget.users?.phone);
    genderController = TextEditingController(text: widget.users?.gender);
    addressController = TextEditingController(text: widget.users?.address);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneController.dispose();
    imageController.dispose();
    genderController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.users?.age ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != widget.users?.age) {
      setState(() {
        widget.users?.age = picked;
        ageController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<String> uploadImage(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/upload/'));

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

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      var jsonResponse = json.decode(result);
      return jsonResponse[0]['url']; // Assuming 'url' is the key where image URL is returned
    } else {
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      throw Exception('Failed to upload image. Status code: ${response.statusCode}. Response: $result');
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      } else {
        throw Exception('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void editUser({
    required Users users,
    required String fullName,
    required String email,
    required DateTime age,
    required String image,
    required String phone,
    required String gender,
    required String address,
  }) async {
    if (_image != null) {
      try {
        image = await uploadImage(_image!);
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
        return;
      }
    }

    Map data = {
      'data': {
        "fullName": fullName,
        "email": email,
        "age": DateFormat('yyyy-MM-dd').format(age),
        "image": image,
        "phone": phone,
        "gender": gender,
        "address": address,
      }
    };

    // Encode Map to JSON
    var body = json.encode(data);
    final response = await http.put(
      Uri.parse("http://10.21.1.33:1337/api/profiles/${users.id}"),
      headers: <String, String>{
        'content-type': 'application/json;charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => const DisplayUser(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print('Failed to update user: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.fullName = val;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.email = val;
                });
              },
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                  onChanged: (val) {
                    setState(() {
                      widget.users?.age = DateFormat('yyyy-MM-dd').parse(val);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.avatar = val;
                });
              },
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.phone = val;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.gender = val;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
              onChanged: (val) {
                setState(() {
                  widget.users?.address = val;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                editUser(
                  users: widget.users!,
                  fullName: fullNameController.text,
                  age: DateFormat('yyyy-MM-dd').parse(ageController.text),
                  email: emailController.text,
                  image: imageController.text,
                  phone: phoneController.text,
                  gender: genderController.text,
                  address: addressController.text,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
