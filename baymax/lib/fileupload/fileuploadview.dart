import 'package:baymax/fileupload/fileuploadcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fileuploadview extends StatelessWidget {
  const Fileuploadview({super.key});

  @override
  Widget build(BuildContext context) {
    final FileUploadController fpl = Get.find<FileUploadController>();
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverAppBar(
              title: Text(
                "Select Files",
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: _height * 0.03),
                  TextField(
                    controller: fpl.filename,
                    decoration: InputDecoration(
                      filled: true,
                      //prefixIcon: const Icon(Icons.upload_file_outlined),
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
                      hintText: "Filename",
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Upload"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
