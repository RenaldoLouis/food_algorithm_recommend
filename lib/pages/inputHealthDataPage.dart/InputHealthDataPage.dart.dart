import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/pages/Home/Home.dart';
import 'package:food_algorithm_recommend/providers/userInfoProviders.dart';

class InputHealthDataPage extends ConsumerStatefulWidget {
  final User user;

  const InputHealthDataPage({Key? key, required this.user}) : super(key: key);

  @override
  _InputHealthDataPageState createState() => _InputHealthDataPageState();
}

class _InputHealthDataPageState extends ConsumerState<InputHealthDataPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void _handleInputDataToDatabase() async {
    final userInfo = <String, int>{"height": 210, "weight": 80};

    firebaseFirestore
        .collection("userHealthInfoCollection")
        .doc(widget.user.uid)
        .set(userInfo)
        .onError((e, _) => print("Error writing document: $e"));
  }

  void _handleAddUserInfoToProvider() async {
    final userInfoNotifier = ref.read(userHealthInfoProvider.notifier);
    userInfoNotifier.setUserInfo(
      int.parse(_heightController.text),
      int.parse(_weightController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleAddUserInfoToProvider();
                _handleInputDataToDatabase();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Home(user: widget.user),
                  ),
                );
              },
              child: Text('Save'),
            ),
            Consumer(builder: (context, watch, child) {
              final userInfo = ref.watch(userHealthInfoProvider);
              return userInfo != null
                  ? Text('User Info: ${userInfo.weight}, ${userInfo.height}')
                  : Text('No user info available');
            }),
          ],
        ),
      ),
    );
  }
}
