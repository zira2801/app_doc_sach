import 'package:flutter/material.dart';
import 'package:app_doc_sach/model/product_phobien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemDefaultWidget extends StatefulWidget {
  const TimKiemDefaultWidget({super.key});

  @override
  State<TimKiemDefaultWidget> createState() => _TimKiemWidgetState();
}

class _TimKiemWidgetState extends State<TimKiemDefaultWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  List<String> recentSearches = [];
  List<String> popularSearches = [
    "Ngày hoa lưu ngược gió",
    "Đắc Nhân Tâm",
    "Muôn kiếp nhân sinh",
    "Ghi chép pháp y",
    "Tâm lý",
    "Thôi miên bằng ngôn từ",
    "hóa",
    "Đắc Nhân Tâm",
    "Nguyên tắc",
    "toán",
    "thao túng tâm lý",
    "Tâm lý học tội phạm",
  ];

  List<ProductPhobien> listProduct = [
    ProductPhobien(
        id: '1',
        tenSach: 'Mắt biếc',
        theLoai: 'Tinh cam',
        image: 'assets/book/matbiec.png'),
    ProductPhobien(
        id: '2',
        tenSach: 'Truyện Kiều',
        theLoai: 'Tinh cam',
        image: 'assets/book/thuykieu.png'),
    ProductPhobien(
        id: '3',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
    ProductPhobien(
        id: '4',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
    ProductPhobien(
        id: '5',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
    ProductPhobien(
        id: '6',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
    ProductPhobien(
        id: '7',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
    ProductPhobien(
        id: '8',
        tenSach: 'Từng bước nở hoa sen',
        theLoai: 'Tinh cam',
        image: 'assets/book/nohosenbia2.png'),
  ];

  List<ProductPhobien> searchResults = [];

  void _addRecentSearch(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedRecentSearches = [...recentSearches];

    if (!updatedRecentSearches.contains(query) && query.isNotEmpty) {
      updatedRecentSearches.insert(0, query);
      if (updatedRecentSearches.length > 5) {
        updatedRecentSearches.removeLast();
      }

      setState(() {
        recentSearches = updatedRecentSearches;
      });

      // Lưu danh sách recentSearches vào bộ nhớ local
      await prefs.setStringList('recentSearches', recentSearches);
    }
  }

  @override
  void initState() {
    super.initState();
    searchResults = listProduct;
    _loadRecentSearches();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRecentSearches = prefs.getStringList('recentSearches');
    if (savedRecentSearches != null) {
      setState(() {
        recentSearches = savedRecentSearches;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
