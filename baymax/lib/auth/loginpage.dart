import 'package:baymax/auth/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController lgn = Get.find<LoginController>();
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: _width * 0.05, right: _width * 0.05),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: _height * 0.35,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: lgn.usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.person_2),
                        fillColor: const Color.fromARGB(255, 238, 255, 253),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(width: 0.1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(width: 0.5)),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        hintText: "Username",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  SizedBox(
                    // height: 20,
                    child: TextField(
                      controller: lgn.passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.person_2),
                        fillColor: const Color.fromARGB(255, 238, 255, 253),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(width: 0.1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(width: 0.5)),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        hintText: "password",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      onPressed: () async {
                        lgn.login();
                        await lgn.getKey(lgn.usname.string);
                        final token = await lgn.box.read("token");
                        if (token != null) {
                          Get.toNamed("/home");
                        }
                      },
                      icon: const Icon(Icons.login)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
