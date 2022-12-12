import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/models/reminder/reminder.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _userRef;

  DatabaseService({required this.uid})
      : _database = FirebaseFirestore.instance,
        _userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  Stream<List<TodoList>> todoListStream() {
    return _userRef
        .collection('todo_lists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (todoListSnapshot) => TodoList.fromJson(
                todoListSnapshot.data(),
              ),
            )
            .toList());
  }

  Stream<List<Reminder>> remindersStream() {
    return _userRef.collection('reminders').snapshots().map((snapshot) =>
        snapshot
            .docs
            .map((reminderSnapshot) =>
                Reminder.fromJson(reminderSnapshot.data()))
            .toList());
  }

  addTodoList({required TodoList todoList}) async {
    final todoListRef = _userRef.collection('todo_lists').doc();
    todoList.id = todoListRef.id;
    try {
      await todoListRef.set(todoList.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodoList(TodoList todoList) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final todoListRef = _userRef.collection('todo_lists').doc(todoList.id);
    final reminderSnaspots = await _userRef
        .collection('reminders')
        .where('list.id', isEqualTo: todoList.id)
        .get();

    reminderSnaspots.docs.forEach((reminder) {
      batch.delete(reminder.reference);
    });
    batch.delete(todoListRef);

    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future addReminder({required Reminder reminder}) async {
    var reminderRef = _userRef.collection('reminders').doc();
    reminder.id = reminderRef.id;

    final listRef = _userRef.collection('todo_lists').doc(reminder.list['id']);

    WriteBatch batch = _database.batch();
    batch.set(reminderRef, reminder.toJson());
    batch.update(
        listRef, {'reminder_count': reminder.list['reminder_count'] + 1});
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReminder(
      Reminder reminder, TodoList todoListForReminder) async {
    WriteBatch batch = _database.batch();

    final reminderRef = _userRef.collection('reminders').doc(reminder.id);
    final listRef = _userRef.collection('todo_lists').doc(reminder.list['id']);
    batch.delete(reminderRef);
    batch.update(
        listRef, {'reminder_count': todoListForReminder.reminderCount - 1});
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
