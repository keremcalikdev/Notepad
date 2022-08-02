class Note {
  Note({this.title, this.text, this.editTime});

  String? title;
  String? text;
  String? label;
  String? editTime;

  void update({title , text, editTime}){
    this.title = title;
    this.text = text;
    this.editTime = editTime;
  }
}
