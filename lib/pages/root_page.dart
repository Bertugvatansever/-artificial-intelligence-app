import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nexa_reach/controllers/chat_controller.dart';
import 'package:nexa_reach/pages/chat_page.dart';
import 'package:nexa_reach/pages/image_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [ChatPage(), ImagePage()];
  ChatController _chatController = Get.find();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer: SizedBox(
            width: 310.w,
            child: Drawer(
              child: Column(
                children: [
                  SizedBox(
                    width: 310.w,
                    height: 90.h,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF49108B),
                      ),
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: Text(
                          'Konuşma Geçmişi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _chatController.chats.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _chatController.currentChat.value =
                                _chatController.chats[index];

                            _chatController.messageList.clear();
                            _chatController.messageList.addAll(
                                _chatController.currentChat.value.messages);

                            Navigator.pop(context); // Drawer'ı kapatmak için
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80.h,
                                child: Center(
                                  child: ListTile(
                                    leading: FaIcon(
                                        FontAwesomeIcons.solidComments,
                                        color: Color(0xFF49108B)),
                                    title: SizedBox(
                                        width: 300.w,
                                        child: Text(
                                          _chatController
                                              .chats[index].lastMessage,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
        appBar: AppBar(
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.bars),
            color: Colors.white,
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            "NexaReach",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: FaIcon(FontAwesomeIcons.ellipsisVertical,
                  color: Colors.white, size: 30),
              onSelected: (value) {
                _chatController.deleteChats();
                _chatController.chats.clear();
              },
              offset: Offset(0, 50.h),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'menuItem1',
                  child: Text('Konuşmaları Sil'),
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidComments), label: "Chat"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.paintbrush), label: "Image")
          ],
          selectedItemColor: Color(0xFF49108B),
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
        body: screens[_currentIndex]);
  }
}
