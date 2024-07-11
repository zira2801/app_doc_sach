import 'package:app_doc_sach/page/page_tab_searh/search_author.dart';
import 'package:app_doc_sach/page/page_tab_searh/search_book.dart';
import 'package:app_doc_sach/page/page_tab_searh/search_book_colection.dart';
import 'package:app_doc_sach/page/page_tab_searh/search_category.dart';
import 'package:app_doc_sach/page/page_tab_searh/search_quotations.dart';
import 'package:app_doc_sach/page/search_page/search_default_book.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:app_doc_sach/state/tab_state.dart';
import 'package:app_doc_sach/state/tab_state_search.dart';
import 'package:flutter/material.dart';
import 'package:app_doc_sach/model/product_phobien.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemWidget extends StatefulWidget {
  const TimKiemWidget({super.key});

  @override
  State<TimKiemWidget> createState() => _TimKiemWidgetState();
}

class _TimKiemWidgetState extends State<TimKiemWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int selectedTab = 0;
  late TabController _tabController;

  //Trang thai cua Tab
  final _tabState = TabStateSearch();
  final _selectedColor = const Color(0xFF38A938);
  final _unselectedColor = const Color(0xff5f6368);
  final _tabs = const [
    Tab(text: 'Sách'),
    Tab(child: Text('Tác giả')),
    Tab(child: Text('Danh mục')),
    Tab(child: Text('Danh ngôn')),
    Tab(child: Text('Bộ sưu tập')),
  ];

  // Function to generate tabs with dynamic text color
  List<Tab> generateTabs(UiProvider notifier) {
    return const [
      Tab(
        child: Text(
          'Sách',
        ),
      ),
      Tab(
        child: Text(
          'Tác giả',
        ),
      ),
      Tab(
        child: Text(
          'Danh mục',
        ),
      ),
      Tab(
        child: Text(
          'Danh ngôn',
        ),
      ),
      Tab(
        child: Text(
          'Bộ sưu tập',
        ),
      )
    ];
  }

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
/*
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
*/
  bool isSearching = false;
  String _searchText = '';
  void _filterProducts(String query) {
    setState(() {
      searchResults = listProduct
          .where((product) =>
              product.tenSach.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isSearching = query.isNotEmpty;
    });
  }

  @override
  void initState() {
    _tabController = TabController(
        length: _tabs.length, vsync: this, initialIndex: _tabState.selectedTab);
    super.initState();
    /* _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isSearching = false;
        });
      }
    });*/
    searchResults = listProduct;
    _searchController.addListener(_updateSearchText);
  }

  void _updateSearchText() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchText = '';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    /*_focusNode.dispose();*/
    super.dispose();
    _tabController.dispose();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _tabState,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Consumer<UiProvider>(
              builder:
                  (BuildContext context, UiProvider notifier, Widget? child) {
                return Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 16),
                            child: TextField(
                              maxLines: 1,
                              controller: _searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 7.0,
                                    horizontal: 12.0), // Giảm padding
                                hintText: 'Nhập tên sách, tác giả,...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {},
                                ),
                              ),
                              onChanged: (String query) {
                                _filterProducts(query);
                              },
                              onSubmitted: (String query) {
                                setState(() {
                                  _searchText = query;
                                });
                              },
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TabBar(
                              controller: _tabController,
                              tabs: generateTabs(notifier),
                              labelColor: _selectedColor,
                              dividerColor: Colors.transparent,
                              indicatorColor: _selectedColor,
                              unselectedLabelColor: notifier.isDark
                                  ? Colors.white
                                  : _unselectedColor,
                              tabAlignment: TabAlignment.center,
                              isScrollable: true,
                              onTap: (index) {
                                _tabState.setSelectedTab(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: _buildTabContentWidget(_searchText))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

/*
  Widget _buildDropdown() {
    if (!isSearching || searchResults.isEmpty) {
      return SizedBox
          .shrink(); // Return an empty widget if not searching or no results
    }

    return Positioned(
      left: 16,
      right: 16,
      top: 65,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: searchResults.length > 6 ? 6 : searchResults.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    searchResults[index].image,
                    height: 50,
                    width: 30,
                  ),
                  title: Text(
                    searchResults[index].tenSach,
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Text(
                    searchResults[index].theLoai,
                    style: TextStyle(fontSize: 10),
                  ),
                  onTap: () {
                    _searchController.text = searchResults[index].tenSach;
                    setState(() {
                      isSearching = false;
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
*/
  Widget _buildTabContentWidget(String text) {
    return Consumer<TabStateSearch>(
      builder: (context, tabState, child) {
        // Update the TabController index
        return IndexedStack(
          index: _tabState.selectedTab,
          children: [
            // Nội dung cho mỗi Tab
            _buildTabContent(TimKiemSach(
              textSearch: text,
            )),
            _buildTabContent(TimKiemTacGia(
              textSearch: text,
            )),
            _buildTabContent(TimKiemDanhMuc(
              textSearch: text,
            )),
            _buildTabContent(TimKiemDanhNgon(
              textSearch: text,
            )),
            _buildTabContent(TimKiemBoSuuTap()),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(Widget widget) {
    return Center(child: widget);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
