import 'package:baymax/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Recordsretrieval extends GetxController {
  final GetConnect getcon = Get.find<GetConnect>();
  final box = GetStorage();

  final _baseurl = Constants.baseurl;
  final isloading = false.obs;

  // RxList variables to hold the extracted data
  final RxList<String> nameList = <String>[].obs;
  final RxList<String> dateList = <String>[].obs;
  final RxList<String> summaryList = <String>[].obs;
  final RxList<String> urlList = <String>[].obs;

  Future<dynamic> getFiles() async {
    isloading.value = true;
    final key = box.read("token");
    Response res = await getcon
        .get("${_baseurl}records/", headers: {"Authorization": "token $key"});

    if (res.statusCode == 200) {
      debugPrint("The data is ${res.body.toString()}");

      // Extract data from the JSON response
      List<dynamic> records = res.body;

      // Clear existing lists
      nameList.clear();
      dateList.clear();
      summaryList.clear();
      urlList.clear();

      // Populate lists with data from the response
      for (var record in records) {
        nameList.add(record['name']);
        dateList.add(record['date']);
        summaryList.add(record['summary']);
        urlList.add(record['url']);
      }
      debugPrint("Name List: $nameList");
      debugPrint("Date List: $dateList");
      debugPrint("Summary List: $summaryList");
      debugPrint("Url List: $urlList");
      isloading.value = false;
    } else {
      debugPrint("Can't Send Url");
    }
  }
}
