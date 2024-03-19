import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nexa_reach/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController _chatController = Get.find();
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            height: 593.h,
            child: Obx(
              () => ListView.builder(
                itemCount: _chatController.messageList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                BubbleSpecialThree(
                                  text: _chatController
                                      .messageList[index]!.message,
                                  color: Color(0xFF49108B),
                                  tail: true,
                                  isSender: true,
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ],
                            )
                          : _chatController.messageList[index]?.role == "user"
                              ? BubbleSpecialThree(
                                  text: _chatController
                                      .messageList[index]!.message,
                                  color: Color(0xFF49108B),
                                  tail: true,
                                  isSender: true,
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                )
                              : BubbleSpecialThree(
                                  text: _chatController
                                      .messageList[index]!.message,
                                  color: Color.fromARGB(255, 194, 236, 9),
                                  tail: true,
                                  isSender: false,
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 18.sp),
                                ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            height: 50.h,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 344.w,
                  child: Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: TextField(
                      maxLines: 2,
                      enableSuggestions: false,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                        hintText: "Soru Sor...",
                        hintStyle: TextStyle(
                            color: Color(0xFF49108B), fontSize: 20.sp),
                      ),
                      onSubmitted: (value) {
                        _textEditingController.clear();
                        _chatController.sendChat(value);
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String prompt = _textEditingController.text;
                    _textEditingController.clear();
                    _chatController.sendChat(prompt);
                    ;
                  },
                  icon: Icon(Icons.send),
                  color: Color(0xFF49108B),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
