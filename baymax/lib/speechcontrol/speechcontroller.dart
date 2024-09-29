import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SpeechController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening = false.obs;
  var spokenText = ''.obs;

  // Initialize the speech-to-text functionality
  Future<void> initSpeech() async {
    var permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech Status: $status'),
        onError: (error) => print('Speech Error: $error'),
      );
      if (available) {
        print('Speech-to-Text initialized successfully');
      }
    } else {
      print('Microphone permission denied');
    }
  }

  // Start listening for voice input
  void startListening() async {
    if (!_speech.isListening) {
      isListening.value = true;
      _speech.listen(
        onResult: (result) {
          spokenText.value = result.recognizedWords;
        },
      );
    }
  }

  // Stop listening to voice input
  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
      isListening.value = false;
    }
  }
}
