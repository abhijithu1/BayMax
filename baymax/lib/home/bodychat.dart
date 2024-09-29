import 'package:baymax/home/chatcontroller.dart';
import 'package:baymax/home/datecontrol.dart';
import 'package:baymax/speechcontrol/speechcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyChat extends StatelessWidget {
  final double height;
  final double width;

  const BodyChat({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final ChatController cht = Get.find<ChatController>();
    final DateController dt = Get.put(DateController());
    final SpeechController spc = Get.put(SpeechController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Clear Chat Icon
          IconButton(
            onPressed: () {
              cht.chatMessages.clear();
              cht.date = '';
            },
            icon: const Icon(
              Icons.cleaning_services,
              color: Colors.red,
              size: 28, // Set the size of the icon here
            ),
          ),

          // Date Picker Icon
          IconButton(
            icon: const Icon(
              Icons.date_range_outlined,
              color: Colors.red,
              size: 28, // Set the size of the icon here
            ),
            onPressed: () async {
              await dt.selectDate(context);
            },
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: cht.chatMessages.length,
                itemBuilder: (context, index) {
                  final message = cht.chatMessages[index];
                  final isUserMessage = message.values.first;

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? const Color.fromARGB(
                                255, 224, 6, 6) // BayMax theme color for user
                            : const Color.fromARGB(255, 255, 196,
                                196), // Light grey for received message
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft:
                              isUserMessage ? Radius.circular(12) : Radius.zero,
                          bottomRight:
                              isUserMessage ? Radius.zero : Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(2, 2), // Soft shadow for depth
                          ),
                        ],
                      ),
                      child: Text(
                        message.keys.first.toString(),
                        style: TextStyle(
                          color: isUserMessage
                              ? Colors.white // White text for user message
                              : Colors.black, // Black text for received message
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w500, // Slightly bold for readability
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Loading Indicator
          Obx(() => cht.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : const SizedBox()),

          // Message Input Field
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Message Text Field
                Expanded(
                  child: TextField(
                    controller: cht.messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(
                            255, 183, 183, 183), // Softer hint color
                        fontStyle:
                            FontStyle.italic, // Italic hint for a smoother look
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(
                          255, 253, 247, 247), // BayMax light background
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ), // Adjusted padding for better spacing
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            25), // More rounded text field
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 216, 3, 3), // BayMax themed red border
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 240, 9, 9), // Slightly darker red on focus
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(
                          0xFF0A8FDC), // Themed input text color (light blue)
                    ),
                    cursorColor:
                        const Color(0xFF0A8FDC), // Matching cursor color
                  ),
                ),

                const SizedBox(
                    width: 10), // Space between the TextField and buttons

                // Send Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 6,
                        6), // BayMax-themed red background for send button
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await cht.sendMessage();
                    },
                    icon:
                        const Icon(Icons.send_rounded), // More modern send icon
                    color: Colors.white,
                    splashRadius: 28.0, // Smooth splash effect
                    splashColor: Colors.grey.withOpacity(0.3),
                  ),
                ),

                const SizedBox(width: 10), // Space between Send button and Mic

                // Voice Record Button
                Container(
                  decoration: BoxDecoration(
                    color: spc.isListening.value
                        ? const Color.fromARGB(
                            255, 240, 9, 9) // Red when recording (mic active)
                        : const Color.fromARGB(
                            255, 253, 247, 247), // BayMax light when inactive
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 224, 6, 6), // Red border for consistency
                      width: 1.5,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle microphone action here
                    },
                    icon: spc.isListening.value
                        ? const Icon(Icons.mic_off_rounded,
                            color: Colors.white) // Icon change for mic off
                        : const Icon(Icons.mic_rounded,
                            color: Color.fromARGB(255, 224, 6,
                                6)), // Red mic icon for active state
                    splashRadius: 28.0,
                    splashColor: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
