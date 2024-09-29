import 'package:baymax/home/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyChat extends StatelessWidget {
  final double height;
  final double width;

  const BodyChat({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final ChatController cht = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.keys.first.toString(),
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                // Message Text Field
                Expanded(
                  child: TextField(
                    controller: cht.messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 238, 255, 253),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Send Button
                IconButton(
                  onPressed: () async {
                    await cht.sendMessage();
                  },
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
