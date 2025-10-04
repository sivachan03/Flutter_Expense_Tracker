import 'package:expense_trackerr/Pages/AddExpense.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Models/expense_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<ExpenseModel> expenes = [
  //   ExpenseModel(title: "Electric bill", amount: 12, date: DateTime.now()),
  //   ExpenseModel(title: "Pertrol bill", amount: 12, date: DateTime.now()),
  // ];

  final expenseBox = Hive.box<ExpenseModel>("expenses");

  List<ExpenseModel> get expenes => expenseBox.values.toList();
  final double totamt = 15000;

  double get totexpenses =>
      expenes.fold(0.0, (sum, item) => sum + (item.amount ?? 0.0));

  double get balence => totamt - totexpenses;

  confirmDelete(index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Expense"),
        content: Text("Are you sure want to Delete?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() async {
                final expenseBox = Hive.box<ExpenseModel>("expenses");
                await expenseBox.deleteAt(index);
                setState(() {});
                Navigator.pop(context);
              });
            },
            child: Text("Delete"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpenses = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addexpense()),
          );
          setState(() {
            // expenes.add(newExpenses);
            expenseBox.add(newExpenses);
          });
          // print(" Title is :${newExpenses.title}");
          // print(" Amount is :${newExpenses.amount}");
          // print(" Date is :${newExpenses.date}");
        },
        splashColor: Colors.pinkAccent,
        backgroundColor: Colors.pinkAccent[300],
        child: Icon(Icons.add, size: 30, color: Colors.red),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Expense Tracker",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 30, top: 30, bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total Amount ",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: balence.toStringAsFixed(2),
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text.rich(
                  TextSpan(
                    text: "Balence Amount ",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: balence.toStringAsFixed(2),
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 68.0, left: 130),
                  child: expenes.isEmpty
                      ? Text("No Expenses ", style: TextStyle(fontSize: 20))
                      : Container(),
                ),
              ],
            ),
          ),

          Expanded(
            child: expenes.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 208.0),
                    child: LoadingAnimationWidget.halfTriangleDot(
                      color: Colors.redAccent,

                      size: 50,
                    ),
                  )
                : ListView.builder(
                    itemCount: expenes.length,
                    itemBuilder: (context, index) {
                      final ex = expenes[index];
                      return Expenses(
                        title: ex.title,
                        amount: ex.amount,
                        date: ex.date,

                        onDelete: () => confirmDelete(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Expenses extends StatelessWidget {
  final title;
  final date;
  final amount;
  final VoidCallback onDelete;

  const Expenses({
    super.key,
    this.title,
    this.date,
    this.amount,
    required this.onDelete,
  });

  String get formatedDate {
    return date == null ? "noDate" : DateFormat("MMMM d,y").format(date!);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(5),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.pink[700],
            ),
            width: width,
            height: 90,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.length > 10
                            ? '${title.substring(0, 10)}...'
                            : title,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // "${date.day} / ${date.month}/ ${date.year}",
                        formatedDate,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    "\$ $amount",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, size: 32, color: Colors.red[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
