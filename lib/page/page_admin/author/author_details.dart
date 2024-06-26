import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/model/author_model.dart';
import 'package:app_doc_sach/page/page_admin/author/display_author.dart';
import 'package:app_doc_sach/page/page_admin/author/edit_author.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';  // Import the intl package

class AuthorDetails extends StatefulWidget {
  final Author authors;
  const AuthorDetails({required this.authors});
  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetails> {
  @override
  Widget build(BuildContext context) {
    // sử dụng từ khóa async để cho phép sử dụng await bên trong hàm.
    void deleteAuthor() async {
      //http.delete(Uri.parse("http://192.168.1.6:1337/api/categories/${widget.categories.id}")) 
      //gửi một yêu cầu HTTP DELETE đến một API tại địa chỉ http://192.168.1.6:1337/api/categories/<id>,
      // với <id> là giá trị của widget.categories.id. 
      //await đảm bảo rằng hàm sẽ chờ cho đến khi yêu cầu DELETE được thực hiện xong.
      await http.delete(
        Uri.parse("$baseUrl/api/authors/${widget.authors.id}"),
      );
      //Điều hướng đến màn hình DisplayCategory và xóa tất cả các màn hình khác trong stack điều hướng.
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const DisplayAuthor()),
        (Route<dynamic> route) => false,
      );
    }

    // Format the birth date
    String formattedBirthDate = DateFormat('dd-MM-yyy').format(widget.authors.birthDate!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Details'),
        elevation: 0.0,//giá trị 0.0 nghĩa là không có bóng đổ.
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            //cho phép Column co lại kích thước chiều dọc tối thiểu để chứa các con widget.
            mainAxisSize: MainAxisSize.min,
            children: [
              Center( // Center the content inside the container
                child: Container(
                  //Chiều rộng bằng với chiều rộng của màn hình.
                  width: MediaQuery.of(context).size.width,
                  height: 500, // Adjusted height to make the form longer
                  // định nghĩa kiểu dáng cho Container.
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),//tạo bo góc
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,//độ lan tỏa của bóng đổ là 2 đơn vị
                        blurRadius: 5,
                        offset: const Offset(0, 3),// vị trí của bóng đổ là dịch chuyển về phía dưới 3 đơn vị.
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center align the text
                      mainAxisAlignment: MainAxisAlignment.center, // Center align the text vertically
                      children: [
                        Text(
                          'ID: ${widget.authors.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Name: ${widget.authors.authorName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Date of birth: $formattedBirthDate',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Born: ${widget.authors.born}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Telephone: ${widget.authors.telphone}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Nationality: ${widget.authors.nationality}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bio: ${widget.authors.bio}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,//để căn đều khoảng cách giữa các con widget
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue.shade700,//màu nền xanh đậm, màu chữ trắng
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditAuthor(authors: widget.authors)),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: deleteAuthor,
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
