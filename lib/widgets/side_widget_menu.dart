import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/data/side_menu_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideWidgetMenu extends StatefulWidget {
  const SideWidgetMenu({super.key});

  @override
  State<StatefulWidget> createState() => _SideWidgetState();
}

class _SideWidgetState extends State<SideWidgetMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      //một lớp trong Flutter cung cấp các tùy chọn trang trí cho Container, 
      //chẳng hạn như màu nền, viền, bo góc, hình ảnh nền, và các hiệu ứng gradient
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () => setState(() {
          selectedIndex = index;
        }),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
