import 'package:baymax/home/chatcontroller.dart';
import 'package:baymax/speechcontrol/speechcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BigScreen extends StatelessWidget {
  const BigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ChatController cht = Get.find<ChatController>();
    final SpeechController spc = Get.find<SpeechController>();
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://image.winudf.com/v2/image/Y29tLkJheW1heFdhbGxwYXBlckFydC5ncml2ZV9jcmVhdGl2b19zY3JlZW5fMF8xNTI1ODAyMzk4XzA0NQ/screen-0.jpg?fakeurl=1&type=.jpg",
          ),
        )),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(children: [
                    SizedBox(height: height * 0.5),
                    SizedBox(
                        height: height * 0.2,
                        width: width * 0.3,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Obx(() => IconButton(
                                onPressed: () async {
                                  if (spc.isListening.value) {
                                    await spc.stopListening();
                                  } else {
                                    await spc.startListening();
                                  }
                                },
                                icon: spc.isListening.value
                                    ? Icon(
                                        Icons.mic,
                                        color: Colors.white,
                                        size: 50,
                                      )
                                    : Icon(
                                        Icons.mic_off,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                color: Colors.white,
                              )),
                        )),
                    SizedBox(height: height * 0.09),
                    FloatingActionButton(
                      onPressed: () {
                        Get.toNamed("/realhome");
                      },
                      child: Icon(Icons.chevron_right),
                    )
                  ])
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
