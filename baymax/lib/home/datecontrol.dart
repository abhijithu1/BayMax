import 'package:baymax/home/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = ''.obs;
  final ChatController cht = Get.find<ChatController>();

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
      cht.date = selectedDate.value;
      debugPrint("Selected Date: $selectedDate");
    }
  }
}
