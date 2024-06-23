class CategoryModel {
   int? id;
   String nameCategory;
   String desCategory;

  CategoryModel(
      {required this.id,
      required this.nameCategory,
      required this.desCategory});

   factory CategoryModel.fromJson(Map<String, dynamic> json) {
     return CategoryModel(
       id: json['id'],
       nameCategory: json['attributes']['name'] ?? '',
       desCategory: json['attributes']['Description'] ?? '',
     );
   }

   @override
   String toString() {
     return 'CategoryModel{id: $id, nameCategory: $nameCategory, Description: $desCategory}';
   }
}
