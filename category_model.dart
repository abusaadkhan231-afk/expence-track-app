import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class ExpenseCategories {
  static const food = CategoryModel(
    name: 'Food',
    icon: Icons.restaurant,
    color: Colors.orange,
  );

  static const transport = CategoryModel(
    name: 'Transport',
    icon: Icons.directions_bus,
    color: Colors.blue,
  );

  static const rent = CategoryModel(
    name: 'Rent',
    icon: Icons.home,
    color: Colors.purple,
  );

  static const shopping = CategoryModel(
    name: 'Shopping',
    icon: Icons.shopping_bag,
    color: Colors.pink,
  );

  static const salary = CategoryModel(
    name: 'Salary',
    icon: Icons.account_balance_wallet,
    color: Colors.green,
  );

  static List<CategoryModel> all = [food, transport, rent, shopping, salary];

  static CategoryModel fromName(String name) {
    return all.firstWhere((c) => c.name == name, orElse: () => food);
  }
}
