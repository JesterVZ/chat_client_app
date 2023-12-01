class SendChatMessage {
  String? id;
  String? themeId;
  String? message;

  SendChatMessage({this.id, this.themeId, this.message});

  SendChatMessage.fromJson(Map<String, dynamic> json) {
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