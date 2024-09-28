import 'package:baymax/home/chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyChat extends StatelessWidget {
  final double height;
  final double width;

  const BodyChat({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final ChatController cht = ChatController();
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.7,
            child: Text("waiting for messages"),
          ),
          TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () async {
                  await cht.sendMessage();
                },
                icon: const Icon(Icons.send),
              ),
              hintText: "Type a message",
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 255, 253),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 0.1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 0.5)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
