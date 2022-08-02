import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/pages/note_page.dart';

Card noteCard(Note note, context) {
  return Card(
    elevation: 12,
    color: const Color.fromARGB(255, 47, 47, 47),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NotePage(note: note))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250, minHeight: 100),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title!),
                note.title != null
                    ? const SizedBox(
                        height: 15,
                      )
                    : const SizedBox(),
                Text(
                  note.text!,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                note.label != null
                    ? Container(
                        height: 28,
                        child: Chip(
                            backgroundColor: Colors.white,
                            label: Text(
                              note.label!,
                              style: const TextStyle(fontSize: 12),
                            ),
                            padding: const EdgeInsets.all(8)),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
