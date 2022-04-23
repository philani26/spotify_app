// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TrackSearch extends StatelessWidget {
  static ValueNotifier<String> searchItem = ValueNotifier("");
  const TrackSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Icon(Icons.search),
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration(hintText: "Find tracks in playlist"),
                onChanged: (value) {
                  searchItem.value = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
