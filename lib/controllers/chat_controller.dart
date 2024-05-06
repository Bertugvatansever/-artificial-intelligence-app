import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:nexa_reach/models/chat.dart';
import 'package:nexa_reach/models/message.dart';
import 'package:nexa_reach/services/chatgpt.dart';
import 'package:nexa_reach/services/localdbservice.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  RxList<Message?> messageList = <Message>[].obs;
  RxList<Chat> chats = <Chat>[].obs;
  ChatGpt chatGpt = ChatGpt();
  LocalDbService _localDbService = LocalDbService();
  Rx<Chat> currentChat =
      Chat(chatId: '', messages: [], lastMessage: '', dateTime: DateTime.now())
          .obs;
  RxList<String> imageList = <String>[].obs;
  Rx<String> generatedImageUrl = "".obs;
  RxBool isGeneratingImage = false.obs;

  @override
  void onInit() {
    super.onInit();

    _localDbService.getChats().then((value) {
      chats.addAll(value);
    });
  }

  Future<void> getChats() async {
    List<Chat> tempChats = [];
    tempChats = await _localDbService.getChats();
    chats.addAll(tempChats);
  }

  Future<void> sendChat(String message) async {
    Message userMessage = Message(message: message, role: "user", id: "");
    messageList.add(userMessage);

    if (currentChat.value.chatId.isEmpty) {
      String id = Uuid().v4();

      currentChat.value = Chat(
          chatId: id,
          lastMessage: userMessage.message,
          messages: [userMessage],
          dateTime: DateTime.now());
    } else {
      currentChat.value.lastMessage = userMessage.message;
      currentChat.value.messages.add(userMessage);
      currentChat.value.dateTime = DateTime.now();
    }

    await _localDbService.saveChat(currentChat.value);

    Message? gptAnswer = await chatGpt.messageSend(message);

    if (gptAnswer != null) {
      messageList.add(gptAnswer);

      currentChat.value.lastMessage = gptAnswer.message;
      currentChat.value.messages.add(gptAnswer);
      currentChat.value.dateTime = DateTime.now();

      await _localDbService.saveChat(currentChat.value);
    }
  }

  Future<void> deleteChats() async {
    _localDbService.deleteChats();
  }

  Future<void> generateImage(String message) async {
    isGeneratingImage.value = true;

    String? imageUrl = await chatGpt.generateImage(message);

    if (imageUrl != null) {
      generatedImageUrl.value = imageUrl;

      isGeneratingImage.value = false;
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    // try {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
        quality: 60, name: DateTime.now().toIso8601String());

    Fluttertoast.showToast(
        msg: "Resminiz başarıyla galerinize kaydedildi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    // } catch (_) {}
  }
}
