import 'package:app_doc_sach/model/book_statistical_model.dart';

class BookDetails {
  final bookData = const [
    BookStatisticalModel(
        icon: 'assets/icon/burn.png', value: "305", title: "Calories burned"),
    BookStatisticalModel(
        icon: 'assets/icon/steps.png', value: "10,983", title: "Steps"),
    BookStatisticalModel(
        icon: 'assets/icon/distance.png', value: "7km", title: "Distance"),
    BookStatisticalModel(icon: 'assets/icon/sleep.png', value: "7h48m", title: "Sleep"),
  ];
}
