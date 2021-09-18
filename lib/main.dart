import 'package:flutter/material.dart';
import 'package:notes/screens/note_details_screen.dart';
import 'package:notes/screens/pin_screen.dart';
import 'screens/my_homepage.dart';
import './providers/notes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Notes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.grey[850], fontFamily: 'Lato'),
        routes: {
          '/': (ctx) => MyHomepage(),
          NoteDetailsScreen.routeName: (ctx) => NoteDetailsScreen(),
          PinScreen.routeName: (ctx) => PinScreen()
        },
      ),
    );
  }
}
