import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/models/FoodCategoryModel.dart';
import 'package:food_algorithm_recommend/models/product.dart';
import 'package:food_algorithm_recommend/pages/listFood/ProductContainer.dart';
import 'package:food_algorithm_recommend/providers/userInfoProviders.dart';
import 'package:food_algorithm_recommend/services/FatSecretService.dart';
import 'package:food_algorithm_recommend/theme.dart';

class ListFoodPage extends ConsumerStatefulWidget {
  const ListFoodPage({super.key});

  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends ConsumerState<ListFoodPage> {
  final _fatSecretService = FatSecretService();
  final List<String> categories = ['Food', 'Fruits', 'Sports', 'Vehicle'];

  List<String> selectedCatogories = [];

  String BMIResult = '';

  Future<String> calculateBMI(int weight, int height) async {
    double heightMeter = height / 100;
    double res = (weight / (heightMeter * heightMeter));
    return res.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userInfo = ref.watch(userHealthInfoProvider);
      String value = await calculateBMI(userInfo!.weight, userInfo.height);
      if (mounted) {
        setState(() {
          BMIResult = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = productList.where((product) {
      return selectedCatogories.isEmpty ||
          selectedCatogories.contains(product.category);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Info BMI: ${BMIResult}'),
        backgroundColor: green1,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait(
          [
            _fatSecretService.getAllRecipe(),
          ],
        ),
        builder: (context, snapshot) {
          var Recipies;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Text('Error: ${snapshot.error}');
          } else {
            Recipies = snapshot.data![0] as List<dynamic>;
          }

          log('Recipies $Recipies');

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categories
                      .map(
                        (category) => FilterChip(
                          label: Text(category),
                          selected: selectedCatogories.contains(category),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedCatogories.add(category);
                              } else {
                                selectedCatogories.remove(category);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: false,
                  primary: false,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    ...filteredProducts.map(
                      (product) => ProductContainer(
                        image: 'assets/images/biryani.png',
                        price: 12,
                        name: product.name,
                      ),
                    ),
                  ],
                ),

                // ListView.builder(
                //   itemCount: filteredProducts.length,
                //   itemBuilder: (context, index) {
                //     final product = filteredProducts[index];
                //     return Card(
                //       elevation: 8.0,
                //       margin: const EdgeInsets.all(8.0),
                //       child: Container(
                //         decoration:
                //             const BoxDecoration(color: Colors.indigoAccent),
                //         child: ListTile(
                //           contentPadding: const EdgeInsets.symmetric(
                //               horizontal: 10, vertical: 10),
                //           title: Text(
                //             product.name,
                //             style: const TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           subtitle: Text(
                //             product.category,
                //             style: const TextStyle(
                //                 color: Colors.white,
                //                 fontStyle: FontStyle.italic),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          );
        },
      ),
    );
  }
}
