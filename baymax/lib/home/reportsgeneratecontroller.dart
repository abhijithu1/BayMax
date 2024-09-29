import 'package:baymax/constants.dart';
import 'package:baymax/home/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReportDateController extends GetxController {
  var selectedDate = ''.obs;
  final baseurl = Constants.baseurl;
  final GetConnect getcon = Get.find<GetConnect>();
  final GetStorage box = GetStorage();

  // Method to show the date picker dialog
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Update the selected date as a string in the format "yyyy-MM-dd"
      selectedDate.value = pickedDate.toString().substring(0, 10);

      debugPrint("Selected Date: $selectedDate");
    }
  }

  Future<dynamic> getReport() async {
    final key = box.read("token");
    Response res = await getcon.post(
      "${baseurl}/createReport/",
      {"date": "${selectedDate.value}"},
      headers: {"Authorization": "token $key"},
    );
  }
}
