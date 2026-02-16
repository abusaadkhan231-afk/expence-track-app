import 'dart:io';
import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../models/transaction_model.dart';

class ExportService {
  /// 📄 Export PDF
  static Future<void> exportToPDF(List<ExpenseTransaction> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Expense Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),

            pw.Table.fromTextArray(
              headers: ['Title', 'Category', 'Amount', 'Date'],
              data: transactions.map((tx) {
                return [
                  tx.title,
                  tx.category,
                  tx.isIncome ? '+${tx.amount}' : '-${tx.amount}',
                  tx.date.toString().split(' ')[0],
                ];
              }).toList(),
            ),
          ],
        ),
      ),
    );

    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/expense_report.pdf');

    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }

  /// 📊 Export Excel
  static Future<void> exportToExcel(
    List<ExpenseTransaction> transactions,
  ) async {
    final excel = Excel.createExcel();
    final sheet = excel['Expenses'];

    sheet.appendRow(['Title', 'Category', 'Amount', 'Date']);

    for (var tx in transactions) {
      sheet.appendRow([
        tx.title,
        tx.category,
        tx.isIncome ? tx.amount : -tx.amount,
        tx.date.toString().split(' ')[0],
      ]);
    }

    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/expense_report.xlsx');

    file.writeAsBytesSync(excel.encode()!);
    await OpenFile.open(file.path);
  }
}
