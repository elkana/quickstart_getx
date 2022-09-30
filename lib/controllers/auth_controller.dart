import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'pref_controller.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  var authenticated = false.obs;

  AuthController() {
    // authenticated(pref.hasLoggedUser());
  }

  Future<void> autoLogin() async {
    debugPrint('autoLogin => ${authenticated.value}');
    if (PrefController.instance.hasLoggedUser()) {
      User? _user = PrefController.instance.getLoggedUser();

      // login(pref.getServerChoice(), _user!.userId!, _user.userPwd!,
      //     _user.rememberMe!);
    }
  }

  /// tidak mengatur reroute disini, hanya authentication secara online.
  ///
  /// login offline tidak diperlukan diatur di class ini karena sudah diatur di LoginController.
  Future<User?> login(String userId, String pwd, bool rememberMe) async {
    // var resp = await Api.instance.login(userId, pwd);
    var resp = User(userId: userId, userPassword: pwd);
    resp.rememberMe = rememberMe;
    // inject password, because server might hide it
    resp.userPassword = pwd;
    authenticated(true);
    return resp;
  }

  /// must be called before route to login
  logout() async {
    if (PrefController.instance.hasLoggedUser()) {
      var user = PrefController.instance.getLoggedUser();
      if (!user!.rememberMe!) await PrefController.instance.cleanLoggedUserData();
    }
    authenticated(false);
  }
}
