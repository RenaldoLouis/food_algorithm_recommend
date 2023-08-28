import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/pages/login/Login.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            "https://assets4.lottiefiles.com/packages/lf20_AMBEWz.json",
            controller: _controller,
            onLoaded: (compoes) {
              _controller
                ..duration = compoes.duration
                ..forward().then(
                  (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  ),
                );
            },
          ),
          const Center(
            child: Text("FoodApp"),
          )
        ],
      ),
    );
  }
}
