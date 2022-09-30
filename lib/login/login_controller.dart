import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickstart_getx/routes/app_routes.dart';

import '../controllers/auth_controller.dart';
import '../controllers/pref_controller.dart';
import '../models/user.dart';
import '../utils/screen_util.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController ctrlUserId, ctrlPwd;
  var obscurePwd = true.obs;
  var rememberPwd = false.obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ctrlUserId = TextEditingController();
    ctrlPwd = TextEditingController();
  }

  @override
  void onClose() {
    ctrlPwd.dispose();
    ctrlUserId.dispose();
    super.onClose();
  }

  String? validateUserId(String value) {
    if (GetUtils.isLengthLessThan(value, 4)) return 'Length must be of 4 chars';
    if (!GetUtils.isEmail(value)) return 'Invalid email';
    return null;
  }

  String? validatePassword(String value) {
    if (GetUtils.isLengthLessThan(value, 6)) {
      return 'Password must be of 6 chars';
    }
    return null;
  }

  Future<void> login() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    loading(true);
    try {
      User? user = await AuthController.instance
          .login(ctrlUserId.text, ctrlPwd.text, rememberPwd.value)
          .onError((error, stackTrace) {
        ScreenUtil.showToast(error.toString(), error: true, title: 'Login Failed');
        return null;
      });

      if (user == null) return;
      await PrefController.instance.setLoggedUser(user);

      await 1.delay();
      gotoHome();
    } finally {
      loading(false);
    }
  }

  gotoHome() {
    Get.offAllNamed(Routes.HOME);
  }
}
