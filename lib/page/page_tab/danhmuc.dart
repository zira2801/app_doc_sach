import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DanhMucWidget extends StatefulWidget {
  const DanhMucWidget({super.key});

  @override
  State<DanhMucWidget> createState() => _DanhMucWidgetState();
}

class _DanhMucWidgetState extends State<DanhMucWidget> {
  List<CategoryModel> listCategory = [
    CategoryModel(
        id: 1,
        nameCategory: 'Chiến tranh',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 2,
        nameCategory: 'Chính luận',
        desCategory: 'Sách nói về Chính luận'),
    CategoryModel(
        id: 3,
        nameCategory: 'Dân gian',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 4,
        nameCategory: 'Giả tưởng',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 5,
        nameCategory: 'Hiện thực',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 6,
        nameCategory: 'Hồi Ký - Tùy Bút',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 7, nameCategory: 'Kinh dị', desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 8,
        nameCategory: 'Lãng mạn',
        desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 9, nameCategory: 'Lịch sử', desCategory: 'Sách nói về chiến tranh'),
    CategoryModel(
        id: 10, nameCategory: 'Thơ', desCategory: 'Sách nói về chiến tranh'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (BuildContext context, UiProvider value, Widget? child) {
        return Scaffold(
          body: Container(
              color: value.isDark
                  ? Colors.black12
                  : const Color.fromRGBO(232, 245, 233, 1.0),
              child: gridview_danhmuc()),
        );
      },
    );
  }

  Widget gridview_danhmuc() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: listCategory.length,
          itemBuilder: (BuildContext context, index) {
            final category = listCategory[index];
            return Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  category.nameCategory,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
