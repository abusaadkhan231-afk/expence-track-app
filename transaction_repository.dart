import '../db/expense_database.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final db = ExpenseDatabase.instance;

  Future<void> insertTransaction(ExpenseTransaction tx) async {
    final database = await db.database;
    await database.insert('transactions', tx.toMap());
  }

  Future<List<ExpenseTransaction>> fetchTransactions() async {
    final database = await db.database;
    final result = await database.query('transactions', orderBy: 'date DESC');

    return result.map((e) => ExpenseTransaction.fromMap(e)).toList();
  }

  Future<void> deleteTransaction(int id) async {
    final database = await db.database;
    await database.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
