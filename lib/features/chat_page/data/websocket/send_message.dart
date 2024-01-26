class Message {
  int? id;
  String? themeId;
  String? message;

  Message({this.id, this.themeId, this.message});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    themeId = json['themeId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['themeId'] = themeId;
    data['message'] = message;
    return data;
  }
}