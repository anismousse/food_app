
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodapp/models/common/cutom_color_collection.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../models/common/custom_color.dart';
import '../../models/common/custom_icon.dart';
import 'package:foodapp/common/helpers/helpers.dart' as helpers;
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/common/custom_icon_collection.dart';



class AddListScreen extends StatefulWidget {
  const AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {

  CustomColor _seclectedColor = CustomColorCollection().colors.first;
  CustomIcon _seclectedIcon = CustomIconCollection().icons.first;
  TextEditingController _textController =  TextEditingController();
  String _listName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.addListener(() {
      setState((){
        _listName = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New List'),
        actions: [
          TextButton(
              onPressed: _listName.isEmpty
              ? null
              : () async {
                if (_textController.text.isNotEmpty)
                  {
                    final user =Provider.of<User?>(context, listen: false);

                    final newTodoList = TodoList(
                        id: null,
                        title: _textController.text,
                        icon:{
                          'id': _seclectedIcon.id,
                          'color': _seclectedColor.id},
                        reminderCount: 0);

                    //set the date in firebase
                    try {
                      DatabaseService(uid: user!.uid).addTodoList(todoList: newTodoList);
                      helpers.showSnackBar(context, 'List added.');
                    } catch(e){
                      helpers.showSnackBar(context, 'Unable to add list.');
                    }
                    Navigator.pop(context);
                  }
                else{
                  print('please add a list');
                }
              },
              child: Text(
                  'Add',
              style: TextStyle(),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: _seclectedColor.color
              ),
              child: Icon(_seclectedIcon.icon, size:75,)
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: _textController,
                autofocus: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () => _textController.clear(),
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                          child: Icon(Icons.clear)),
                    )),
              ),
            ),
            SizedBox(height: 10,),
            Wrap(
              spacing: 11,
              runSpacing: 11,
              children: [
                for(final customColor in CustomColorCollection().colors)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _seclectedColor = customColor;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: _seclectedColor.id == customColor.id
                              ? Border.all(color: Colors.grey[600]!, width: 5)
                              : null,
                          shape: BoxShape.circle,
                          color: customColor.color),
                    ),
                  )
              ],
            ),
            SizedBox(height: 10,),
            Wrap(
              spacing: 11,
              runSpacing: 11,
              children: [
                for(final customIcon in CustomIconCollection().icons)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _seclectedIcon = customIcon;
                      });
                    },
                    child: Container(
                      child: Icon(customIcon.icon),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: _seclectedIcon.id == customIcon.id
                          ? Border.all(color: Colors.grey[600]!, width: 5)
                          : null,
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
