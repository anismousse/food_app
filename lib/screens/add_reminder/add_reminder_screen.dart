import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/widgets/category_icon.dart';
import 'package:foodapp/models/category/category.dart';
import 'package:foodapp/models/category/category_collection.dart';
import 'package:foodapp/models/reminder/reminder.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/screens/add_reminder/select_reminder_category_screen.dart';
import 'package:foodapp/screens/add_reminder/select_reminder_list_screen.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/common/helpers/helpers.dart' as helpers;

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _notesTextController = TextEditingController();
  String _title = '';
  TodoList? _selectedList;
  Category _selectedCategory = CategoryCollection().categories[0];
  DateTime? _selctedDate;
  TimeOfDay? _selctedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController.addListener(() {
      setState(() {
        _title = _titleTextController.text;
      });
    });
  }

  _updateSelectedList(TodoList todoList) {
    setState(() {
      _selectedList = todoList;
    });
  }

  _updateSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextController.dispose();
    _notesTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _todolists = Provider.of<List<TodoList>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Reminder'),
        actions: [
          TextButton(
              onPressed: _title.isEmpty ||
                      _selctedTime == null ||
                      _selctedDate == null
                  ? null
                  : () async {
                      if (_selectedList == null) {
                        _selectedList = _todolists.first;
                      }
                      //1. add the reminder to user>uuid>reminders>new reminder
                      //2. update the reminder count in the list -> users>uid>todolists>todolist
                      final user = Provider.of<User?>(context, listen: false);

                      var newReminder = Reminder(
                          id: null,
                          title: _titleTextController.text,
                          categoryId: _selectedCategory.id,
                          list: _selectedList!.toJson(),
                          dueDate: _selctedDate!.microsecondsSinceEpoch,
                          dueTime: {
                            'hour': _selctedTime!.hour,
                            'minutes': _selctedTime!.minute
                          },
                          notes: _notesTextController.text);
                      try {
                        DatabaseService(uid: user!.uid)
                            .addReminder(reminder: newReminder);
                        Navigator.pop(context);
                        helpers.showSnackBar(context, 'Reminder added.');
                      } catch (e) {
                        helpers.showSnackBar(context, 'Unable to add reminder.');
                      }
                    },
              child: Text('Add', style: TextStyle()))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor),
              child: Column(
                children: [
                  TextField(
                    controller: _titleTextController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Title'),
                  ),
                  Divider(height: 1),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      controller: _notesTextController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Notes'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  // tileColor: Theme.of(context).cardColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectReminderListScreen(
                                  todolists: _todolists,
                                  selectedList: _selectedList != null
                                      ? _selectedList!
                                      : _todolists.first,
                                  selectListCallback: _updateSelectedList,
                                )));
                  },

                  leading: Text(
                    'List',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.blueAccent,
                          iconData: Icons.calendar_today),
                      SizedBox(width: 10),
                      Text(_selectedList != null
                          ? _selectedList!.title
                          : _todolists.first.title),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  // tileColor: Theme.of(context).cardColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectReminderCategoryScreen(
                                  selectedCategory: _selectedCategory,
                                  selectCategoryCallback:
                                      _updateSelectedCategory,
                                ),
                            fullscreenDialog: true));
                  },

                  leading: Text(
                    'Categorie',
                    style: Theme.of(context).textTheme.headline6,
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: _selectedCategory.icon.bgColor,
                          iconData: _selectedCategory.icon.iconData),
                      SizedBox(width: 10),
                      Text(_selectedCategory.name),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  // tileColor: Theme.of(context).cardColor,
                  onTap: () async {
                    final DateTime? pickdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)));

                    if (pickdate != null) {
                      setState(() {
                        _selctedDate = pickdate;
                      });
                    } else {
                      print('No date was picked');
                    }
                  },
                  leading: Text(
                    'Date',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.red.shade300,
                          iconData: CupertinoIcons.calendar_badge_minus),
                      SizedBox(width: 10),
                      Text(_selctedDate != null
                          ? DateFormat.yMMMd().format(_selctedDate!).toString()
                          : 'Selected Date'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
// tileColor: Theme.of(context).cardColor,
                  onTap: () async {
                    final TimeOfDay? picktime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (picktime != null) {
                      setState(() {
                        _selctedTime = picktime;
                      });
                    } else {
                      print('Np date was picked');
                    }
                  },
                  leading: Text(
                    'Time',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.red.shade300,
                          iconData: CupertinoIcons.time),
                      SizedBox(width: 10),
                      Text(_selctedTime != null
                          ? _selctedTime!.format(context).toString()
                          : 'Select Time'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
