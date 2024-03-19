import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexa_reach/controllers/chat_controller.dart';
import 'package:nexa_reach/pages/image_full_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final ChatController _chatController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => SizedBox(
                width: 330.w,
                height: 330.w,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: _chatController.isGeneratingImage.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF49108B),
                          ),
                        )
                      : _chatController.generatedImageUrl.value.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                _chatController.generatedImageUrl.value,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(36.0),
                                child: Text(
                                  "Resim oluşturmak için lütfen aşağıdan tarif edin.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                ),
              ),
            ),
            Obx(
              () => _chatController.generatedImageUrl.value.isNotEmpty
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(),
            ),
            Obx(
              () => _chatController.generatedImageUrl.value.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                              () => ImageFullScreen(
                                  imageUrl:
                                      _chatController.generatedImageUrl.value),
                            );
                          },
                          icon: Icon(Icons.fullscreen),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          onPressed: () async {
                            // PermissionStatus storageStatus =
                            //     await Permission.storage.status;

                            // if (storageStatus == PermissionStatus.granted) {
                            //   _chatController.downloadImage(
                            //       _chatController.generatedImageUrl.value);
                            // } else {
                            //   final List<Permission> permissions = <Permission>[
                            //     Permission.storage
                            //   ];
                            //   await permissions.request();

                            //   PermissionStatus storageStatusNew =
                            //       await Permission.storage.status;

                            //   if (storageStatusNew ==
                            //       PermissionStatus.granted) {
                            //     _chatController.downloadImage(
                            //         _chatController.generatedImageUrl.value);
                            //   }
                            // }

                            _chatController.downloadImage(
                                _chatController.generatedImageUrl.value);
                          },
                          icon: Icon(Icons.download),
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 330.w,
              height: 150.w,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await _chatController
                    .generateImage(_textEditingController.text);
              },
              child: Text("Oluştur"),
            )
          ],
        ),
      ),
    );
  }
}
