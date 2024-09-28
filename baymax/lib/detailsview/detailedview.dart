import 'package:flutter/material.dart';

class DetailFileView extends StatelessWidget {
  final String name;
  final String url;
  final String date;
  final String summary;

  const DetailFileView({
    super.key,
    required this.name,
    required this.url,
    required this.date,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Text(name),
                      SizedBox(
                        width: _width * 0.05,
                      ),
                      Text(date),
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Text(summary),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Text(url),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
