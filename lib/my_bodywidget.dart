import 'package:flutter/material.dart';
import 'package:notes/widgets/note_item.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';

class MyBodywidget extends StatefulWidget {
  final bool showLocked;

  MyBodywidget(this.showLocked);

  @override
  _MyBodywidgetState createState() => _MyBodywidgetState();
}

class _MyBodywidgetState extends State<MyBodywidget> {
  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context);
    final notes = widget.showLocked ? notesData.lockedItems : notesData.items;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: EdgeInsets.all(10),
      itemCount: notes.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: notes[i],
        child: NoteItem(),
      ),
    );
  }
}
