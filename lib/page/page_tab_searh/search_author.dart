import 'package:app_doc_sach/model/author_model.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimKiemTacGia extends StatefulWidget {
  const TimKiemTacGia({super.key, required this.textSearch});

  final String textSearch;
  @override
  State<TimKiemTacGia> createState() => _TimKiemTacGiaState();
}

class _TimKiemTacGiaState extends State<TimKiemTacGia> {
  List<String> recentSearches = [];
  List<Author> listAuthor = [
    Author(
      id: 1,
      authorName: 'Nguyễn Nhật Ánh',
      birthDate: DateTime(1955, 5, 7),
      born: 'Quảng Nam, Vietnam',
      telphone: '0912345678',
      nationality: 'Vietnamese',
      bio: 'Famous for his novels about Vietnamese youth.',
    ),
    Author(
      id: 2,
      authorName: 'Bảo Ninh',
      birthDate: DateTime(1952, 10, 18),
      born: 'Hà Nội, Vietnam',
      telphone: '0923456789',
      nationality: 'Vietnamese',
      bio: 'Known for his novel "The Sorrow of War".',
    ),
    Author(
      id: 3,
      authorName: 'Nguyễn Du',
      birthDate: DateTime(1766, 1, 3),
      born: 'Hà Tĩnh, Vietnam',
      telphone: '0934567890',
      nationality: 'Vietnamese',
      bio: 'Renowned for his epic poem "The Tale of Kiều".',
    ),
    Author(
      id: 4,
      authorName: 'Tô Hoài',
      birthDate: DateTime(1920, 9, 27),
      born: 'Hà Nội, Vietnam',
      telphone: '0945678901',
      nationality: 'Vietnamese',
      bio: 'Famous for his children\'s literature and novels.',
    ),
    Author(
      id: 5,
      authorName: 'Xuân Diệu',
      birthDate: DateTime(1916, 2, 2),
      born: 'Hà Tĩnh, Vietnam',
      telphone: '0956789012',
      nationality: 'Vietnamese',
      bio: 'One of the most prominent Vietnamese poets.',
    ),
    Author(
      id: 6,
      authorName: 'Nam Cao',
      birthDate: DateTime(1915, 10, 29),
      born: 'Hà Nam, Vietnam',
      telphone: '0967890123',
      nationality: 'Vietnamese',
      bio: 'Known for his works depicting rural life and the human condition.',
    ),
    Author(
      id: 7,
      authorName: 'Nguyễn Huy Thiệp',
      birthDate: DateTime(1950, 4, 29),
      born: 'Thái Nguyên, Vietnam',
      telphone: '0978901234',
      nationality: 'Vietnamese',
      bio: 'Famous for his short stories and novels.',
    ),
    Author(
      id: 8,
      authorName: 'Phạm Tiến Duật',
      birthDate: DateTime(1941, 1, 14),
      born: 'Phú Thọ, Vietnam',
      telphone: '0989012345',
      nationality: 'Vietnamese',
      bio: 'Renowned for his war poetry.',
    ),
    Author(
      id: 9,
      authorName: 'Lê Minh Khuê',
      birthDate: DateTime(1949, 12, 6),
      born: 'Thanh Hóa, Vietnam',
      telphone: '0990123456',
      nationality: 'Vietnamese',
      bio: 'Known for her short stories and novels about Vietnamese women.',
    ),
    Author(
      id: 10,
      authorName: 'Nguyễn Ngọc Tư',
      birthDate: DateTime(1976, 11, 20),
      born: 'Cà Mau, Vietnam',
      telphone: '0912345123',
      nationality: 'Vietnamese',
      bio: 'Famous for her stories about the rural South of Vietnam.',
    ),
  ];
  List<String> vietnameseAuthors = [
    "Nguyễn Nhật Ánh",
    "Nguyên Phong",
    "Tần Minh",
    "Tô Hoài",
    "Xuân Diệu",
    "Nam Cao",
    "Nguyễn Huy Thiệp",
    "Phạm Tiến Duật",
    "Lê Minh Khuê",
    "Nguyễn Ngọc Tư",
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

  List<Author> _filterAuthors(String textSearch) {
    return listAuthor
        .where((author) =>
            author.authorName.toLowerCase().contains(textSearch.toLowerCase()))
        .toList();
  }

  Widget gridviewDanhmuc(String textSearch) {
    final filteredAuthors = _filterAuthors(textSearch);
    if (filteredAuthors.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
          crossAxisCount: 2,
          childAspectRatio: 3.2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: filteredAuthors.length,
        itemBuilder: (BuildContext context, index) {
          final author = filteredAuthors[index];
          return Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                author.authorName,
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
            if (recentSearches.isNotEmpty) ...[
              _buildSectionTitle('Tìm kiếm gần đây'),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildSearchList(recentSearches),
              ),
            ],
            _buildSectionTitle('Tìm kiếm nổi bật'),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSearchList(vietnameseAuthors),
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

  Widget _buildSearchList(List<String> items) {
    return Container(
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 2.0,
        children: items.map((item) {
          return Chip(
            label: Text(
              item,
              style: const TextStyle(fontSize: 9),
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
