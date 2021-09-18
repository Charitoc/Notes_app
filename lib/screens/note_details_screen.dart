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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      if (note.id == '' &&
          (titleController.text != '' || textController.text != '')) {
        addNote(
          DateTime.now().toString(),
          titleController.text,
          textController.text,
        );
        notesData.saveNotesonDB();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Note added'),
          duration: Duration(seconds: 2),
        ));
      } else if (note.id != '') {
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
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              popPage();
            }),
        // title: Text(note?.title ?? ""),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          TextFormField(
            maxLength: 30,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: new InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintStyle: TextStyle(color: Colors.white30),
                hintText: note.title != '' ? note.title : "Title"),
            controller: titleController,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            maxLines: 7,
            controller: textController,
            decoration: new InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintStyle: TextStyle(
                  color: Colors.white30,
                ),
                hintText: note.text != '' ? note.text : "Note"),
          )
        ],
      ),
    );
  }
}
