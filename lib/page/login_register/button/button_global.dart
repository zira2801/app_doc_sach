import 'package:app_doc_sach/color/mycolor.dart';
import 'package:flutter/material.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 55,
      decoration: BoxDecoration(
        color: MyColor.primaryColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [ BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
        )
        ],
      ),
      child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
    );
  }
}
