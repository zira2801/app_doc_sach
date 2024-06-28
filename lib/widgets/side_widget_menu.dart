import 'package:app_doc_sach/data/side_menu_data.dart';
import 'package:flutter/material.dart';

class SideWidgetMenu extends StatelessWidget {
  const SideWidgetMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          //...:nó chèn all phần tử của 1 danh sách vào một list khác
          ...SideMenuData().menu.map((menuItem) {
            return ListTile(
              leading: Icon(menuItem.icon),
              title: Text(menuItem.title),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                switch (menuItem.title) {
                  case 'Dashboard':
                    Navigator.pushNamed(context, '/homepage');
                    break;
                  case 'Book':
                    Navigator.pushNamed(context, '/bookpage');
                    break;
                  case 'Category':
                    Navigator.pushNamed(context, '/category');
                    break;
                  case 'Author':
                    Navigator.pushNamed(context, '/author');
                    break;
                  case 'User':
                    Navigator.pushNamed(context, '/user');
                    break;
                  // Add other cases for different menu items here
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}