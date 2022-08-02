import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/data/data.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/widgets/note_card_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = '';
  List<Note> notes = noteData!;

  filterNotes() {
    List<Note> results = [];
    var regex = RegExp('^($search)');

    for (var element in noteData!) {
      if(element.title!.toLowerCase().contains(search.toLowerCase())||element.text!.toLowerCase().contains(search.toLowerCase()) ){
        results.add(element);
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          autofocus: true,
          onChanged: (text) {
            setState(() {
              search = text;
              notes = filterNotes();
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search your notes',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => noteCard(notes[index], context)),
    );
  }
}
