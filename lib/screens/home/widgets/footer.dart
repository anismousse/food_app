import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/screens/add_list/add_list_screen.dart';
import 'package:foodapp/screens/add_reminder/add_reminder_screen.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: todoLists.length > 0
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddReminderScreen(),
                              fullscreenDialog: true));
                    }
                  : null,
              icon: Icon(Icons.add),
              label: Text('New reminder')),
          TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/addList');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddListScreen(),
                        fullscreenDialog: true));
              },
              child: Text('Add List')),
        ],
      ),
    );
  }
}
