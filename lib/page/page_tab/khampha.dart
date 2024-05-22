import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KhamPhaWidget extends StatefulWidget {
  const KhamPhaWidget({super.key});

  @override
  State<KhamPhaWidget> createState() => _KhamPhaWidgetState();
}

class _KhamPhaWidgetState extends State<KhamPhaWidget> {

  final List<String> imgList = [
    'https://bizweb.dktcdn.net/thumb/grande/100/468/779/themes/883715/assets/slider_3.jpg?1674889023980',
    'https://bizweb.dktcdn.net/thumb/large/100/222/758/articles/fb-tap-noi-tap-doc-1-01-01.jpg?v=1610358102210',
    'https://bizweb.dktcdn.net/100/222/758/themes/549028/assets/slider-img3.jpg?1708567836625'
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
            children: [
              CarouselSlider(
                items: imgList.map((item) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                )).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  height: 180,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _controller,
              ),
              buildCarouseIndicator(),
          ],
        )
            ),
          ],
        ),
      ),
    );
  }

  buildCarouseIndicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
