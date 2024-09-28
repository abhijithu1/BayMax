import 'package:baymax/auth/logincontroller.dart';
import 'package:baymax/auth/loginpage.dart';
import 'package:baymax/fileupload/fileuploadcontroller.dart';
import 'package:baymax/home/chatcontroller.dart';
import 'package:baymax/home/homecontroller.dart';
import 'package:baymax/home/homescreen.dart';
import 'package:baymax/home/recordsretrieval.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put<GetConnect>(GetConnect());
  runApp(ScreenHome());
}

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final storage = GetStorage();
  final LoginController lgn = Get.put(LoginController());
  final HomeController hmc = Get.put(HomeController());
  final FileUploadController fpl = Get.put(FileUploadController());
  final Recordsretrieval rrc = Get.put(Recordsretrieval());
  final ChatController cht = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Baymax",
      initialRoute: lgn.box.read("token") == null ? "/login" : "/home",
      getPages: [
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/home", page: () => HomeScreen())
      ],
    );
  }
}
