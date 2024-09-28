import 'package:baymax/auth/logincontroller.dart';
import 'package:baymax/home/bodychat.dart';
import 'package:baymax/home/bodyrecord.dart';
import 'package:baymax/home/bodyrelations.dart';
import 'package:baymax/home/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    final LoginController lgn = Get.find<LoginController>();
    final HomeController hmc = Get.find<HomeController>();
    final PageController pg = PageController();
    return Scaffold(
      bottomNavigationBar: Container(
        height: _height * 0.084518,
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            hmc.setindex(index);
            pg.animateToPage(index,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutSine);
            // debugPrint("Index number $index");
          },
          currentIndex: hmc.page_num.value,
          items: const [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.medical_services,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.chat_bubble_outline),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.family_restroom),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          // height: _screenheight,
          // width: _screenwidth,
          child: Padding(
            padding: EdgeInsets.only(
              top: _height * 0.0100227,
              bottom: 0,
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: _width * 0.04843318),
                      child: Container(
                        height: _height * 0.07399,
                        width: _width * 0.17193,
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-photo/indoor-shot-beautiful-happy-african-american-woman-smiling-cheerfully-keeping-her-arms-folded-relaxing-indoors-after-morning-lectures-university_273609-1270.jpg",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: _width * 0.04843318),
                      child: Container(
                        child: IconButton(
                            onPressed: () async {
                              await lgn.box.remove("token");
                              debugPrint("Token Removed");
                              Get.offAllNamed("/login");
                            },
                            icon: Icon(Icons.logout_rounded)),
                      ),
                    )
                  ],
                  toolbarHeight: _height * 0.0900227,
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: _height * 0.016,
                    ),
                    child: Obx(() => Text(
                          hmc.titles[hmc.page_num.value],
                          // style: StyleText.font2.copyWith(
                          //   fontSize: _screenheight * 0.0340543,
                          // ),
                        )),
                  ),
                  automaticallyImplyLeading: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // const SizedBox(height: 5),
                    Container(
                      height: _height * 0.7948700485,
                      child: PageView(
                        controller: pg,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (int index1) {
                          hmc.setindex(index1);
                        },
                        children: [
                          BodyRecord(
                            height: _height,
                            width: _width,
                          ),
                          BodyChat(),
                          RelationBody(),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
