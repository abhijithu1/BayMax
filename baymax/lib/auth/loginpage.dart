import 'package:baymax/auth/logincontroller.dart';
import 'package:baymax/home/recordsretrieval.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController lgn = Get.find<LoginController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    final Recordsretrieval rrc = Recordsretrieval();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Unfocus the current TextField
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/baymax.jpeg'),
                  fit: BoxFit.cover)),
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: height * 0.35,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        child: TextField(
                          controller: lgn.usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.person_3_outlined,
                              color: Color.fromARGB(255, 224, 6,
                                  6), // BayMax's theme color (calm blue)
                            ),
                            fillColor: const Color.fromARGB(255, 253, 247,
                                247), // Light, soothing background color
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(
                                    255, 216, 3, 3), // Themed border color
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color:
                                    Colors.black, // Slightly darker for focus
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color: Colors.grey, // Grey for disabled state
                                width: 0.5,
                              ),
                            ),
                            hintText: "Username",
                            hintStyle: const TextStyle(
                              color: Color(0xFFB0BEC5), // Light grey for hint
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(
                                0xFF0A8FDC), // Themed text color for user input
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: const Color(
                              0xFF0A8FDC), // Cursor color matching the theme
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        // height: 20,
                        child: TextField(
                          controller: lgn.passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color.fromARGB(
                                  255, 224, 6, 6), // BayMax's theme color (red)
                            ),
                            fillColor: const Color.fromARGB(255, 253, 247,
                                247), // Light, soothing background color
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(
                                    255, 216, 3, 3), // Themed border color
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color:
                                    Colors.black, // Slightly darker for focus
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(
                                color: Colors.grey, // Grey for disabled state
                                width: 0.5,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color(0xFFB0BEC5), // Light grey for hint
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(
                                0xFF0A8FDC), // Themed text color for user input
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: const Color(
                              0xFF0A8FDC), // Cursor color matching the theme
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 253, 247, 247), // Light background color
                          borderRadius:
                              BorderRadius.circular(50), // Circular shape
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  const Offset(0, 3), // Changes shadow position
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors
                              .transparent, // Transparent to show background
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                50), // Match the container's border radius
                            splashColor:
                                const Color.fromARGB(255, 241, 238, 238)
                                    .withOpacity(0.3), // Smooth red splash
                            onTap: () async {
                              await lgn.getKey();

                              final token = await lgn.box.read("token");
                              if (token != null) {
                                Get.offAllNamed("/home");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(
                                  12.0), // Add padding around the icon
                              child: Icon(
                                Icons
                                    .arrow_forward, // Icon suitable for login action
                                color: Color.fromARGB(
                                    255, 224, 6, 6), // BayMax theme red color
                                size: 30.0, // Icon size
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
