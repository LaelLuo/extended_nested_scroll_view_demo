import 'package:flutter/material.dart';

class ChildPage extends StatelessWidget {
  final int index;

  ChildPage(this.index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ListTile(title: Text('Title $index')),
      itemCount: index * 10,
    );
  }
}
