import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/user_model.dart';
import 'package:app_doc_sach/page/page_admin/user/create_user.dart';
import 'package:app_doc_sach/page/page_admin/user/user_details.dart';
import 'package:app_doc_sach/widgets/side_widget_menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../const.dart';

class DisplayUser extends StatefulWidget {
  const DisplayUser({Key? key}) : super(key: key);

  @override
  _DisplayUsersState createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUser> {
  List<Users> users = [];

  Future<List<Users>> fetchUsers() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/api/profiles/'));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        for (var u in decodedData) {
          try {
            Users user = Users.fromJson(u);
            users.add(user);
          } catch (e) {
            print('Error parsing user data: $e\nData: $u');
          }
        }
        return users;
      } else {
        print('Failed to load users, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        elevation: 0.0,
        backgroundColor: backgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: secondaryColor,
                backgroundColor: primaryColor,
              ),
              onPressed: () {
                Navigator.push(context,
                     MaterialPageRoute(builder: (_) => CreateUser()));
              },
              child: const Text('Create'),
            ),
          )
        ],
      ),
      drawer: const SideWidgetMenu(),
      body: FutureBuilder<List<Users>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: ListTile(
                    title: Text(snapshot.data![index].fullName),
                    subtitle: Text(snapshot.data![index].email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetails(
                            users: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
