import 'package:flutter/material.dart';
import 'package:foodapp/common/widgets/dismissible_background.dart';
import 'package:foodapp/screens/view_list/view_list_screen.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../common/widgets/category_icon.dart';
import '../../../models/common/custom_icon_collection.dart';
import '../../../models/common/cutom_color_collection.dart';
import '../../../models/todo_list/todo_list.dart';
import 'package:foodapp/common/helpers/helpers.dart' as helpers;

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    final user = Provider.of<User?>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'My list',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todoLists.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {

                    try {
                      await DatabaseService(uid: user!.uid).deleteTodoList(
                          todoLists[index]);
                      helpers.showSnackBar(context, 'List deleted.');
                    } catch (e){
                      helpers.showSnackBar(context, 'Unable to delete list.');
                    }
                  },
                  key: UniqueKey(),
                  background: DismissibleBackground(),
                  direction: DismissDirection.endToStart,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        onTap: todoLists[index].reminderCount > 0
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewListScreen(
                                              todolist: todoLists[index],
                                            )));
                              }
                            : null,
                        leading: CategoryIcon(
                            bgColor: CustomColorCollection()
                                .findColorById(todoLists[index].icon['color'])
                                .color,
                            iconData: CustomIconCollection()
                                .findColorById(todoLists[index].icon['id'])
                                .icon),
                        title: Text(todoLists[index].title),
                        trailing: Text(
                          todoLists[index].reminderCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      )),
                );
              }),
        ),
      ]),
    );
  }


}

