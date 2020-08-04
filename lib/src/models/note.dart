class Note {
  final int id;
  final String title;
  final String content;

  const Note({this.id, this.content, this.title});

  @override
  String toString() {
    return '{"id": $id, "title": "${title ?? ""}", "content": "${content ?? ""}"}';
  }
}
