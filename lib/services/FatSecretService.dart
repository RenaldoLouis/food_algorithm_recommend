import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as logger;

import 'package:food_algorithm_recommend/models/FoodCategoryModel.dart';

_token() async {
  final Dio dio = Dio();
  String getURL = 'https://oauth.fatsecret.com/connect/token';

  String username = '4ad0b6ef0b984ff89cca7569eeb65226';
  String password = 'c5470d2bc42542fe89dd35314b460b9d';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));

  Map<String, dynamic> header = {
    'Authorization': basicAuth,
  };

  final formData = FormData.fromMap({
    'grant_type': 'client_credentials',
    'scope': 'basic',
  });

  String token;

  try {
    final res = await dio.post(
      getURL,
      options: Options(
        headers: header,
      ),
      data: formData,
    );
    token = res.data['access_token'];
  } on DioError catch (e) {
    token = '';
    logger.log('error Get Acces Token: ${e.response?.data}');
  }

  return 'Bearer $token';
}

class FatSecretService {
  final Dio dio = Dio();

  Future<List<FoodCategoryModel>> getAllFoodCategories() async {
    String getURL =
        'https://platform.fatsecret.com/rest/server.api?method=food.get.v3&format=json';

    Map<String, dynamic> header = {
      'Authorization': await _token(),
    };

    List<FoodCategoryModel> food_categories;

    try {
      final res = await dio.get(
        getURL,
        options: Options(
          headers: header,
          contentType: 'application/json',
        ),
      );
      var users = res.data['food_categories'];
      food_categories = users['food_category']
          .map<FoodCategoryModel>(
            (item) => FoodCategoryModel.fromJson(item),
          )
          .toList();
    } on DioError catch (e) {
      food_categories = [];
      logger.log('error Get all FoodCategory: ${e.response?.data}');
    }

    return food_categories;
  }

  Future<List<dynamic>> getAllRecipe() async {
    String getURL =
        'https://platform.fatsecret.com/rest/server.api?method=recipe_types.get.v2&format=json';

    Map<String, dynamic> header = {
      'Authorization': await _token(),
    };

    List<dynamic> recipe = [];

    try {
      final res = await dio.get(
        getURL,
        options: Options(
          headers: header,
          contentType: 'application/json',
        ),
      );
      var recipes = res.data['recipe_types'];
      if (recipes != null) {
        if (recipes['recipe_type'] != null) {
          recipe = recipes['recipe_type'].toList();
        }
      }
    } on DioError catch (e) {
      recipe = [];
      logger.log('error Get all FoodCategory: ${e.response?.data}');
    }

    return recipe;
  }
}
