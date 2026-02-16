import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../repository/transaction_repository.dart';

class TransactionProvider with ChangeNotifier {
  final _repo = TransactionRepository();
  List<ExpenseTransaction> _transactions = [];

  List<ExpenseTransaction> get transactions => _transactions;

  double get totalIncome =>
      _transactions.where((t) => t.isIncome).fold(0, (a, b) => a + b.amount);

  double get totalExpense =>
      _transactions.where((t) => !t.isIncome).fold(0, (a, b) => a + b.amount);

  double get balance => totalIncome - totalExpense;

  Future<void> loadTransactions() async {
    _transactions = await _repo.fetchTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(ExpenseTransaction tx) async {
    await _repo.insertTransaction(tx);
    loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _repo.deleteTransaction(id);
    loadTransactions();
  }
}
