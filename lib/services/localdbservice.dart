import 'package:hive_flutter/hive_flutter.dart';
import 'package:nexa_reach/models/chat.dart';
import 'package:nexa_reach/models/message.dart';

class LocalDbService {
  Future<void> initializeService() async {
    // Hive açıldı
    await Hive.initFlutter();
    // Hive in içindeki class tipleri tanımlandı
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(MessageAdapter());
    // verileri almak için gereken tabloyu açtık
    await Hive.openBox<Chat>('Chats');
  }

  Future<List<Chat>> getChats() async {
    Box<Chat> chatBox = Hive.box<Chat>("Chats");
    List<Chat> chatList = [];
    chatList.addAll(chatBox.values.toList());
    return chatList;
  }

  Future<void> saveChat(Chat chat) async {
    Box<Chat> chatBox = Hive.box<Chat>("Chats");
    await chatBox.put(chat.chatId, chat);
  }

  Future<void> deleteChats() async {
    Box<Chat> chats = Hive.box<Chat>("Chats");
    await chats.clear();
  }
}
