import 'package:baymax/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final GetConnect getConnect = Get.find<GetConnect>();
  final GetStorage box = GetStorage();
  final String baseUrl = Constants.baseurl; // Replace with your base URL

  // RxList to store chat messages and notify the UI when new messages are added.
  final RxList<Map<String, bool>> chatMessages = <Map<String, bool>>[].obs;
  final isLoading = false.obs;
  var date = '';

  Future<void> sendMessage(String massage) async {
    // Retrieve the stored token
    final token = await box.read("token");
    final message = massage;

    // Exit if no message is entered

    // Indicate that a message is being sent
    isLoading.value = true;

    // Add the user message to the chat list and update the UI
    chatMessages.add({message: true});
    messageController.clear(); // Clear the text field after sending the message

    // Make the API call to send the message
    final Response res = await getConnect.post(
      "$baseUrl/aichat/",
      {"date": "$date", "msg": message},
      headers: {"Authorization": "token $token"},
    );

    if (res.statusCode == 200) {
      // Add the received message to the chat list and update the UI
      chatMessages.add({res.body: false});
      debugPrint("Message: ${res.body}");
    } else {
      debugPrint("Failed to send message");
    }

    // Set loading to false after the message has been sent or failed
    isLoading.value = false;
  }
}
