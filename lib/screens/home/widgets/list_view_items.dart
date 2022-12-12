import 'package:flutter/material.dart';
import 'package:foodapp/models/category/category_collection.dart';

class ListViewItems extends StatefulWidget {
  final CategoryCollection categoryCollection;
  const ListViewItems({required this.categoryCollection});

  @override
  State<ListViewItems> createState() => _ListViewItemsState();
}

class _ListViewItemsState extends State<ListViewItems> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        shrinkWrap: true,
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex)
          {
            newIndex -=1;
          }
        final item = widget.categoryCollection.removeItem(oldIndex);
        setState(() {
          widget.categoryCollection.insertItem(newIndex, item);
        });

      },
      children: widget.categoryCollection.categories.map(
              (category) => ListTile(
                onTap: (){
                  //toggle checkbox
                  setState(() {
                    category.toggleCheckbox();
                  });

                },
                key: UniqueKey(),
                tileColor: Theme.of(context).cardColor,
                leading: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: category.isChecked
                        ? Colors.blueAccent
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: category.isChecked
                          ? Colors.blueAccent
                          : Colors.grey,
                    )
                  ),
                    child: Icon(
                        Icons.check,
                        color: category.isChecked
                            ? Colors.white
                            : Colors.transparent,
                    )
                ),
                title: Row(
                  children: [
                    category.icon,
                    SizedBox(width: 10),
                    Text(category.name),
                  ],
                ),
                trailing: Icon(Icons.reorder),
              )
      ).toList()
    );
  }
}
