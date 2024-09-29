import 'package:baymax/detailsview/detailedview.dart';
import 'package:baymax/fileupload/fileuploadview.dart';
import 'package:baymax/home/recordsretrieval.dart';
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
            child: FutureBuilder(
                future: rrc.getFiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]["name"].toString()),
                        onTap: () {
                          final data = snapshot.data[index];
                          Get.to(
                            DetailFileView(
                              name: data["name"].toString(),
                              url: data["url"].toString(),
                              date: data["date"].toString(),
                              summary: data["summary"].toString(),
                            ),
                          );
                        },
                      );
                    },
                  );
                }))
      ]),
    );
  }
}
