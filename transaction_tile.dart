import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';

class TransactionTile extends StatelessWidget {
  final ExpenseTransaction tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final category = ExpenseCategories.fromName(tx.category);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1.5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: category.color.withValues(alpha: 0.15),
          child: Icon(category.icon, color: category.color),
        ),
        title: Text(
          tx.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy').format(tx.date),
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Text(
          (tx.isIncome ? '+ ₹' : '- ₹') + tx.amount.toStringAsFixed(2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: tx.isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
