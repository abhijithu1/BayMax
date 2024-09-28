import 'package:baymax/fileupload/fileuploadview.dart';
import 'package:baymax/home/recordsretrieval.dart';
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
    final Recordsretrieval rrc = Recordsretrieval();

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
            child: Obx(
              () {
                if (rrc.isloading.value) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Show loading indicator
                } else if (rrc.nameList.isEmpty) {
                  return Center(child: Text("No files to show"));
                } else {
                  return Obx(() => ListView.builder(
                        itemCount: rrc.nameList.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(rrc.nameList.value[index]),
                            onTap: () {},
                          );
                        },
                      ));
                }
              },
            ))
      ]),
    );
  }
}
