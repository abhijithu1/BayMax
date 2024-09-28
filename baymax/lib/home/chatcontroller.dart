import 'package:baymax/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  final TextEditingController messagectc = TextEditingController();
  final GetConnect getcon = Get.find<GetConnect>();
  final baseurl = Constants.baseurl;
  final GetStorage box = GetStorage();

  Future<void> sendMessage() async {
    final token = await box.read("token");
    final Response res = await getcon.post("${baseurl}aichat/",
        {"date": "", "msg": "what a sudden surprise. who are you? "},
        headers: {"Authorization": "token $token"});
    if (res.statusCode == 200) {
      debugPrint("The data is ${res.body.toString()}");
    } else {
      debugPrint("Can't Send Url");
    }
  }
}
