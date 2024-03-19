import 'package:hive_flutter/hive_flutter.dart';
import 'package:nexa_reach/models/message.dart';
part 'chat.g.dart';

@HiveType(typeId: 2)
class Chat {
  @HiveField(0)
  String chatId;
  @HiveField(1)
  String lastMessage;
  @HiveField(2)
  List<Message> messages;
  @HiveField(3)
  DateTime dateTime;

  Chat(
      {required this.chatId,
      required this.lastMessage,
      required this.messages,
      required this.dateTime});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
      chatId: json["chatId"],
      lastMessage: json["lastMessage"],
      messages: json["messages"],
      dateTime: json["dateTime"]);

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "lastMessage": lastMessage,
        "messages": messages,
        "dateTime": dateTime
      };
}
