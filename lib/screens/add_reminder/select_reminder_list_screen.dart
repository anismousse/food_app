import 'package:flutter/material.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';

class SelectReminderListScreen extends StatelessWidget {
  final List<TodoList> todolists;
  final TodoList selectedList;
  final Function(TodoList) selectListCallback;

  const SelectReminderListScreen({super.key,
    required this.todolists,
    required this.selectedList,
    required this.selectListCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selct List'),
      ),
      body: ListView.builder(
          itemCount: todolists.length,
          itemBuilder: (context, index) {
            final item = todolists[index];
            return ListTile(
              onTap: (){
                selectListCallback(item);
                Navigator.pop(context);
              },
              title: Text(item.title),
              trailing: item.title == selectedList.title
                  ? Icon(Icons.check)
                  : null,
            );
          }),
    );
  }
}
