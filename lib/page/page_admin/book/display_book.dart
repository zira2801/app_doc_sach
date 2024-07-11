import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/controller/book_controller.dart';
import 'package:app_doc_sach/page/page_admin/book/book_detail.dart';
import 'package:app_doc_sach/page/page_admin/book/create_book.dart';
import 'package:app_doc_sach/page/page_admin/book/slideleftroutes.dart';
import 'package:flutter/material.dart';

import '../../../const/constant.dart';
import '../../../model/book_model.dart';
import '../../../widgets/side_widget_menu.dart';

class DisplayBook extends StatefulWidget {
  const DisplayBook({super.key});

  @override
  State<DisplayBook> createState() => _DisplayBookState();
}

class _DisplayBookState extends State<DisplayBook> {
  final BookController _bookService = BookController();
  List<Book> _books = [];
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    try {
      final books = await _bookService.getBooks();
      setState(() {
        _books = books;
      });
    } catch (e) {
      print('Error loading books: $e');
      // Hiển thị thông báo lỗi cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải sách. Vui lòng thử lại sau.')),
      );
    }
  }

  Widget _buildListCategory(List<String> categories) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(8.0), // Để tăng khoảng cách giữa các phần tử và viền container
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0, // Khoảng cách giữa các Chip
          runSpacing: 8.0, // Khoảng cách giữa các hàng
          children: categories.map((category) {
            return Chip(
              label: Text(
                category,
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.green),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sách') ,
        elevation: 0.0, // Controls the shadow below the app bar
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(SlideLeftRoute(page: const BookCreate()));
              },
              child: const Text('Tạo mới'),
            ),
          )
        ],
      ),

      drawer: const SideWidgetMenu(),
      body: Padding(
        padding: const EdgeInsets.only(top:13,right: 13,left: 13,bottom: 20),
        child: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            final book = _books[index];
            return GestureDetector(
              onTap: () {
                // Chuyển hướng sang trang chi tiết và truyền dữ liệu của cuốn sách
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailAdmin(book: book),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 255,
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.white),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: book.coverImage != ''
                              ? Image.network(
                            baseUrl + book.coverImage!.url,
                            width: 120,
                            height: 180,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high, // Sử dụng FilterQuality.high để cải thiện chất lượng hình ảnh
                          )
                              : const Icon(Icons.book, size: 80, color: Colors.grey), // Thay thế bằng biểu tượng mặc định khi không có ảnh bìa
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title ?? 'Không có tiêu đề',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                                const SizedBox(height: 15),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'ISBN:  ',
                                      ),
                                      TextSpan(
                                        text: book.isbn,
                                        style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
              
                                const SizedBox(height: 15),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Tác giả:  ',
                                      ),
                                      TextSpan(
                                        text: book.authors!.isNotEmpty
                                            ? book.authors!.map((author) => author.authorName).join(', ')
                                            : 'Không có tác giả',
                                        style:  TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
              
                                const SizedBox(height: 15),
                                const Text(
                                  'Thể loại:',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5),
                                book.categories!.isNotEmpty
                                    ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: book.categories!.map((category) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10.0), // Add some spacing between the chips
                                        child: Chip(
                                          label: Text(
                                            category.nameCategory,
                                            style: const TextStyle(fontSize: 10,color:  Colors.white),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: const BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                                    : const Text(
                                  'Không có thể loại',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(height: 5,),
                                Row(
              
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.visibility_rounded,color: Colors.white,),
                                      const SizedBox(width: 8,),
                                      Text('${book.view}',style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),),
                                      const SizedBox(width:  30),
                                      Row(
                                        children: [
              
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${book.likes}', // Sử dụng thuộc tính likes của đối tượng Book
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],)// Spacer để đẩy giá và biểu tượng yêu thích xuống dưới cùng
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
