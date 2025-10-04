import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Models/expense_model.dart';
import 'Pages/AddExpense.dart';
import 'Pages/home.dart';
import 'Pages/onBoardingScreen.dart';

void main() async {
  // ✅ initialize Hive
  await Hive.initFlutter();

  // ✅ register adapter
  Hive.registerAdapter(ExpenseModelAdapter());

  // ✅ open the box
  await Hive.openBox<ExpenseModel>("expenses");
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoardingSccreen(),
    );
  }
}
