import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/pages/login/LoginForm.dart';
import 'package:food_algorithm_recommend/pages/login/Login_screen_top_image.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Row(
        children: [
          const Expanded(
            child: LoginScreenTopImage(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  // width: 450,
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
