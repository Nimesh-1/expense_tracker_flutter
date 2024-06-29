import 'package:cost_tracker/models/expense.dart';
import 'package:cost_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onremoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onremoveExpense(expenses[index]);
        },
        child: ExpensesItem(
          expenses[index],
        ),
      ),
    );
  }
}
