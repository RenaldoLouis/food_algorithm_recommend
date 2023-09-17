import 'dart:ffi';

class FoodCategoryModel {
  final String food_category_description;
  final String food_category_id;
  final String food_category_name;

  const FoodCategoryModel({
    this.food_category_description = "",
    this.food_category_id = "",
    this.food_category_name = "",
  });

  factory FoodCategoryModel.fromJson(Map json) {
    return FoodCategoryModel(
      food_category_description: json['food_category_description'],
      food_category_id: json['food_category_id'],
      food_category_name: json['food_category_name'],
    );
  }
}
