import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/summary_card.dart';
import 'transaction_list_screen.dart';
import 'add_transaction_screen.dart';
import '../utils/export_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (provider.transactions.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No transactions to export')),
                );
                return;
              }

              if (value == 'pdf') {
                ExportService.exportToPDF(provider.transactions);
              } else if (value == 'excel') {
                ExportService.exportToExcel(provider.transactions);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'pdf',
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Export as PDF'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'excel',
                child: Row(
                  children: [
                    Icon(Icons.table_chart, color: Colors.green),
                    SizedBox(width: 10),
                    Text('Export as Excel'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTransactionScreen(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          SummaryCard(
            balance: provider.balance,
            income: provider.totalIncome,
            expense: provider.totalExpense,
          ),
          const Expanded(child: TransactionListScreen()),
        ],
      ),
    );
  }
}
