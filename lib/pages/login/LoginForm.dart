import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/pages/profile/Profile.dart';
import 'package:food_algorithm_recommend/pages/register/Register.dart';
import 'package:food_algorithm_recommend/utils/Validator.dart';
import 'package:food_algorithm_recommend/utils/fire_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _emailTextController = TextEditingController();
    final _passwordTextController = TextEditingController();

    final _focusEmail = FocusNode();
    final _focusPassword = FocusNode();

    bool _isProcessing = false;

    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User? user = await FireAuth
                                          .signInUsingEmailPassword(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Profile(user: user),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 24.0),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
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
    );
  }
}