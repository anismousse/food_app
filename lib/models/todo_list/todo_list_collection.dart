import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';

class TodoListCollection with ChangeNotifier{
  List<TodoList> _todolists = [];

  UnmodifiableListView<TodoList> get todolists =>UnmodifiableListView(_todolists);

  addTodoList(TodoList todoList){
    _todolists.add(todoList);
    notifyListeners();
  }

  removeTodoList(TodoList todoList){
    _todolists.removeWhere((element) => element.id == todoList.id);
    notifyListeners();
  }
}