import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nexa_reach/controllers/chat_controller.dart';
import 'package:nexa_reach/pages/splash_page.dart';
import 'package:nexa_reach/services/localdbservice.dart';

void main() async {
  // Hive kurulumu için gereken kodlar
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDbService().initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    ScreenUtil.init(context,
        designSize: Size(392.72727272727275, 783.2727272727273));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Yapay Zeka",
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade300,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF49108B)),
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFF49108B))),
      home: const SplashPage(),
    );
  }
}
