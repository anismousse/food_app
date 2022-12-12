import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/widgets/category_icon.dart';
import 'package:foodapp/config/custom_theme.dart';
import 'package:foodapp/models/category/category_collection.dart';
import 'package:foodapp/models/common/custom_icon_collection.dart';
import 'package:foodapp/models/common/cutom_color_collection.dart';
import 'package:foodapp/models/todo_list/todo_list.dart';
import 'package:foodapp/models/todo_list/todo_list_collection.dart';
import 'package:foodapp/screens/auth/authenticate_screen.dart';
import 'package:foodapp/screens/home/widgets/TodoLists.dart';
import 'package:provider/provider.dart';

import 'widgets/footer.dart';
import 'widgets/grid_view_items.dart';
import 'widgets/list_view_items.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();
  String layoutType = 'grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.wb_sunny),
              onPressed: () {
                final customTheme =
                    Provider.of<CustomTheme>(context, listen: false);
                customTheme.toggleTheme();
              }),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout)),
          TextButton(
              onPressed: () {
                setState(() {
                  if (layoutType == 'grid') {
                    layoutType = 'list';
                  } else {
                    layoutType = 'grid';
                  }
                });
              },
              child: Text(
                layoutType == 'grid' ? 'Edit' : 'Done',
                // style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              // shrinkWrap: true,
              children: [
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  crossFadeState: layoutType == 'grid'
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: GridViewItems(
                      categories: categoryCollection.selectedCategories),
                  secondChild:
                      ListViewItems(categoryCollection: categoryCollection),
                ),
                TodoLists()
              ],
            ),
          ),
          Footer()
        ],
      )),
    );
  }
}
