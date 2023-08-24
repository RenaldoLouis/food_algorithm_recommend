import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/components/background.dart';
import 'package:food_algorithm_recommend/pages/inputHealthDataPage.dart/InputHealthDataPage.dart.dart';
import 'package:food_algorithm_recommend/pages/login/Login.dart';
import 'package:food_algorithm_recommend/pages/profile/Profile.dart';
import 'package:food_algorithm_recommend/pages/register/sign_up_top_image.dart';
import 'package:food_algorithm_recommend/utils/Validator.dart';
import 'package:food_algorithm_recommend/utils/fire_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SignUpScreenTopImage(),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      _focusName.unfocus();
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _registerFormKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _nameTextController,
                                    focusNode: _focusName,
                                    validator: (value) =>
                                        Validator.validateName(
                                      name: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      errorBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    validator: (value) =>
                                        Validator.validateEmail(
                                      email: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      errorBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    focusNode: _focusPassword,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(
                                      password: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      errorBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32.0),
                                  _isProcessing
                                      ? const CircularProgressIndicator()
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _isProcessing = true;
                                                  });

                                                  if (_registerFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    User? user = await FireAuth
                                                        .registerUsingEmailPassword(
                                                      name: _nameTextController
                                                          .text,
                                                      email:
                                                          _emailTextController
                                                              .text,
                                                      password:
                                                          _passwordTextController
                                                              .text,
                                                    );

                                                    setState(() {
                                                      _isProcessing = false;
                                                    });

                                                    if (user != null) {
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              InputHealthDataPage(
                                                                  user: user),
                                                        ),
                                                        ModalRoute.withName(
                                                            '/inputUserInfo'),
                                                      );
                                                    }
                                                  } else {
                                                    setState(() {
                                                      _isProcessing = false;
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                  'Sign up',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24.0),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
