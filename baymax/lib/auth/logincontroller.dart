import 'package:baymax/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final GetConnect getcon = Get.find<GetConnect>();
  final box = GetStorage();

  var usname = "".obs;
  var pass = "".obs;

  void login() {
    usname.value = usernameController.text;
    pass.value = passwordController.text;
  }

  final _baseurl = Constants.baseurl;

  Future<dynamic> getKey() async {
    final Response res = await getcon.post("${_baseurl}auth/login/",
        {"username": "snapeos", "password": "nandu123"});

    if (res.statusCode == 200) {
      debugPrint(res.body.toString());
      //final name = res.body['name'];
      final hardkey = res.body['key'];
      debugPrint("HardKey: $hardkey");
      await box.write("token", hardkey);
      return res.body;
    } else {
      debugPrint("Can't Login");
    }
  }
}
