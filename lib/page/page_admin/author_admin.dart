import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/page/page_admin/main_screen.dart';
import 'package:flutter/material.dart';

class AuthorAdminWidget extends StatelessWidget{
    const AuthorAdminWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text("Author Page")),
     body: Center(
        child: ElevatedButton(
          child: const Text("Go To Home"),
          onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),
              Navigator.pushNamed(context, '/author');
          //   ),
          // );  
          },
        ),
     ),
    );
  }

}