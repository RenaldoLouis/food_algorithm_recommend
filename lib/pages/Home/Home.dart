import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_algorithm_recommend/pages/Home/Access.dart';
import 'package:food_algorithm_recommend/pages/Home/Goclub.dart';
import 'package:food_algorithm_recommend/pages/Home/Gopay.dart';
import 'package:food_algorithm_recommend/pages/Home/Menus.dart';
import 'package:food_algorithm_recommend/pages/Home/News.dart';
import 'package:food_algorithm_recommend/pages/Home/Search.dart';
import 'package:food_algorithm_recommend/pages/login/Login.dart';
import 'package:food_algorithm_recommend/pages/Home/Header.dart';
import 'package:food_algorithm_recommend/theme.dart';
import 'package:food_algorithm_recommend/utils/fire_auth.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _currentUser = widget.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: green2,
          elevation: 0,
          toolbarHeight: 71,
          title: const Header()),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Search(),
          Gopay(),
          Menus(),
          GoCLub(),
          Access(),
          News(),
        ],
      )),
    );
  }
}
