class Note {
  final int id;
  final String title;
  final String content;

  const Note({this.id, this.content, this.title});

  @override
  String toString() {
    return '{"id": $id, "title": "${title ?? ""}", "content": "${content ?? ""}"}';
  }

  Note copyWith({int id, String title, String content}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
