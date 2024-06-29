import 'package:cost_tracker/main.dart';
import 'package:cost_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:cost_tracker/models/expense.dart';
import 'package:cost_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 122,
      title: 'flutter',
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      amount: 99,
      title: 'cinsema',
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  _addExpenses() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenses(onAddExpense: _addExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('no expense found. Start Adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onremoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _addExpenses,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Container(
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Center(child: Text('The chart'))),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: const Center(child: Text('The chart'))),
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
