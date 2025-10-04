import 'package:expense_trackerr/Models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Addexpense extends StatefulWidget {
  const Addexpense({super.key});

  @override
  State<Addexpense> createState() => _AddexpenseState();
}

class _AddexpenseState extends State<Addexpense> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? _selectedDate;
  final _formkey = GlobalKey<FormState>();

  void ShowDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    print("Picked Date: $pickedDate");
  }

  void SubmitForm() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text);

    if ((_formkey.currentState?.validate() ?? false) && _selectedDate != null) {
      {
        // print("$title, $amount,date: $_selectedDate");
        // final Newexpense = {
        //   'Title': title,
        //   'Amount': amount,
        //   'Date': _selectedDate,
        // };
        final Newexpense = ExpenseModel(
          title: title,
          amount: amount,
          date: _selectedDate,
        );
        Navigator.pop(context, Newexpense);
      }
    }
  }

  void ResetForm() {
    setState(() {
      _formkey.currentState?.reset();
      titleController.clear();
      amountController.clear();
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Add Expences")),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image.asset("assets/images/add.jpg", width: 200),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Text(
                "Add Your Expenses ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 40),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 3,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 30),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount is required";
                  }
                  // if (double.tryParse(value) == null) {
                  //   return "Enter a valid number";
                  // }
                },

                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 3,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 40, bottom: 20),
              child: Text(
                _selectedDate == null
                    ? "No selcted date"
                    : "Selected Date:  ${_selectedDate!.day} / ${_selectedDate!.month} /${_selectedDate!.year}",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
            ),

            TextButton(
              onPressed: () {
                ShowDatePicker();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select Date", style: TextStyle(fontSize: 22)),
                  Icon(Icons.date_range),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    SubmitForm();
                  },
                  child: Text("Add Expense", style: TextStyle(fontSize: 22)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    ResetForm();
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
