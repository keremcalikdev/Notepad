import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notepad/data/data.dart';
import 'package:notepad/pages/home_page.dart';

class LabelsPage extends StatefulWidget {
  const LabelsPage({Key? key}) : super(key: key);

  @override
  State<LabelsPage> createState() => _LabelsPageState();
}

class _LabelsPageState extends State<LabelsPage> {
  int selectedIndex = -1;
  late List<TextEditingController> textEditingControllers;
  bool isNew = true;

  @override
  void initState() {
    super.initState();
    setTextFields();
  }

  void setTextFields() {
    textEditingControllers = List.generate(
        labelsData!.length + 1, (index) => TextEditingController());

    for (int i = 0; i < labelsData!.length; i++) {
      textEditingControllers[i].text = labelsData![i];
    }
  }

  void editLabel(String text, {int index = -1}) {
    if (index != -1) {
      labelsData![index] = text;
    } else {
      labelsData!.add(text);
    }
    setState(() {
      setTextFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10 ,right: 10, bottom:10 ,top: 30),
            child: Row(children: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              const Text('Edit labels',style: TextStyle(fontSize: 18),),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: isNew
                    ? const Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      )
                    : null,
              ),
              child: ListTile(
                selected: isNew,
                leading: const Icon(
                  Icons.label_outline_rounded,
                  color: Colors.white,
                ),
                trailing: isNew
                    ? IconButton(
                        onPressed: () {
                          isNew = false;
                          editLabel(textEditingControllers.last.text);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.blue[100],
                        ),
                      )
                    : const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                title: TextField(
                  onTap: () {
                    setState(() {
                      print('ontpa');
                      selectedIndex = -1;
                      isNew = true;
                    });
                  },
                  controller: textEditingControllers.last,
                  autofocus: isNew,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Create new label',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5))),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: index == selectedIndex
                    ? const Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      )
                    : null,
              ),
              child: ListTile(
                selected: index == selectedIndex,
                leading: index == selectedIndex
                    ? IconButton(
                        onPressed: () => '',
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                        ))
                    : const Icon(
                        Icons.label_outline_rounded,
                        color: Colors.white,
                      ),
                trailing: index == selectedIndex
                    ? IconButton(
                        onPressed: (){
                          selectedIndex = -1;
                          editLabel(
                            textEditingControllers[index].text,
                            index: index);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.blue[100],
                        ),
                      )
                    : const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                title: TextField(
                  onTap: () {
                    setState(() {
                      isNew = false;
                      selectedIndex = index;
                    });
                  },
                  controller: textEditingControllers[index],
                  autofocus: index == selectedIndex,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            itemCount: labelsData!.length,
          ))
        ],
      ),
    );
  }
}
