import 'dart:ui'; // Import for ImageFilter
import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/page/tab_detail_book/binhluan.dart';
import 'package:app_doc_sach/view/pdf_view/pdf_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_doc_sach/model/product_phobien.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductPhobien product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 290,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.keyboard_backspace_outlined, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.file_download_outlined, color: Colors.black),
                              onPressed: () {
                                // Handle download action
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.question_mark, color: Colors.black),
                              onPressed: () {
                                // Handle question mark action
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined, color: Colors.black),
                              onPressed: () {
                                // Handle share action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 16,
                    right: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 30),
                          child: Container(
                            height: 180,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 2),
                                  blurRadius: 20,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(product.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    product.tenSach,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.theLoai,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                                const SizedBox(height: 8),
                              Chip(
                                label: Text(
                                  product.theLoai,
                                  style: const TextStyle(fontSize: 9),
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.green,width: 2),
                                ),
                              ),
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Icon(Icons.favorite, color: Colors.red),
                                    SizedBox(width: 4),
                                    Text(
                                      '106k',
                                      style: TextStyle(color: Colors.black, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.remove_red_eye, color: Colors.black),
                                    SizedBox(width: 4),
                                    Text(
                                      '21k',
                                      style: TextStyle(color: Colors.black, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
              const SizedBox(height: 5),
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    const TabBar(
                      dividerColor: Colors.transparent,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.black,
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                      tabs: [
                        Tab(text: "Giới thiệu"),
                        Tab(text: "Bình luận"),
                        Tab(text: "Sách liên quan"),
                        Tab(text: "Báo lỗi"),
                      ],
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.tenSach), // Placeholder for product description
                          ),
                         Center(child: CommentScreen()), // Placeholder for comments
                          const Center(child: Text("Sách liên quan")), // Placeholder for related books
                          const Center(child: Text("Báo lỗi")), // Placeholder for reporting errors
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 35),
              const SizedBox(width: 16), // Add some spacing between the icon and button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                   /* if (kIsWeb) {
                      // Handle file picking for web platform here
                      // file_picker package doesn't support web currently
                      print('File picking not supported on web.');
                      return;
                    } else {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );

                      if (result != null && result.files.single.path != null) {
                        String filePath = result.files.single.path!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewerPage(filePath: filePath),
                          ),
                        );
                      }
                    }*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(assetPath: 'assets/file_book/matbiec.pdf'),
                      ),
                    );
                  },
                  child: const Text(
                    "Đọc sách",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
