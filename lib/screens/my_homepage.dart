import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/note_details_screen.dart';
import 'package:notes/screens/pin_screen.dart';
import '../my_bodywidget.dart';

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  var _showOnlyLocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Notes'),
        actions: [
          PopupMenuButton(
              onSelected: (int selectedValue) {
                setState(() {
                  if (selectedValue == 1) {
                    Navigator.of(context).pushNamed(PinScreen.routeName);
                    _showOnlyLocked = true;
                  } else
                    _showOnlyLocked = false;
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text('Show locked'),
                      value: 1,
                    )
                  ])
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: MyBodywidget(_showOnlyLocked),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor,
              height: 120,
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.yellow[800],
          onPressed: () {
            Navigator.of(context)
                .pushNamed(NoteDetailsScreen.routeName, arguments: {
              'id': '',
              'title': '',
              'text': '',
            });
          }),
    );
  }
}
