import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/models/product.dart';
import 'package:food_algorithm_recommend/providers/userInfoProviders.dart';
import 'package:food_algorithm_recommend/theme.dart';

class ListFoodPage extends ConsumerStatefulWidget {
  const ListFoodPage({super.key});

  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends ConsumerState<ListFoodPage> {
  final List<String> categories = ['Food', 'Fruits', 'Sports', 'Vehicle'];

  List<String> selectedCatogories = [];
  @override
  Widget build(BuildContext context) {
    final filteredProducts = productList.where((product) {
      return selectedCatogories.isEmpty ||
          selectedCatogories.contains(product.category);
    }).toList();

    final userInfo = ref.watch(userHealthInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Info: ${userInfo!.weight}, ${userInfo!.height}'),
        backgroundColor: green1,
      ),
      body: Column(
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
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.indigoAccent),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      title: Text(
                        product.name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product.category,
                        style: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
