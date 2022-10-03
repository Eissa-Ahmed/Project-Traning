class MessageModel {
  String message;
  String date;
  String uid;
  String receveuid;
  MessageModel({
    required this.date,
    required this.message,
    required this.receveuid,
    required this.uid,
  });
  factory MessageModel.fromJson(Map json) {
    return MessageModel(
      date: json["date"],
      message: json["message"],
      receveuid: json["receveuid"],
      uid: json["uid"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "message": message,
      "uid": uid,
      "receveuid": receveuid,
    };
  }
}
