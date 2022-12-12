import 'package:flutter/material.dart';
import 'package:foodapp/models/category/category.dart';
import 'package:foodapp/models/category/category_collection.dart';

class SelectReminderCategoryScreen extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) selectCategoryCallback;

  SelectReminderCategoryScreen(
      {required this.selectedCategory, required this.selectCategoryCallback});

  var categories = CategoryCollection().categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slect category'),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            if (item.id=='all'){
             return Container();
            }
            return ListTile(
              onTap: (){
                selectCategoryCallback(item);
                Navigator.pop(context);
              },
              title: Text(item.name),
              trailing:
                  item.name == selectedCategory.name ? Icon(Icons.check) : null,
            );
          }),
    );
  }
}
