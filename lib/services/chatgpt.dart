import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dart_openai/dart_openai.dart' as dallE;
import 'package:nexa_reach/models/message.dart';
import 'package:path/path.dart';

class ChatGpt {
  final openAI = OpenAI.instance.build(
    token: "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",
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );

  Future<Message?> messageSend(String message) async {
    final request = ChatCompleteText(messages: [
      {"role": "user", "content": message}
    ], maxToken: 200, model: GptTurboChatModel());

    final response = await openAI.onChatCompletion(request: request);
    Message gptAnswer = Message(message: "", role: "", id: "");
    List<String?> answer = [];
    String? role = "";
    for (var element in response!.choices) {
      answer.add(element.message?.content);
      role = element.message?.role;
      print("data -> ${element.message?.role}");
    }
    gptAnswer.message = answer.join();
    if (role != null) {
      gptAnswer.role = role;
    }
    return gptAnswer;
  }

  Future<String?> generateImage(String _prompt) async {
    String? imageUrl;
    dallE.OpenAI.apiKey = "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";
    dallE.OpenAIImageModel image = await dallE.OpenAI.instance.image.create(
        prompt: _prompt,
        n: 1,
        size: dallE.OpenAIImageSize.size1024,
        responseFormat: dallE.OpenAIImageResponseFormat.url,
        quality: dallE.OpenAIImageQuality.hd);

// Printing the output to the console.
    for (int index = 0; index < image.data.length; index++) {
      final currentItem = image.data[index];
      imageUrl = currentItem.url;
    }
    return imageUrl;
  }
}
