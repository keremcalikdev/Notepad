import 'package:flutter/material.dart';
import 'package:notepad/data/data.dart';
import 'package:notepad/models/note.dart';

labelsSheet(context, Note note) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            height: 350,
            color: const Color.fromARGB(255, 23, 23, 23),
            child: StatefulBuilder(
              builder: (context, setState) => ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        selected: note.label == labelsData![index],
                        leading: const Icon(
                          Icons.label_outline_rounded,
                          color: Colors.white,
                        ),
                        title: Text(labelsData![index]),
                        onTap: () {
                          setState(() {
                            note.label == labelsData![index] ? note.label = null : note.label = labelsData![index];
                          });
                        },
                      ),
                  itemCount: labelsData!.length),
            ),
          ));
}
