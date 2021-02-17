import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZCollectionBottomSheet extends StatefulWidget {
  final String title;

  ZCollectionBottomSheet({@required this.title});

  @override
  _ZCollectionBottomSheetState createState() => _ZCollectionBottomSheetState();
}

class _ZCollectionBottomSheetState extends State<ZCollectionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: [
          new Text(
            widget.title,
            style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
    );
  }
}
