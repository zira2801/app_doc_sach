import 'package:app_doc_sach/model/product_phobien.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderSachPhoBien extends StatefulWidget {
  const SliderSachPhoBien({super.key});

  @override
  State<SliderSachPhoBien> createState() => _SliderSachPhoBienState();
}

class _SliderSachPhoBienState extends State<SliderSachPhoBien> {
  List<ProductPhobien> listProduct = [
    ProductPhobien(id: '1', tenSach: 'Mat Biec', theLoai: 'Tinh cam', image: 'assets/book/matbiec.png'),
    ProductPhobien(id: '2', tenSach: 'Thuy Kieu', theLoai: 'Tinh cam', image: 'assets/book/thuykieu.png'),
    ProductPhobien(id: '3', tenSach: 'No hoa sen', theLoai: 'Tinh cam', image: 'assets/book/nohoasen.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: listProduct.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.tenSach,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Thể loại: ${product.theLoai}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
