import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/chat/widgets/Input_decoration.dart';
import 'package:avrod/chat/widgets/login_button.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/widgets/avrod_bunner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<HomePageController> {
  const LoginPage({Key? key}) : super(key: key);

  static String routName = '/loginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: controller.currrentIndexTab == 1 ? "Китобхона" : 'Чат',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  maxLines: 3,
                  title: controller.currrentIndexTab == 1
                      ? 'Барои дохил шудан ба китобхона, шумо бояд ба ҳисоби корбари худ ворид шавед!'
                      : 'Барои дохил шудан ба чат, шумо бояд ба ҳисоби корбари худ ворид шавед!',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 40,
                ),
                const AvrodBunner(
                  height: 200,
                  width: 200,
                  borderRadius: 100,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Лутфан email-и дурустро ворид кунед!";
                  },
                  onChanged: (val) {
                    controller.onChangedLoginEmail(val);
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: navItemsColor,
                    ),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Рамз бояд на камтар аз 6 аломат бошад";
                    } else {
                      return null;
                    }
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: navItemsColor,
                    ),
                    hintText: 'Password',
                  ),
                  onChanged: (val) {
                    controller.onChangedLoginPassword(val);
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginButton(
                  buttonTitle: 'Вуруд',
                  onPressed: () {
                    controller.login();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Айни ҳол ҳисоб надоред? ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Сабт кардан',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToRegisterPage();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
