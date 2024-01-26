class TalkTheme {
  String? id;
  String? title;
  bool? isCanRing;

  String get getTitle => title ?? "Без темы";

  TalkTheme({this.title, this.isCanRing});

  TalkTheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCanRing = json['isCanRing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isCanRing'] = isCanRing;
    return data;
  }

  String get getId => id ?? '';
}