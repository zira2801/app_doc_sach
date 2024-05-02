import 'package:flutter/material.dart';

class TextFormGlobal_MK extends StatefulWidget {
  const TextFormGlobal_MK({super.key,required this.controller, required this.text, required this.textInputType, required this.obscure, required this.icon, this.suffix});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final Icon icon;
  final Widget? suffix;

  @override
  State<TextFormGlobal_MK> createState() => _TextFormGlobal_MKState();
}

class _TextFormGlobal_MKState extends State<TextFormGlobal_MK> {
 // Định nghĩa kiểu dữ liệu cho suffix
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3,left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 7
            )
          ]
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2,right: 20),
            child: Icon(
              widget.icon.icon,
              color: Colors.black, // Sử dụng màu được truyền vào
            ), // Thay thế Icons.lock bằng icon mà bạn muốn sử dụng
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
              obscureText: widget.obscure,
              decoration: InputDecoration(
                hintText: widget.text,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1,
                  fontSize: 13, // Đặt kích thước chữ ở đây
                ),
                contentPadding: const EdgeInsets.all(0),
                suffix: widget.suffix,

              ),
              style: const TextStyle(fontSize: 13), // Đặt kích thước chữ cho văn bản nhập vào ở đây
            ),
          ),
        ],
      ),
    );
  }
}
