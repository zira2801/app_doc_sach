import 'package:app_doc_sach/data/side_menu_data.dart';
import 'package:flutter/material.dart';

class SideWidgetMenu extends StatelessWidget {
  const SideWidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFD8EFD3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Image(
                      image: AssetImage('assets/icon/logoapp.png'),
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Flexible(
                    child: Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            ...SideMenuData().menu.map((menuItem) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            menuItem.icon,
                            color: Colors.black,
                            size: 30, // Increased size of Icon
                          ),
                        ),
                        const SizedBox(width: 20), // Increased width for spacing
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              menuItem.title,
                              style: const TextStyle(
                                fontSize: 24, // Increased font size for Text
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  ),
                  const Divider(color: Colors.grey), // Add a divider between items
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}