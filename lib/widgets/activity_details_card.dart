import 'package:app_doc_sach/data/book_details.dart';
import 'package:app_doc_sach/util/responsive.dart';
import 'package:app_doc_sach/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bookDetails = BookDetails();

    return GridView.builder(
      itemCount: bookDetails.bookData.length,
      //Đặt thuộc tính này thành true để lưới chỉ chiếm 
      //không gian cần thiết dựa trên số lượng mục của nó, thay vì chiếm toàn bộ không gian sẵn có.
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      //sắp xếp các mục lưới
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //crossAxisCount: 4: Số lượng cột trong lưới là 4.
        crossAxisCount:  Responsive.isMobile(context) ? 2 : 4,
        //khoảng cách giữa các cột
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        // Khoảng cách giữa các hàng là 12 đơn vị.
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) => CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              bookDetails.bookData[index].icon,
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 4),
              child: Text(
                bookDetails.bookData[index].value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              bookDetails.bookData[index].title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}