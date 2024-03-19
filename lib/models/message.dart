import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
part 'message.g.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Message {
  @HiveField(0)
  String id;
  @HiveField(1)
  String message;
  @HiveField(2)
  String role;

  Message({
    required this.id,
    required this.message,
    required this.role,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "role": role,
      };
}
