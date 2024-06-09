import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/page/page_admin/author_admin.dart';
import 'package:app_doc_sach/page/page_admin/book_admin.dart';
import 'package:app_doc_sach/page/page_admin/category/category_admin.dart';
import 'package:app_doc_sach/page/page_admin/category/category_details.dart';
import 'package:app_doc_sach/page/page_admin/category/create_category.dart';
import 'package:app_doc_sach/page/page_admin/main_screen.dart';
import 'package:app_doc_sach/page/page_admin/user_admin.dart';
import 'package:app_doc_sach/widgets/side_widget_menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayCategory extends StatefulWidget {
  const DisplayCategory({Key? key}) : super(key: key);
  @override
  _DisplayCategorysState createState() => _DisplayCategorysState();
}

class _DisplayCategorysState extends State<DisplayCategory> {
  List<Category> category = [];
  Future<List<Category>> getAll() async {
     // The await keyword pauses the execution of the function until the HTTP request completes.
    var response =
        await http.get(Uri.parse("http://192.168.1.7:1337/api/categories/"));
    if (response.statusCode == 200) {
      category.clear();
    }
    //dùng để ptich chuỗi trong json
    final decodedData = jsonDecode(response.body);
    for (var u in decodedData["data"]) {
      category.add(Category(
          u['id'], u['attributes']["name"], u['attributes']["Description"]));
    }
    return category;
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        elevation: 0.0,
        backgroundColor: backgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: secondaryColor,
                backgroundColor:
                    primaryColor, // Using the custom secondaryColor
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> CreateCategory()));
              },
              child: const Text('Create'),
            ),
          )
        ],
      ),
      drawer: const SideWidgetMenu(),
      
      body: FutureBuilder(
          future: getAll(),
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, index) => InkWell(
                        child: ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].Description),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyDetails(
                                          categories: snapshot.data![index],
                          )));
                        },
                        ),
                      ));
            }
          }),
    );
  }
}
