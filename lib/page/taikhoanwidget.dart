import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/page/login_register/button/DangNhapDangKyWidget.dart';
import 'package:app_doc_sach/page/login_register/button/DangXuatWidget.dart';
import 'package:app_doc_sach/page/page_tab_taikhoanwidget/gia_han_goi.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/auth_controller.dart';
import '../controller/controller.dart';
import 'login_register/service/auth_service.dart';

class TaiKhoanWidget extends StatefulWidget {
  const TaiKhoanWidget({super.key});

  @override
  State<TaiKhoanWidget> createState() => _TaiKhoanWidgetState();
}

class _TaiKhoanWidgetState extends State<TaiKhoanWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer <UiProvider>(
        builder: (context,UiProvider notifier, child) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              color: notifier.isDark ? Colors.black.withOpacity(0.1) : Colors.green.shade50,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                       Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                          child: Container(
                          height: 168,
                          width: double.infinity,
                          /*color: Colors.green.shade50,*/
                          decoration: BoxDecoration(
                            color: notifier.isDark ? Colors.black38 : Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  margin: const EdgeInsets.only(top: 15),
                                  child: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/icon/logoapp.png'),
                                    radius: 55,
                                  ),
                                ),
                               const SizedBox(height: 15,),
                                Obx(
                                      () {
                                    return authController.user.value != null
                                        ? const DangXuatWidget()
                                        : const DangNhapDangKyWidget();
                                  },
                                ),
                                /*token != null? const DangXuatWidget() : const DangNhapDangKyWidget()*/
                              ],
                            ),
                          ),
                          ),
                        ),
                       const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),

                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: notifier.isDark ? Colors.black38 : Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                        // Add your onTap functionality here
                      },
                      contentPadding: const EdgeInsets.only(left: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                          ),
                          child: const Center(
                            child: Icon(Icons.diamond, color: MyColor.primaryColor, size: 20),
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GiaHanGoi()),
                            );
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 10,),
                            Text('Gia hạn gói',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                  ),
                                  textAlign: TextAlign.end, // Align text to the right
                                ),
                              const Spacer(),
                              const Icon(
                                Icons.navigate_next_sharp,
                                size: 25,
                                color: MyColor.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                              ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: notifier.isDark ? Colors.black38 : Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:5),
                              child: ListTile(
                                onTap: () {
                                  // Add your onTap functionality here
                                },
                                contentPadding: const EdgeInsets.only(left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                leading: Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.info, color: MyColor.primaryColor, size: 20),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10,),
                                      Text('Thông tin tài khoản',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                        ),
                                        textAlign: TextAlign.end, // Align text to the right
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.navigate_next_sharp,
                                        size: 25,
                                        color: MyColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                           Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),

                            ListTile(
                              contentPadding: const EdgeInsets.only(left: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              leading: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                ),
                                child: const Center(
                                  child: Icon(Icons.dark_mode, color: MyColor.primaryColor, size: 20),
                                ),
                              ),
                              title: Row(
                                children: [
                                  const SizedBox(width: 10,),
                                  Text('Giao diện tối',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                    ),
                                    textAlign: TextAlign.end, // Align text to the right
                                  ),
                                  const Spacer(),
                                  CupertinoSwitch(
                                        value: notifier.isDark,
                                        onChanged: (value) {notifier.changeTheme();},
                                       activeColor: Colors.green,
                                      ),

                                  /*
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: FlutterSwitch(
                                      value: notifier.isDark,
                                      onToggle: (value) {notifier.changeTheme();  },
                                      width: 50,
                                      height: 28,
                                      activeColor: Colors.lightGreenAccent,
                                      activeToggleColor: MyColor.primaryColor,
                                      inactiveColor: Colors.grey.shade400,
                                      inactiveToggleColor: Colors.white,

                                    ),
                                  )
                                  */
                                ],
                              ),
                            ),

                            Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),

                            ListTile(
                              onTap: () {
                                // Add your onTap functionality here
                              },
                              contentPadding: const EdgeInsets.only(left: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              leading: Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                ),
                                child: const Center(
                                  child: Icon(Icons.dashboard_customize_sharp, color: MyColor.primaryColor, size: 20),
                                ),
                              ),
                              title: Row(
                                children: [
                                  const SizedBox(width: 10,),
                                  Text('Tùy chỉnh màn hình chủ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                    ),
                                    textAlign: TextAlign.end, // Align text to the right
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.navigate_next_sharp,
                                    size: 25,
                                    color: MyColor.primaryColor,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                onTap: () {
                                  // Add your onTap functionality here
                                },
                                contentPadding: const EdgeInsets.only(left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                leading: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.language, color: MyColor.primaryColor, size: 20),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    const SizedBox(width: 10,),
                                    Text('Ngôn ngữ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                      ),
                                      textAlign: TextAlign.end, // Align text to the right
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.navigate_next_sharp,
                                      size: 25,
                                      color: MyColor.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                                color: notifier.isDark ? Colors.black38 : Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:5),
                                  child: ListTile(
                                    onTap: () {
                                      // Add your onTap functionality here
                                    },
                                    contentPadding: const EdgeInsets.only(left: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    leading: Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.mark_email_unread, color: MyColor.primaryColor, size: 20),
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái
                                            children: [
                                              Text('Yêu cầu sách, báo lỗi, ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                                ),
                                              ),
                                              Text('góp ý',textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const Spacer(),
                                          const Icon(
                                            Icons.navigate_next_sharp,
                                            size: 25,
                                            color: MyColor.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 8),
                                    child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),

                                ListTile(
                                  onTap: () {
                                    // Add your onTap functionality here
                                  },
                                  contentPadding: const EdgeInsets.only(left: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  leading: Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.question_mark, color: MyColor.primaryColor, size: 20),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10,),
                                      Text('Hướng dẫn sử dụng',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                        ),
                                        textAlign: TextAlign.end, // Align text to the right
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.navigate_next_sharp,
                                        size: 25,
                                        color: MyColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 8),
                                    child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),

                                ListTile(
                                  onTap: () {
                                    // Add your onTap functionality here
                                  },
                                  contentPadding: const EdgeInsets.only(left: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  leading: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: notifier.isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.group, color: MyColor.primaryColor, size: 20),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      const SizedBox(width: 10,),
                                      Text('Về chúng tôi',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: notifier.isDark ? Colors.white : Colors.grey.shade800,
                                        ),
                                        textAlign: TextAlign.end, // Align text to the right
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.navigate_next_sharp,
                                        size: 25,
                                        color: MyColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 8),
                                    child: Divider(color: notifier.isDark ? Colors.grey.shade800 : Colors.grey.shade200,)),
                              ],
                            ),
                          )
                      ),
                      const SizedBox(height: 50,),

                      Center(
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: notifier.isDark ? Colors.white :  MyColor.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                                color: notifier.isDark ? Colors.transparent : Colors.white
                              ),
                              child: Center(child: Text('Xóa tài khoản',style: TextStyle(color: notifier.isDark ? Colors.white :  Colors.black87,fontSize: 13,fontStyle: FontStyle.italic))),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50,),
                    ]
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

