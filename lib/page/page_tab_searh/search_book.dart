import 'package:flutter/material.dart';

import '../../model/product_phobien.dart';

class TimKiemSach extends StatefulWidget {
  const TimKiemSach({super.key, required this.textSearch});
  final String? textSearch;
  @override
  State<TimKiemSach> createState() => _TimKiemSachState();
}

class _TimKiemSachState extends State<TimKiemSach> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.textSearch != null && widget.textSearch!.isNotEmpty)
              searchResults(widget.textSearch!)
            else
              searchDefault(),
          ],
        ),
      ),
    ));
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
      height: 200,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0, // Tăng khoảng cách giữa các item
          runSpacing: 2.0, // Tăng khoảng cách giữa các hàng
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
      ),
    );
  }

  Widget searchDefault() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: recentSearches.isNotEmpty,
                child: Column(
                  children: [
                    _buildSectionTitle('Tìm kiếm gần đây'),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildSearchList(recentSearches),
                    ),
                  ],
                ),
              ),
              /*
              _buildSectionTitle('Tìm kiếm gần đây'),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildSearchList(recentSearches),
              ),*/
              _buildSectionTitle('Tìm kiếm nổi bật'),
              Align(
                  alignment: Alignment.centerLeft,
                  child: _buildSearchList(popularSearches)),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
      /*  if (isSearching) _buildDropdown()*/
    ]);
  }

  Widget _buildProductList(List<ProductPhobien> products) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          width: double.infinity,
          height: 220, // Adjust height if needed
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.image,
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.tenSach,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Tác giả',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Chip(
                          label: Text(
                            product.theLoai,
                            style: const TextStyle(fontSize: 10),
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.green),
                          ),
                        ),
                        const Spacer(), // Added a Spacer to push the price and favorite icon to the bottom
                        const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Align the row to the right
                          children: [
                            Text(
                              '100k',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchResults(String text) {
    List<ProductPhobien> searchResults = listProduct
        .where((product) =>
            product.tenSach.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildSectionTitle('Kết quả tìm kiếm cho "$text"'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: searchResults.isEmpty
                      ? _buildNoResultsFound()
                      : _buildProductList(searchResults),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoResultsFound() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          'Không tìm thấy sách nào.',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
