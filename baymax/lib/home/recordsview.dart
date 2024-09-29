import 'package:baymax/home/reportsgeneratecontroller.dart';
import 'package:flutter/material.dart';

class GetFileDetails extends StatelessWidget {
  final double height;
  final double width;
  const GetFileDetails({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final ReportDateController rpt = ReportDateController();
    return Column(
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        ElevatedButton(
            onPressed: () {
              rpt.selectDate(context);
            },
            child: Text("Enter Date: ")),
        ElevatedButton(
          onPressed: () {},
          child: Text("Generate Report"),
        ),
        SizedBox(
          height: height * 0.03,
        ),
      ],
    );
  }
}
