import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_algorithm_recommend/models/userHealthinfo.dart';

// final userInfoProvider =
//     StateNotifierProvider<UserInfoNotifier, UserHealthInfo>((ref) {
//   return UserInfoNotifier();
// });

final userHealthInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserHealthInfo?>((ref) {
  return UserInfoNotifier();
});

class UserInfoNotifier extends StateNotifier<UserHealthInfo?> {
  UserInfoNotifier() : super(null);

  void setUserInfo(String name, String email) {
    state = UserHealthInfo(name, email);
  }
}
