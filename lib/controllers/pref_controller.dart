import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class PrefController extends GetxController {
  static PrefController instance = Get.find();
  final box = GetStorage();

  Future initStorage() => GetStorage.init();
  Future cleanLoggedUserData() async {
    // dont use box.erase. key servers must not be deleted
    await box.remove('auth');
    // add more here
  }
  // Future cleanAll() => box.erase();  too dangerous

// has...
  bool hasLoggedUser() => box.hasData('auth');
  bool hasDarkTheme() => box.hasData('theme.dark');

// sets...
  Future<void> setLoggedUser(User? model) => model == null ? cleanLoggedUserData() : box.write('auth', model.toJson());
  Future<void> setDarkTheme(bool value) => box.write('theme.dark', value);

// gets...
  User? getLoggedUser() {
    if (!hasLoggedUser()) return null;
    final map = box.read('auth') ?? {};
    return User.fromJson(map);
  }

  bool getDarkTheme() => box.read('theme.dark') ?? false;
}
