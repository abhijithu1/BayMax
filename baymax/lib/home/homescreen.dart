import 'package:baymax/auth/logincontroller.dart';
import 'package:baymax/home/bodychat.dart';
import 'package:baymax/home/bodyrecord.dart';
import 'package:baymax/home/homecontroller.dart';
import 'package:baymax/home/recordsview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final LoginController lgn = Get.find<LoginController>();
    final HomeController hmc = Get.find<HomeController>();
    final PageController pg = PageController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        height: height * 0.08,
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            hmc.setindex(index);
            pg.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutSine);
            // debugPrint("Index number $index");
          },
          currentIndex: hmc.page_num.value,
          items: const [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.chat_bubble_outline,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.medical_services),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined),
              label: "",
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Unfocus the current TextField
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Container(
            // height: _screenheight,
            // width: _screenwidth,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0,
                bottom: 0,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: const Color.fromARGB(255, 253, 247,
                        247), // Light background color (BayMax theme)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Soft rounded corners for aesthetics
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.04843318),
                        child: SizedBox(
                          height: height * 0.07399,
                          width: width * 0.17193,
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                                255, 224, 6, 6), // BayMax red border
                            child: CircleAvatar(
                              radius: width * 0.07193,
                              backgroundImage: const NetworkImage(
                                "https://img.freepik.com/free-photo/indoor-shot-beautiful-happy-african-american-woman-smiling-cheerfully-keeping-her-arms-folded-relaxing-indoors-after-morning-lectures-university_273609-1270.jpg",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.04843318),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 224, 6,
                                6), // BayMax red background for logout button
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Subtle shadow for button elevation
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3), // Shadow position
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await lgn.box.remove("token");
                              debugPrint("Token Removed");
                              Get.offAllNamed("/login");
                            },
                            icon: const Icon(Icons.logout_rounded,
                                color: Colors.white), // White logout icon
                            splashRadius: 28.0, // Smooth splash effect on tap
                            tooltip: "Logout", // Tooltip for accessibility
                          ),
                        ),
                      ),
                    ],
                    toolbarHeight: height * 0.0900227,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    title: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.016,
                      ),
                      child: Obx(() => Text(
                            hmc.titles[hmc.page_num.value],
                            style: TextStyle(
                              color: const Color.fromARGB(
                                  255, 224, 6, 6), // BayMax red theme for text
                              fontWeight: FontWeight.bold, // Bold for emphasis
                              fontSize: height *
                                  0.0340543, // Adjusted font size for better readability
                            ),
                          )),
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // const SizedBox(height: 5),
                      SizedBox(
                        height: height * 0.7948700485,
                        child: PageView(
                          controller: pg,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (int index1) {
                            hmc.setindex(index1);
                          },
                          children: [
                            BodyChat(
                              height: height,
                              width: width,
                            ),
                            BodyRecord(
                              height: height,
                              width: width,
                            ),
                            GetFileDetails(
                              height: height,
                              width: width,
                            ),
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
      ),
    );
  }
}
