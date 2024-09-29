import 'package:baymax/home/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SpeechController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening = false.obs;
  var spokenText = ''.obs;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
  }

  // Initialize the speech-to-text functionality and request permission
  Future<void> initSpeech() async {
    var permissionStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done') {
            // Handle stopping status from the speech library.
            isListening.value = false;
            handleSpeechDone(); // Call the function when status is 'done'
          }
          print('Speech Status: $status');
        },
        onError: (error) {
          print('Speech Error: $error');
          isListening.value = false;
        },
      );

      if (available) {
        isInitialized.value = true;
        Get.snackbar('Speech-to-Text', 'Initialized successfully');
      } else {
        Get.snackbar('Speech-to-Text', 'Initialization failed');
        isInitialized.value = false;
      }
    } else {
      Get.snackbar("Microphone permission", "Permission denied");
    }
  }

  // Start listening for voice input
  Future<void> startListening() async {
    if (!_speech.isListening && isInitialized.value) {
      try {
        await _speech.listen(
          onResult: (result) {
            spokenText.value = result.recognizedWords;
            debugPrint("Spoken Text: ${spokenText.value}");
          },
        );
        isListening.value = true;
      } catch (e) {
        print("Error during listening: $e");
        Get.snackbar("Speech-to-Text", "Failed to start listening");
      }
    }
  }

  // Stop listening to voice input
  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
      isListening.value = false;
    }
  }

  // Function to handle speech done status
  void handleSpeechDone() async {
    // Add the code you want to run when the speech is 'done'
    print("Speech is done. Calling the desired function...");
    final ChatController ctc = Get.find<ChatController>();
    await ctc.sendMessage(spokenText.value);

    // Example: Do something here, like updating the UI or triggering another action
  }

  @override
  void onClose() {
    _speech
        .stop(); // Ensure speech instance is stopped when controller is disposed.
    super.onClose();
  }
}
