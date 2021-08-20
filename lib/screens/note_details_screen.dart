import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';

class NoteDetailsScreen extends StatefulWidget {
  static const routeName = '/note_details_screen';

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final noteId = routeArgs['id'];
    final notesData = Provider.of<Notes>(context);
    final note = notesData.openNote(noteId);
    final titleController = TextEditingController(text: note?.title ?? "");
    final textController = TextEditingController(text: note?.text ?? "");

    Function addNote = notesData.addNote;

    void popPage() {
      if (note.id == null &&
          (titleController.text != '' || textController.text != '')) {
        addNote(
          DateTime.now().toString(),
          titleController.text,
          textController.text,
        );
        notesData.saveNotesonDB();
      } else if (note.id != null) {
        notesData.updateNote(
            note.id, titleController.text, textController.text);
        notesData.saveNotesonDB();
      } else {
        DoNothingAction();
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => popPage(),
        ),
        title: Text(note?.title ?? ""),
      ),
      body: Column(
        children: [
          TextField(
            maxLength: 30,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: titleController,
          ),
          TextFormField(
            //maxLength: MediaQuery.of(context).size.width,
            maxLines: 7,
            cursorColor: Colors.black,
            controller: textController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: note.text != '' ? note.text : "Note"),
          )
        ],
      ),
    );
  }
}
