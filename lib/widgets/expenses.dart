import 'package:flutter/material.dart';

import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenses(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // immediately show undo when collection deleted
    ScaffoldMessenger.of(context).clearSnackBars();
    //after deleted expense. show undo button
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expenses deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some..!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpenses: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width <
              600 // Ternary expression for IF width < 600 display as a Column - Portrait mode ( Landscape )
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(
                child: mainContent,
              ),
            ])
          : Row(
              // ELSE display as a Row
              children: [
                Expanded(
                  // This expanded using because default chart using width: double.infinity for their Container. So after portrait width also take infinity display.
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
