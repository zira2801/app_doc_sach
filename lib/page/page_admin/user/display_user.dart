import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/user_model.dart';
import 'package:app_doc_sach/page/page_admin/user/create_user.dart';
import 'package:app_doc_sach/page/page_admin/user/user_details.dart';
import 'package:app_doc_sach/widgets/side_widget_menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DisplayUser extends StatefulWidget {
  const DisplayUser({Key? key}) : super(key: key);

  @override
  _DisplayUsersState createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUser> {
  List<Users> users = [];

  Future<List<Users>> getAll() async {
    try {
      var response = await http.get(Uri.parse("http://192.168.1.5:1337/api/profiles/"));
      if (response.statusCode == 200) {
        users.clear();
        final decodedData = jsonDecode(response.body);
        for (var u in decodedData["data"]) {
          try {
            var attributes = u['attributes'];
            Users user = Users(
              id: u['id'],
              fullName: attributes["fullName"]?.toString() ?? 'N/A',
              email: attributes["email"]?.toString() ?? 'N/A',
              phone: attributes["phone"]?.toString() ?? 'N/A',
              gender: attributes["gender"]?.toString() ?? 'N/A',
              address: attributes["address"]?.toString() ?? 'N/A',
              age: attributes["age"] != null ? DateTime.parse(attributes["age"]) : null,
              avatar: attributes["image"],
            );
            users.add(user);
          } catch (e) {
            print('Error parsing user data: $e\nData: $u');
          }
        }
      } else {
        print('Failed to load users, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
    return users;
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
        future: getAll(),
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