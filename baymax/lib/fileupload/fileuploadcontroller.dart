import 'package:baymax/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FileUploadController extends GetxController {
  final TextEditingController filename = TextEditingController();
  final TextEditingController url = TextEditingController();

  final GetConnect getcon = Get.find<GetConnect>();
  final box = GetStorage();

  var fname = "".obs;
  var furl = "".obs;

  void setVal() {
    fname.value = filename.text;
    furl.value = url.text;
  }

  final _baseurl = Constants.baseurl;

  Future<dynamic> postUrl(String name) async {
    final key = box.read("token");
    Response res = await getcon.post("${_baseurl}records/", {
      "name": "${fname.value}",
      "url": "${furl.value}",
      "date": "22/08/24",
      "record_type": "bloodreport"
    }, headers: {
      "Authorization": "token $key"
    });

    if (res.statusCode == 200) {
      debugPrint("The data is ${res.body.toString()}");
      //final name = res.body['name'];

      return res.body;
    } else {
      debugPrint("Can't Send Url");
    }
  }
}
