import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_tile.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return ListView.builder(
      itemCount: provider.transactions.length,
      itemBuilder: (context, index) {
        final tx = provider.transactions[index];

        return Dismissible(
          key: ValueKey(tx.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => provider.deleteTransaction(tx.id!),
          child: TransactionTile(tx: tx),
        );
      },
    );
  }
}
