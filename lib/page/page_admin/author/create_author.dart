import 'package:app_doc_sach/model/author_model.dart';
import 'package:app_doc_sach/page/page_admin/author/display_author.dart';
import 'package:app_doc_sach/page/page_admin/category/textfield.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CreateAuthor extends StatefulWidget {
  final int? id;
  const CreateAuthor({Key? key, this.id});
  @override
  _CreateAuthorState createState() => _CreateAuthorState();
}

Author author = Author(0, '', DateTime.now(), '', '', '', '');

// TextEditingController is a class in Flutter to manage the state and handle data of a TextField.
TextEditingController authorNameController =
    TextEditingController(text: author.authorName);
TextEditingController birthDateController =
    TextEditingController(text: DateFormat('yyyy-MM-dd').format(author.birthDate));
TextEditingController bornController = TextEditingController(text: author.born);
TextEditingController teleController =
    TextEditingController(text: author.telphone);
TextEditingController nationalityController =
    TextEditingController(text: author.nationality);
TextEditingController bioController = TextEditingController(text: author.bio);

class _CreateAuthorState extends State<CreateAuthor> {
  Future save() async {
    try {
      Map data = {
        'data': {
          "authorName": author.authorName,
          "birthDate": DateFormat('yyyy-MM-dd').format(author.birthDate),
          "born": author.born,
          "telphone": author.telphone,
          "nationality": author.nationality,
          "bio": author.bio,
        }
      };
      var body = json.encode(data);
      var response =
          await http.post(Uri.parse("http://192.168.1.5:1337/api/authors/"),
              headers: <String, String>{
                'content-type': 'application/json; charset=UTF-8',
              },
              body: body);
      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const DisplayAuthor()),
            (Route<dynamic> route) => false);
      } else {
        print('Failed to create author: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: author.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != author.birthDate) {
      setState(() {
        author.birthDate = picked;
        birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: const Text('Create Author'),
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
                      author.authorName = val;
                    },
                    hintText: 'Name',
                    icon: const Icon(Icons.near_me),
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
                        hintText: 'Birth Date',
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
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: bornController,
                    onChanged: (val) {
                      author.born = val;
                    },
                    hintText: 'Born',
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: const Icon(Icons.bathroom_rounded),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Textfield(
                    controller: teleController,
                    onChanged: (val) {
                      author.telphone = val;
                    },
                    hintText: 'Telphone',
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          setState(() {
                            author.nationality = country.countryCode;
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
                        icon: const Icon(Icons.offline_bolt),
                        onChanged: (String val) {
                          // No-op, as the value is selected using the country picker.
                        },
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
                      author.bio = val;
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