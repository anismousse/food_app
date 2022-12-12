import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/widgets/dismissible_background.dart';
import 'package:foodapp/models/reminder/reminder.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/common/helpers/helpers.dart' as helpers;

class ViewListScreen extends StatelessWidget {
  final TodoList todolist;

  const ViewListScreen({Key? key, required this.todolist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForList = allReminders
        .where((reminder) => reminder.list['id'] == todolist.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(todolist.title),
      ),
      body: ListView.builder(
          itemCount: remindersForList.length,
          itemBuilder: (context, index) {
            final reminder = remindersForList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: DismissibleBackground(),
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context, listen: false);
                try {
                  await DatabaseService(uid: user!.uid)
                      .deleteReminder(reminder, todolist);
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
