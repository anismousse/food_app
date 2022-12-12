import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/helpers/helpers.dart' as helpers;
import 'package:foodapp/common/widgets/dismissible_background.dart';
import 'package:foodapp/models/category/category.dart';
import 'package:foodapp/models/reminder/reminder.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:provider/provider.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;

  const ViewListByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == 'all')
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.id),
      ),
      body: ListView.builder(
          itemCount: remindersForCategory.length,
          itemBuilder: (context, index) {
            final reminder = remindersForCategory[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: DismissibleBackground(),
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context, listen: false);
                final todolist =
                    Provider.of<List<TodoList>>(context, listen: false);
                final todoListForReminder = todolist.firstWhere(
                    (todoList) => todoList.id == reminder.list['id']);
                try {
                  await DatabaseService(uid: user!.uid)
                      .deleteReminder(reminder, todoListForReminder);
                  helpers.showSnackBar(context, 'Reminder deleted');
                } catch (e) {
                  helpers.showSnackBar(context, 'Unable to delete reminder');
                }
              },
              child: Card(
                child: ListTile(
                  title: Text(reminder.title),
                  subtitle:
                      reminder.notes != null ? Text(reminder.notes!) : null,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(helpers.formatDate(reminder.dueDate)),
                      Text(helpers.formatTime(context, reminder.dueTime['hour'],
                          reminder.dueTime['minutes']))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
