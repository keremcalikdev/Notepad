import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/data/data.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/pages/labels_page.dart';
import 'package:notepad/pages/note_page.dart';
import 'package:notepad/pages/search_page.dart';
import 'package:notepad/utils/time.dart';
import 'package:notepad/widgets/note_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String view = 'All';
  late List<Note> notes;

  @override
  void initState() {
    super.initState();
    notes = filterNotes();
  }

  Future<bool> _onWillPop() async {
    if (view != 'All') {
      view = 'All';
      setState(() {
        notes = filterNotes();
      });
    }
    return false;
  }

  filterNotes() {
    var resultList = view == 'All'
        ? noteData
        : noteData!.where((element) => element.label == view).toList();
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 23, 23, 23),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'NotePad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Labels',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) => index < labelsData!.length
                  ? ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      leading: const Icon(
                        Icons.label_outline_rounded,
                        color: Colors.white,
                      ),
                      minLeadingWidth: 5,
                      title: Text(labelsData![index]),
                      onTap: () => {
                        view = labelsData![index],
                        setState(() {
                          notes = filterNotes();
                        }),
                        Navigator.pop(context)
                      },
                    )
                  : ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      leading: const Icon(
                        Icons.new_label_outlined,
                        color: Colors.white,
                      ),
                      minLeadingWidth: 5,
                      title: const Text('Create new label'),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LabelsPage())),
                    ),
              itemCount: labelsData!.length + 1,
            ))
          ]),
        ),
        body: noteData != null
            ? Column(
                children: [
                  view == 'All'
                      ? Container(
                          width: 300,
                          height: 35,
                          //padding: EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15, top: 35),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _scaffoldKey.currentState!.openDrawer();
                                    },
                                    icon: const Icon(
                                      Icons.menu_rounded,
                                      size: 20,
                                    )),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SearchPage()));
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 35,
                                      width: 250,
                                      child: const Text(
                                        'Search your notes',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      : Container(
                          height: 55,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _scaffoldKey.currentState!.openDrawer(),
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  view,
                                  textAlign: TextAlign.end,
                                ),
                              ]),
                        ),
                  Expanded(
                    child: notes.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) =>
                                noteCard(notes[index], context),
                            itemCount: notes.length,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.label_off_outlined,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 120,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('No note this label'),
                              ]),
                  )
                ],
              )
            : const Center(
                child: Text(
                  'Create note',
                  style: TextStyle(color: Colors.white),
                ),
              ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(10),
          height: 60,
          width: 60,
          child: FloatingActionButton(
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotePage(
                      note: Note(title: '', text: '', editTime: todayDate))))),
        ),
      ),
    );
  }
}
