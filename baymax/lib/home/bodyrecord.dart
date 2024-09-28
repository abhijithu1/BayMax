import 'package:baymax/fileupload/fileuploadview.dart';
import 'package:baymax/recordview/recordview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyRecord extends StatelessWidget {
  final double height;
  final double width;
  const BodyRecord({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.04),
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            Get.to(const Fileuploadview());
          },
          child: const Text("Upload Files"),
        ),
        SizedBox(
          height: height * 0.7,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    const FileView(),
                  );
                },
                child: ListTile(
                  title: Text(
                    "File name $index",
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
