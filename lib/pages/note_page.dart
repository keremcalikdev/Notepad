import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/data/data.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/pages/home_page.dart';
import 'package:notepad/utils/time.dart';

import '../widgets/bottom_sheet.dart';

class NotePage extends StatefulWidget {
  final Note note;
  const NotePage({Key? key, required this.note}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    controller.text = widget.note.title ?? '';
    controller1.text = widget.note.text ?? '';

    super.initState();
  }

  void noteEdit(note) {
    if (controller.text != '' && controller1.text != '') {
      note.update(
          title: controller.text, text: controller1.text, editTime: todayDate);
      noteData!.remove(note);
      noteData!.insert(0, note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 5, right: 10, top: 25),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    noteEdit(widget.note);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: Colors.white,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    labelsSheet(context, widget.note);
                  },
                  icon: const Icon(Icons.new_label_outlined),
                  color: Colors.white,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(widget.note.editTime!,
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            //margin: EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 10),
            child: TextField(
              maxLines: null,
              // expands: true,
              controller: controller1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),

              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                border: InputBorder.none,
                hintText: 'Note Here',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
