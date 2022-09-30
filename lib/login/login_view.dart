import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/locales.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LoginController>(() => LoginController());
}

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
          body: SizedBox(
        width: 300,
        child: Form(
            child: Column(children: [
              const Text('Hello Login'),
              // email
              TextFormField(
                  controller: controller.ctrlUserId,
                  textAlign: TextAlign.center,
                  validator: (val) => controller.validateUserId(val!),
                  onSaved: (val) => controller.ctrlUserId.text = val!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  autofocus: false,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      suffixIcon: SizedBox(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0))),
              //passwordf
              Obx(() => TextFormField(
                  controller: controller.ctrlPwd,
                  textAlign: TextAlign.center,
                  validator: (val) => controller.validatePassword(val!),
                  onSaved: (val) => controller.ctrlPwd.text = val!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye), onPressed: () => controller.obscurePwd.toggle()),
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0)),
                  obscureText: controller.obscurePwd.value)),
              // toggle rememberme
              Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                      onPressed: controller.rememberPwd.toggle,
                      icon: Obx(() => Switch(
                          value: controller.rememberPwd.value, onChanged: (val) => controller.rememberPwd.toggle())),
                      label: Text(LocaleKeys.buttons_rememberme.tr, style: const TextStyle(fontSize: 12)))),
              const SizedBox(height: 10.0),
              //button login
              Obx(() => controller.loading.value
                  ? const CircularProgressIndicator()
                  : Padding(
                      child: Material(
                          child: MaterialButton(
                              child: const Text('MASUK', style: TextStyle(color: Colors.white)),
                              onPressed: controller.login,
                              minWidth: double.infinity,
                              height: 42.0),
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 5.0,
                          color: Colors.purple),
                      padding: const EdgeInsets.symmetric(vertical: 16.0))),
            ]),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.formKey),
      ));
}
