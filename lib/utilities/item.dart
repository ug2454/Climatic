import 'package:flutter/material.dart';

class Item {
  bool isExpanded;
  Widget headerValue;
  Widget expandedValue;

  Item({this.isExpanded = false, this.headerValue, this.expandedValue});
}
