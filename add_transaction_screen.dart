import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _category = 'Food';
  bool _isIncome = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountCtrl,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _category,
              items: [
                'Food',
                'Transport',
                'Rent',
                'Shopping',
              ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            SwitchListTile(
              title: const Text('Income'),
              value: _isIncome,
              onChanged: (v) => setState(() => _isIncome = v),
            ),
            ElevatedButton(
              onPressed: () {
                final tx = ExpenseTransaction(
                  title: _titleCtrl.text,
                  amount: double.parse(_amountCtrl.text),
                  category: _category,
                  date: DateTime.now(),
                  isIncome: _isIncome,
                );
                context.read<TransactionProvider>().addTransaction(tx);
                Navigator.pop(context);
              },
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
