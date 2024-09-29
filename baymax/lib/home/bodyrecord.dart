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
      child: Column(
        children: [
          // Upload Button
          ElevatedButton.icon(
            onPressed: () {
              Get.to(const Fileuploadview());
            },
            icon: const Icon(
              Icons.file_upload, // Icon for file upload
              color: Color.fromARGB(
                  255, 224, 6, 6), // Red icon color (BayMax theme)
            ),
            label: const Text(
              "Upload Files",
              style: TextStyle(
                color: Color.fromARGB(255, 109, 93, 93), // Text color
                fontWeight: FontWeight.w600, // Slightly bold text
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor:
                  const Color.fromARGB(255, 253, 247, 247), // Button fill color
              side: const BorderSide(
                color: Color.fromARGB(255, 224, 6, 6), // Red outline color
                width: 2.0, // Width of the border
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height *
                    0.02, // Responsive button height
                horizontal: MediaQuery.of(context).size.width *
                    0.1, // Responsive button width
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
            ),
          ),

          // File List Section inside Expanded
          Expanded(
            child: FutureBuilder(
              future: rrc.getFiles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return const Center(child: Text('No files available.'));
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
