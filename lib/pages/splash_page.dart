import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexa_reach/pages/root_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3 ),(){
     Get.to(()=>RootPage());
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/yapay_zeka.jpg"),fit: BoxFit.cover)
        ),
      ),
    );
  }
}