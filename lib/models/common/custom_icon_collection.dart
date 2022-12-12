import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/common/custom_icon.dart';

class CustomIconCollection{
  final List<CustomIcon> _icons = [
    CustomIcon(id: 'bars', icon: CupertinoIcons.bars),
    CustomIcon(id: 'alarm', icon: CupertinoIcons.alarm),
    CustomIcon(id: 'airplane', icon: CupertinoIcons.airplane),
    CustomIcon(id: 'today', icon: CupertinoIcons.calendar_today),
    CustomIcon(id: 'photo', icon: CupertinoIcons.photo_on_rectangle),
    CustomIcon(id: 'person', icon: CupertinoIcons.person),
    CustomIcon(id: 'phone', icon: CupertinoIcons.phone),
    CustomIcon(id: 'lightbulb', icon: CupertinoIcons.lightbulb_fill),
    CustomIcon(id: 'umbrella', icon: CupertinoIcons.umbrella_fill),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);

  CustomIcon findColorById(id){
    return _icons.firstWhere((element) => element.id == id);
  }
}