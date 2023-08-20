import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/components/background.dart';
import 'package:food_algorithm_recommend/pages/login/LoginForm.dart';
import 'package:food_algorithm_recommend/pages/login/Login_screen_top_image.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(
              child: LoginScreenTopImage(),
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: const [
            //       SizedBox(
            //         width: 450,
            //         child: LoginForm(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
