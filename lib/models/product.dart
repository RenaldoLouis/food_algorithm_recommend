class Product {
  final String name;
  final String category;

  Product({
    required this.name,
    required this.category,
  });
}

final List<Product> productList = [
  Product(name: 'Sandwich', category: 'Food'),
  Product(name: 'Vegeatble', category: 'Food'),
  Product(name: 'Tennis', category: 'Sports'),
  Product(name: 'Tesla', category: 'Vehicle'),
  Product(name: 'BMW', category: 'Vehicle'),
  Product(name: 'Apple', category: 'Fruits'),
  Product(name: 'Mango', category: 'Fruits'),
  Product(name: 'Banana', category: 'Fruits'),
];
