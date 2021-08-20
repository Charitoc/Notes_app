import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/note_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';

class NoteItem extends StatefulWidget {
  @required
  final String id;
  @required
  final String title;
  @required
  final String text;
  @required
  final bool isLocked;

  NoteItem({this.id, this.title, this.text, this.isLocked});

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    final note = Provider.of<Note>(context);
    final notes = Provider.of<Notes>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(note.isLocked ? Icons.lock : Icons.lock_open),
              onPressed: () {
                note.toggleLocked();
                notes.saveNotesonDB();
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                notes.deleteNote(note.id);
              },
            ),
            backgroundColor: Colors.black54,
          ),
          child: GestureDetector(
            //onTap: () => openNote(context),
            onTap: () => Navigator.of(context).pushNamed(
              NoteDetailsScreen.routeName,
              arguments: {'id': note.id},
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontWeight: FontWeight.w900),
                    maxLines: 1,
                  ),
                  Text(
                    note.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
