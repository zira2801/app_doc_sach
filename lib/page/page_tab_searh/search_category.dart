import 'package:app_doc_sach/model/category_model.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimKiemDanhMuc extends StatefulWidget {
  const TimKiemDanhMuc({super.key, required this.textSearch});
  final String textSearch;
  @override
  State<TimKiemDanhMuc> createState() => _TimKiemDanhMucState();
}

class _TimKiemDanhMucState extends State<TimKiemDanhMuc> {
  List<CategoryModel> bookCategories = [
    CategoryModel(
      id: 1,
      nameCategory: 'Tiểu thuyết',
      desCategory: 'Sách chứa các câu chuyện, sự kiện và nhân vật hư cấu.',
    ),
    CategoryModel(
      id: 2,
      nameCategory: 'Phi tiểu thuyết',
      desCategory: 'Sách dựa trên các sự kiện, con người và sự thật có thật.',
    ),
    CategoryModel(
      id: 3,
      nameCategory: 'Khoa học viễn tưởng',
      desCategory: 'Sách dựa trên khoa học giả tưởng hoặc tương lai.',
    ),
    CategoryModel(
      id: 4,
      nameCategory: 'Thần thoại',
      desCategory: 'Sách chứa các yếu tố phép thuật hoặc siêu nhiên.',
    ),
    CategoryModel(
      id: 5,
      nameCategory: 'Tiểu sử',
      desCategory: 'Sách viết về cuộc đời của một người.',
    ),
    CategoryModel(
      id: 6,
      nameCategory: 'Trinh thám',
      desCategory:
          'Sách liên quan đến việc giải quyết tội phạm hoặc khám phá bí mật.',
    ),
    CategoryModel(
      id: 7,
      nameCategory: 'Lãng mạn',
      desCategory: 'Sách tập trung vào các mối quan hệ tình cảm.',
    ),
    CategoryModel(
      id: 8,
      nameCategory: 'Kinh dị',
      desCategory: 'Sách nhằm mục đích gây sợ hãi hoặc lo lắng cho người đọc.',
    ),
    CategoryModel(
      id: 9,
      nameCategory: 'Tự lực',
      desCategory:
          'Sách viết với mục đích hướng dẫn người đọc giải quyết các vấn đề cá nhân.',
    ),
    CategoryModel(
      id: 10,
      nameCategory: 'Lịch sử',
      desCategory:
          'Sách khám phá các sự kiện trong quá khứ và bối cảnh lịch sử.',
    ),
  ];

  List<CategoryModel> featuredCategories = [
    CategoryModel(
      id: 1,
      nameCategory: 'Sách bán chạy',
      desCategory:
          'Những cuốn sách được bán nhiều nhất trong thời gian gần đây.',
    ),
    CategoryModel(
      id: 2,
      nameCategory: 'Sách mới phát hành',
      desCategory: 'Những cuốn sách mới được xuất bản và phát hành.',
    ),
    CategoryModel(
      id: 3,
      nameCategory: 'Sách được đánh giá cao',
      desCategory:
          'Những cuốn sách nhận được nhiều đánh giá tích cực từ người đọc.',
    ),
    CategoryModel(
      id: 4,
      nameCategory: 'Sách đoạt giải',
      desCategory:
          'Những cuốn sách đã giành được các giải thưởng văn học uy tín.',
    ),
    CategoryModel(
      id: 5,
      nameCategory: 'Sách kinh điển',
      desCategory: 'Những cuốn sách được coi là kinh điển trong nền văn học.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (BuildContext context, UiProvider value, Widget? child) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              if (widget.textSearch.isNotEmpty)
                Expanded(child: searchResults(widget.textSearch))
              else
                Expanded(child: searchDefault()),
            ],
          ),
        );
      },
    );
  }

  Widget searchResults(String text) {
    return Consumer<UiProvider>(
      builder: (BuildContext context, UiProvider value, Widget? child) {
        return Container(
          color: value.isDark
              ? Colors.black12
              : const Color.fromRGBO(232, 245, 233, 1.0),
          child: gridviewDanhmuc(text),
        );
      },
    );
  }

  List<CategoryModel> _filterCategories(String textSearch) {
    return bookCategories
        .where((category) => category.nameCategory
            .toLowerCase()
            .contains(textSearch.toLowerCase()))
        .toList();
  }

  Widget gridviewDanhmuc(String textSearch) {
    final filteredCateory = _filterCategories(textSearch);
    if (filteredCateory.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Không tìm thấy tác giả nào.',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5.1,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: filteredCateory.length,
        itemBuilder: (BuildContext context, index) {
          final category = filteredCateory[index];
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
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchDefault() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildSectionTitle('Tìm kiếm nổi bật'),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSearchList(featuredCategories),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchList(List<CategoryModel> items) {
    return Container(
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 2.0,
        children: items.map((item) {
          return Chip(
            label: Text(
              item.nameCategory,
              style: const TextStyle(fontSize: 10),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Colors.green),
            ),
          );
        }).toList(),
      ),
    );
  }
}
