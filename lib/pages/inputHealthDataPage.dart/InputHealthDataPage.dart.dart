import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/providers/userInfoProviders.dart';

class InputHealthDataPage extends ConsumerStatefulWidget {
  final User user;

  const InputHealthDataPage({Key? key, required this.user}) : super(key: key);

  @override
  _InputHealthDataPageState createState() => _InputHealthDataPageState();
}

class _InputHealthDataPageState extends ConsumerState<InputHealthDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void _handleInputDataToDatabase() async {
    final userInfo = <String, String>{"height": "210", "weight": "80"};

    firebaseFirestore
        .collection("userHealthInfoCollection")
        .doc(widget.user.displayName)
        .set(userInfo)
        .onError((e, _) => print("Error writing document: $e"));
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
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () {
                final userInfoNotifier =
                    ref.read(userHealthInfoProvider.notifier);
                userInfoNotifier.setUserInfo(
                    _nameController.text, _emailController.text);
                _handleInputDataToDatabase();
              },
              child: Text('Save'),
            ),
            Consumer(builder: (context, watch, child) {
              final userInfo = ref.watch(userHealthInfoProvider);
              return userInfo != null
                  ? Text('User Info: ${userInfo.name}, ${userInfo.email}')
                  : Text('No user info available');
            }),
          ],
        ),
      ),
    );
  }
}
