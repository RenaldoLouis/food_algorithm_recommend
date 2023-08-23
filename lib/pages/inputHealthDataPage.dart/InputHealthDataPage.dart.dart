import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/providers/userInfoProviders.dart';

class InputHealthDataPage extends ConsumerStatefulWidget {
  const InputHealthDataPage({super.key});

  @override
  _InputHealthDataPageState createState() => _InputHealthDataPageState();
}

class _InputHealthDataPageState extends ConsumerState<InputHealthDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
