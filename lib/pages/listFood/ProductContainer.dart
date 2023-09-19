import 'dart:ffi';

import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  String image;
  String name;
  int price;

  ProductContainer({
    Key? key,
    this.image = "assets/images/biryani.png",
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 220,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            new BoxShadow(color: Colors.black87, blurRadius: 5.0),
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset(image),
            // backgroundImage: AssetImage(image),
          ),
          ListTile(
            leading: Text(
              name,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: Text(
              "\Rs.$price",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
